Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1758F56
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2019 02:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfF1Auu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Jun 2019 20:50:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38714 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfF1Aut (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Jun 2019 20:50:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so1782447pgz.5
        for <linux-fpga@vger.kernel.org>; Thu, 27 Jun 2019 17:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WqdklbQ6zMUFnwZcyQZUcBmlqOVs1+Df1yhgx8AnMUU=;
        b=WYxKEKBS4sglvYrCfok/YVZd91DSVsnleyPjV2vrx8/iO0XZcSwDXzAnq3wL0mCVnh
         KL6Ar5hYNdVfxzDlbaGz0xTctnJXe1DbdeM9e5yif2du2ZmF47P+8k+6pBRPKX+EhlxJ
         j0Cqp3oTr38wcXQLyFBgs0ayuhSmaIJJE9umYy5FEmvTp2QW00DqYbKgrEJ/bPCizfGb
         7f7Uq2pgOCD2W56kR3IXi6MjcRCIIvs9vXbTKDRX+oC7vrR+SqVVTtdDNvgBS6/h3w99
         KuK8ZELBXg0k6vXBLh+okBmsWo1M7JlRNDXvsIz2UxQPI3t2u+3JInWgeyA/B7IDoTrE
         fWOw==
X-Gm-Message-State: APjAAAUuvK5awFKmUif/xwWaYUcybzBjODpyrdlA4w2mE6HNzPpbM5k9
        RF5x3pbvgBJzBhx2y/9AYOknFworWmI=
X-Google-Smtp-Source: APXvYqyVV5nxSCLvMbYAQl4SUJtSqWVsfpz3Nk73tL7pCIT3Mx4lezw8fl8a3ZZNqTFhwTv4Rz9IBQ==
X-Received: by 2002:a65:448a:: with SMTP id l10mr6475489pgq.53.1561683048045;
        Thu, 27 Jun 2019 17:50:48 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id k6sm285990pfi.12.2019.06.27.17.50.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:47 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Luwei Kang <luwei.kang@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 15/15] fpga: dfl: fme: add global error reporting support
Date:   Thu, 27 Jun 2019 17:49:51 -0700
Message-Id: <20190628004951.6202-16-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

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
 .../ABI/testing/sysfs-platform-dfl-fme        |  75 ++++
 drivers/fpga/Makefile                         |   2 +-
 drivers/fpga/dfl-fme-error.c                  | 385 ++++++++++++++++++
 drivers/fpga/dfl-fme-main.c                   |   4 +
 drivers/fpga/dfl-fme.h                        |   2 +
 drivers/fpga/dfl.h                            |   2 +
 6 files changed, 469 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fpga/dfl-fme-error.c

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index 99cd3b2acff5..86eef83938b2 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -44,3 +44,78 @@ Description:	Read-only. It returns socket_id to indicate which socket
 		this FPGA belongs to, only valid for integrated solution.
 		User only needs this information, in case standard numa node
 		can't provide correct information.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/revision
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the revision of this global
+		error reporting private feature.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/pcie0_errors
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file for errors detected on pcie0 link.
+		Write this file to clear errors logged in pcie0_errors. Write
+		fails with -EINVAL if input parsing fails or input error code
+		doesn't match.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/pcie1_errors
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file for errors detected on pcie1 link.
+		Write this file to clear errors logged in pcie1_errors. Write
+		fails with -EINVAL if input parsing fails or input error code
+		doesn't match.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/nonfatal_errors
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns non-fatal errors detected.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/catfatal_errors
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns catastrophic and fatal errors detected.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/inject_error
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file to check errors injected. Write this
+		file to inject errors for testing purpose. Write fails with
+		-EINVAL if input parsing fails or input inject error code isn't
+		supported.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme-errors/errors
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get errors detected by hardware.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme-errors/first_error
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the first error detected by
+		hardware.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme-errors/next_error
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the second error detected by
+		hardware.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme-errors/clear
+Date:		June 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. Write error code to this file to clear all errors
+		logged in errors, first_error and next_error. Write fails with
+		-EINVAL if input parsing fails or input error code doesn't
+		match.
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 72558914a29c..4865b74b00a4 100644
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
index 000000000000..cdea10825f71
--- /dev/null
+++ b/drivers/fpga/dfl-fme-error.c
@@ -0,0 +1,385 @@
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
+	dev_dbg(&pdev->dev, "FME Global Error Reporting Init.\n");
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
+	ret = sysfs_create_groups(&dev->kobj, error_groups);
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
+	dev_dbg(&pdev->dev, "FME Global Error Reporting UInit.\n");
+
+	sysfs_remove_groups(&dev->kobj, error_groups);
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
index 2d69b8fd0137..4490cf484dc1 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -226,6 +226,10 @@ static struct dfl_feature_driver fme_feature_drvs[] = {
 		.id_table = fme_pr_mgmt_id_table,
 		.ops = &fme_pr_mgmt_ops,
 	},
+	{
+		.id_table = fme_global_err_id_table,
+		.ops = &fme_global_err_ops,
+	},
 	{
 		.ops = NULL,
 	},
diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
index 7a021c483e9b..5fbe3f552553 100644
--- a/drivers/fpga/dfl-fme.h
+++ b/drivers/fpga/dfl-fme.h
@@ -37,5 +37,7 @@ struct dfl_fme {
 
 extern const struct dfl_feature_ops fme_pr_mgmt_ops;
 extern const struct dfl_feature_id fme_pr_mgmt_id_table[];
+extern const struct dfl_feature_ops fme_global_err_ops;
+extern const struct dfl_feature_id fme_global_err_id_table[];
 
 #endif /* __DFL_FME_H */
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index fbc57f0f76ef..6c320801dd4a 100644
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
2.22.0

