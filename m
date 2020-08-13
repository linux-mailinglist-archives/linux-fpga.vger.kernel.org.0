Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193212434D5
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Aug 2020 09:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHMHVz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Aug 2020 03:21:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:3437 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgHMHVy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 13 Aug 2020 03:21:54 -0400
IronPort-SDR: CFB+SbkkClcpc5YG/mA7soDC7jqR0IiX08Ys6Npp8QxX7S1WsInU4WWc0X4YAnCMuEpU3BB4yG
 5LghvN6hlewQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="239010533"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="239010533"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 00:21:53 -0700
IronPort-SDR: jPapyTB1+U9Mi950ouj+ofoDXT2CidHqpYAgnCadO3xyrc3lSGziAmCM0gy0MWFy3z6M7AG7jX
 q4mPUbO8cyuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="439679767"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 13 Aug 2020 00:21:50 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v5 3/3] fpga: dfl: add support for N3000 Nios private feature
Date:   Thu, 13 Aug 2020 15:18:00 +0800
Message-Id: <1597303080-30640-4-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597303080-30640-1-git-send-email-yilun.xu@intel.com>
References: <1597303080-30640-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds support for the Nios handshake private feature on Intel
PAC (Programmable Acceleration Card) N3000.

The Nios is the embedded processor on the FPGA card. This private feature
provides a handshake interface to FPGA Nois firmware, which receives
retimer configuration command from host and executes via an internal SPI
master (spi-altera). When Nios finishes the configuration, host takes over
the ownership of the SPI master to control an Intel MAX10 BMC (Board
Management Controller) Chip on the SPI bus.

For Nios firmware handshake part, this driver requests the retimer
configuration for Nios with parameters from module param, and adds some
sysfs nodes for user to query the onboard retimer's working mode and
Nios firmware version.

For SPI part, this driver adds a spi-altera platform device as well as
the MAX10 BMC spi slave info. A spi-altera driver will be matched to
handle the following SPI work.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3: Add the doc for this driver
    Minor fixes for comments from Tom
v4: Move the err log in regmap implementation, and delete
     n3000_nios_writel/readl(), they have nothing to wrapper now.
    Some minor fixes and comments improvement.
v5: Fix the output of fec_mode sysfs inf to "no" on 10G configuration,
    cause no FEC mode could be configured for 10G.
    Rename the dfl_n3000_nios_* to n3000_nios_*
    Improves comments.
---
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  18 +
 Documentation/fpga/dfl-n3000-nios.rst              |  45 ++
 Documentation/fpga/index.rst                       |   1 +
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 528 +++++++++++++++++++++
 6 files changed, 605 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
 create mode 100644 drivers/fpga/dfl-n3000-nios.c

diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
new file mode 100644
index 0000000..221d635
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
@@ -0,0 +1,18 @@
+What:		/sys/bus/dfl/devices/dfl_dev.X/fec_mode
+Date:		Aug 2020
+KernelVersion:	5.10
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. It returns the FEC mode of the ethernet retimer
+		configured by NIOS firmware. "rs" for Reed Solomon FEC, "kr"
+		for Fire Code FEC, "no" FOR NO FEC. The FEC mode could be set
+		by module parameters, but it could only be set once after the
+		board powers up.
+		Format: string
+
+What:		/sys/bus/dfl/devices/dfl_dev.X/nios_fw_version
+Date:		Aug 2020
+KernelVersion:	5.10
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. It returns the NIOS firmware version in FPGA. Its
+		format is "major.minor.patch".
+		Format: %x.%x.%x
diff --git a/Documentation/fpga/dfl-n3000-nios.rst b/Documentation/fpga/dfl-n3000-nios.rst
new file mode 100644
index 0000000..c562aab
--- /dev/null
+++ b/Documentation/fpga/dfl-n3000-nios.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+N3000 Nios Private Feature Driver
+=================================
+
+The N3000 Nios driver supports for the Nios handshake private feature on Intel
+PAC (Programmable Acceleration Card) N3000.
+
+The Nios is the embedded processor on the FPGA card. This private feature
+provides a handshake interface to FPGA Nios firmware, which receives the
+ethernet retimer configuration command from host and does the configuration via
+an internal SPI master (spi-altera). When Nios finishes the configuration, host
+takes over the ownership of the SPI master to control an Intel MAX10 BMC (Board
+Management Controller) Chip on the SPI bus.
+
+So the driver does 2 major tasks on probe, uses the Nios firmware to configure
+the ethernet retimer, and then creates a spi master platform device with the
+MAX10 device info in spi_board_info.
+
+Module Parameters
+=================
+
+The N3000 Nios driver supports the following module parameters:
+
+* fec_mode: string
+  Require the Nios firmware to set the FEC (Forward Error Correction) mode of
+  the ethernet retimer on the Intel PAC N3000. The possible values could be:
+
+  - "rs": Reed Solomon FEC (default)
+  - "kr": Fire Code FEC
+  - "no": No FEC
+
+  The configuration can only be set once after the board powers up, the
+  firmware will not accept second configuration afterward. So it is not proper
+  to have a RW sysfs node for the FEC mode. A better way is that we set the FEC
+  mode on driver probe according to the module parameter from user, and create
+  a RO sysfs node for the FEC mode query.
+
+  Besides, the fec mode will not be changed if the module is reloaded with a
+  different param value.
+
+  The configured value of the fec mode could be queried from sysfs node:
+
+  /sys/bus/dfl/devices/dfl_dev.X/fec_mode
diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
index f80f956..5fd3c37 100644
--- a/Documentation/fpga/index.rst
+++ b/Documentation/fpga/index.rst
@@ -8,6 +8,7 @@ fpga
     :maxdepth: 1
 
     dfl
