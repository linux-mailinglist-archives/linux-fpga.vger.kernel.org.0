Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62928EDAA
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Oct 2020 09:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgJOHW0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Oct 2020 03:22:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:17184 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgJOHWS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Oct 2020 03:22:18 -0400
IronPort-SDR: m8F5tC6Yz+RL+VMXQCHdjrCjSHFZcU/e8gFRcvBnkoJoIgiNb+eKZbOZMt93lYpl3MHPg/Gryh
 SMXbazT+dYOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="154112266"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="154112266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 00:22:17 -0700
IronPort-SDR: +Ql/bb9XJMjXLWxJhfh/AVd+xIy+CJvz1nvyE5HT1drTla/q+/F6UPAqrPgJ6bf1Cs4MNw/8G6
 Y2c2gpO1gEcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="531145218"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2020 00:22:08 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v10 6/6] memory: dfl-emif: add the DFL EMIF private feature driver
Date:   Thu, 15 Oct 2020 15:16:33 +0800
Message-Id: <1602746193-10626-7-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
References: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This driver is for the EMIF private feature implemented under FPGA
Device Feature List (DFL) framework. It is used to expose memory
interface status information as well as memory clearing control.

The purpose of memory clearing block is to zero out all private memory
when FPGA is to be reprogrammed. This gives users a reliable method to
prevent potential data leakage.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
v2: Adjust the position of this driver in Kconfig.
    Improves the name of the Kconfig option.
    Change the include dfl-bus.h to dfl.h, cause the previous patchset
     renames the file.
    Some minor fixes and comment improvement.
v3: Adjust the position of the driver in Makefile.
v9: Add static prefix for emif attributes macro.
    Update the kernel version of the sysfs interfaces in Doc.
v10: Rebase due to the dfl head file moves to include/linux
---
 .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   2 +
 drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 drivers/memory/dfl-emif.c

diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
new file mode 100644
index 0000000..1ae8ebd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
@@ -0,0 +1,25 @@
+What:		/sys/bus/dfl/devices/dfl_dev.X/infX_cal_fail
+Date:		Oct 2020
+KernelVersion:	5.11
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. It indicates if the calibration failed on this
+		memory interface. "1" for calibration failure, "0" for OK.
+		Format: %u
+
+What:		/sys/bus/dfl/devices/dfl_dev.X/infX_init_done
+Date:		Oct 2020
+KernelVersion:	5.11
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. It indicates if the initialization completed on
+		this memory interface. "1" for initialization complete, "0"
+		for not yet.
+		Format: %u
+
+What:		/sys/bus/dfl/devices/dfl_dev.X/infX_clear
+Date:		Oct 2020
+KernelVersion:	5.11
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Write-only. Writing "1" to this file will zero out all memory
+		data in this memory interface. Writing of other values is
+		invalid.
+		Format: %u
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 00e013b..2495bc4 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -137,6 +137,15 @@ config TI_EMIF_SRAM
 	  sequence so this driver provides several relocatable PM functions
 	  for the SoC PM code to use.
 
+config FPGA_DFL_EMIF
+	tristate "FPGA DFL EMIF Driver"
+	depends on FPGA_DFL && HAS_IOMEM
+	help
+	  This driver is for the EMIF private feature implemented under
+	  FPGA Device Feature List (DFL) framework. It is used to expose
+	  memory interface status information as well as memory clearing
+	  control.
+
 config MVEBU_DEVBUS
 	bool "Marvell EBU Device Bus Controller"
 	default y if PLAT_ORION
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index e71cf7b..bc7663e 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -28,6 +28,8 @@ obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
 obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
+obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
+
 ti-emif-sram-objs		:= ti-emif-pm.o ti-emif-sram-pm.o
 
 AFLAGS_ti-emif-sram-pm.o	:=-Wa,-march=armv7-a
