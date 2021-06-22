Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883693B0E27
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Jun 2021 22:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhFVUIO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 16:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231284AbhFVUII (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 16:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624392351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imf/vwZqsVLuWA6Zj9H7KFtay/Cl1NHRkS3APpZDlCY=;
        b=JvMx8Ewvn2clRejuSDUvBLyz0F4+aI7c8XZ8XKqpozSd446wyRJRDwNBotciQ9VzXWCVcS
        7vmrPLLeUIj4Z2sdALdiZ5u9EaGyzBWuygGwhnt/aK8d97r84mQw8MR7ZecO6v4s3yXlci
        U0sKjAYoNwajxoqp9BrG7ZScO1VhISo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-OwkqezQJNZCtN0A2TkQgZw-1; Tue, 22 Jun 2021 16:05:50 -0400
X-MC-Unique: OwkqezQJNZCtN0A2TkQgZw-1
Received: by mail-oi1-f200.google.com with SMTP id w125-20020acac6830000b029021ecc100d7bso356777oif.6
        for <linux-fpga@vger.kernel.org>; Tue, 22 Jun 2021 13:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imf/vwZqsVLuWA6Zj9H7KFtay/Cl1NHRkS3APpZDlCY=;
        b=Bz37TYwLPeGGjr0KMz0XeY2X+wtaVhlvfAQ/LicfWb8uVRJwAqu2hrgaiceLIIT9Im
         YaGM6qoplO4HuFi1FH5wZvgafeeFpBu7yf+SMh9PriDgaNKAIfeU8u4MuDR4pNZ2D2Wb
         cPk4rdTV38LQW1/2Ka8/5Bit+svAxh8W+yY54BgaClXtMepVuTDDVXW1Vn9p3ZEP4tZq
         HemKIjmP4yFSTXdr19dX5eAamxT67jbpdMmU9SgQbpPUi9EjHjuRapE+w6XewTZnXpZb
         wJx+6ioVID0D1oFeAWvI7UQoI91gfLKDeS1jAMD+ypnGVhHix2oIHoaA/494H2jdPyoK
         d5qw==
X-Gm-Message-State: AOAM531VdBI0QpzY6pBpApq8ifrNClqXiNLgc2LMwgz+LCuegjRYtveU
        /PX+0Br0iBE0CEVTRytoYMn4UtwbnE5PlW1o740HzYmCdg8WpDNwphFaqdcj6vWF91ix8hhLWp9
        JXVZjFGDscaFbfq28msKSxw==
X-Received: by 2002:a9d:4a8a:: with SMTP id i10mr4544223otf.282.1624392349598;
        Tue, 22 Jun 2021 13:05:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB2HYaGn7Ntv/RbG7ZFn0Q4qdBrZKMihLvCvoEmZgw8dpenxZvmaxhXAOMHsGVrGQSs70GlQ==
X-Received: by 2002:a9d:4a8a:: with SMTP id i10mr4544201otf.282.1624392349363;
        Tue, 22 Jun 2021 13:05:49 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 5sm727184oot.29.2021.06.22.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 13:05:48 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        davidgow@google.com, fpacheco@redhat.com,
        russell.h.weight@intel.com, richard.gong@intel.com,
        luca@lucaceresoli.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v5 2/4] fpga: xilinx: reorganize to subdir layout
Date:   Tue, 22 Jun 2021 13:05:09 -0700
Message-Id: <20210622200511.3739914-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210622200511.3739914-1-trix@redhat.com>
References: <20210622200511.3739914-1-trix@redhat.com>
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
index 7a290b2234576..28c261807b428 100644
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
index 0000000000000..b907f9793195c
--- /dev/null
+++ b/drivers/fpga/xilinx/Kconfig
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config FPGA_XILINX
+	bool "Xilinx FPGAs"
+	default y
+	help
+	  If you have a Xilinx FPGA, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Xilinx FPGAs. If you say Y, you will be asked
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

