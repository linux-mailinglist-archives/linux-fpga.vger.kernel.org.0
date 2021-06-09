Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDC93A156C
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhFINZC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 09:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234605AbhFINZB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Jun 2021 09:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623244987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92YiPexxYpFlIHYIfUzcajyREjX7dCB4H6SLkcvlG4w=;
        b=Yx6Ty0kM/fA3NdfefXZAbouUBjNpaVkFT8r+CdqT34TLOT+6v45sSqswP1ElQY9t4EDp67
        VW6XlO0XpfeipNun6M2QDDVI+/26xd28cfNGDg8UTIaWF2ynVzLrm7N8XOKReWC6M4MUhe
        wBr8KJ0Q2icdVt8zUsU2ZqkJm9Cs+Ck=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-J7UWsI_AOPGdaogFVYe4Pw-1; Wed, 09 Jun 2021 09:23:06 -0400
X-MC-Unique: J7UWsI_AOPGdaogFVYe4Pw-1
Received: by mail-oo1-f69.google.com with SMTP id n16-20020a0568200550b029020b438b2591so15524576ooj.19
        for <linux-fpga@vger.kernel.org>; Wed, 09 Jun 2021 06:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92YiPexxYpFlIHYIfUzcajyREjX7dCB4H6SLkcvlG4w=;
        b=nxT3fwqanubLM2Pb7l8lWDLqnCp2upBT+zZWnfeK8HFkwvhS8tF8tw46UzWyjUFx++
         sefXvLEIjrzfW6HDydjopDBupDGSEq15CXSz6v2lcBAV8/bKcfeXgMunMY83P59lHY2i
         YkGC+owJBLFSIUWQMvBA8apsfvzzfP2byPeJpka2PbfYZ6t7gmiSc14zulYgwPye+3+g
         kQ2XBTZQs14yeLn1eTWTeSYJPv+1sQryG0VwslVdqOcz2o4v85XF2AdCg+J79xD/Z/MN
         w5EUUZDzFbyT/O1GJjfud60s46sgEo6lvBHMFPLgGThAjdrD6LZUHuB4Cps3+xPNvMAg
         hwjA==
X-Gm-Message-State: AOAM530PE72QJFqWKcD3ITBrkrJjAXBQJ6syqteQ1ivgyY260YRjvrtE
        o6uuKaI2WutrwNOS+gfLBhI2v4pk4envB4vyF+P4nDByPbjbpnK7ehn9pdr0QBe/kWc/O3Y4Etd
        lp34dMtYP8h2pGtPZ9SE4tA==
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr2735062otq.73.1623244985016;
        Wed, 09 Jun 2021 06:23:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPMIpjxRX4dadpgXM5m40PYb26wDF4WHHQmibOXeVOj7sfKA78mnLLazA+DThMByerKnUIJw==
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr2735042otq.73.1623244984756;
        Wed, 09 Jun 2021 06:23:04 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 21sm3165654otd.21.2021.06.09.06.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:23:04 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 1/7] fpga: dfl: reorganize to subdir layout
Date:   Wed,  9 Jun 2021 06:21:45 -0700
Message-Id: <20210609132151.3081379-3-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210609132151.3081379-1-trix@redhat.com>
References: <20210609132151.3081379-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Create a dfl/ subdir
Move dfl-* files to it.
Add a Kconfig and Makefile

