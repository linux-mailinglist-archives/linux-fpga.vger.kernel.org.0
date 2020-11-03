Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A622A3A45
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 03:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgKCCMX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Nov 2020 21:12:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38772 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKCCMX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 2 Nov 2020 21:12:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id f21so7818168plr.5
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 18:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PBrhBSQRx+q/wyWus9fWH62gVFujVI/mUGgTvFLrRgM=;
        b=SOTxzclTEbup/xqIDM9qooAPFVUJZSm1/YLppbVCADXAHqShUYmyVshzE3c4pgITv8
         e53hBe6XZA2blS5WY0E41SiWgvFn6ERF9yNvft8LmKavNvxuK4h+XNtKxNJUlxic9ogq
         m59H2PdbNHJItMKnFOTaXmgjd1cAmxwcGl3gFsq0maRdHMm6UYFlJW3nHWFKQBgVcICx
         2ihEl6LljfwD2PvkvbDAGYb0hKqGbQi43VS0/bo2L/psUI7FMR2mPilpcFNf/BR2AuY1
         csjk5Za5HehgwTqqfz3iqMCw5ArDbM6SHxQbgdMwKXhy/r4XbMBl8Z2RhUb0vvxnkxLe
         w3lA==
X-Gm-Message-State: AOAM530FnHaxwaX0nNW0zU8au0LMIQQmrAi/26ZHV4nCxnAXHJPEh6yx
        x2YxIAtBuinfg8CZqB+X2fqyVxXerOM=
X-Google-Smtp-Source: ABdhPJxEJNvx/Xv8mD+X/3gRxvV/vPnDKet+87qzTa7ZsOt6mVicrZI5POJ7L/TFUa2NO5SRI1MyvA==
X-Received: by 2002:a17:902:9a0c:b029:d6:c6a3:66f with SMTP id v12-20020a1709029a0cb02900d6c6a3066fmr8073277plp.52.1604369542669;
        Mon, 02 Nov 2020 18:12:22 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id g85sm15065001pfb.4.2020.11.02.18.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:12:22 -0800 (PST)
Date:   Mon, 2 Nov 2020 18:12:21 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager changes for 5.11
Message-ID: <20201103021221.GA4952@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ fpga-mgr-cleanup-for-5.11

for you to fetch changes up to 0fd2ae8ab326c79fbede549dadaa6fa27d9e16bb:

  Merge tag 'v5.10-rc1' into devm_fpga_mgr_register (2020-11-02 18:03:50 -0800)

----------------------------------------------------------------
First set of FPGA Manager changes for 5.11-rc1

This is the first set of changes for the FPGA Manager 5.11-rc1
mergewindow.

Core:
- Simplify registration of FPGA Manager drivers by providing a devres
  based API, that removes the need to call fpga_mgr_unregister() in
  every single driver.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Moritz Fischer (11):
      fpga: fpga-mgr: Add devm_fpga_mgr_register() API
      fpga: fpga-mgr: altera-ps-spi: Simplify registration
      fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
      fpga: fpga-mgr: ice40-spi: Simplify registration
      fpga: fpga-mgr: machxo2-spi: Simplify registration
      fpga: fpga-mgr: socfpga: Simplify registration
      fpga: fpga-mgr: ts73xx: Simplify registration
      fpga: fpga-mgr: xilinx-spi: Simplify registration
      fpga: fpga-mgr: zynqmp: Simplify registration
      fpga: fpga-mgr: altera-pr-ip: Simplify registration
      Merge tag 'v5.10-rc1' into devm_fpga_mgr_register

 drivers/fpga/altera-pr-ip-core-plat.c | 10 -----
 drivers/fpga/altera-pr-ip-core.c      |  4 +-
 drivers/fpga/altera-ps-spi.c          | 14 +-----
 drivers/fpga/dfl-fme-mgr.c            | 13 +-----
 drivers/fpga/fpga-mgr.c               | 81 +++++++++++++++++++++++++++++------
 drivers/fpga/ice40-spi.c              | 14 +-----
 drivers/fpga/machxo2-spi.c            | 14 +-----
 drivers/fpga/socfpga.c                | 14 +-----
 drivers/fpga/ts73xx-fpga.c            | 14 +-----
 drivers/fpga/xilinx-spi.c             | 14 +-----
 drivers/fpga/zynqmp-fpga.c            | 21 +--------
 include/linux/fpga/fpga-mgr.h         |  2 +
 12 files changed, 80 insertions(+), 135 deletions(-)
