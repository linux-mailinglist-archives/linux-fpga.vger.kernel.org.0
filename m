Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402871A9A05
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Apr 2020 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896229AbgDOKKi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Apr 2020 06:10:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:27978 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896241AbgDOKKa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Apr 2020 06:10:30 -0400
IronPort-SDR: cC3mhXuuth5Dne86lRPSvygUTxTVrDvgh949lsyWBm2lAjUiKj1/CccJ2cwoWlLcN+2uwka5/7
 +FtrPyfVrWOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 03:10:29 -0700
IronPort-SDR: TrIs2Jd8KSvcMe+gGvGCc/0N2b4jX7lU3AfBLxFVT+pc00jNuWSVZadO7rSFl6hVdteg5LQkjr
 sbK7ajoenoBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="253482978"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 03:10:27 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v4 4/7] fpga: dfl: afu: add interrupt support for port error reporting
Date:   Wed, 15 Apr 2020 18:07:32 +0800
Message-Id: <1586945255-30823-5-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
References: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Error reporting interrupt is very useful to notify users that some
errors are detected by the hardware. Once users are notified, they
could query hardware logged error states, no need to continuously
poll on these states.

This patch adds interrupt support for port error reporting sub feature.
It follows the common DFL interrupt notification and handling mechanism,
implements two ioctl commands below for user to query number of irqs
supported, and set/unset interrupt triggers.

 Ioctls:
 * DFL_FPGA_PORT_ERR_GET_IRQ_NUM
   get the number of irqs, which is used to determine whether/how many
   interrupts error reporting feature supports.

 * DFL_FPGA_PORT_ERR_SET_IRQ
   set/unset given eventfds as error interrupt triggers.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
----
v2: use DFL_FPGA_PORT_ERR_GET_IRQ_NUM instead of
    DFL_FPGA_PORT_ERR_GET_INFO
    Delete flag field for DFL_FPGA_PORT_ERR_SET_IRQ param
v3: put_user() instead of copy_to_user()
    improves comments
v4: use common functions to handle irq ioctls
---
 drivers/fpga/dfl-afu-error.c  | 22 ++++++++++++++++++++++
 drivers/fpga/dfl-afu-main.c   |  4 ++++
 include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index c1467ae..facbd7b 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/uaccess.h>
+#include <linux/fpga-dfl.h>
 
 #include "dfl-afu.h"
 
@@ -219,6 +220,26 @@ static void port_err_uinit(struct platform_device *pdev,
 	afu_port_err_mask(&pdev->dev, true);
 }
 
+static long
+port_err_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
+	       unsigned int cmd, unsigned long arg)
+{
+	long ret = -ENODEV;
+
+	switch (cmd) {
+	case DFL_FPGA_PORT_ERR_GET_IRQ_NUM:
+		ret = dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
+		break;
+	case DFL_FPGA_PORT_ERR_SET_IRQ:
+		ret = dfl_feature_ioctl_set_irq(pdev, feature, arg);
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
@@ -227,4 +248,5 @@ const struct dfl_feature_id port_err_id_table[] = {
 const struct dfl_feature_ops port_err_ops = {
 	.init = port_err_init,
 	.uinit = port_err_uinit,
+	.ioctl = port_err_ioctl,
 };
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index b0c3178..357cd5d 100644
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
index 8a5979e..fbe1e99 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -164,6 +164,29 @@ struct dfl_fpga_irq_set {
 	__s32 evtfds[];
 };
 
+/**
+ * DFL_FPGA_PORT_ERR_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 5,
+ *								__u32 num_irqs)
+ *
+ * Get the number of irqs supported by the fpga port error reporting private
+ * feature. Currently hardware supports up to 1 irq.
+ * Return: 0 on success, -errno on failure.
+ */
+#define DFL_FPGA_PORT_ERR_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
+					     DFL_PORT_BASE + 5, __u32)
+
+/**
+ * DFL_FPGA_PORT_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 6,
+ *						struct dfl_fpga_irq_set)
+ *
+ * Set fpga port error reporting interrupt trigger if evtfds[n] is valid.
+ * Unset related interrupt trigger if evtfds[n] is a negative value.
+ * Return: 0 on success, -errno on failure.
+ */
+#define DFL_FPGA_PORT_ERR_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
+					     DFL_PORT_BASE + 6,	\
+					     struct dfl_fpga_irq_set)
+
 /* IOCTLs for FME file descriptor */
 
 /**
-- 
2.7.4

