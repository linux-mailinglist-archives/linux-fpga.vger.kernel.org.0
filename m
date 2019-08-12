Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAC7989597
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Aug 2019 05:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfHLDID (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Aug 2019 23:08:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:12631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfHLDIC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Aug 2019 23:08:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 20:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,375,1559545200"; 
   d="scan'208";a="199987508"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2019 20:08:00 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>, Luwei Kang <luwei.kang@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v5 8/9] fpga: dfl: fme: add global error reporting support
Date:   Mon, 12 Aug 2019 10:50:03 +0800
Message-Id: <1565578204-13969-9-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds support for global error reporting for FPGA
Management Engine (FME), it introduces sysfs interfaces to
report different error detected by the hardware, and allow
user to clear errors or inject error for testing purpose.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: switch to device_add/remove_groups for sysfs.
v3: update kernel version and date in sysfs doc
v4: rebase, remove dev_dbg in init/uinit callback.
v5: reorganize sysfs entries:
      remove "fme-errors" sub folder and related sysfs entries to
      upper level folder.
      merge WO "clear" to RO "errors" to keep alignment with error
      sysfs entries in upper level folder.
      remove revision sysfs entry.
    add missed locking in sysfs entries.
    expose sysfs group with is_visible via dev_groups.
---
 Documentation/ABI/testing/sysfs-platform-dfl-fme |  62 ++++
 drivers/fpga/Makefile                            |   2 +-
 drivers/fpga/dfl-fme-error.c                     | 359 +++++++++++++++++++++++
 drivers/fpga/dfl-fme-main.c                      |  17 +-
 drivers/fpga/dfl-fme.h                           |   3 +
 5 files changed, 440 insertions(+), 3 deletions(-)
 create mode 100644 drivers/fpga/dfl-fme-error.c

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index 65372aa..72634d3 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -44,3 +44,65 @@ Description:	Read-only. It returns socket_id to indicate which socket
 		this FPGA belongs to, only valid for integrated solution.
 		User only needs this information, in case standard numa node
 		can't provide correct information.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/pcie0_errors
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file for errors detected on pcie0 link.
+		Write this file to clear errors logged in pcie0_errors. Write
+		fails with -EINVAL if input parsing fails or input error code
+		doesn't match.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/pcie1_errors
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file for errors detected on pcie1 link.
+		Write this file to clear errors logged in pcie1_errors. Write
+		fails with -EINVAL if input parsing fails or input error code
+		doesn't match.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/nonfatal_errors
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns non-fatal errors detected.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/catfatal_errors
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns catastrophic and fatal errors detected.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/inject_errors
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file to check errors injected. Write this
+		file to inject errors for testing purpose. Write fails with
+		-EINVAL if input parsing fails or input inject error code isn't
+		supported.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme_errors
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file to get errors detected on FME.
+		Write this file to clear errors logged in fme_errors. Write
+		fials with -EINVAL if input parsing fails or input error code
+		doesn't match.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/first_error
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the first error detected by
+		hardware.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/next_error
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the second error detected by
+		hardware.
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 7255891..4865b74 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
 obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
 obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
 
-dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
+dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o dfl-fme-error.o
 dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
 dfl-afu-objs += dfl-afu-error.o
 
diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
new file mode 100644
index 0000000..f897d41
--- /dev/null
+++ b/drivers/fpga/dfl-fme-error.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Management Engine Error Management
+ *
+ * Copyright 2019 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Kang Luwei <luwei.kang@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *   Wu Hao <hao.wu@intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Mitchel, Henry <henry.mitchel@intel.com>
+ */
+
+#include <linux/uaccess.h>
+
+#include "dfl.h"
+#include "dfl-fme.h"
+
+#define FME_ERROR_MASK		0x8
+#define FME_ERROR		0x10
+#define MBP_ERROR		BIT_ULL(6)
+#define PCIE0_ERROR_MASK	0x18
+#define PCIE0_ERROR		0x20
+#define PCIE1_ERROR_MASK	0x28
+#define PCIE1_ERROR		0x30
+#define FME_FIRST_ERROR		0x38
+#define FME_NEXT_ERROR		0x40
+#define RAS_NONFAT_ERROR_MASK	0x48
+#define RAS_NONFAT_ERROR	0x50
+#define RAS_CATFAT_ERROR_MASK	0x58
+#define RAS_CATFAT_ERROR	0x60
+#define RAS_ERROR_INJECT	0x68
+#define INJECT_ERROR_MASK	GENMASK_ULL(2, 0)
+
+#define ERROR_MASK		GENMASK_ULL(63, 0)
+
+static ssize_t pcie0_errors_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 value;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	value = readq(base + PCIE0_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+}
+
+static ssize_t pcie0_errors_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	int ret = 0;
+	u64 v, val;
+
+	if (kstrtou64(buf, 0, &val))
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	writeq(GENMASK_ULL(63, 0), base + PCIE0_ERROR_MASK);
+
+	v = readq(base + PCIE0_ERROR);
+	if (val == v)
+		writeq(v, base + PCIE0_ERROR);
+	else
+		ret = -EINVAL;
+
+	writeq(0ULL, base + PCIE0_ERROR_MASK);
+	mutex_unlock(&pdata->lock);
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(pcie0_errors);
+
+static ssize_t pcie1_errors_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 value;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	value = readq(base + PCIE1_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+}
+
+static ssize_t pcie1_errors_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	int ret = 0;
+	u64 v, val;
+
+	if (kstrtou64(buf, 0, &val))
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	writeq(GENMASK_ULL(63, 0), base + PCIE1_ERROR_MASK);
+
+	v = readq(base + PCIE1_ERROR);
+	if (val == v)
+		writeq(v, base + PCIE1_ERROR);
+	else
+		ret = -EINVAL;
+
+	writeq(0ULL, base + PCIE1_ERROR_MASK);
+	mutex_unlock(&pdata->lock);
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(pcie1_errors);
+
+static ssize_t nonfatal_errors_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
+}
+static DEVICE_ATTR_RO(nonfatal_errors);
+
+static ssize_t catfatal_errors_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
+}
+static DEVICE_ATTR_RO(catfatal_errors);
+
+static ssize_t inject_errors_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + RAS_ERROR_INJECT);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
+}
+
+static ssize_t inject_errors_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u8 inject_error;
+	u64 v;
+
+	if (kstrtou8(buf, 0, &inject_error))
+		return -EINVAL;
+
+	if (inject_error & ~INJECT_ERROR_MASK)
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + RAS_ERROR_INJECT);
+	v &= ~INJECT_ERROR_MASK;
+	v |= FIELD_PREP(INJECT_ERROR_MASK, inject_error);
+	writeq(v, base + RAS_ERROR_INJECT);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(inject_errors);
+
+static ssize_t fme_errors_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 value;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	value = readq(base + FME_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+}
+
+static ssize_t fme_errors_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v, val;
+	int ret = 0;
+
+	if (kstrtou64(buf, 0, &val))
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	writeq(GENMASK_ULL(63, 0), base + FME_ERROR_MASK);
+
+	v = readq(base + FME_ERROR);
+	if (val == v)
+		writeq(v, base + FME_ERROR);
+	else
+		ret = -EINVAL;
+
+	/* Workaround: disable MBP_ERROR if feature revision is 0 */
+	writeq(dfl_feature_revision(base) ? 0ULL : MBP_ERROR,
+	       base + FME_ERROR_MASK);
+	mutex_unlock(&pdata->lock);
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(fme_errors);
+
+static ssize_t first_error_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 value;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	value = readq(base + FME_FIRST_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+}
+static DEVICE_ATTR_RO(first_error);
+
+static ssize_t next_error_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 value;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	value = readq(base + FME_NEXT_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+}
+static DEVICE_ATTR_RO(next_error);
+
+static struct attribute *fme_global_err_attrs[] = {
+	&dev_attr_pcie0_errors.attr,
+	&dev_attr_pcie1_errors.attr,
+	&dev_attr_nonfatal_errors.attr,
+	&dev_attr_catfatal_errors.attr,
+	&dev_attr_inject_errors.attr,
+	&dev_attr_fme_errors.attr,
+	&dev_attr_first_error.attr,
+	&dev_attr_next_error.attr,
+	NULL,
+};
+
+static umode_t fme_global_err_attrs_visible(struct kobject *kobj,
+					    struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	/*
+	 * sysfs entries are visible only if related private feature is
+	 * enumerated.
+	 */
+	if (!dfl_get_feature_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR))
+		return 0;
+
+	return attr->mode;
+}
+
+const struct attribute_group fme_global_err_group = {
+	.name       = "errors",
+	.attrs      = fme_global_err_attrs,
+	.is_visible = fme_global_err_attrs_visible,
+};
+
+static void fme_err_mask(struct device *dev, bool mask)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+
+	/* Workaround: keep MBP_ERROR always masked if revision is 0 */
+	if (dfl_feature_revision(base))
+		writeq(mask ? ERROR_MASK : 0, base + FME_ERROR_MASK);
+	else
+		writeq(mask ? ERROR_MASK : MBP_ERROR, base + FME_ERROR_MASK);
+
+	writeq(mask ? ERROR_MASK : 0, base + PCIE0_ERROR_MASK);
+	writeq(mask ? ERROR_MASK : 0, base + PCIE1_ERROR_MASK);
+	writeq(mask ? ERROR_MASK : 0, base + RAS_NONFAT_ERROR_MASK);
+	writeq(mask ? ERROR_MASK : 0, base + RAS_CATFAT_ERROR_MASK);
+
+	mutex_unlock(&pdata->lock);
+}
+
+static int fme_global_err_init(struct platform_device *pdev,
+			       struct dfl_feature *feature)
+{
+	fme_err_mask(&pdev->dev, false);
+
+	return 0;
+}
+
+static void fme_global_err_uinit(struct platform_device *pdev,
+				 struct dfl_feature *feature)
+{
+	fme_err_mask(&pdev->dev, true);
+}
+
+const struct dfl_feature_id fme_global_err_id_table[] = {
+	{.id = FME_FEATURE_ID_GLOBAL_ERR,},
+	{0,}
+};
+
+const struct dfl_feature_ops fme_global_err_ops = {
+	.init = fme_global_err_init,
+	.uinit = fme_global_err_uinit,
+};
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index bf8114d..4d78e18 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -127,7 +127,10 @@ static ssize_t socket_id_show(struct device *dev,
 	&dev_attr_socket_id.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(fme_hdr);
+
+static const struct attribute_group fme_hdr_group = {
+	.attrs = fme_hdr_attrs,
+};
 
 static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
 				       unsigned long arg)
