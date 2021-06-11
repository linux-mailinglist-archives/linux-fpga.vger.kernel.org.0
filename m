Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C443A4663
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Jun 2021 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFKQYD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 11 Jun 2021 12:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229572AbhFKQYA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 11 Jun 2021 12:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623428522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g52ZCLcTJ6SpDErdk6Wx+ZFOggYmtqOY5W5y2JVk44A=;
        b=UPkTikKnQ7KASG7f5RFV9+u0MLveYi8PD8USfqyNxK3VvZJqX7PAY6iO/j5KG5dqtLCMns
        MV8gRsQ24TFT7iQwCbCDLDUz9zLHmJqj7FABHHwt/GNSV6tkEqqvYcQ9iC0/Pk3LEtNXl1
        vzoFfaISDSqOSUx+fkoBH4Ck8B8W0Z4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-s4R1yfG_NRq7GznxkISWOA-1; Fri, 11 Jun 2021 12:21:59 -0400
X-MC-Unique: s4R1yfG_NRq7GznxkISWOA-1
Received: by mail-oo1-f72.google.com with SMTP id r17-20020a4a96510000b029024988968d95so1832824ooi.2
        for <linux-fpga@vger.kernel.org>; Fri, 11 Jun 2021 09:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g52ZCLcTJ6SpDErdk6Wx+ZFOggYmtqOY5W5y2JVk44A=;
        b=Iuz1KD2Hh6OyNYTmd/M99wd9gaOEmBN3o2DpjXHOhEQPMvC79DUJYiWP/AVAnlJoqT
         gFGSzeLDRZZ2e9CftZD7DvEymtWaUbpabGX8NLbAV3HuIipenVT42HRbffkgwH7VZUIj
         gsgr7OIoS8ihWIgWSDxp+QvI0O/vyfqLt+9P868c6Rgw3vBILK0dFxf4SSBpSiJcW7mC
         /ELZCOFAUfw3RRNSaA0iif05nsmkYJhdKc9XG3Z02f9jWsr3Hgo3s6fP5TUTCdmZQnlO
         ygsNVl8lxUaLoe9gvOxUoBD/cDm81hdboTz2SIAK1DQOaLq8m6jrM90ucVL9+8kQI1J7
         m2Iw==
X-Gm-Message-State: AOAM5300bqhubwvNQM4vaySgudHBmn1UDVGB2pBreQcfFxXvcSBQ2IW3
        VmR/JCh54bIUL+MW3za6sh3m65NxUMU8ZV+VqVlDdmmagaHTVAqKAiPlrlCw8Xu1pQ8Z6+J1PmO
        BEeMfHahO7HtRFy4d8dg3Kg==
X-Received: by 2002:aca:59c3:: with SMTP id n186mr3167328oib.98.1623428518638;
        Fri, 11 Jun 2021 09:21:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8g03s5+63CjcVfNBJnpViDjp16Pi198FSYQqFDCwz6i9jA7qBf2Z0nd+M1V/nuiJtEzN7/A==
X-Received: by 2002:aca:59c3:: with SMTP id n186mr3167307oib.98.1623428518449;
        Fri, 11 Jun 2021 09:21:58 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m18sm1346345otr.61.2021.06.11.09.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 09:21:58 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski@canonical.com,
        dinguyen@kernel.org, nava.manne@xilinx.com, yilun.xu@intel.com,
        davidgow@google.com, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 2/4] fpga: xilinx: reorganize to subdir layout
Date:   Fri, 11 Jun 2021 09:21:27 -0700
Message-Id: <20210611162129.3203483-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210611162129.3203483-1-trix@redhat.com>
References: <20210611162129.3203483-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Follow drivers/net/ethernet/ which has control configs
NET_VENDOR_BLA that map to drivers/net/ethernet/bla
Since fpgas do not have many vendors, drop the 'VENDOR' and use
FPGA_BLA.

There are several new subdirs
altera/
dfl/
lattice/
xilinx/

Each subdir has a Kconfig that has a new/reused