diff --git a/drivers/memory/dfl-emif.c b/drivers/memory/dfl-emif.c
new file mode 100644
index 0000000..70a62eb
--- /dev/null
+++ b/drivers/memory/dfl-emif.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DFL device driver for EMIF private feature
+ *
+ * Copyright (C) 2020 Intel Corporation, Inc.
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/dfl.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define FME_FEATURE_ID_EMIF		0x9
+
+#define EMIF_STAT			0x8
+#define EMIF_STAT_INIT_DONE_SFT		0
+#define EMIF_STAT_CALC_FAIL_SFT		8
+#define EMIF_STAT_CLEAR_BUSY_SFT	16
+#define EMIF_CTRL			0x10
+#define EMIF_CTRL_CLEAR_EN_SFT		0
+#define EMIF_CTRL_CLEAR_EN_MSK		GENMASK_ULL(3, 0)
+
+#define EMIF_POLL_INVL			10000 /* us */
+#define EMIF_POLL_TIMEOUT		5000000 /* us */
+
+struct dfl_emif {
+	struct device *dev;
+	void __iomem *base;
+	spinlock_t lock;	/* Serialises access to EMIF_CTRL reg */
+};
+
+struct emif_attr {
+	struct device_attribute attr;
+	u32 shift;
+	u32 index;
+};
+
+#define to_emif_attr(dev_attr) \
+	container_of(dev_attr, struct emif_attr, attr)
+
+static ssize_t emif_state_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct emif_attr *eattr = to_emif_attr(attr);
+	struct dfl_emif *de = dev_get_drvdata(dev);
+	u64 val;
+
+	val = readq(de->base + EMIF_STAT);
+
+	return sprintf(buf, "%u\n",
+		       !!(val & BIT_ULL(eattr->shift + eattr->index)));
+}
+
+static ssize_t emif_clear_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct emif_attr *eattr = to_emif_attr(attr);
+	struct dfl_emif *de = dev_get_drvdata(dev);
+	u64 clear_busy_msk, clear_en_msk, val;
+	void __iomem *base = de->base;
+
+	if (!sysfs_streq(buf, "1"))
+		return -EINVAL;
+
+	clear_busy_msk = BIT_ULL(EMIF_STAT_CLEAR_BUSY_SFT + eattr->index);
+	clear_en_msk = BIT_ULL(EMIF_CTRL_CLEAR_EN_SFT + eattr->index);
+
+	spin_lock(&de->lock);
+	/* The CLEAR_EN field is WO, but other fields are RW */
+	val = readq(base + EMIF_CTRL);
+	val &= ~EMIF_CTRL_CLEAR_EN_MSK;
+	val |= clear_en_msk;
+	writeq(val, base + EMIF_CTRL);
+	spin_unlock(&de->lock);
+
+	if (readq_poll_timeout(base + EMIF_STAT, val,
+			       !(val & clear_busy_msk),
+			       EMIF_POLL_INVL, EMIF_POLL_TIMEOUT)) {
+		dev_err(de->dev, "timeout, fail to clear\n");
+		return -ETIMEDOUT;
+	}
+
+	return count;
+}
+
+#define emif_state_attr(_name, _shift, _index)				\
+	static struct emif_attr emif_attr_##inf##_index##_##_name =	\
+		{ .attr = __ATTR(inf##_index##_##_name, 0444,		\
+				 emif_state_show, NULL),		\
+		  .shift = (_shift), .index = (_index) }
+
+#define emif_clear_attr(_index)						\
+	static struct emif_attr emif_attr_##inf##_index##_clear =	\
+		{ .attr = __ATTR(inf##_index##_clear, 0200,		\
+				 NULL, emif_clear_store),		\
+		  .index = (_index) }
+
+emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 0);
+emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 1);
+emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 2);
+emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 3);
+
+emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 0);
+emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 1);
+emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 2);
+emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 3);
+
+emif_clear_attr(0);
+emif_clear_attr(1);
+emif_clear_attr(2);
+emif_clear_attr(3);
+
+static struct attribute *dfl_emif_attrs[] = {
+	&emif_attr_inf0_init_done.attr.attr,
+	&emif_attr_inf0_cal_fail.attr.attr,
+	&emif_attr_inf0_clear.attr.attr,
+
+	&emif_attr_inf1_init_done.attr.attr,
+	&emif_attr_inf1_cal_fail.attr.attr,
+	&emif_attr_inf1_clear.attr.attr,
+
+	&emif_attr_inf2_init_done.attr.attr,
+	&emif_attr_inf2_cal_fail.attr.attr,
+	&emif_attr_inf2_clear.attr.attr,
+
+	&emif_attr_inf3_init_done.attr.attr,
+	&emif_attr_inf3_cal_fail.attr.attr,
+	&emif_attr_inf3_clear.attr.attr,
+
+	NULL,
+};
+
+static umode_t dfl_emif_visible(struct kobject *kobj,
+				struct attribute *attr, int n)
+{
+	struct dfl_emif *de = dev_get_drvdata(kobj_to_dev(kobj));
+	struct emif_attr *eattr = container_of(attr, struct emif_attr,
+					       attr.attr);
+	u64 val;
+
+	/*
+	 * This device supports upto 4 memory interfaces, but not all
+	 * interfaces are used on different platforms. The read out value of
+	 * CLEAN_EN field (which is a bitmap) could tell how many interfaces
+	 * are available.
+	 */
+	val = FIELD_GET(EMIF_CTRL_CLEAR_EN_MSK, readq(de->base + EMIF_CTRL));
+
+	return (val & BIT_ULL(eattr->index)) ? attr->mode : 0;
+}
+
+static const struct attribute_group dfl_emif_group = {
+	.is_visible = dfl_emif_visible,
+	.attrs = dfl_emif_attrs,
+};
+
+static const struct attribute_group *dfl_emif_groups[] = {
+	&dfl_emif_group,
+	NULL,
+};
+
+static int dfl_emif_probe(struct dfl_device *ddev)
+{
+	struct device *dev = &ddev->dev;
+	struct dfl_emif *de;
+
+	de = devm_kzalloc(dev, sizeof(*de), GFP_KERNEL);
+	if (!de)
+		return -ENOMEM;
+
+	de->base = devm_ioremap_resource(dev, &ddev->mmio_res);
+	if (IS_ERR(de->base))
+		return PTR_ERR(de->base);
+
+	de->dev = dev;
+	spin_lock_init(&de->lock);
+	dev_set_drvdata(dev, de);
+
+	return 0;
+}
+
+static const struct dfl_device_id dfl_emif_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_EMIF },
+	{ }
+};
+MODULE_DEVICE_TABLE(dfl, dfl_emif_ids);
+
+static struct dfl_driver dfl_emif_driver = {
+	.drv	= {
+		.name       = "dfl-emif",
+		.dev_groups = dfl_emif_groups,
+	},
+	.id_table = dfl_emif_ids,
+	.probe   = dfl_emif_probe,
+};
+module_dfl_driver(dfl_emif_driver);
+
+MODULE_DESCRIPTION("DFL EMIF driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