Because FPGA_DFL is now used in dfl/Kconfig in a if/endif
block, all the other configs in dfl/Kconfig implicitly depend
on FPGA_DFL.  So the explict dependence can be removed.  Also
since FPGA_DFL depends on HAS_IOMEM, it can be removed from the
other configs.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS                                 |  2 +-
 drivers/fpga/Kconfig                        | 80 +-------------------
 drivers/fpga/Makefile                       | 18 +----
 drivers/fpga/dfl/Kconfig                    | 81 +++++++++++++++++++++
 drivers/fpga/dfl/Makefile                   | 19 +++++
 drivers/fpga/{ => dfl}/dfl-afu-dma-region.c |  0
 drivers/fpga/{ => dfl}/dfl-afu-error.c      |  0
 drivers/fpga/{ => dfl}/dfl-afu-main.c       |  0
 drivers/fpga/{ => dfl}/dfl-afu-region.c     |  0
 drivers/fpga/{ => dfl}/dfl-afu.h            |  0
 drivers/fpga/{ => dfl}/dfl-fme-br.c         |  0
 drivers/fpga/{ => dfl}/dfl-fme-error.c      |  0
 drivers/fpga/{ => dfl}/dfl-fme-main.c       |  0
 drivers/fpga/{ => dfl}/dfl-fme-mgr.c        |  0
 drivers/fpga/{ => dfl}/dfl-fme-perf.c       |  0
 drivers/fpga/{ => dfl}/dfl-fme-pr.c         |  0
 drivers/fpga/{ => dfl}/dfl-fme-pr.h         |  0
 drivers/fpga/{ => dfl}/dfl-fme-region.c     |  0
 drivers/fpga/{ => dfl}/dfl-fme.h            |  0
 drivers/fpga/{ => dfl}/dfl-n3000-nios.c     |  0
 drivers/fpga/{ => dfl}/dfl-pci.c            |  0
 drivers/fpga/{ => dfl}/dfl.c                |  0
 drivers/fpga/{ => dfl}/dfl.h                |  0
 23 files changed, 103 insertions(+), 97 deletions(-)
 create mode 100644 drivers/fpga/dfl/Kconfig
 create mode 100644 drivers/fpga/dfl/Makefile
 rename drivers/fpga/{ => dfl}/dfl-afu-dma-region.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu-error.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu-main.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu-region.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu.h (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-br.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-error.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-main.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-mgr.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-perf.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-pr.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-pr.h (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-region.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme.h (100%)
 rename drivers/fpga/{ => dfl}/dfl-n3000-nios.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-pci.c (100%)
 rename drivers/fpga/{ => dfl}/dfl.c (100%)
 rename drivers/fpga/{ => dfl}/dfl.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1be6895a143d2..46ef3af06ba53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7201,7 +7201,7 @@ L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-dfl*
 F:	Documentation/fpga/dfl.rst
-F:	drivers/fpga/dfl*
+F:	drivers/fpga/dfl/
 F:	drivers/uio/uio_dfl.c
 F:	include/linux/dfl.h
 F:	include/uapi/linux/fpga-dfl.h
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 33e15058d0dc7..c427b25cc6f7e 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -145,85 +145,7 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
-config FPGA_DFL
-	tristate "FPGA Device Feature List (DFL) support"
-	select FPGA_BRIDGE
-	select FPGA_REGION
-	depends on HAS_IOMEM
-	help
-	  Device Feature List (DFL) defines a feature list structure that
-	  creates a linked list of feature headers within the MMIO space
-	  to provide an extensible way of adding features for FPGA.
-	  Driver can walk through the feature headers to enumerate feature
-	  devices (e.g. FPGA Management Engine, Port and Accelerator
-	  Function Unit) and their private features for target FPGA devices.
-
-	  Select this option to enable common support for Field-Programmable
-	  Gate Array (FPGA) solutions which implement Device Feature List.
-	  It provides enumeration APIs and feature device infrastructure.
-
-config FPGA_DFL_FME
-	tristate "FPGA DFL FME Driver"
-	depends on FPGA_DFL && HWMON && PERF_EVENTS
-	help
-	  The FPGA Management Engine (FME) is a feature device implemented
-	  under Device Feature List (DFL) framework. Select this option to
-	  enable the platform device driver for FME which implements all
-	  FPGA platform level management features. There shall be one FME
-	  per DFL based FPGA device.
-
-config FPGA_DFL_FME_MGR
-	tristate "FPGA DFL FME Manager Driver"
-	depends on FPGA_DFL_FME && HAS_IOMEM
-	help
-	  Say Y to enable FPGA Manager driver for FPGA Management Engine.
-
-config FPGA_DFL_FME_BRIDGE
-	tristate "FPGA DFL FME Bridge Driver"
-	depends on FPGA_DFL_FME && HAS_IOMEM
-	help
-	  Say Y to enable FPGA Bridge driver for FPGA Management Engine.
-
-config FPGA_DFL_FME_REGION
-	tristate "FPGA DFL FME Region Driver"
-	depends on FPGA_DFL_FME && HAS_IOMEM
-	help
-	  Say Y to enable FPGA Region driver for FPGA Management Engine.
-
-config FPGA_DFL_AFU
-	tristate "FPGA DFL AFU Driver"
-	depends on FPGA_DFL
-	help
-	  This is the driver for FPGA Accelerated Function Unit (AFU) which
-	  implements AFU and Port management features. A User AFU connects
-	  to the FPGA infrastructure via a Port. There may be more than one
-	  Port/AFU per DFL based FPGA device.
-
-config FPGA_DFL_NIOS_INTEL_PAC_N3000
-	tristate "FPGA DFL NIOS Driver for Intel PAC N3000"
-	depends on FPGA_DFL
-	select REGMAP
-	help
-	  This is the driver for the N3000 Nios private feature on Intel
-	  PAC (Programmable Acceleration Card) N3000. It communicates
-	  with the embedded Nios processor to configure the retimers on
-	  the card. It also instantiates the SPI master (spi-altera) for
-	  the card's BMC (Board Management Controller).
-
-config FPGA_DFL_PCI
-	tristate "FPGA DFL PCIe Device Driver"
-	depends on PCI && FPGA_DFL
-	help
-	  Select this option to enable PCIe driver for PCIe-based
-	  Field-Programmable Gate Array (FPGA) solutions which implement
-	  the Device Feature List (DFL). This driver provides interfaces
-	  for userspace applications to configure, enumerate, open and access
-	  FPGA accelerators on the FPGA DFL devices, enables system level
-	  management functions such as FPGA partial reconfiguration, power
-	  management and virtualization with DFL framework and DFL feature
-	  device drivers.
-
-	  To compile this as a module, choose M here.
+source "drivers/fpga/dfl/Kconfig"
 
 config FPGA_MGR_ZYNQMP_FPGA
 	tristate "Xilinx ZynqMP FPGA"
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 18dc9885883a2..bda74e54ce390 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -31,20 +31,4 @@ obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
 obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
 obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 
-# FPGA Device Feature List Support
-obj-$(CONFIG_FPGA_DFL)			+= dfl.o
-obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
-obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
-obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
-obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
-obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
-
-dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o dfl-fme-error.o
-dfl-fme-objs += dfl-fme-perf.o
-dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
-dfl-afu-objs += dfl-afu-error.o
-
-obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
-
-# Drivers for FPGAs which implement DFL
-obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+obj-$(CONFIG_FPGA_DFL) += dfl/
diff --git a/drivers/fpga/dfl/Kconfig b/drivers/fpga/dfl/Kconfig
new file mode 100644
index 0000000000000..1f5ce42f63e44
--- /dev/null
+++ b/drivers/fpga/dfl/Kconfig
@@ -0,0 +1,81 @@
+config FPGA_DFL
+	tristate "FPGA Device Feature List (DFL) support"
+	select FPGA_BRIDGE
+	select FPGA_REGION
+	depends on HAS_IOMEM
+	help
+	  Device Feature List (DFL) defines a feature list structure that
+	  creates a linked list of feature headers within the MMIO space
+	  to provide an extensible way of adding features for FPGA.
+	  Driver can walk through the feature headers to enumerate feature
+	  devices (e.g. FPGA Management Engine, Port and Accelerator
+	  Function Unit) and their private features for target FPGA devices.
+
+	  Select this option to enable common support for Field-Programmable
+	  Gate Array (FPGA) solutions which implement Device Feature List.
+	  It provides enumeration APIs and feature device infrastructure.
+
+if FPGA_DFL
+
+config FPGA_DFL_FME
+	tristate "FPGA DFL FME Driver"
+	depends on HWMON && PERF_EVENTS
+	help
+	  The FPGA Management Engine (FME) is a feature device implemented
+	  under Device Feature List (DFL) framework. Select this option to
+	  enable the platform device driver for FME which implements all
+	  FPGA platform level management features. There shall be one FME
+	  per DFL based FPGA device.
+
+config FPGA_DFL_FME_MGR
+	tristate "FPGA DFL FME Manager Driver"
+	depends on FPGA_DFL_FME
+	help
+	  Say Y to enable FPGA Manager driver for FPGA Management Engine.
+
+config FPGA_DFL_FME_BRIDGE
+	tristate "FPGA DFL FME Bridge Driver"
+	depends on FPGA_DFL_FME
+	help
+	  Say Y to enable FPGA Bridge driver for FPGA Management Engine.
+
+config FPGA_DFL_FME_REGION
+	tristate "FPGA DFL FME Region Driver"
+	depends on FPGA_DFL_FME
+	help
+	  Say Y to enable FPGA Region driver for FPGA Management Engine.
+
+config FPGA_DFL_AFU
+	tristate "FPGA DFL AFU Driver"
+	help
+	  This is the driver for FPGA Accelerated Function Unit (AFU) which
+	  implements AFU and Port management features. A User AFU connects
+	  to the FPGA infrastructure via a Port. There may be more than one
+	  Port/AFU per DFL based FPGA device.
+
+config FPGA_DFL_NIOS_INTEL_PAC_N3000
+	tristate "FPGA DFL NIOS Driver for Intel PAC N3000"
+	select REGMAP
+	help
+	  This is the driver for the N3000 Nios private feature on Intel
+	  PAC (Programmable Acceleration Card) N3000. It communicates
+	  with the embedded Nios processor to configure the retimers on
+	  the card. It also instantiates the SPI master (spi-altera) for
+	  the card's BMC (Board Management Controller).
+
+config FPGA_DFL_PCI
+	tristate "FPGA DFL PCIe Device Driver"
+	depends on PCI
+	help
+	  Select this option to enable PCIe driver for PCIe-based
+	  Field-Programmable Gate Array (FPGA) solutions which implement
+	  the Device Feature List (DFL). This driver provides interfaces
+	  for userspace applications to configure, enumerate, open and access
+	  FPGA accelerators on the FPGA DFL devices, enables system level
+	  management functions such as FPGA partial reconfiguration, power
+	  management and virtualization with DFL framework and DFL feature
+	  device drivers.
+
+	  To compile this as a module, choose M here.
+
+endif #FPGA_DFL
diff --git a/drivers/fpga/dfl/Makefile b/drivers/fpga/dfl/Makefile
new file mode 100644
index 0000000000000..724792039026f
--- /dev/null
+++ b/drivers/fpga/dfl/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# FPGA Device Feature List (DFL) Support
+obj-$(CONFIG_FPGA_DFL) += dfl.o
+obj-$(CONFIG_FPGA_DFL_AFU) += dfl-afu.o
+obj-$(CONFIG_FPGA_DFL_FME) += dfl-fme.o
+obj-$(CONFIG_FPGA_DFL_FME_BRIDGE) += dfl-fme-br.o
+obj-$(CONFIG_FPGA_DFL_FME_MGR) += dfl-fme-mgr.o
+obj-$(CONFIG_FPGA_DFL_FME_REGION) += dfl-fme-region.o
+obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000) += dfl-n3000-nios.o
+obj-$(CONFIG_FPGA_DFL_PCI) += dfl-pci.o
+
+dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o dfl-fme-error.o		\
+                dfl-fme-perf.o
+dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o	\
+                dfl-afu-error.o
+
+
+
diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl/dfl-afu-dma-region.c
similarity index 100%
rename from drivers/fpga/dfl-afu-dma-region.c
rename to drivers/fpga/dfl/dfl-afu-dma-region.c
diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl/dfl-afu-error.c
similarity index 100%
rename from drivers/fpga/dfl-afu-error.c
rename to drivers/fpga/dfl/dfl-afu-error.c
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl/dfl-afu-main.c
similarity index 100%
rename from drivers/fpga/dfl-afu-main.c
rename to drivers/fpga/dfl/dfl-afu-main.c
diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl/dfl-afu-region.c
similarity index 100%
rename from drivers/fpga/dfl-afu-region.c
rename to drivers/fpga/dfl/dfl-afu-region.c
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl/dfl-afu.h
similarity index 100%
rename from drivers/fpga/dfl-afu.h
rename to drivers/fpga/dfl/dfl-afu.h
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl/dfl-fme-br.c
similarity index 100%
rename from drivers/fpga/dfl-fme-br.c
rename to drivers/fpga/dfl/dfl-fme-br.c
diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl/dfl-fme-error.c
similarity index 100%
rename from drivers/fpga/dfl-fme-error.c
rename to drivers/fpga/dfl/dfl-fme-error.c
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl/dfl-fme-main.c
similarity index 100%
rename from drivers/fpga/dfl-fme-main.c
rename to drivers/fpga/dfl/dfl-fme-main.c
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl/dfl-fme-mgr.c
similarity index 100%
rename from drivers/fpga/dfl-fme-mgr.c
rename to drivers/fpga/dfl/dfl-fme-mgr.c
diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl/dfl-fme-perf.c
similarity index 100%
rename from drivers/fpga/dfl-fme-perf.c
rename to drivers/fpga/dfl/dfl-fme-perf.c
diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl/dfl-fme-pr.c
similarity index 100%
rename from drivers/fpga/dfl-fme-pr.c
rename to drivers/fpga/dfl/dfl-fme-pr.c
diff --git a/drivers/fpga/dfl-fme-pr.h b/drivers/fpga/dfl/dfl-fme-pr.h
similarity index 100%
rename from drivers/fpga/dfl-fme-pr.h
rename to drivers/fpga/dfl/dfl-fme-pr.h
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl/dfl-fme-region.c
similarity index 100%
rename from drivers/fpga/dfl-fme-region.c
rename to drivers/fpga/dfl/dfl-fme-region.c
diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl/dfl-fme.h
similarity index 100%
rename from drivers/fpga/dfl-fme.h
rename to drivers/fpga/dfl/dfl-fme.h
diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl/dfl-n3000-nios.c
similarity index 100%
rename from drivers/fpga/dfl-n3000-nios.c
rename to drivers/fpga/dfl/dfl-n3000-nios.c
diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl/dfl-pci.c
similarity index 100%
rename from drivers/fpga/dfl-pci.c
rename to drivers/fpga/dfl/dfl-pci.c
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl/dfl.c
similarity index 100%
rename from drivers/fpga/dfl.c
rename to drivers/fpga/dfl/dfl.c
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl/dfl.h
similarity index 100%
rename from drivers/fpga/dfl.h
rename to drivers/fpga/dfl/dfl.h
-- 
2.26.3

