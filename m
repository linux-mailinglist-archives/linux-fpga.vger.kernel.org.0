Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBCE80A9C
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Aug 2019 12:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfHDKiM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Aug 2019 06:38:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:31912 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfHDKiL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 4 Aug 2019 06:38:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2019 03:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,345,1559545200"; 
   d="scan'208";a="167679010"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2019 03:38:08 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>, Luwei Kang <luwei.kang@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v4 11/12] fpga: dfl: fme: add global error reporting support
Date:   Sun,  4 Aug 2019 18:20:21 +0800
Message-Id: <1564914022-3710-12-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
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
---
 Documentation/ABI/testing/sysfs-platform-dfl-fme |  75 +++++
 drivers/fpga/Makefile                            |   2 +-
 drivers/fpga/dfl-fme-error.c                     | 381 +++++++++++++++++++++++
 drivers/fpga/dfl-fme-main.c                      |   4 +
 drivers/fpga/dfl-fme.h                           |   2 +
 drivers/fpga/dfl.h                               |   2 +
 6 files changed, 465 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fpga/dfl-fme-error.c

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index 65372aa..6e9e7d4 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -44,3 +44,78 @@ Description:	Read-only. It returns socket_id to indicate which socket
 		this FPGA belongs to, only valid for integrated solution.
 		User only needs this information, in case standard numa node
 		can't provide correct information.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/revision
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the revision of this global
+		error reporting private feature.
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
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/inject_error
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file to check errors injected. Write this
+		file to inject errors for testing purpose. Write fails with
+		-EINVAL if input parsing fails or input inject error code isn't
+		supported.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme-errors/errors
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get errors detected by hardware.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme-errors/first_error
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the first error detected by
+		hardware.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme-errors/next_error
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the second error detected by
+		hardware.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme-errors/clear
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. Write error code to this file to clear all errors
+		logged in errors, first_error and next_error. Write fails with
+		-EINVAL if input parsing fails or input error code doesn't
+		match.
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
index 0000000..8b2df80
--- /dev/null
+++ b/drivers/fpga/dfl-fme-error.c
@@ -0,0 +1,381 @@
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
+static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "%u\n", dfl_feature_revision(base));
+}
+static DEVICE_ATTR_RO(revision);
+
+static ssize_t pcie0_errors_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)readq(base + PCIE0_ERROR));
+}
+
+static ssize_t pcie0_errors_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+	int ret = 0;
+	u64 v, val;
+
+	if (kstrtou64(buf, 0, &val))
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
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
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)readq(base + PCIE1_ERROR));
+}
+
+static ssize_t pcie1_errors_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+	int ret = 0;
+	u64 v, val;
+
+	if (kstrtou64(buf, 0, &val))
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
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
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
+}
+static DEVICE_ATTR_RO(nonfatal_errors);
+
+static ssize_t catfatal_errors_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
+}
+static DEVICE_ATTR_RO(catfatal_errors);
+
+static ssize_t inject_error_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	v = readq(base + RAS_ERROR_INJECT);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
+}
+
+static ssize_t inject_error_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
+	struct device *err_dev = dev->parent;
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
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
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
+static DEVICE_ATTR_RW(inject_error);
+
+static struct attribute *errors_attrs[] = {
+	&dev_attr_revision.attr,
+	&dev_attr_pcie0_errors.attr,
+	&dev_attr_pcie1_errors.attr,
+	&dev_attr_nonfatal_errors.attr,
+	&dev_attr_catfatal_errors.attr,
+	&dev_attr_inject_error.attr,
+	NULL,
+};
+
+static struct attribute_group errors_attr_group = {
+	.attrs	= errors_attrs,
+};
+
+static ssize_t errors_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)readq(base + FME_ERROR));
+}
+static DEVICE_ATTR_RO(errors);
+
+static ssize_t first_error_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)readq(base + FME_FIRST_ERROR));
+}
+static DEVICE_ATTR_RO(first_error);
+
+static ssize_t next_error_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)readq(base + FME_NEXT_ERROR));
+}
+static DEVICE_ATTR_RO(next_error);
+
+static ssize_t clear_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
+	struct device *err_dev = dev->parent;
+	void __iomem *base;
+	u64 v, val;
+	int ret = 0;
+
+	if (kstrtou64(buf, 0, &val))
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
+
+	mutex_lock(&pdata->lock);
+	writeq(GENMASK_ULL(63, 0), base + FME_ERROR_MASK);
+
+	v = readq(base + FME_ERROR);
+	if (val == v) {
+		writeq(v, base + FME_ERROR);
+		v = readq(base + FME_FIRST_ERROR);
+		writeq(v, base + FME_FIRST_ERROR);
+		v = readq(base + FME_NEXT_ERROR);
+		writeq(v, base + FME_NEXT_ERROR);
+	} else {
+		ret = -EINVAL;
+	}
+
+	/* Workaround: disable MBP_ERROR if feature revision is 0 */
+	writeq(dfl_feature_revision(base) ? 0ULL : MBP_ERROR,
+	       base + FME_ERROR_MASK);
+	mutex_unlock(&pdata->lock);
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(clear);
+
+static struct attribute *fme_errors_attrs[] = {
+	&dev_attr_errors.attr,
+	&dev_attr_first_error.attr,
+	&dev_attr_next_error.attr,
+	&dev_attr_clear.attr,
+	NULL,
+};
+
+static struct attribute_group fme_errors_attr_group = {
+	.attrs	= fme_errors_attrs,
+	.name	= "fme-errors",
+};
+
+static const struct attribute_group *error_groups[] = {
+	&fme_errors_attr_group,
+	&errors_attr_group,
+	NULL
+};
+
+static void fme_error_enable(struct dfl_feature *feature)
+{
+	void __iomem *base = feature->ioaddr;
+
+	/* Workaround: disable MBP_ERROR if revision is 0 */
+	writeq(dfl_feature_revision(feature->ioaddr) ? 0ULL : MBP_ERROR,
+	       base + FME_ERROR_MASK);
+	writeq(0ULL, base + PCIE0_ERROR_MASK);
+	writeq(0ULL, base + PCIE1_ERROR_MASK);
+	writeq(0ULL, base + RAS_NONFAT_ERROR_MASK);
+	writeq(0ULL, base + RAS_CATFAT_ERROR_MASK);
+}
+
+static void err_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static int fme_global_err_init(struct platform_device *pdev,
+			       struct dfl_feature *feature)
+{
+	struct device *dev;
+	int ret = 0;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->parent = &pdev->dev;
+	dev->release = err_dev_release;
+	dev_set_name(dev, "errors");
+
+	fme_error_enable(feature);
+
+	ret = device_register(dev);
+	if (ret) {
+		put_device(dev);
+		return ret;
+	}
+
+	ret = device_add_groups(dev, error_groups);
+	if (ret) {
+		device_unregister(dev);
+		return ret;
+	}
+
+	feature->priv = dev;
+
+	return ret;
+}
+
+static void fme_global_err_uinit(struct platform_device *pdev,
+				 struct dfl_feature *feature)
+{
+	struct device *dev = feature->priv;
+
+	device_remove_groups(dev, error_groups);
+	device_unregister(dev);
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
index f033f1c..59bc2cc 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -214,6 +214,10 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
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
diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
index e4131e8..a3a48c8 100644
--- a/drivers/fpga/dfl-fme.h
+++ b/drivers/fpga/dfl-fme.h
@@ -35,5 +35,7 @@ struct dfl_fme {
 
 extern const struct dfl_feature_ops fme_pr_mgmt_ops;
 extern const struct dfl_feature_id fme_pr_mgmt_id_table[];
+extern const struct dfl_feature_ops fme_global_err_ops;
+extern const struct dfl_feature_id fme_global_err_id_table[];
 
 #endif /* __DFL_FME_H */
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 9f0e656..d312678 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -197,12 +197,14 @@ struct dfl_feature_driver {
  *		    feature dev (platform device)'s reources.
  * @ioaddr: mapped mmio resource address.
  * @ops: ops of this sub feature.
+ * @priv: priv data of this feature.
  */
 struct dfl_feature {
 	u64 id;
 	int resource_index;
 	void __iomem *ioaddr;
 	const struct dfl_feature_ops *ops;
+	void *priv;
 };
 
 #define DEV_STATUS_IN_USE	0
-- 
1.8.3.1

