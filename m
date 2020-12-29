Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA12E6D43
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Dec 2020 03:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgL2CWi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Dec 2020 21:22:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:61444 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbgL2CWg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Dec 2020 21:22:36 -0500
IronPort-SDR: HunbAIIjyu8TJK+Zk1S+/58oOQezI6XsC9RwKtndt26Ir9vEXzoEkIkCiBLdomH6gEQj7CKkGO
 OTzBO7OhNbdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="175672196"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="175672196"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 18:21:52 -0800
IronPort-SDR: bRHuqJ5eC0vMDtMqeOc960Rv8LRWRYhHkaoV+m8++tPHoCIYgJlgnfXeTNCYJ3f9SrlOrNad+J
 cQk0TZLZJCcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="419006219"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 28 Dec 2020 18:21:49 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v14 5/6] fpga: dfl: add support for N3000 Nios private feature
Date:   Tue, 29 Dec 2020 10:16:47 +0800
Message-Id: <1609208208-6697-6-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609208208-6697-1-git-send-email-yilun.xu@intel.com>
References: <1609208208-6697-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds support for the Nios handshake private feature on Intel
PAC (Programmable Acceleration Card) N3000.

The Nios is the embedded processor on the FPGA card. This private feature
provides a handshake interface to FPGA Nios firmware, which receives
retimer configuration command from host and executes via an internal SPI
master (spi-altera). When Nios finishes the configuration, host takes over
the ownership of the SPI master to control an Intel MAX10 BMC (Board
Management Controller) Chip on the SPI bus.

For Nios firmware handshake part, this driver requests the retimer
configuration for Nios firmware on probe, and adds some sysfs nodes for
user to query the onboard retimer's working mode and Nios firmware
version.

For SPI part, this driver adds a spi-altera platform device as well as
the MAX10 BMC spi slave info. A spi-altera driver will be matched to
handle the following SPI work.

[mdf@kernel.org: Fixed up MAINTAINERS file to include added ABI doc]
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3: add the doc for this driver
    minor fixes for comments from Tom
v4: move the err log in regmap implementation, and delete
     n3000_nios_writel/readl(), they have nothing to wrapper now.
    some minor fixes and comments improvement.
v5: fix the output of fec_mode sysfs inf to "no" on 10G configuration,
     cause no FEC mode could be configured for 10G.
    rename the dfl_n3000_nios_* to n3000_nios_*
    improves comments.
v6: fix the output of fec_mode sysfs inf to "not supported" if in 10G,
     or the firmware version major < 3.
    minor fixes and improves comments.
v7: improves comments.
v8: add sysfs interfaces for retimer mode, also doc update.
    delete duplicated sysfs interfaces description in doc.
    minor fixes.
