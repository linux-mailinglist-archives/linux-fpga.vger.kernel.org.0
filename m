Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D63195B16
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Mar 2020 17:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0QaC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Mar 2020 12:30:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33157 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0QaC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Mar 2020 12:30:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id g18so3653551plq.0
        for <linux-fpga@vger.kernel.org>; Fri, 27 Mar 2020 09:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SJvWFjZDOe1lgiVVdLFGLPbmS0CAKvI/u5kx3H2WLgY=;
        b=BQmSNFS8PJ6cL6uxkhvI7dZEPEtXRQh8jzPrc+jP877Q0P8JYkS5bqZA8HCiVt2jwc
         q73WDJuBRXUf17ddxPdk+NCgSFGUax1/vK8lRq/CvF3w6veYaeFYXxuS6ndfZ961wCgx
         YYGlg8l+j+iBW1BiMUgmQAYQwDfrhbljpG0F8rD1IeyxU0K7qruOIQitJxltvgFxWFAJ
         qUObwjb9i+ZAdHNURgq4AkSJfWL9++BwY+BM1inwmQzaC3yMIdr/8uGdByHvQOx6J58W
         SB1em85qWsZtO+M91aHnl9Me988AWoJ7pie4JutZVFgt0q+IwEkmLwSx/7+FnJyP0LNU
         A6Gg==
X-Gm-Message-State: ANhLgQ06ByV6TQ4WC8tal1B3fIdyRI2d4iiZHyVjt4nUe6skMhVxLvVP
        DUOuly/k6ugWpdpGmPz5pXp48PQPvSY=
X-Google-Smtp-Source: ADFU+vuhCIpSA5J71HOnf06/piQUnCIRneWVwEDL6SYOx4ogPKJNJH5U8++9yN/20yDhpv6ItBvucg==
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr277689pjb.18.1585326601187;
        Fri, 27 Mar 2020 09:30:01 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1160:3ae1:1f56:6f77:5f9e])
        by smtp.gmail.com with ESMTPSA id e9sm4485846pfl.179.2020.03.27.09.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 09:30:00 -0700 (PDT)
Date:   Fri, 27 Mar 2020 09:29:44 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     moritzf@google.com, linux-fpga@vger.kernel.org
Subject: [GIT PULL] FPGA Manager changes for 5.7
Message-ID: <20200327162944.GA4118@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-for-5.7

for you to fetch changes up to 3d5a5417ad064a6ca64a33f0c554d917311c79f4:

  fpga: dfl: afu: support debug access to memory-mapped afu regions (2020-03-21 13:14:30 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.7

Here's the first set of changes for the 5.7-rc1 merge window.

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

Shubhrajyoti Datta (1):
      fpga: zynq: Remove clk_get error message for probe defer

Xu Yilun (2):
      fpga: dfl: support multiple opens on feature device node.
      fpga: dfl: pci: fix return value of cci_pci_sriov_configure

 .../bindings/firmware/intel,stratix10-svc.txt      |  2 +-
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |  3 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |  4 +--
 drivers/fpga/dfl-afu-main.c                        | 35 +++++++++++++-------
 drivers/fpga/dfl-fme-main.c                        | 19 +++++++----
 drivers/fpga/dfl-pci.c                             |  6 ++--
 drivers/fpga/dfl.c                                 | 15 +++++++--
 drivers/fpga/dfl.h                                 | 37 ++++++++++++++++------
 drivers/fpga/ice40-spi.c                           | 10 ++++--
 drivers/fpga/machxo2-spi.c                         | 12 ++++---
 drivers/fpga/stratix10-soc.c                       |  3 +-
 drivers/fpga/zynq-fpga.c                           |  3 +-
 12 files changed, 106 insertions(+), 43 deletions(-)
