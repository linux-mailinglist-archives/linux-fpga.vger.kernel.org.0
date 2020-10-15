Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31A28ED85
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Oct 2020 09:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgJOHVs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Oct 2020 03:21:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:36090 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgJOHVs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Oct 2020 03:21:48 -0400
IronPort-SDR: BR0D2H1FLQ2re7ku14bevYc/Q1hKjk9gsoQRBKWNQTE04wE7gqmEeuwjLtAvMowa+LTDqSZwAR
 9MEtYsrQ6P9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="166344301"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="166344301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 00:21:47 -0700
IronPort-SDR: mFlgq4L1CsqZ4AaPodtYCNmrP4SHlu5kiXokGqxSZKvgQ0ja9YLaNswSCCE6v25YI3GLgssC2U
 DuYH1XrevFzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="531145058"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2020 00:21:44 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v10 1/6] fpga: dfl: fix the definitions of type & feature_id for dfl devices
Date:   Thu, 15 Oct 2020 15:16:28 +0800
Message-Id: <1602746193-10626-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
References: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The value of the field dfl_device.type comes from the 12 bits register
field DFH_ID according to DFL spec. So this patch changes the definition
of the type field to u16.

Also it is not necessary to illustrate the valid bits of the type field
in comments. Instead we should explicitly define the possible values in
the enumeration type for it, because they are shared by hardware spec.
We should not let the compiler decide these values.

Similar changes are also applied to dfl_device.feature_id.

This patch also fixed the MODALIAS format according to the changes
above.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v9: no change
v10: no change
---
 drivers/fpga/dfl.c |  3 +--
 drivers/fpga/dfl.h | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b450870..5a6ba3b 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -298,8 +298,7 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct dfl_device *ddev = to_dfl_dev(dev);
 
-	/* The type has 4 valid bits and feature_id has 12 valid bits */
-	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
+	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",
 			      ddev->type, ddev->feature_id);
 }
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 5dc758f..ac373b1 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -520,19 +520,19 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
  * enum dfl_id_type - define the DFL FIU types
  */
 enum dfl_id_type {
-	FME_ID,
-	PORT_ID,
+	FME_ID = 0,
+	PORT_ID = 1,
 	DFL_ID_MAX,
 };
 
 /**
  * struct dfl_device_id -  dfl device identifier
- * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
- * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
+ * @type: DFL FIU type of the device. See enum dfl_id_type.
+ * @feature_id: feature identifier local to its DFL FIU type.
  * @driver_data: driver specific data.
  */
 struct dfl_device_id {
-	u8 type;
+	u16 type;
 	u16 feature_id;
 	unsigned long driver_data;
 };
@@ -543,7 +543,7 @@ struct dfl_device_id {
  * @dev: generic device interface.
  * @id: id of the dfl device.
  * @type: type of DFL FIU of the device. See enum dfl_id_type.
- * @feature_id: 16 bits feature identifier local to its DFL FIU type.
+ * @feature_id: feature identifier local to its DFL FIU type.
  * @mmio_res: mmio resource of this dfl device.
  * @irqs: list of Linux IRQ numbers of this dfl device.
  * @num_irqs: number of IRQs supported by this dfl device.
@@ -553,7 +553,7 @@ struct dfl_device_id {
 struct dfl_device {
 	struct device dev;
 	int id;
-	u8 type;
+	u16 type;
 	u16 feature_id;
 	struct resource mmio_res;
 	int *irqs;
-- 
2.7.4

