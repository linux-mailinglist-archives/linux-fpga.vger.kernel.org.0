Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B450D1907B9
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Mar 2020 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCXIfm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 24 Mar 2020 04:35:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:53578 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgCXIfl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 24 Mar 2020 04:35:41 -0400
IronPort-SDR: ow1KTnLHpSS/QSqyE+XpR9V1kyoZr+bclvrrS5j9d95OPJtr/ZCqov9wND7VLlTisG3vnyne69
 9DzI4G/1jkxA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 01:35:41 -0700
IronPort-SDR: jkCuV6WsqJn8Fhl0ND9uVXnovrtax7udYxiaM70I5Y80kDKC+bZzG0/EAYGcgkzNtjKteIOO1S
 +srK9DjB4//A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,299,1580803200"; 
   d="scan'208";a="446143839"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2020 01:35:39 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v3 6/7] fpga: dfl: afu: add user interrupt support
Date:   Tue, 24 Mar 2020 16:32:42 +0800
Message-Id: <1585038763-22944-7-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585038763-22944-1-git-send-email-yilun.xu@intel.com>
References: <1585038763-22944-1-git-send-email-yilun.xu@intel.com>
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
two ioctls below for user to query number of irqs supported and set/unset
interrupt triggers.

 Ioctls:
 * DFL_FPGA_PORT_UINT_GET_IRQ_NUM
   get the number of irqs, which is used to determine how many interrupts
   UINT feature supports.

 * DFL_FPGA_PORT_UINT_SET_IRQ
   set/unset eventfds as AFU user interrupt triggers.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
----
v2: use DFL_FPGA_PORT_UINT_GET_IRQ_NUM instead of
    DFL_FPGA_PORT_UINT_GET_INFO
    Delete flags field for DFL_FPGA_PORT_UINT_SET_IRQ
v3: put_user() instead of copy_to_user()
    improves comments
---
 drivers/fpga/dfl-afu-main.c   | 70 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fpga-dfl.h | 23 ++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 357cd5d..d2db5b6 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -529,6 +529,72 @@ static const struct dfl_feature_ops port_stp_ops = {
 	.init = port_stp_init,
 };
 
+static long
+port_uint_get_num_irqs(struct platform_device *pdev,
+		       struct dfl_feature *feature, unsigned long arg)
+{
+	return put_user(feature->nr_irqs, (__u32 __user *)arg);
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
+	if (!hdr.count || (hdr.start + hdr.count > feature->nr_irqs) ||
+	    (hdr.start + hdr.count < hdr.start))
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
+	case DFL_FPGA_PORT_UINT_GET_IRQ_NUM:
+		ret = port_uint_get_num_irqs(pdev, feature, arg);
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
@@ -547,6 +613,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
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
index 206bad9..5f885a8 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -180,6 +180,29 @@ struct dfl_fpga_irq_set {
 					     DFL_PORT_BASE + 6,	\
 					     struct dfl_fpga_irq_set)
 
+/**
+ * DFL_FPGA_PORT_UINT_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 7,
+ *								__u32 num_irqs)
+ *
+ * Get the number of irqs supported by the fpga AFU user interrupt private
+ * feature.
+ * Return: 0 on success, -errno on failure.
+ */
+#define DFL_FPGA_PORT_UINT_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
+					     DFL_PORT_BASE + 7, __u32)
+
+/**
+ * DFL_FPGA_PORT_UINT_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 8,
+ *						struct dfl_fpga_irq_set)
+ *
+ * Set fpga afu user interrupt trigger if evtfds[n] is valid.
+ * Unset related interrupt trigger if evtfds[n] is a negative value.
+ * Return: 0 on success, -errno on failure.
+ */
+#define DFL_FPGA_PORT_UINT_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
+					     DFL_PORT_BASE + 8,	\
+					     struct dfl_fpga_irq_set)
+
 /* IOCTLs for FME file descriptor */
 
 /**
-- 
2.7.4