if FPGA_BLA
  ... existing configs ...
endif FPGA_BLA

Which is sourced into the main fpga/Kconfig

Each subdir has a Makefile whose transversal is controlled in the
fpga/Makefile by

obj-$(CONFIG_FPGA_BLA) += bla/

This is the xilinx/ subdir part

Create a xilinx/ subdir
Move xilinx-* and zynq* files to it.
Add a Kconfig and Makefile

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig                          | 40 +-------------
 drivers/fpga/Makefile                         |  5 +-
 drivers/fpga/xilinx/Kconfig                   | 55 +++++++++++++++++++
 drivers/fpga/xilinx/Makefile                  |  6 ++
 .../fpga/{ => xilinx}/xilinx-pr-decoupler.c   |  0
 drivers/fpga/{ => xilinx}/xilinx-spi.c        |  0
 drivers/fpga/{ => xilinx}/zynq-fpga.c         |  0
 drivers/fpga/{ => xilinx}/zynqmp-fpga.c       |  0
 8 files changed, 63 insertions(+), 43 deletions(-)
 create mode 100644 drivers/fpga/xilinx/Kconfig
 create mode 100644 drivers/fpga/xilinx/Makefile
 rename drivers/fpga/{ => xilinx}/xilinx-pr-decoupler.c (100%)
 rename drivers/fpga/{ => xilinx}/xilinx-spi.c (100%)
 rename drivers/fpga/{ => xilinx}/zynq-fpga.c (100%)
 rename drivers/fpga/{ => xilinx}/zynqmp-fpga.c (100%)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index c427b25cc6f7e..657703b41b06e 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -52,25 +52,12 @@ config FPGA_MGR_ALTERA_CVP
 	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V,
 	  Arria 10 and Stratix10 Altera FPGAs using the CvP interface over PCIe.
 
-config FPGA_MGR_ZYNQ_FPGA
-	tristate "Xilinx Zynq FPGA"
-	depends on ARCH_ZYNQ || COMPILE_TEST
-	help
-	  FPGA manager driver support for Xilinx Zynq FPGAs.
-
 config FPGA_MGR_STRATIX10_SOC
 	tristate "Intel Stratix10 SoC FPGA Manager"
 	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
 	help
 	  FPGA manager driver support for the Intel Stratix10 SoC.
 
-config FPGA_MGR_XILINX_SPI
-	tristate "Xilinx Configuration over Slave Serial (SPI)"
-	depends on SPI
-	help
-	  FPGA manager driver support for Xilinx FPGA configuration
-	  over slave serial interface.
-
 config FPGA_MGR_ICE40_SPI
 	tristate "Lattice iCE40 SPI"
 	depends on OF && SPI
@@ -113,23 +100,6 @@ config ALTERA_FREEZE_BRIDGE
 	  isolate one region of the FPGA from the busses while that
 	  region is being reprogrammed.
 
-config XILINX_PR_DECOUPLER
-	tristate "Xilinx LogiCORE PR Decoupler"
-	depends on FPGA_BRIDGE
-	depends on HAS_IOMEM
-	help
-	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
-	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
-	  The PR Decoupler exists in the FPGA fabric to isolate one
-	  region of the FPGA from the busses while that region is
-	  being reprogrammed during partial reconfig.
-	  The Dynamic Function eXchange AXI shutdown manager prevents
-	  AXI traffic from passing through the bridge. The controller
-	  safely handles AXI4MM and AXI4-Lite interfaces on a
-	  Reconfigurable Partition when it is undergoing dynamic
-	  reconfiguration, preventing the system deadlock that can
-	  occur if AXI transactions are interrupted by DFX.
-
 config FPGA_REGION
 	tristate "FPGA Region"
 	depends on FPGA_BRIDGE
@@ -146,14 +116,6 @@ config OF_FPGA_REGION
 	  overlay.
 
 source "drivers/fpga/dfl/Kconfig"