v9: delete the retimer FEC mode configuration via module_parameter.
    update the kernel version of the sysfs interfaces in Doc.
    merge the patch "Make m10_n3000_info static" (https://lore.kernel.org/linux-fpga/52d8411e-13d8-1e91-756d-131802f5f445@huawei.com/T/#t)
    remove the tags of Maintainers, this implementation is changed.
v10: improve the name of some macros, functions and variables.
     refactor the FEC mode setting and reading.
     refactor the retimer init error checking and dumping.
     refactor the loop timeout for regbus reading & write.
     some minor fixes.
v11: use sysfs_emit instead of sprintf.
     rebase to 5.10-rc1.
v12: move the MODULE_DEVICE_TABLE() right after its definition.
v13: fix the wrong use of logical'||', should use '|' on Nios
     INIT_DONE and INIT_START check, reported by lkp check.
v14: no change, rebase to 5.11-rc1
---
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
 MAINTAINERS                                        |   2 +-
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
 5 files changed, 649 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 drivers/fpga/dfl-n3000-nios.c

diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
new file mode 100644
index 0000000..a505537
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
@@ -0,0 +1,47 @@
+What:		/sys/bus/dfl/devices/dfl_dev.X/fec_mode
+Date:		Oct 2020
+KernelVersion:	5.11
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. Returns the FEC mode of the 25G links of the
+		ethernet retimers configured by Nios firmware. "rs" for Reed
+		Solomon FEC, "kr" for Fire Code FEC, "no" for NO FEC.
+		"not supported" if the FEC mode setting is not supported, this
+		happens when the Nios firmware version major < 3, or no link is
+		configured to 25G.
+		Format: string
+
+What:		/sys/bus/dfl/devices/dfl_dev.X/retimer_A_mode
+Date:		Oct 2020
+KernelVersion:	5.11
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. Returns the enumeration value of the working mode of
+		the retimer A configured by the Nios firmware. The value is
+		read out from shared registers filled by the Nios firmware. Now
+		the values could be:
+
+		- "0": Reset
+		- "1": 4x10G
+		- "2": 4x25G
+		- "3": 2x25G
+		- "4": 2x25G+2x10G
+		- "5": 1x25G
+
+		If the Nios firmware is updated in future to support more
+		retimer modes, more enumeration value is expected.
+		Format: 0x%x
+
+What:		/sys/bus/dfl/devices/dfl_dev.X/retimer_B_mode
+Date:		Oct 2020
+KernelVersion:	5.11
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. Returns the enumeration value of the working mode of
+		the retimer B configured by the Nios firmware. The value format
+		is the same as retimer_A_mode.
+
+What:		/sys/bus/dfl/devices/dfl_dev.X/nios_fw_version
+Date:		Oct 2020
+KernelVersion:	5.11
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. Returns the version of the Nios firmware in the
+		FPGA. Its format is "major.minor.patch".
+		Format: %x.%x.%x
diff --git a/MAINTAINERS b/MAINTAINERS
index a044b58..aebb26a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6954,7 +6954,7 @@ M:	Wu Hao <hao.wu@intel.com>
 R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-dfl
+F:	Documentation/ABI/testing/sysfs-bus-dfl*
 F:	Documentation/fpga/dfl.rst
 F:	drivers/fpga/dfl*
 F:	include/linux/dfl.h
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 5645226..5ff9438 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -192,6 +192,17 @@ config FPGA_DFL_AFU
 	  to the FPGA infrastructure via a Port. There may be more than one
 	  Port/AFU per DFL based FPGA device.
 
+config FPGA_DFL_NIOS_INTEL_PAC_N3000
+	tristate "FPGA DFL NIOS Driver for Intel PAC N3000"
+	depends on FPGA_DFL
+	select REGMAP
+	help
+	  This is the driver for the N3000 Nios private feature on Intel
+	  PAC (Programmable Acceleration Card) N3000. It communicates
+	  with the embedded Nios processor to configure the retimers on
+	  the card. It also instantiates the SPI master (spi-altera) for
+	  the card's BMC (Board Management Controller).
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index d8e21df..18dc9885 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -44,5 +44,7 @@ dfl-fme-objs += dfl-fme-perf.o
 dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
 dfl-afu-objs += dfl-afu-error.o
 
+obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
+
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
new file mode 100644
index 0000000..7a95366
--- /dev/null
+++ b/drivers/fpga/dfl-n3000-nios.c
@@ -0,0 +1,588 @@
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
+#include <linux/dfl.h>
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
+/*
+ * N3000 Nios private feature registers, named as NIOS_SPI_XX on spec.
+ * NS is the abbreviation of NIOS_SPI.
+ */
+#define N3000_NS_PARAM				0x8
+#define N3000_NS_PARAM_SHIFT_MODE_MSK		BIT_ULL(1)
+#define N3000_NS_PARAM_SHIFT_MODE_MSB		0
+#define N3000_NS_PARAM_SHIFT_MODE_LSB		1
+#define N3000_NS_PARAM_DATA_WIDTH		GENMASK_ULL(7, 2)
+#define N3000_NS_PARAM_NUM_CS			GENMASK_ULL(13, 8)
+#define N3000_NS_PARAM_CLK_POL			BIT_ULL(14)
+#define N3000_NS_PARAM_CLK_PHASE		BIT_ULL(15)
+#define N3000_NS_PARAM_PERIPHERAL_ID		GENMASK_ULL(47, 32)
+
+#define N3000_NS_CTRL				0x10
+#define N3000_NS_CTRL_WR_DATA			GENMASK_ULL(31, 0)
+#define N3000_NS_CTRL_ADDR			GENMASK_ULL(44, 32)
+#define N3000_NS_CTRL_CMD_MSK			GENMASK_ULL(63, 62)
+#define N3000_NS_CTRL_CMD_NOP			0
+#define N3000_NS_CTRL_CMD_RD			1
+#define N3000_NS_CTRL_CMD_WR			2
+
+#define N3000_NS_STAT				0x18
+#define N3000_NS_STAT_RD_DATA			GENMASK_ULL(31, 0)
+#define N3000_NS_STAT_RW_VAL			BIT_ULL(32)
+
+/* Nios handshake registers, indirect access */
+#define N3000_NIOS_INIT				0x1000
+#define N3000_NIOS_INIT_DONE			BIT(0)
+#define N3000_NIOS_INIT_START			BIT(1)
+/* Mode for retimer A, link 0, the same below */
+#define N3000_NIOS_INIT_REQ_FEC_MODE_A0_MSK	GENMASK(9, 8)
+#define N3000_NIOS_INIT_REQ_FEC_MODE_A1_MSK	GENMASK(11, 10)
+#define N3000_NIOS_INIT_REQ_FEC_MODE_A2_MSK	GENMASK(13, 12)
+#define N3000_NIOS_INIT_REQ_FEC_MODE_A3_MSK	GENMASK(15, 14)
+#define N3000_NIOS_INIT_REQ_FEC_MODE_B0_MSK	GENMASK(17, 16)
+#define N3000_NIOS_INIT_REQ_FEC_MODE_B1_MSK	GENMASK(19, 18)
+#define N3000_NIOS_INIT_REQ_FEC_MODE_B2_MSK	GENMASK(21, 20)
+#define N3000_NIOS_INIT_REQ_FEC_MODE_B3_MSK	GENMASK(23, 22)
+#define N3000_NIOS_INIT_REQ_FEC_MODE_NO		0x0
+#define N3000_NIOS_INIT_REQ_FEC_MODE_KR		0x1
+#define N3000_NIOS_INIT_REQ_FEC_MODE_RS		0x2
+
+#define N3000_NIOS_FW_VERSION			0x1004
+#define N3000_NIOS_FW_VERSION_PATCH		GENMASK(23, 20)
+#define N3000_NIOS_FW_VERSION_MINOR		GENMASK(27, 24)
+#define N3000_NIOS_FW_VERSION_MAJOR		GENMASK(31, 28)
+
+/* The retimers we use on Intel PAC N3000 is Parkvale, abbreviated to PKVL */
+#define N3000_NIOS_PKVL_A_MODE_STS		0x1020
+#define N3000_NIOS_PKVL_B_MODE_STS		0x1024
+#define N3000_NIOS_PKVL_MODE_STS_GROUP_MSK	GENMASK(15, 8)
+#define N3000_NIOS_PKVL_MODE_STS_GROUP_OK	0x0
+#define N3000_NIOS_PKVL_MODE_STS_ID_MSK		GENMASK(7, 0)
+/* When GROUP MASK field == GROUP_OK  */
+#define N3000_NIOS_PKVL_MODE_ID_RESET		0x0
+#define N3000_NIOS_PKVL_MODE_ID_4X10G		0x1
+#define N3000_NIOS_PKVL_MODE_ID_4X25G		0x2
+#define N3000_NIOS_PKVL_MODE_ID_2X25G		0x3
+#define N3000_NIOS_PKVL_MODE_ID_2X25G_2X10G	0x4
+#define N3000_NIOS_PKVL_MODE_ID_1X25G		0x5
+
+#define N3000_NIOS_REGBUS_RETRY_COUNT		10000	/* loop count */
+
+#define N3000_NIOS_INIT_TIMEOUT			10000000	/* usec */
+#define N3000_NIOS_INIT_TIME_INTV		100000		/* usec */
+
+#define N3000_NIOS_INIT_REQ_FEC_MODE_MSK_ALL	\
+	(N3000_NIOS_INIT_REQ_FEC_MODE_A0_MSK |	\
+	 N3000_NIOS_INIT_REQ_FEC_MODE_A1_MSK |	\
+	 N3000_NIOS_INIT_REQ_FEC_MODE_A2_MSK |	\
+	 N3000_NIOS_INIT_REQ_FEC_MODE_A3_MSK |	\
+	 N3000_NIOS_INIT_REQ_FEC_MODE_B0_MSK |	\
+	 N3000_NIOS_INIT_REQ_FEC_MODE_B1_MSK |	\
+	 N3000_NIOS_INIT_REQ_FEC_MODE_B2_MSK |	\
+	 N3000_NIOS_INIT_REQ_FEC_MODE_B3_MSK)
+
+#define N3000_NIOS_INIT_REQ_FEC_MODE_NO_ALL			\
+	(FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A0_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_NO) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A1_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_NO) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A2_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_NO) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A3_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_NO) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B0_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_NO) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B1_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_NO) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B2_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_NO) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B3_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_NO))
+
+#define N3000_NIOS_INIT_REQ_FEC_MODE_KR_ALL			\
+	(FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A0_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_KR) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A1_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_KR) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A2_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_KR) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A3_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_KR) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B0_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_KR) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B1_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_KR) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B2_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_KR) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B3_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_KR))
+
+#define N3000_NIOS_INIT_REQ_FEC_MODE_RS_ALL			\
+	(FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A0_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_RS) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A1_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_RS) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A2_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_RS) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_A3_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_RS) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B0_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_RS) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B1_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_RS) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B2_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_RS) |		\
+	 FIELD_PREP(N3000_NIOS_INIT_REQ_FEC_MODE_B3_MSK,	\
+		    N3000_NIOS_INIT_REQ_FEC_MODE_RS))
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
+	struct n3000_nios *nn = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(nn->regmap, N3000_NIOS_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%x.%x.%x\n",
+			  (u8)FIELD_GET(N3000_NIOS_FW_VERSION_MAJOR, val),
+			  (u8)FIELD_GET(N3000_NIOS_FW_VERSION_MINOR, val),
+			  (u8)FIELD_GET(N3000_NIOS_FW_VERSION_PATCH, val));
+}
+static DEVICE_ATTR_RO(nios_fw_version);
+
+#define IS_MODE_STATUS_OK(mode_stat)					\
+	(FIELD_GET(N3000_NIOS_PKVL_MODE_STS_GROUP_MSK, (mode_stat)) ==	\
+	 N3000_NIOS_PKVL_MODE_STS_GROUP_OK)
+
+#define IS_RETIMER_FEC_SUPPORTED(retimer_mode)			\
+	((retimer_mode) != N3000_NIOS_PKVL_MODE_ID_RESET &&	\
+	 (retimer_mode) != N3000_NIOS_PKVL_MODE_ID_4X10G)
+
+static int get_retimer_mode(struct n3000_nios *nn, unsigned int mode_stat_reg,
+			    unsigned int *retimer_mode)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(nn->regmap, mode_stat_reg, &val);
+	if (ret)
+		return ret;
+
+	if (!IS_MODE_STATUS_OK(val))
+		return -EFAULT;
+
+	*retimer_mode = FIELD_GET(N3000_NIOS_PKVL_MODE_STS_ID_MSK, val);
+
+	return 0;
+}
+
+static ssize_t retimer_A_mode_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct n3000_nios *nn = dev_get_drvdata(dev);
+	unsigned int mode;
+	int ret;
+
+	ret = get_retimer_mode(nn, N3000_NIOS_PKVL_A_MODE_STS, &mode);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%x\n", mode);
+}
+static DEVICE_ATTR_RO(retimer_A_mode);
+
+static ssize_t retimer_B_mode_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct n3000_nios *nn = dev_get_drvdata(dev);
+	unsigned int mode;
+	int ret;
+
+	ret = get_retimer_mode(nn, N3000_NIOS_PKVL_B_MODE_STS, &mode);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%x\n", mode);
+}
+static DEVICE_ATTR_RO(retimer_B_mode);
+
+static ssize_t fec_mode_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	unsigned int val, retimer_a_mode, retimer_b_mode, fec_modes;
+	struct n3000_nios *nn = dev_get_drvdata(dev);
+	int ret;
+
+	/* FEC mode setting is not supported in early FW versions */
+	ret = regmap_read(nn->regmap, N3000_NIOS_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(N3000_NIOS_FW_VERSION_MAJOR, val) < 3)
+		return sysfs_emit(buf, "not supported\n");
+
+	/* If no 25G links, FEC mode setting is not supported either */
+	ret = get_retimer_mode(nn, N3000_NIOS_PKVL_A_MODE_STS, &retimer_a_mode);
+	if (ret)
+		return ret;
+
+	ret = get_retimer_mode(nn, N3000_NIOS_PKVL_B_MODE_STS, &retimer_b_mode);
+	if (ret)
+		return ret;
+
+	if (!IS_RETIMER_FEC_SUPPORTED(retimer_a_mode) &&
+	    !IS_RETIMER_FEC_SUPPORTED(retimer_b_mode))
+		return sysfs_emit(buf, "not supported\n");
+
+	/* get the valid FEC mode for 25G links */
+	ret = regmap_read(nn->regmap, N3000_NIOS_INIT, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * FEC mode should always be the same for all links, as we set them
+	 * in this way.
+	 */
+	fec_modes = (val & N3000_NIOS_INIT_REQ_FEC_MODE_MSK_ALL);
+	if (fec_modes == N3000_NIOS_INIT_REQ_FEC_MODE_NO_ALL)
+		return sysfs_emit(buf, "no\n");
+	else if (fec_modes == N3000_NIOS_INIT_REQ_FEC_MODE_KR_ALL)
+		return sysfs_emit(buf, "kr\n");
+	else if (fec_modes == N3000_NIOS_INIT_REQ_FEC_MODE_RS_ALL)
+		return sysfs_emit(buf, "rs\n");
+
+	return -EFAULT;
+}
+static DEVICE_ATTR_RO(fec_mode);
+
+static struct attribute *n3000_nios_attrs[] = {
+	&dev_attr_nios_fw_version.attr,
+	&dev_attr_retimer_A_mode.attr,
+	&dev_attr_retimer_B_mode.attr,
+	&dev_attr_fec_mode.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(n3000_nios);
+
+static int n3000_nios_init_done_check(struct n3000_nios *nn)
+{
+	unsigned int val, state_a, state_b;
+	struct device *dev = nn->dev;
+	int ret, ret2;
+
+	/*
+	 * The SPI is shared by the Nios core inside the FPGA, Nios will use
+	 * this SPI master to do some one time initialization after power up,
+	 * and then release the control to OS. The driver needs to poll on
+	 * INIT_DONE to see when driver could take the control.
+	 *
+	 * Please note that after Nios firmware version 3.0.0, INIT_START is
+	 * introduced, so driver needs to trigger START firstly and then check
+	 * INIT_DONE.
+	 */
+
+	ret = regmap_read(nn->regmap, N3000_NIOS_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * If Nios version register is totally uninitialized(== 0x0), then the
+	 * Nios firmware is missing. So host could take control of SPI master
+	 * safely, but initialization work for Nios is not done. To restore the
+	 * card, we need to reprogram a new Nios firmware via the BMC chip on
+	 * SPI bus. So the driver doesn't error out, it continues to create the
+	 * spi controller device and spi_board_info for BMC.
+	 */
+	if (val == 0) {
+		dev_err(dev, "Nios version reg = 0x%x, skip INIT_DONE check, but the retimer may be uninitialized\n",
+			val);
+		return 0;
+	}
+
+	if (FIELD_GET(N3000_NIOS_FW_VERSION_MAJOR, val) >= 3) {
+		/* read NIOS_INIT to check if retimer initialization is done */
+		ret = regmap_read(nn->regmap, N3000_NIOS_INIT, &val);
+		if (ret)
+			return ret;
+
+		/* check if retimers are initialized already */
+		if (val & (N3000_NIOS_INIT_DONE | N3000_NIOS_INIT_START))
+			goto nios_init_done;
+
+		/* configure FEC mode per module param */
+		val = N3000_NIOS_INIT_START;
+
+		/*
+		 * When the retimer is to be set to 10G mode, there is no FEC
+		 * mode setting, so the REQ_FEC_MODE field will be ignored by
+		 * Nios firmware in this case. But we should still fill the FEC
+		 * mode field cause host could not get the retimer working mode
+		 * until the Nios init is done.
+		 *
+		 * For now the driver doesn't support the retimer FEC mode
+		 * switching per user's request. It is always set to Reed
+		 * Solomon FEC.
+		 *
+		 * The driver will set the same FEC mode for all links.
+		 */
+		val |= N3000_NIOS_INIT_REQ_FEC_MODE_RS_ALL;
+
+		ret = regmap_write(nn->regmap, N3000_NIOS_INIT, val);
+		if (ret)
+			return ret;
+	}
+
+nios_init_done:
+	/* polls on NIOS_INIT_DONE */
+	ret = regmap_read_poll_timeout(nn->regmap, N3000_NIOS_INIT, val,
+				       val & N3000_NIOS_INIT_DONE,
+				       N3000_NIOS_INIT_TIME_INTV,
+				       N3000_NIOS_INIT_TIMEOUT);
+	if (ret)
+		dev_err(dev, "NIOS_INIT_DONE %s\n",
+			(ret == -ETIMEDOUT) ? "timed out" : "check error");
+
+	ret2 = regmap_read(nn->regmap, N3000_NIOS_PKVL_A_MODE_STS, &state_a);
+	if (ret2)
+		return ret2;
+
+	ret2 = regmap_read(nn->regmap, N3000_NIOS_PKVL_B_MODE_STS, &state_b);
+	if (ret2)
+		return ret2;
+
+	if (!ret) {
+		/*
+		 * After INIT_DONE is detected, it still needs to check if the
+		 * Nios firmware reports any error during the retimer
+		 * configuration.
+		 */
+		if (IS_MODE_STATUS_OK(state_a) && IS_MODE_STATUS_OK(state_b))
+			return 0;
+
+		/*
+		 * If the retimer configuration is failed, the Nios firmware
+		 * will still release the spi controller for host to
+		 * communicate with the BMC. It makes possible for people to
+		 * reprogram a new Nios firmware and restore the card. So the
+		 * driver doesn't error out, it continues to create the spi
+		 * controller device and spi_board_info for BMC.
+		 */
+		dev_err(dev, "NIOS_INIT_DONE OK, but err on retimer init\n");
+	}
+
+	dev_err(nn->dev, "PKVL_A_MODE_STS 0x%x\n", state_a);
+	dev_err(nn->dev, "PKVL_B_MODE_STS 0x%x\n", state_b);
+
+	return ret;
+}
+
+static struct spi_board_info m10_n3000_info = {
+	.modalias = "m10-n3000",
+	.max_speed_hz = 12500000,
+	.bus_num = 0,
+	.chip_select = 0,
+};
+
+static int create_altera_spi_controller(struct n3000_nios *nn)
+{
+	struct altera_spi_platform_data pdata = { 0 };
+	struct platform_device_info pdevinfo = { 0 };
+	void __iomem *base = nn->base;
+	u64 v;
+
+	v = readq(base + N3000_NS_PARAM);
+
+	pdata.mode_bits = SPI_CS_HIGH;
+	if (FIELD_GET(N3000_NS_PARAM_CLK_POL, v))
+		pdata.mode_bits |= SPI_CPOL;
+	if (FIELD_GET(N3000_NS_PARAM_CLK_PHASE, v))
+		pdata.mode_bits |= SPI_CPHA;
+
+	pdata.num_chipselect = FIELD_GET(N3000_NS_PARAM_NUM_CS, v);
+	pdata.bits_per_word_mask =
+		SPI_BPW_RANGE_MASK(1, FIELD_GET(N3000_NS_PARAM_DATA_WIDTH, v));
+
+	pdata.num_devices = 1;
+	pdata.devices = &m10_n3000_info;
+
+	dev_dbg(nn->dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
+		pdata.num_chipselect, pdata.bits_per_word_mask,
+		pdata.mode_bits);
+
+	pdevinfo.name = "subdev_spi_altera";
+	pdevinfo.id = PLATFORM_DEVID_AUTO;
+	pdevinfo.parent = nn->dev;
+	pdevinfo.data = &pdata;
+	pdevinfo.size_data = sizeof(pdata);
+
+	nn->altera_spi = platform_device_register_full(&pdevinfo);
+	return PTR_ERR_OR_ZERO(nn->altera_spi);
+}
+
+static void destroy_altera_spi_controller(struct n3000_nios *nn)
+{
+	platform_device_unregister(nn->altera_spi);
+}
+
+static int n3000_nios_poll_stat_timeout(void __iomem *base, u64 *v)
+{
+	int loops;
+
+	/*
+	 * We don't use the time based timeout here for performance.
+	 *
+	 * The regbus read/write is on the critical path of Intel PAC N3000
+	 * image programing. The time based timeout checking will add too much
+	 * overhead on it. Usually the state changes in 1 or 2 loops on the
+	 * test server, and we set 10000 times loop here for safety.
+	 */
+	for (loops = N3000_NIOS_REGBUS_RETRY_COUNT; loops > 0 ; loops--) {
+		*v = readq(base + N3000_NS_STAT);
+		if (*v & N3000_NS_STAT_RW_VAL)
+			break;
+		cpu_relax();
+	}
+
+	return (loops > 0) ? 0 : -ETIMEDOUT;
+}
+
+static int n3000_nios_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct n3000_nios *nn = context;
+	u64 v;
+	int ret;
+
+	v = FIELD_PREP(N3000_NS_CTRL_CMD_MSK, N3000_NS_CTRL_CMD_WR) |
+	    FIELD_PREP(N3000_NS_CTRL_ADDR, reg) |
+	    FIELD_PREP(N3000_NS_CTRL_WR_DATA, val);
+	writeq(v, nn->base + N3000_NS_CTRL);
+
+	ret = n3000_nios_poll_stat_timeout(nn->base, &v);
+	if (ret)
+		dev_err(nn->dev, "fail to write reg 0x%x val 0x%x: %d\n",
+			reg, val, ret);
+
+	return ret;
+}
+
+static int n3000_nios_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct n3000_nios *nn = context;
+	u64 v;
+	int ret;
+
+	v = FIELD_PREP(N3000_NS_CTRL_CMD_MSK, N3000_NS_CTRL_CMD_RD) |
+	    FIELD_PREP(N3000_NS_CTRL_ADDR, reg);
+	writeq(v, nn->base + N3000_NS_CTRL);
+
+	ret = n3000_nios_poll_stat_timeout(nn->base, &v);
+	if (ret)
+		dev_err(nn->dev, "fail to read reg 0x%x: %d\n", reg, ret);
+	else
+		*val = FIELD_GET(N3000_NS_STAT_RD_DATA, v);
+
+	return ret;
+}
+
+static const struct regmap_config n3000_nios_regbus_cfg = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+
+	.reg_write = n3000_nios_reg_write,
+	.reg_read = n3000_nios_reg_read,
+};
+
+static int n3000_nios_probe(struct dfl_device *ddev)
+{
+	struct device *dev = &ddev->dev;
+	struct n3000_nios *nn;
+	int ret;
+
+	nn = devm_kzalloc(dev, sizeof(*nn), GFP_KERNEL);
+	if (!nn)
+		return -ENOMEM;
+
+	dev_set_drvdata(&ddev->dev, nn);
+
+	nn->dev = dev;
+
+	nn->base = devm_ioremap_resource(&ddev->dev, &ddev->mmio_res);
+	if (IS_ERR(nn->base))
+		return PTR_ERR(nn->base);
+
+	nn->regmap = devm_regmap_init(dev, NULL, nn, &n3000_nios_regbus_cfg);
+	if (IS_ERR(nn->regmap))
+		return PTR_ERR(nn->regmap);
+
+	ret = n3000_nios_init_done_check(nn);
+	if (ret)
+		return ret;
+
+	ret = create_altera_spi_controller(nn);
+	if (ret)
+		dev_err(dev, "altera spi controller create failed: %d\n", ret);
+
+	return ret;
+}
+
+static void n3000_nios_remove(struct dfl_device *ddev)
+{
+	struct n3000_nios *nn = dev_get_drvdata(&ddev->dev);
+
+	destroy_altera_spi_controller(nn);
+}
+
+#define FME_FEATURE_ID_N3000_NIOS	0xd
+
+static const struct dfl_device_id n3000_nios_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_N3000_NIOS },
+	{ }
+};
+MODULE_DEVICE_TABLE(dfl, n3000_nios_ids);
+
+static struct dfl_driver n3000_nios_driver = {
+	.drv	= {
+		.name       = "dfl-n3000-nios",
+		.dev_groups = n3000_nios_groups,
+	},
+	.id_table = n3000_nios_ids,
+	.probe   = n3000_nios_probe,
+	.remove  = n3000_nios_remove,
+};
+
+module_dfl_driver(n3000_nios_driver);
+
+MODULE_DESCRIPTION("Driver for Nios private feature on Intel PAC N3000");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