@@ -188,6 +191,10 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
 		.ops = &fme_pr_mgmt_ops,
 	},
 	{
+		.id_table = fme_global_err_id_table,
+		.ops = &fme_global_err_ops,
+	},
+	{
 		.ops = NULL,
 	},
 };
@@ -333,10 +340,16 @@ static int fme_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct attribute_group *fme_dev_groups[] = {
+	&fme_hdr_group,
+	&fme_global_err_group,
+	NULL
+};
+
 static struct platform_driver fme_driver = {
 	.driver	= {
 		.name       = DFL_FPGA_FEATURE_DEV_FME,
-		.dev_groups = fme_hdr_groups,
+		.dev_groups = fme_dev_groups,
 	},
 	.probe   = fme_probe,
 	.remove  = fme_remove,
diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
index e4131e8..6685c8e 100644
--- a/drivers/fpga/dfl-fme.h
+++ b/drivers/fpga/dfl-fme.h
@@ -35,5 +35,8 @@ struct dfl_fme {
 
 extern const struct dfl_feature_ops fme_pr_mgmt_ops;
 extern const struct dfl_feature_id fme_pr_mgmt_id_table[];
+extern const struct dfl_feature_ops fme_global_err_ops;
+extern const struct dfl_feature_id fme_global_err_id_table[];
+extern const struct attribute_group fme_global_err_group;
 
 #endif /* __DFL_FME_H */
-- 
1.8.3.1