-
-config FPGA_MGR_ZYNQMP_FPGA
-	tristate "Xilinx ZynqMP FPGA"
-	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
-	help
-	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
-	  This driver uses the processor configuration port(PCAP)
-	  to configure the programmable logic(PL) through PS
-	  on ZynqMP SoC.
+source "drivers/fpga/xilinx/Kconfig"
 
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index bda74e54ce390..0868c7c4264d8 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -15,9 +15,6 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
-obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
-obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
-obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
@@ -25,10 +22,10 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
 obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
-obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
 
 # High Level Interfaces
 obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
 obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 
 obj-$(CONFIG_FPGA_DFL) += dfl/
+obj-$(CONFIG_FPGA_XILINX) += xilinx/
diff --git a/drivers/fpga/xilinx/Kconfig b/drivers/fpga/xilinx/Kconfig
new file mode 100644
index 0000000000000..e016d450539a0
--- /dev/null
+++ b/drivers/fpga/xilinx/Kconfig
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config FPGA_XILINX
+	bool "Xilinx FPGAs"
+	default y
+	help
+	  If you have a xilinx fpga, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about xilinx fpgas. If you say Y, you will be asked
+	  for your specific device in the following questions.
+
+if FPGA_XILINX
+
+config FPGA_MGR_ZYNQ_FPGA
+	tristate "Xilinx Zynq FPGA"
+	depends on ARCH_ZYNQ || COMPILE_TEST
+	help
+	  FPGA manager driver support for Xilinx Zynq FPGAs.
+
+config FPGA_MGR_ZYNQMP_FPGA
+	tristate "Xilinx ZynqMP FPGA"
+	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
+	help
+	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
+	  This driver uses the processor configuration port(PCAP)
+	  to configure the programmable logic(PL) through PS
+	  on ZynqMP SoC.
+
+config XILINX_PR_DECOUPLER
+	tristate "Xilinx LogiCORE PR Decoupler"
+	depends on FPGA_BRIDGE
+	depends on HAS_IOMEM
+	help
+	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
+	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
+	  The PR Decoupler exists in the FPGA fabric to isolate one
+	  region of the FPGA from the busses while that region is
+	  being reprogrammed during partial reconfig.
+	  The Dynamic Function eXchange AXI shutdown manager prevents
+	  AXI traffic from passing through the bridge. The controller
+	  safely handles AXI4MM and AXI4-Lite interfaces on a
+	  Reconfigurable Partition when it is undergoing dynamic
+	  reconfiguration, preventing the system deadlock that can
+	  occur if AXI transactions are interrupted by DFX.
+
+config FPGA_MGR_XILINX_SPI
+	tristate "Xilinx Configuration over Slave Serial (SPI)"
+	depends on SPI
+	help
+	  FPGA manager driver support for Xilinx FPGA configuration
+	  over slave serial interface.
+
+endif #FPGA_XILINX
diff --git a/drivers/fpga/xilinx/Makefile b/drivers/fpga/xilinx/Makefile
new file mode 100644
index 0000000000000..2361aa14eb549
--- /dev/null
+++ b/drivers/fpga/xilinx/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_XILINX_PR_DECOUPLER) += xilinx-pr-decoupler.o
+obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += xilinx-spi.o
+obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA) += zynq-fpga.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA) += zynqmp-fpga.o
diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx/xilinx-pr-decoupler.c
similarity index 100%
rename from drivers/fpga/xilinx-pr-decoupler.c
rename to drivers/fpga/xilinx/xilinx-pr-decoupler.c
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx/xilinx-spi.c
similarity index 100%
rename from drivers/fpga/xilinx-spi.c
rename to drivers/fpga/xilinx/xilinx-spi.c
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/xilinx/zynq-fpga.c
similarity index 100%
rename from drivers/fpga/zynq-fpga.c
rename to drivers/fpga/xilinx/zynq-fpga.c
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/xilinx/zynqmp-fpga.c
similarity index 100%
rename from drivers/fpga/zynqmp-fpga.c
rename to drivers/fpga/xilinx/zynqmp-fpga.c
-- 
2.26.3

