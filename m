Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF38E3D516E
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Jul 2021 04:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGZCO7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Jul 2021 22:14:59 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:46866 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhGZCO6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Jul 2021 22:14:58 -0400
Received: by mail-pj1-f49.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so12210408pji.5
        for <linux-fpga@vger.kernel.org>; Sun, 25 Jul 2021 19:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=og4Cx+BEH/BZvVXh5nTnC1W51iAmXjZ60wGc4VMmYHk=;
        b=UOUCGAHNIWj3+pZWJ1/EaX0GBh8oYdFkiWf6Ds1u9Ci2BGdHV8OYmQhtxxvKe0PXyb
         EIT2/1KLUVvwowavfIk12NJ7fJZhW5SDXO6qZYi2LkDQ+aeTLvO2iKwizbNpVM5NwLrm
         2ZB2kubNBnBZABQ3bS+QvXBgvfrU+lusp/wItOEd04zmb8LxAPv8aINArQ3DaPDttgmu
         Gy5j4SY+/ZL9kfDQDwkCYzXiouTy5cRQ1Q2w7LI2tG39d66FFy5J8rVHygb0JznhiNgp
         KDG13kJrLwJfLTUA8c4jHakeXO9/HYVD3Lg29keb2oBRFO6kANEXyO61m5CIk+9fcWxd
         3RCw==
X-Gm-Message-State: AOAM530LTGnH7zxF8CglW1hUd8ziNgL8OQD6KpIpoDuihrTTQRX1+E9D
        IxY/F+VHoBXU1XdU83ugBQo=
X-Google-Smtp-Source: ABdhPJxx79li9Vu6OxVPpbUoRP2h+Ai1nnZo3LKKusRBWj6N+D7fx5UM4qHemtEGhSH+yAtMuDGH6Q==
X-Received: by 2002:a63:1656:: with SMTP id 22mr16208077pgw.163.1627268127962;
        Sun, 25 Jul 2021 19:55:27 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id 21sm39022128pfh.103.2021.07.25.19.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 19:55:27 -0700 (PDT)
Date:   Sun, 25 Jul 2021 19:55:26 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org
Subject: [GIT PULL] FPGA Manager changes for 5.15-rc1
Message-ID: <YP4kHpn7CDzCYrbU@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-for-5.15

for you to fetch changes up to c485d3bf3cc7790faed2b90c799a38caa2f69268:

  fpga: fpga-mgr: wrap the write_sg() op (2021-07-18 08:05:00 -0700)

----------------------------------------------------------------
FPGA Manager Changes for 5.15-rc1

FPGA Manager

- Navin's change removes a duplicate word in a comment
- Tom's change fixes a spelling mistake
- Mauro's change fixes up documentation
- Tom's second set adds wrappers to allow drivers not having to
  implement empty functions by moving checks into fpga-mgr core code
- My changes address a bunch of warnings

DFL

- Martin's change adds a new PCI ID for Silicom N501x PAC cards

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of my for-next branch).

I did get a complaint about one of the commit messages w/ a Fixes: tag
which would need a rebase to fix.

Some of the earlier patches were originally meant for 5.14 but missed
the merge window by a couple of days, hence the back-merge of 5.14-rc1.

Signed-offy-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Martin Hundebøll (1):
      fpga: dfl: pci: add device IDs for Silicom N501x PAC cards

Mauro Carvalho Chehab (1):
      docs: driver-api: fpga: avoid using UTF-8 chars

Moritz Fischer (5):
      Merge tag 'v5.14-rc1' into for-next
      fpga: altera-freeze-bridge: Address warning about unused variable
      fpga: xiilnx-spi: Address warning about unused variable
      fpga: xilinx-pr-decoupler: Address warning about unused variable
      fpga: zynqmp-fpga: Address warning about unused variable

Navin Sankar Velliangiri (1):
      fpga: fpga-bridge: removed repeated word

Tom Rix (8):
      fpga: fix spelling mistakes
      fpga: fpga-mgr: wrap the write_init() op
      fpga: fpga-mgr: make write_complete() op optional
      fpga: fpga-mgr: wrap the write() op
      fpga: fpga-mgr: wrap the status() op
      fpga: fpga-mgr: wrap the state() op
      fpga: fpga-mgr: wrap the fpga_remove() op
      fpga: fpga-mgr: wrap the write_sg() op

 Documentation/driver-api/fpga/fpga-bridge.rst      |  10 +-
 Documentation/driver-api/fpga/fpga-mgr.rst         |  12 +--
 Documentation/driver-api/fpga/fpga-programming.rst |   8 +-
 Documentation/driver-api/fpga/fpga-region.rst      |  20 ++--
 Documentation/fpga/dfl.rst                         |   4 +-
 drivers/fpga/altera-cvp.c                          |   2 +-
 drivers/fpga/altera-freeze-bridge.c                |   2 +
 drivers/fpga/dfl-fme-mgr.c                         |   6 --
 drivers/fpga/dfl-fme-pr.c                          |   2 +-
 drivers/fpga/dfl-n3000-nios.c                      |   2 +-
 drivers/fpga/dfl-pci.c                             |   5 +
 drivers/fpga/dfl.h                                 |   2 +-
 drivers/fpga/fpga-bridge.c                         |   8 +-
 drivers/fpga/fpga-mgr.c                            | 111 ++++++++++++++-------
 drivers/fpga/stratix10-soc.c                       |   6 --
 drivers/fpga/ts73xx-fpga.c                         |   6 --
 drivers/fpga/xilinx-pr-decoupler.c                 |   2 +
 drivers/fpga/xilinx-spi.c                          |   2 +
 drivers/fpga/zynq-fpga.c                           |   6 +-
 drivers/fpga/zynqmp-fpga.c                         |  10 +-
 include/linux/fpga/fpga-mgr.h                      |   2 +-
 21 files changed, 127 insertions(+), 101 deletions(-)
