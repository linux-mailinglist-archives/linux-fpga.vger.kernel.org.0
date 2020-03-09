Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9117DDA2
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Mar 2020 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCIKcP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Mar 2020 06:32:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:46791 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgCIKcO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 9 Mar 2020 06:32:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 03:32:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="288655069"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2020 03:32:12 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xu Yilun <yilun.xu@intel.com>, Luwei Kang <luwei.kang@intel.com>,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH 6/7] fpga: dfl: afu: add user interrupt support
Date:   Mon,  9 Mar 2020 18:29:49 +0800
Message-Id: <1583749790-10837-7-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583749790-10837-1-git-send-email-yilun.xu@intel.com>
References: <1583749790-10837-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

AFU (Accelerated Function Unit) is dynamic region of the DFL based FPGA,
and always defined by users. Some DFL based FPGA cards allow users to
implement their own interrupts in AFU. In order to support this,
hardware implements a new UINT (User Interrupt) private feature with
related capability register which describes the number of supported
user interrupts as well as the local index of the interrupts for
software enumeration, and from software side, driver follows the common
DFL interrupt notification and handling mechanism, and it implements
two ioctls below for user to query capability and set/unset interrupt
triggers.

 Ioctls:
 * DFL_FPGA_PORT_UINT_GET_INFO
   Get UINT private feature info, including num_irqs which is used to
   determine how many interrupts it supports.

 * DFL_FPGA_PORT_UINT_SET_IRQ
   set/unset eventfds as AFU user interrupt triggers.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-afu-main.c   | 79 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fpga-dfl.h | 28 +++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index fc8b9cf..7eec383 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -529,6 +529,81 @@ static const struct dfl_feature_ops port_stp_ops = {
 	.init = port_stp_init,
 };
 
+static long
+port_uint_get_info(struct platform_device *pdev,
+		   struct dfl_feature *feature, unsigned long arg)
+{
+	struct dfl_fpga_port_uint_info info;
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
+static long port_uint_set_irq(struct platform_device *pdev,
+			      struct dfl_feature *feature, unsigned long arg)
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
+port_uint_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
+		unsigned int cmd, unsigned long arg)
+{
+	long ret = -ENODEV;
+
+	switch (cmd) {
+	case DFL_FPGA_PORT_UINT_GET_INFO:
+		ret = port_uint_get_info(pdev, feature, arg);
+		break;
+	case DFL_FPGA_PORT_UINT_SET_IRQ:
+		ret = port_uint_set_irq(pdev, feature, arg);
+		break;
+	default:
+		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
+	}
+	return ret;
+}
+
+static const struct dfl_feature_id port_uint_id_table[] = {
+	{.id = PORT_FEATURE_ID_UINT,},
+	{0,}
+};
+
+static const struct dfl_feature_ops port_uint_ops = {
+	.ioctl = port_uint_ioctl,
+};
+
 static struct dfl_feature_driver port_feature_drvs[] = {
 	{
 		.id_table = port_hdr_id_table,
@@ -547,6 +622,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
 		.ops = &port_stp_ops,
 	},
 	{
+		.id_table = port_uint_id_table,
+		.ops = &port_uint_ops,
+	},
+	{
 		.ops = NULL,
 	}
 };
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
index c212fa9..f392b93 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -185,6 +185,34 @@ struct dfl_fpga_irq_set {
 
 #define DFL_FPGA_PORT_ERR_SET_IRQ	_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 6)
 
+/**
+ * DFL_FPGA_PORT_UINT_GET_INFO - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 7,
+ *						struct dfl_fpga_port_uint_info)
+ *
+ * Retrieve information about the fpga AFU user interrupt private feature.
+ * Driver fills the info in provided struct dfl_fpga_port_uint_info.
+ * Return: 0 on success, -errno on failure.
+ */
+struct dfl_fpga_port_uint_info {
+	/* Output */
+	__u32 flags;		/* Zero for now */
+	__u32 capability;	/* The capability of user interrupt */
+	__u32 num_irqs;		/* number of irqs user interrupt supports */
+};
+
+#define DFL_FPGA_PORT_UINT_GET_INFO	_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 7)
+
+/**
+ * DFL_FPGA_PORT_UINT_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 8,
+ *						struct dfl_fpga_irq_set)
+ *
+ * Set fpga afu user interrupt trigger if evtfds[n] is valid.
+ * Unset related interrupt trigger if evtfds[n] is a negative value.
+ * Return: 0 on success, -errno on failure.
+ */
+
+#define DFL_FPGA_PORT_UINT_SET_IRQ	_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 8)
+
 /* IOCTLs for FME file descriptor */
 
 /**
-- 
2.7.4

