Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B8A17DD9E
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Mar 2020 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgCIKcJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Mar 2020 06:32:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:46791 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgCIKcJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 9 Mar 2020 06:32:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 03:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="288655036"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2020 03:32:06 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xu Yilun <yilun.xu@intel.com>, Luwei Kang <luwei.kang@intel.com>,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH 4/7] fpga: dfl: afu: add interrupt support for error reporting
Date:   Mon,  9 Mar 2020 18:29:47 +0800
Message-Id: <1583749790-10837-5-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583749790-10837-1-git-send-email-yilun.xu@intel.com>
References: <1583749790-10837-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Error reporting interrupt is very useful to notify users that some
errors are detected by the hardware. Once users are notified, they
could query hardware logged error states, no need to continuously
poll on these states.

This patch follows the common DFL interrupt notification and handling
mechanism, implements two ioctl commands below for user to query
hardware capability, and set/unset interrupt triggers.

 Ioctls:
 * DFL_FPGA_PORT_ERR_GET_INFO
   get error reporting feature info, including num_irqs which is used to
   determine whether/how many interrupts it supports.

 * DFL_FPGA_PORT_ERR_SET_IRQ
   set/unset given eventfds as error interrupt triggers.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-afu-error.c  | 69 +++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl-afu-main.c   |  4 +++
 include/uapi/linux/fpga-dfl.h | 34 +++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index c1467ae..a2c5454 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/uaccess.h>
+#include <linux/fpga-dfl.h>
 
 #include "dfl-afu.h"
 
@@ -219,6 +220,73 @@ static void port_err_uinit(struct platform_device *pdev,
 	afu_port_err_mask(&pdev->dev, true);
 }
 
+static long
+port_err_get_info(struct platform_device *pdev,
+		  struct dfl_feature *feature, unsigned long arg)
+{
+	struct dfl_fpga_port_err_info info;
+
+	info.flags = 0;
+	info.capability = 0;
+	info.num_irqs = feature->nr_irqs;
+
+	if (copy_to_user((void __user *)arg, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long port_err_set_irq(struct platform_device *pdev,
+			     struct dfl_feature *feature, unsigned long arg)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_fpga_irq_set hdr;
+	s32 *fds;
+	long ret;
+
+	if (!feature->nr_irqs)
+		return -ENOENT;
+
+	if (copy_from_user(&hdr, (void __user *)arg, sizeof(hdr)))
+		return -EFAULT;
+
+	if (hdr.flags || (hdr.start + hdr.count > feature->nr_irqs) ||
+	    (hdr.start + hdr.count < hdr.start) || !hdr.count)
+		return -EINVAL;
+
+	fds = memdup_user((void __user *)(arg + sizeof(hdr)),
+			  hdr.count * sizeof(s32));
+	if (IS_ERR(fds))
+		return PTR_ERR(fds);
+
+	mutex_lock(&pdata->lock);
+	ret = dfl_fpga_set_irq_triggers(feature, hdr.start, hdr.count, fds);
+	mutex_unlock(&pdata->lock);
+
+	kfree(fds);
+	return ret;
+}
+
+static long
+port_err_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
+	       unsigned int cmd, unsigned long arg)
+{
+	long ret = -ENODEV;
+
+	switch (cmd) {
+	case DFL_FPGA_PORT_ERR_GET_INFO:
+		ret = port_err_get_info(pdev, feature, arg);
+		break;
+	case DFL_FPGA_PORT_ERR_SET_IRQ:
+		ret = port_err_set_irq(pdev, feature, arg);
+		break;
+	default:
+		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
+	}
+
+	return ret;
+}
+
 const struct dfl_feature_id port_err_id_table[] = {
 	{.id = PORT_FEATURE_ID_ERROR,},
 	{0,}
@@ -227,4 +295,5 @@ const struct dfl_feature_id port_err_id_table[] = {
 const struct dfl_feature_ops port_err_ops = {
 	.init = port_err_init,
 	.uinit = port_err_uinit,
+	.ioctl = port_err_ioctl,
 };
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 435bde4..fc8b9cf 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -577,6 +577,7 @@ static int afu_release(struct inode *inode, struct file *filp)
 {
 	struct platform_device *pdev = filp->private_data;
 	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature *feature;
 
 	dev_dbg(&pdev->dev, "Device File Release\n");
 
@@ -586,6 +587,9 @@ static int afu_release(struct inode *inode, struct file *filp)
 	dfl_feature_dev_use_end(pdata);
 
 	if (!dfl_feature_dev_use_count(pdata)) {
+		dfl_fpga_dev_for_each_feature(pdata, feature)
+			dfl_fpga_set_irq_triggers(feature, 0,
+						  feature->nr_irqs, NULL);
 		__port_reset(pdev);
 		afu_dma_region_destroy(pdata);
 	}
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
index ec70a0746..846fc91 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -151,6 +151,40 @@ struct dfl_fpga_port_dma_unmap {
 
 #define DFL_FPGA_PORT_DMA_UNMAP		_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 4)
 
+/**
+ * DFL_FPGA_PORT_ERR_GET_INFO - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 5,
+ *						struct dfl_fpga_port_err_info)
+ *
+ * Retrieve information about the fpga port error reporting private feature.
+ * Driver fills the info in provided struct dfl_fpga_port_err_info.
+ * Return: 0 on success, -errno on failure.
+ */
+struct dfl_fpga_port_err_info {
+	/* Output */
+	__u32 flags;		/* Zero for now */
+	__u32 capability;	/* The capability of port error reporting */
+	__u32 num_irqs;		/* number of irqs it supports */
+};
+
+#define DFL_FPGA_PORT_ERR_GET_INFO	_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 5)
+
+/**
+ * DFL_FPGA_PORT_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 6,
+ *						struct dfl_fpga_irq_set)
+ *
+ * Set fpga port error reporting interrupt trigger if evtfds[n] is valid.
+ * Unset related interrupt trigger if evtfds[n] is a negative value.
+ * Return: 0 on success, -errno on failure.
+ */
+struct dfl_fpga_irq_set {
+	__u32 flags;		/* Zero for now */
+	__u32 start;		/* First irq number */
+	__u32 count;		/* The number of eventfd handler */
+	__s32 evtfds[];		/* Eventfd handler */
+};
+
+#define DFL_FPGA_PORT_ERR_SET_IRQ	_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 6)
+
 /* IOCTLs for FME file descriptor */
 
 /**
-- 
2.7.4

