Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAE389591
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Aug 2019 05:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfHLDH6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Aug 2019 23:07:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:12631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfHLDH6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Aug 2019 23:07:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 20:07:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,375,1559545200"; 
   d="scan'208";a="199987493"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2019 20:07:56 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v5 6/9] fpga: dfl: afu: add error reporting support.
Date:   Mon, 12 Aug 2019 10:50:01 +0800
Message-Id: <1565578204-13969-7-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Error reporting is one important private feature, it reports error
detected on port and accelerated function unit (AFU). It introduces
several sysfs interfaces to allow userspace to check and clear
errors detected by hardware.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: switch to device_add/remove_group for sysfs.
v3: update kernel version and date in sysfs doc
v4: remove dev_dbg in init/uinit callback function.
v5: rework init/uinit function and improve naming.
    update sysfs entries:
      remove revision sysfs entry.
      merge WO "clear" sysfs to RO "errors" to keep alignment with
      latest changes in fme error reporting support.
    expose error related sysfs entries via dev_groups.
---
 Documentation/ABI/testing/sysfs-platform-dfl-port |  25 +++
 drivers/fpga/Makefile                             |   1 +
 drivers/fpga/dfl-afu-error.c                      | 230 ++++++++++++++++++++++
 drivers/fpga/dfl-afu-main.c                       |   5 +
 drivers/fpga/dfl-afu.h                            |   5 +
 5 files changed, 266 insertions(+)
 create mode 100644 drivers/fpga/dfl-afu-error.c

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index c2660e4..6565826 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -74,3 +74,28 @@ KernelVersion:	5.4
 Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-only. Read this file to get the status of issued command
 		to userclck_freqcntrcmd.
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/errors
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file to get errors detected on port and
+		Accelerated Function Unit (AFU). Write error code to this file
+		to clear errors. Write fails with -EINVAL if input parsing
+		fails or input error code doesn't match. Write fails with
+		-EBUSY or -ETIMEDOUT if error can't be cleared as hardware
+		in low power state (-EBUSY) or not respoding (-ETIMEDOUT).
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/first_error
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the first error detected by
+		hardware.
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/first_malformed_req
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the first malformed request
+		captured by hardware.
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 312b937..7255891 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
+dfl-afu-objs += dfl-afu-error.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
new file mode 100644
index 0000000..c1467ae
--- /dev/null
+++ b/drivers/fpga/dfl-afu-error.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Accelerated Function Unit (AFU) Error Reporting
+ *
+ * Copyright 2019 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@linux.intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Mitchel Henry <henry.mitchel@intel.com>
+ */
+
+#include <linux/uaccess.h>
+
+#include "dfl-afu.h"
+
+#define PORT_ERROR_MASK		0x8
+#define PORT_ERROR		0x10
+#define PORT_FIRST_ERROR	0x18
+#define PORT_MALFORMED_REQ0	0x20
+#define PORT_MALFORMED_REQ1	0x28
+
+#define ERROR_MASK		GENMASK_ULL(63, 0)
+
+/* mask or unmask port errors by the error mask register. */
+static void __afu_port_err_mask(struct device *dev, bool mask)
+{
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
+}
+
+static void afu_port_err_mask(struct device *dev, bool mask)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+
+	mutex_lock(&pdata->lock);
+	__afu_port_err_mask(dev, mask);
+	mutex_unlock(&pdata->lock);
+}
+
+/* clear port errors. */
+static int afu_port_err_clear(struct device *dev, u64 err)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	void __iomem *base_err, *base_hdr;
+	int ret = -EBUSY;
+	u64 v;
+
+	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+
+	/*
+	 * clear Port Errors
+	 *
+	 * - Check for AP6 State
+	 * - Halt Port by keeping Port in reset
+	 * - Set PORT Error mask to all 1 to mask errors
+	 * - Clear all errors
+	 * - Set Port mask to all 0 to enable errors
+	 * - All errors start capturing new errors
+	 * - Enable Port by pulling the port out of reset
+	 */
+
+	/* if device is still in AP6 power state, can not clear any error. */
+	v = readq(base_hdr + PORT_HDR_STS);
+	if (FIELD_GET(PORT_STS_PWR_STATE, v) == PORT_STS_PWR_STATE_AP6) {
+		dev_err(dev, "Could not clear errors, device in AP6 state.\n");
+		goto done;
+	}
+
+	/* Halt Port by keeping Port in reset */
+	ret = __afu_port_disable(pdev);
+	if (ret)
+		goto done;
+
+	/* Mask all errors */
+	__afu_port_err_mask(dev, true);
+
+	/* Clear errors if err input matches with current port errors.*/
+	v = readq(base_err + PORT_ERROR);
+
+	if (v == err) {
+		writeq(v, base_err + PORT_ERROR);
+
+		v = readq(base_err + PORT_FIRST_ERROR);
+		writeq(v, base_err + PORT_FIRST_ERROR);
+	} else {
+		ret = -EINVAL;
+	}
+
+	/* Clear mask */
+	__afu_port_err_mask(dev, false);
+
+	/* Enable the Port by clear the reset */
+	__afu_port_enable(pdev);
+
+done:
+	mutex_unlock(&pdata->lock);
+	return ret;
+}
+
+static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 error;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	mutex_lock(&pdata->lock);
+	error = readq(base + PORT_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
+}
+
+static ssize_t errors_store(struct device *dev, struct device_attribute *attr,
+			    const char *buff, size_t count)
+{
+	u64 value;
+	int ret;
+
+	if (kstrtou64(buff, 0, &value))
+		return -EINVAL;
+
+	ret = afu_port_err_clear(dev, value);
+
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(errors);
+
+static ssize_t first_error_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 error;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	mutex_lock(&pdata->lock);
+	error = readq(base + PORT_FIRST_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
+}
+static DEVICE_ATTR_RO(first_error);
+
+static ssize_t first_malformed_req_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 req0, req1;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	mutex_lock(&pdata->lock);
+	req0 = readq(base + PORT_MALFORMED_REQ0);
+	req1 = readq(base + PORT_MALFORMED_REQ1);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%016llx%016llx\n",
+		       (unsigned long long)req1, (unsigned long long)req0);
+}
+static DEVICE_ATTR_RO(first_malformed_req);
+
+static struct attribute *port_err_attrs[] = {
+	&dev_attr_errors.attr,
+	&dev_attr_first_error.attr,
+	&dev_attr_first_malformed_req.attr,
+	NULL,
+};
+
+static umode_t port_err_attrs_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	/*
+	 * sysfs entries are visible only if related private feature is
+	 * enumerated.
+	 */
+	if (!dfl_get_feature_by_id(dev, PORT_FEATURE_ID_ERROR))
+		return 0;
+
+	return attr->mode;
+}
+
+const struct attribute_group port_err_group = {
+	.name       = "errors",
+	.attrs      = port_err_attrs,
+	.is_visible = port_err_attrs_visible,
+};
+
+static int port_err_init(struct platform_device *pdev,
+			 struct dfl_feature *feature)
+{
+	afu_port_err_mask(&pdev->dev, false);
+
+	return 0;
+}
+
+static void port_err_uinit(struct platform_device *pdev,
+			   struct dfl_feature *feature)
+{
+	afu_port_err_mask(&pdev->dev, true);
+}
+
+const struct dfl_feature_id port_err_id_table[] = {
+	{.id = PORT_FEATURE_ID_ERROR,},
+	{0,}
+};
+
+const struct dfl_feature_ops port_err_ops = {
+	.init = port_err_init,
+	.uinit = port_err_uinit,
+};
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 449185c..e11352a 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -518,6 +518,10 @@ static int port_afu_init(struct platform_device *pdev,
 		.ops = &port_afu_ops,
 	},
 	{
+		.id_table = port_err_id_table,
+		.ops = &port_err_ops,
+	},
+	{
 		.ops = NULL,
 	}
 };
@@ -860,6 +864,7 @@ static int afu_remove(struct platform_device *pdev)
 static const struct attribute_group *afu_dev_groups[] = {
 	&port_hdr_group,
 	&port_afu_group,
+	&port_err_group,
 	NULL
 };
 
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 83683f2..576e949 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -101,4 +101,9 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 struct dfl_afu_dma_region *
 afu_dma_region_find(struct dfl_feature_platform_data *pdata,
 		    u64 iova, u64 size);
+
+extern const struct dfl_feature_ops port_err_ops;
+extern const struct dfl_feature_id port_err_id_table[];
+extern const struct attribute_group port_err_group;
+
 #endif /* __DFL_AFU_H */
-- 
1.8.3.1

