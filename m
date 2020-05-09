Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186371CC3A3
	for <lists+linux-fpga@lfdr.de>; Sat,  9 May 2020 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgEISN6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 9 May 2020 14:13:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43732 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgEISN6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 9 May 2020 14:13:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id z6so2102620plk.10
        for <linux-fpga@vger.kernel.org>; Sat, 09 May 2020 11:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=exaZNX1WCg7hSSzMc4qoC8PFjTdNDt78Vaq5EVnTeig=;
        b=CKwXelYfVrJU8Cnk1AGUL9GNv4Gc7rE6oe5SUlQZ5lEbp0QMYqZ5+lbaTkDVuEg9LQ
         5UMK4+2WsyG698sr4vn3ZXKUT7FedQUNyh9ePpN1pfKZnbpAFJztTmUF4iG9xWlMlSCQ
         +mOzhBuNTcHU7gTv2pm64kYRd2EfU04s3jGUve/PZKXQET4vJdOzKoRBLXJPs1iaw/su
         tjHctr6H15ujiFv4KKy+CqcWG/2VKGdN2CTUggL984QYCITV0Yj5q8Ih46y+AMqkeqzb
         cp9gauAteZl+AaRi/nuT5Uci9Zmtm/zCxdKrqF4s6a0lKzJhjzwBemiQJvtWN/4vbEjA
         Gypg==
X-Gm-Message-State: AGi0PuZEBWypeZqwpM+VkMfBrkab9SjIF/BvLWk2r+IbhsywPwWZjiPy
        +LnwgcPnldeCyLmKcRO+4w0=
X-Google-Smtp-Source: APiQypLv38+E0XV4Ly9VvzJdhUtQ8b1e88f/d/WLjYg0/jjidtrrT7DpxsxC5RwajfyIDzjR9CM7QA==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr11997369pjb.97.1589048037210;
        Sat, 09 May 2020 11:13:57 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id j186sm5167174pfb.220.2020.05.09.11.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 11:13:56 -0700 (PDT)
Date:   Sat, 9 May 2020 11:13:55 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     moritzf@google.com, linux-fpga@vger.kernel.org
Subject: [GIT PULL] FPGA Manager changes for 5.8
Message-ID: <20200509181355.GA3828@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.8

for you to fetch changes up to a2b9d4eadb7727772698d06e4cbeb1a1e2538675:

  fpga: dfl: afu: support debug access to memory-mapped afu regions (2020-04-29 20:37:12 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.8

Here's the first set of changes for the 5.8-rc1 merge window.

Dominic's change adds support for accessing AFU regions with gdb.
Gustavo's change is a cleanup patch regarding variable lenght arrays.
Richard's changes update dt-bindings and add support for stratix and agilex.
Sergiu's changes update spi transfers with the new delay field.
Xu's change addresses an issue with a wrong return value.
Shubhrajyoti's change makes the Zynq FPGA driver return -EPROBE_DEFER on
check of devm_clk_get failure.
Xu's change for DFL enables multiple opens.

All of these patches have been reviewed, have appropriate Acked-by's and
have been in the last few linux-next releases without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Dominic Chen (1):
      fpga: dfl: afu: support debug access to memory-mapped afu regions

Gustavo A. R. Silva (1):
      fpga: dfl.h: Replace zero-length array with flexible-array member

Richard Gong (5):
      dt-bindings: fpga: add compatible value to Stratix10 SoC FPGA manager binding
      arm64: dts: agilex: correct FPGA manager driver's compatible value
      fpga: stratix10-soc: add compatible property value for intel agilex
      dt-bindings, firmware: add compatible value Intel Stratix10 service layer binding
      arm64: dts: agilex: correct service layer driver's compatible value

Sergiu Cuciurean (2):
      fpga: ice40-spi: Use new structure for SPI transfer delays
      fpga: machxo2-spi: Use new structure for SPI transfer delays

Xu Yilun (1):
      fpga: dfl: support multiple opens on feature device node.

 .../bindings/firmware/intel,stratix10-svc.txt      |  2 +-
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |  3 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |  4 +--
 drivers/fpga/dfl-afu-main.c                        | 35 +++++++++++++-------
 drivers/fpga/dfl-fme-main.c                        | 19 +++++++----
 drivers/fpga/dfl.c                                 | 15 +++++++--
 drivers/fpga/dfl.h                                 | 37 ++++++++++++++++------
 drivers/fpga/ice40-spi.c                           | 10 ++++--
 drivers/fpga/machxo2-spi.c                         | 12 ++++---
 drivers/fpga/stratix10-soc.c                       |  3 +-
 10 files changed, 100 insertions(+), 40 deletions(-)