+    dfl-n3000-nios
 
 .. only::  subproject and html
 
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7cd5a29..f6252cd 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -191,6 +191,17 @@ config FPGA_DFL_AFU
 	  to the FPGA infrastructure via a Port. There may be more than one
 	  Port/AFU per DFL based FPGA device.
 
+config FPGA_DFL_N3000_NIOS
+        tristate "FPGA DFL N3000 NIOS Driver"
+        depends on FPGA_DFL
+        select REGMAP
+        help
+	  This is the driver for the N3000 Nios private feature on Intel
+	  PAC (Programmable Acceleration Card) N3000. It communicates
+	  with the embedded Nios processor to configure the retimers on
+	  the card. It also instantiates the SPI master (spi-altera) for
+	  the card's BMC (Board Management Controller) control.
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index d8e21df..27f20f2 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -44,5 +44,7 @@ dfl-fme-objs += dfl-fme-perf.o
 dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
 dfl-afu-objs += dfl-afu-error.o
 
+obj-$(CONFIG_FPGA_DFL_N3000_NIOS)      += dfl-n3000-nios.o
+
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
new file mode 100644
index 0000000..aeac224
--- /dev/null
+++ b/drivers/fpga/dfl-n3000-nios.c
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DFL device driver for Nios private feature on Intel PAC (Programmable
+ * Acceleration Card) N3000
+ *
+ * Copyright (C) 2019-2020 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@intel.com>
+ *   Xu Yilun <yilun.xu@intel.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/stddef.h>
+#include <linux/spi/altera.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "dfl.h"
+
+static char *fec_mode = "rs";
+module_param(fec_mode, charp, 0444);
+MODULE_PARM_DESC(fec_mode, "FEC mode of the ethernet retimer on Intel PAC N3000");
+
+/* N3000 Nios private feature registers */
+#define NIOS_SPI_PARAM			0x8
+#define PARAM_SHIFT_MODE_MSK		BIT_ULL(1)
+#define PARAM_SHIFT_MODE_MSB		0
+#define PARAM_SHIFT_MODE_LSB		1
+#define PARAM_DATA_WIDTH		GENMASK_ULL(7, 2)
+#define PARAM_NUM_CS			GENMASK_ULL(13, 8)
+#define PARAM_CLK_POL			BIT_ULL(14)
+#define PARAM_CLK_PHASE			BIT_ULL(15)
+#define PARAM_PERIPHERAL_ID		GENMASK_ULL(47, 32)
+
+#define NIOS_SPI_CTRL			0x10
+#define CTRL_WR_DATA			GENMASK_ULL(31, 0)
+#define CTRL_ADDR			GENMASK_ULL(44, 32)
+#define CTRL_CMD_MSK			GENMASK_ULL(63, 62)
+#define CTRL_CMD_NOP			0
+#define CTRL_CMD_RD			1
+#define CTRL_CMD_WR			2
+
+#define NIOS_SPI_STAT			0x18
+#define STAT_RD_DATA			GENMASK_ULL(31, 0)
+#define STAT_RW_VAL			BIT_ULL(32)
+
+/* Nios handshake registers, indirect access */
+#define NIOS_INIT			0x1000
+#define NIOS_INIT_DONE			BIT(0)
+#define NIOS_INIT_START			BIT(1)
+/* Mode for PKVL A, link 0, the same below */
+#define REQ_FEC_MODE_A0_MSK		GENMASK(9, 8)
+#define REQ_FEC_MODE_A1_MSK		GENMASK(11, 10)
+#define REQ_FEC_MODE_A2_MSK		GENMASK(13, 12)
+#define REQ_FEC_MODE_A3_MSK		GENMASK(15, 14)
+#define REQ_FEC_MODE_B0_MSK		GENMASK(17, 16)
+#define REQ_FEC_MODE_B1_MSK		GENMASK(19, 18)
+#define REQ_FEC_MODE_B2_MSK		GENMASK(21, 20)
+#define REQ_FEC_MODE_B3_MSK		GENMASK(23, 22)
+#define REQ_FEC_MODE_NO			0x0
+#define REQ_FEC_MODE_KR			0x1
+#define REQ_FEC_MODE_RS			0x2
+
+#define NIOS_FW_VERSION			0x1004
+#define NIOS_FW_VERSION_PATCH		GENMASK(23, 20)
+#define NIOS_FW_VERSION_MINOR		GENMASK(27, 24)
+#define NIOS_FW_VERSION_MAJOR		GENMASK(31, 28)
+
+#define PKVL_A_MODE_STS			0x1020
+#define PKVL_B_MODE_STS			0x1024
+#define PKVL_MODE_STS_GROUP_MSK		GENMASK(15, 8)
+#define PKVL_MODE_STS_GROUP_OK		0x0
+#define PKVL_MODE_STS_ID_MSK		GENMASK(7, 0)
+/* When GROUP MASK field == GROUP_OK  */
+#define PKVL_MODE_ID_RESET		0x0
+#define PKVL_MODE_ID_4X10G		0x1
+#define PKVL_MODE_ID_4X25G		0x2
+#define PKVL_MODE_ID_2X25G		0x3
+#define PKVL_MODE_ID_2X25G_2X10G	0x4
+#define PKVL_MODE_ID_1X25G		0x5
+
+#define NS_REGBUS_WAIT_TIMEOUT	10000		/* loop count */
+#define NIOS_INIT_TIMEOUT		10000000	/* usec */
+#define NIOS_INIT_TIME_INTV		100000		/* usec */
+
+struct n3000_nios {
+	void __iomem *base;
+	struct regmap *regmap;
+	struct device *dev;
+	struct platform_device *altera_spi;
+};
+
+static ssize_t nios_fw_version_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct n3000_nios *ns = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%x.%x.%x\n",
+		       (u8)FIELD_GET(NIOS_FW_VERSION_MAJOR, val),
+		       (u8)FIELD_GET(NIOS_FW_VERSION_MINOR, val),
+		       (u8)FIELD_GET(NIOS_FW_VERSION_PATCH, val));
+}
+static DEVICE_ATTR_RO(nios_fw_version);
+
+#define IS_MODE_STATUS_OK(mode_stat)				\
+	(FIELD_GET(PKVL_MODE_STS_GROUP_MSK, (mode_stat)) ==	\
+	 PKVL_MODE_STS_GROUP_OK)
+
+#define IS_RETIMER_FEC_CONFIGURABLE(retimer_mode)	\
+	((retimer_mode) != PKVL_MODE_ID_RESET &&	\
+	 (retimer_mode) != PKVL_MODE_ID_4X10G)
+
+static int get_retimer_mode(struct n3000_nios *ns, unsigned int mode_stat_reg,
+			    unsigned int *retimer_mode)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(ns->regmap, mode_stat_reg, &val);
+	if (ret)
+		return ret;
+
+	if (!IS_MODE_STATUS_OK(val))
+		return -EFAULT;
+
+	*retimer_mode = FIELD_GET(PKVL_MODE_STS_ID_MSK, val);
+
+	return 0;
+}
+
+static ssize_t fec_mode_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct n3000_nios *ns = dev_get_drvdata(dev);
+	unsigned int val, retimer_a_mode, retimer_b_mode, fec_mode;
+	int ret;
+
+	ret = get_retimer_mode(ns, PKVL_A_MODE_STS, &retimer_a_mode);
+	if (ret)
+		return ret;
+
+	ret = get_retimer_mode(ns, PKVL_B_MODE_STS, &retimer_b_mode);
+	if (ret)
+		return ret;
+
+	if (!IS_RETIMER_FEC_CONFIGURABLE(retimer_a_mode) &&
+	    !IS_RETIMER_FEC_CONFIGURABLE(retimer_b_mode))
+		return sprintf(buf, "no\n");
+
+	ret = regmap_read(ns->regmap, NIOS_INIT, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * FEC mode should always be the same for all links, as we set them
+	 * in this way.
+	 */
+	fec_mode = FIELD_GET(REQ_FEC_MODE_A0_MSK, val);
+	if (fec_mode != FIELD_GET(REQ_FEC_MODE_A1_MSK, val) ||
+	    fec_mode != FIELD_GET(REQ_FEC_MODE_A2_MSK, val) ||
+	    fec_mode != FIELD_GET(REQ_FEC_MODE_A3_MSK, val) ||
+	    fec_mode != FIELD_GET(REQ_FEC_MODE_B0_MSK, val) ||
+	    fec_mode != FIELD_GET(REQ_FEC_MODE_B1_MSK, val) ||
+	    fec_mode != FIELD_GET(REQ_FEC_MODE_B2_MSK, val) ||
+	    fec_mode != FIELD_GET(REQ_FEC_MODE_B3_MSK, val))
+		return -EFAULT;
+
+	switch (fec_mode) {
+	case REQ_FEC_MODE_NO:
+		return sprintf(buf, "no\n");
+	case REQ_FEC_MODE_KR:
+		return sprintf(buf, "kr\n");
+	case REQ_FEC_MODE_RS:
+		return sprintf(buf, "rs\n");
+	}
+
+	return -EFAULT;
+}
+static DEVICE_ATTR_RO(fec_mode);
+
+static struct attribute *n3000_nios_attrs[] = {
+	&dev_attr_nios_fw_version.attr,
+	&dev_attr_fec_mode.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(n3000_nios);
+
+static int init_error_detected(struct n3000_nios *ns)
+{
+	unsigned int val;
+
+	if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
+		return true;
+
+	if (!IS_MODE_STATUS_OK(val))
+		return true;
+
+	if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
+		return true;
+
+	if (!IS_MODE_STATUS_OK(val))
+		return true;
+
+	return false;
+}
+
+static void dump_error_stat(struct n3000_nios *ns)
+{
+	unsigned int val;
+
+	if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
+		return;
+
+	dev_info(ns->dev, "PKVL_A_MODE_STS 0x%x\n", val);
+
+	if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
+		return;
+
+	dev_info(ns->dev, "PKVL_B_MODE_STS 0x%x\n", val);
+}
+
+static int n3000_nios_init_done_check(struct n3000_nios *ns)
+{
+	struct device *dev = ns->dev;
+	unsigned int val, mode;
+	int ret;
+
+	/*
+	 * this SPI is shared by Nios core inside FPGA, Nios will use this SPI
+	 * master to do some one time initialization after power up, and then
+	 * release the control to OS. driver needs to poll on INIT_DONE to
+	 * see when driver could take the control.
+	 *
+	 * Please note that after 3.x.x version, INIT_START is introduced, so
+	 * driver needs to trigger START firstly and then check INIT_DONE.
+	 */
+
+	ret = regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * If Nios version register is totally uninitialized(== 0x0), then the
+	 * Nios firmware is missing. So host could take control of SPI master
+	 * safely, but initialization work for Nios is not done. This is an
+	 * issue of FPGA image. We didn't error out because we need SPI master
+	 * to reprogram a new image.
+	 */
+	if (val == 0) {
+		dev_warn(dev, "Nios version reg = 0x%x, skip INIT_DONE check, but the retimer may be uninitialized\n",
+			 val);
+		return 0;
+	}
+
+	if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) >= 3) {
+		/* read NIOS_INIT to check if PKVL INIT done or not */
+		ret = regmap_read(ns->regmap, NIOS_INIT, &val);
+		if (ret)
+			return ret;
+
+		/* check if PKVLs are initialized already */
+		if (val & NIOS_INIT_DONE || val & NIOS_INIT_START)
+			goto nios_init_done;
+
+		/* configure FEC mode per module param */
+		val = NIOS_INIT_START;
+
+		/*
+		 * When the retimer is to be set to 10G mode, there is no FEC
+		 * mode setting, so the REQ_FEC_MODE field will be ignored by
+		 * Nios firmware in this case. But we should still fill the FEC
+		 * mode field cause host could not get the retimer working mode
+		 * until the Nios init is done.
+		 */
+		if (!strcmp(fec_mode, "no"))
+			mode = REQ_FEC_MODE_NO;
+		else if (!strcmp(fec_mode, "kr"))
+			mode = REQ_FEC_MODE_KR;
+		else if (!strcmp(fec_mode, "rs"))
+			mode = REQ_FEC_MODE_RS;
+		else
+			return -EINVAL;
+
+		/* set the same FEC mode for all links */
+		val |= FIELD_PREP(REQ_FEC_MODE_A0_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_A1_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_A2_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_A3_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_B0_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_B1_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_B2_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_B3_MSK, mode);
+
+		ret = regmap_write(ns->regmap, NIOS_INIT, val);
+		if (ret)
+			return ret;
+	}
+
+nios_init_done:
+	/* polls on NIOS_INIT_DONE */
+	ret = regmap_read_poll_timeout(ns->regmap, NIOS_INIT, val,
+				       val & NIOS_INIT_DONE,
+				       NIOS_INIT_TIME_INTV,
+				       NIOS_INIT_TIMEOUT);
+	if (ret) {
+		dev_err(dev, "NIOS_INIT_DONE %s\n",
+			(ret == -ETIMEDOUT) ? "timed out" : "check error");
+		goto dump_sts;
+	}
+
+	/*
+	 * after INIT_DONE is detected, it still needs to check if any ERR
+	 * detected.
+	 */
+	if (init_error_detected(ns)) {
+		/*
+		 * We won't error out here even if error detected. Although the
+		 * retimer configuration is fail, the Nios will still release
+		 * the spi controller for host to communicate with the BMC. So
+		 * the driver could continue to instantiate the spi controller
+		 * device.
+		 */
+		dev_warn(dev, "NIOS_INIT_DONE OK, but err found during init\n");
+		goto dump_sts;
+	}
+	return 0;
+
+dump_sts:
+	dump_error_stat(ns);
+
+	return ret;
+}
+
+struct spi_board_info m10_n3000_info = {
+	.modalias = "m10-n3000",
+	.max_speed_hz = 12500000,
+	.bus_num = 0,
+	.chip_select = 0,
+};
+
+static int create_altera_spi_controller(struct n3000_nios *ns)
+{
+	struct altera_spi_platform_data pdata = { 0 };
+	struct platform_device_info pdevinfo = { 0 };
+	void __iomem *base = ns->base;
+	u64 v;
+
+	v = readq(base + NIOS_SPI_PARAM);
+
+	pdata.mode_bits = SPI_CS_HIGH;
+	if (FIELD_GET(PARAM_CLK_POL, v))
+		pdata.mode_bits |= SPI_CPOL;
+	if (FIELD_GET(PARAM_CLK_PHASE, v))
+		pdata.mode_bits |= SPI_CPHA;
+
+	pdata.num_chipselect = FIELD_GET(PARAM_NUM_CS, v);
+	pdata.bits_per_word_mask =
+		SPI_BPW_RANGE_MASK(1, FIELD_GET(PARAM_DATA_WIDTH, v));
+
+	pdata.num_devices = 1;
+	pdata.devices = &m10_n3000_info;
+
+	dev_dbg(ns->dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
+		pdata.num_chipselect, pdata.bits_per_word_mask,
+		pdata.mode_bits);
+
+	pdevinfo.name = "subdev_spi_altera";
+	pdevinfo.id = PLATFORM_DEVID_AUTO;
+	pdevinfo.parent = ns->dev;
+	pdevinfo.data = &pdata;
+	pdevinfo.size_data = sizeof(pdata);
+
+	ns->altera_spi = platform_device_register_full(&pdevinfo);
+	return PTR_ERR_OR_ZERO(ns->altera_spi);
+}
+
+static void destroy_altera_spi_controller(struct n3000_nios *ns)
+{
+	platform_device_unregister(ns->altera_spi);
+}
+
+/* ns is the abbreviation of nios_spi */
+static int ns_poll_stat_timeout(void __iomem *base, u64 *v)
+{
+	int loops = NS_REGBUS_WAIT_TIMEOUT;
+
+	/*
+	 * We don't use the time based timeout here for performance.
+	 *
+	 * The regbus read/write is on the critical path of Intel PAC N3000
+	 * image programing. The time based timeout checking will add too much
+	 * overhead on it. Usually the state changes in 1 or 2 loops on the
+	 * test server, and we set 10000 times loop here for safety.
+	 */
+	do {
+		*v = readq(base + NIOS_SPI_STAT);
+		if (*v & STAT_RW_VAL)
+			break;
+		cpu_relax();
+	} while (--loops);
+
+	return loops ? 0 : -ETIMEDOUT;
+}
+
+static int ns_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct n3000_nios *ns = context;
+	u64 v = 0;
+	int ret;
+
+	v |= FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_WR);
+	v |= FIELD_PREP(CTRL_ADDR, reg);
+	v |= FIELD_PREP(CTRL_WR_DATA, val);
+	writeq(v, ns->base + NIOS_SPI_CTRL);
+
+	ret = ns_poll_stat_timeout(ns->base, &v);
+	if (ret)
+		dev_err(ns->dev, "fail to write reg 0x%x val 0x%x: %d\n",
+			reg, val, ret);
+
+	return ret;
+}
+
+static int ns_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct n3000_nios *ns = context;
+	u64 v = 0;
+	int ret;
+
+	v |= FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_RD);
+	v |= FIELD_PREP(CTRL_ADDR, reg);
+	writeq(v, ns->base + NIOS_SPI_CTRL);
+
+	ret = ns_poll_stat_timeout(ns->base, &v);
+	if (ret)
+		dev_err(ns->dev, "fail to read reg 0x%x: %d\n", reg, ret);
+	else
+		*val = FIELD_GET(STAT_RD_DATA, v);
+
+	return ret;
+}
+
+static const struct regmap_config ns_regbus_cfg = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+
+	.reg_write = ns_reg_write,
+	.reg_read = ns_reg_read,
+};
+
+static int n3000_nios_probe(struct dfl_device *dfl_dev)
+{
+	struct device *dev = &dfl_dev->dev;
+	struct n3000_nios *ns;
+	int ret;
+
+	ns = devm_kzalloc(dev, sizeof(*ns), GFP_KERNEL);
+	if (!ns)
+		return -ENOMEM;
+
+	dev_set_drvdata(&dfl_dev->dev, ns);
+
+	ns->dev = dev;
+
+	ns->base = devm_ioremap_resource(&dfl_dev->dev, &dfl_dev->mmio_res);
+	if (IS_ERR(ns->base))
+		return PTR_ERR(ns->base);
+
+	ns->regmap = devm_regmap_init(dev, NULL, ns, &ns_regbus_cfg);
+	if (IS_ERR(ns->regmap))
+		return PTR_ERR(ns->regmap);
+
+	ret = n3000_nios_init_done_check(ns);
+	if (ret)
+		return ret;
+
+	ret = create_altera_spi_controller(ns);
+	if (ret)
+		dev_err(dev, "altera spi controller create failed: %d\n", ret);
+
+	return ret;
+}
+
+static void n3000_nios_remove(struct dfl_device *dfl_dev)
+{
+	struct n3000_nios *ns = dev_get_drvdata(&dfl_dev->dev);
+
+	destroy_altera_spi_controller(ns);
+}
+
+#define FME_FEATURE_ID_N3000_NIOS	0xd
+
+static const struct dfl_device_id n3000_nios_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_N3000_NIOS },
+	{ }
+};
+
+static struct dfl_driver n3000_nios_driver = {
+	.drv	= {
+		.name       = "n3000-nios",
+		.dev_groups = n3000_nios_groups,
+	},
+	.id_table = n3000_nios_ids,
+	.probe   = n3000_nios_probe,
+	.remove  = n3000_nios_remove,
+};
+
+module_dfl_driver(n3000_nios_driver);
+
+MODULE_DEVICE_TABLE(dfl, n3000_nios_ids);
+MODULE_DESCRIPTION("DFL N3000 Nios private feature driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

