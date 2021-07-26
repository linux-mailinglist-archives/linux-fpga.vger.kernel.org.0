Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71913D516C
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Jul 2021 04:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhGZCM4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Jul 2021 22:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhGZCM4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Jul 2021 22:12:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074EEC061757
        for <linux-fpga@vger.kernel.org>; Sun, 25 Jul 2021 19:53:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p5-20020a17090a8685b029015d1a9a6f1aso11868812pjn.1
        for <linux-fpga@vger.kernel.org>; Sun, 25 Jul 2021 19:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=og4Cx+BEH/BZvVXh5nTnC1W51iAmXjZ60wGc4VMmYHk=;
        b=KXrHE1B1CKZC3bHBcCRhQ8zIKC7QFDpxYxBIqODx1HsHBvj+HlszQtPOqeIB2pwW6N
         94uSQ7ldcy+mAHgMSUXgJODaGxtDH3duySfg6lAXAzqF0pZSEZ8vCItTqV2ySoKo6JSj
         8GKM9jjyo+QPR5+bQplrzbV9CGYFuzBGf+LNP2I1imxJC8CVVOFKsI3GrcqXlMna0X+o
         6dbwDvi/Lt+4Ith+XpgqYaBsPc0vdj+FDDg6y+JQCjAuQE1XB+E+5niWYFNBlKfuyOCw
         gIyUeXPVEVFg7/OZQN3yV0mQlfb7bc/R4fV+iOgbqTAVc8H5gMWAVxx7ivAXvY3ZHrJr
         aeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=og4Cx+BEH/BZvVXh5nTnC1W51iAmXjZ60wGc4VMmYHk=;
        b=TTXqtLLoymf7jzQ13d8CM79lA2pvA5jOGdVq2PH4tBptzYBFG0DkcO8bv2aXbLO7H+
         HK83/yRI3xTuT57676ECe3zLbYM5p9zExFDkhVgXDKOgiUiHmfyDkaZinbo3G2vSk01R
         vmh3ZoxXXttwHABfClbyRxYUnPzIxrPMjjg2QgnGJrx6O2ckH+0StCPB6kNxqKGGezVP
         GZXaMVfe7/no27+zk2DQQnQ4lyAHN817Sdv/P6ZCh7GjyQPpOYvGMkHPIOP6iUfdA1I9
         AQdfmpiKj48pBcoEjQ/kOc68506BvKNoNkyoIDQs4mSuzUhxtSMUX34iEjve4JsZLW+7
         PBgw==
X-Gm-Message-State: AOAM533RdXp1wvrz+SNe4xG8oQlIfLEeTXeC8my9yAlOvOrFr3xvHH2Z
        XkuAGpgmUL/zrSgE0JZqXrk=
X-Google-Smtp-Source: ABdhPJzMdTt++Obk+XMRwf0RM6mg/JVy1BlXW95FpVfPUw8b7pIu0EaXCNrEi7N7J3o3m25K9cv72g==
X-Received: by 2002:a65:4386:: with SMTP id m6mr15885893pgp.430.1627268004348;
        Sun, 25 Jul 2021 19:53:24 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id j3sm40486570pfc.10.2021.07.25.19.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 19:53:23 -0700 (PDT)
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
X-Google-Original-From: Moritz Fischer <moritzf@epycbox.lan>
Date:   Sun, 25 Jul 2021 19:53:22 -0700
To:     gregk@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org
Subject: [GIT PULL] FPGA Manager changes for 5.15-rc1
Message-ID: <YP4jogGRVpF/ELV6@epycbox.lan>
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
