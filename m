Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54F4795E6
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Dec 2021 21:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhLQU6B (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Dec 2021 15:58:01 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:35700 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbhLQU6A (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Dec 2021 15:58:00 -0500
Received: by mail-pj1-f43.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso6837114pji.0
        for <linux-fpga@vger.kernel.org>; Fri, 17 Dec 2021 12:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5OF+OC1yFihcGYEiym6LMwyOTzyuxH2ok1ferNGg4LY=;
        b=Pu3Pa1eg4FMudO8XWEW4oajrleD8xyYKAqZiWLH1gBmUS3Rr5MAes2xsivmWwhzbuH
         iLT1WcRsNN+6nBbDwyYZGkQgkS4E7uXY2BfJ5sxbdKaFUMzXrhFd2+5OyvsIVtxZDjaG
         lG3XjEAUgH7X801gYXqCDPIwasWvIiJo7u4V3zagm4h0QNtcCLeZ70BkqnYwhymy3pwL
         WRrx0NdESXqfgJG2IBX2kUfFn7iMROR/99cgUKdQ4rDDHzcjRnzmeHUli3mx28ZlUdY8
         9md82HOr3SOMe8lRKKdd6YvPC97T0DkJIm2fkSS2DijrY8amFbaANQVgzj1FD5c8/0JN
         z9Vg==
X-Gm-Message-State: AOAM530JvFyXnx62AxVotEtgZoWtdugd+js68kXWpXl1uxgtq7w7LW9F
        +P1siCVu68fD50dbjO1eYKY=
X-Google-Smtp-Source: ABdhPJyuzBvM+q5cS36qBm3uM99Yk6ElvhqYkC+AqNRAtzDwnoFl9bSuxbRKB+OE6jVA1yt1ibRebg==
X-Received: by 2002:a17:903:1252:b0:148:ef82:dd12 with SMTP id u18-20020a170903125200b00148ef82dd12mr463759plh.165.1639774680344;
        Fri, 17 Dec 2021 12:58:00 -0800 (PST)
Received: from localhost ([2601:647:5b00:ece0:aab:34ff:52ca:a7a5])
        by smtp.gmail.com with ESMTPSA id s25sm876251pfg.208.2021.12.17.12.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 12:57:59 -0800 (PST)
Date:   Fri, 17 Dec 2021 12:57:58 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, yilun.xu@intel.com, hao.wu@intel.com
Subject: [GIT PULL] FPGA Manager changes for 5.17-rc1
Message-ID: <Ybz51pwucMjutPsA@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-for-5.17-rc1

for you to fetch changes up to 98ceca2f29325d6114ea77be719a68c467c103d6:

  fpga: region: fix kernel-doc (2021-12-09 20:06:54 -0800)

----------------------------------------------------------------
FPGA Manager changes for 5.17-rc1

Russ' patches rework the way we register FPGA managers, regions and
bridges by simplifying the functions into a single register call.

Nathan's patch addresses an unused variable warning that was introduced
by Russ' patches.

Yang's patch addresses a kernel doc warning.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of our for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Nathan Chancellor (1):
      fpga: stratix10-soc: Do not use ret uninitialized in s10_probe()

Russ Weight (3):
      fpga: mgr: Use standard dev_release for class driver
      fpga: bridge: Use standard dev_release for class driver
      fpga: region: Use standard dev_release for class driver

Yang Li (1):
      fpga: region: fix kernel-doc

 Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
 Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++--
 Documentation/driver-api/fpga/fpga-region.rst |  12 +-
 drivers/fpga/altera-cvp.c                     |  12 +-
 drivers/fpga/altera-fpga2sdram.c              |  12 +-
 drivers/fpga/altera-freeze-bridge.c           |  10 +-
 drivers/fpga/altera-hps2fpga.c                |  12 +-
 drivers/fpga/altera-pr-ip-core.c              |   7 +-
 drivers/fpga/altera-ps-spi.c                  |   9 +-
 drivers/fpga/dfl-fme-br.c                     |  10 +-
 drivers/fpga/dfl-fme-mgr.c                    |  22 ++-
 drivers/fpga/dfl-fme-region.c                 |  17 +-
 drivers/fpga/dfl.c                            |  12 +-
 drivers/fpga/fpga-bridge.c                    | 122 ++++-----------
 drivers/fpga/fpga-mgr.c                       | 215 +++++++++++---------------
 drivers/fpga/fpga-region.c                    | 119 ++++++--------
 drivers/fpga/ice40-spi.c                      |   9 +-
 drivers/fpga/machxo2-spi.c                    |   9 +-
 drivers/fpga/of-fpga-region.c                 |  12 +-
 drivers/fpga/socfpga-a10.c                    |  16 +-
 drivers/fpga/socfpga.c                        |   9 +-
 drivers/fpga/stratix10-soc.c                  |  18 +--
 drivers/fpga/ts73xx-fpga.c                    |   9 +-
 drivers/fpga/versal-fpga.c                    |   9 +-
 drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
 drivers/fpga/xilinx-spi.c                     |  11 +-
 drivers/fpga/zynq-fpga.c                      |  16 +-
 drivers/fpga/zynqmp-fpga.c                    |   9 +-
 include/linux/fpga/fpga-bridge.h              |  30 ++--
 include/linux/fpga/fpga-mgr.h                 |  62 +++++---
 include/linux/fpga/fpga-region.h              |  36 +++--
 31 files changed, 388 insertions(+), 519 deletions(-)
