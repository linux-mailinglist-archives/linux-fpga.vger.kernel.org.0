Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2333A156E
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 15:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbhFINZG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 09:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235972AbhFINZE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Jun 2021 09:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623244990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvFqgoXbMqYdld4DmESpGVSZB3RoZyxfbp1QAtbqos0=;
        b=dJGxbb6JVr94XKJKFeEd8312jG2PKcZYpFB5Vy8gss7i6AfTJi/ZUa+g1luFAveKVOk0gB
        JR0l/kQqon3f5duX+qO4ROfiI6+LCVvO0BulaBlMaTGCnBdgvWZ1/iKH/nuMUSPDbOiFa3
        YBunU3oG57uol0zmJWKAI2PD6GCi2ww=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-IA6L6LtxMUa4XUKxmBO5Pg-1; Wed, 09 Jun 2021 09:23:09 -0400
X-MC-Unique: IA6L6LtxMUa4XUKxmBO5Pg-1
Received: by mail-oi1-f200.google.com with SMTP id r19-20020acaa8130000b02901f41b1b235bso3800004oie.9
        for <linux-fpga@vger.kernel.org>; Wed, 09 Jun 2021 06:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvFqgoXbMqYdld4DmESpGVSZB3RoZyxfbp1QAtbqos0=;
        b=YDji3ueQjzjJj3NF7RKnZoneOqlnJRmRtQM292Ui3HxY5fIFwfNjAyQ5BCVM4j3leI
         ALlYRBQ/GCkPNUgsn8N/FmVyR5LcX9WM/8uKCCObDgrgEH/72MAGM1tlDBLpf3T7A6Hb
         8y4ejz/zmbUtACTKYIhZZ7IlmIzkh3qv48Qwu88grzpCj9qDUfILQbOcqwg1REaIHEsT
         d2Z4A5Bg8AKtQrie/6VK8OE29ilSxBxyYaN7tSupKAp4Er+Aquk3quyGK5wJbi57V4jm
         PDNjULeHsbJT6uptri4rpPW0OPaW0JkBvxTA4KLNGxyMLx9MtK+Frrpl9bNgIO40GUpt
         Ny6w==
X-Gm-Message-State: AOAM533/tWOaV0YyHJ2Ajmaikdp8inOWsgSuasiv5m1+7bcpBz2nnaRS
        fc1poP/HFPm85eNsyqTCG4CnEwlTX5RQCWtr4BbspDZPcm06fFpVX17F92XOBItx5VCnFCnMPGW
        SZdmxZN3Y0xueYDm9rOVVvQ==
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr22568497otj.369.1623244988222;
        Wed, 09 Jun 2021 06:23:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7QRjBg+gi5RVOVaFJZtZGRHgUKmOXOl/EGosz1au0ojize/ADUAoiEJmP2WB1Tnm7Sq0yVw==
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr22568483otj.369.1623244988022;
        Wed, 09 Jun 2021 06:23:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 21sm3165654otd.21.2021.06.09.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:23:07 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 2/7] fpga: xilinx: reorganize to subdir layout
Date:   Wed,  9 Jun 2021 06:21:46 -0700
Message-Id: <20210609132151.3081379-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210609132151.3081379-1-trix@redhat.com>
References: <20210609132151.3081379-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Create a xilinx/ subdir
Move xilinx-* and zynq* files to it.
Add a Kconfig and Makefile

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig                          | 40 +---------------
 drivers/fpga/Makefile                         |  5 +-
 drivers/fpga/xilinx/Kconfig                   | 48 +++++++++++++++++++
 drivers/fpga/xilinx/Makefile                  |  8 ++++
 .../fpga/{ => xilinx}/xilinx-pr-decoupler.c   |  0
 drivers/fpga/{ => xilinx}/xilinx-spi.c        |  0
 drivers/fpga/{ => xilinx}/zynq-fpga.c         |  0
 drivers/fpga/{ => xilinx}/zynqmp-fpga.c       |  0
 8 files changed, 58 insertions(+), 43 deletions(-)
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
index 0000000000000..1ef0b6a34ae0c
--- /dev/null
+++ b/drivers/fpga/xilinx/Kconfig
@@ -0,0 +1,48 @@
+config FPGA_XILINX
+	bool "Xilinx Devices"
+	default y
+	help
+	  If you have a xilinx fpga, say Y.
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
index 0000000000000..7bb7543412790
--- /dev/null
+++ b/drivers/fpga/xilinx/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_XILINX_PR_DECOUPLER) += xilinx-pr-decoupler.o
+obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += xilinx-spi.o
+obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA) += zynq-fpga.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA) += zynqmp-fpga.o
+
+
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

