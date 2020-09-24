Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4E277770
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgIXRH1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 13:07:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:17525 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXRH0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Sep 2020 13:07:26 -0400
IronPort-SDR: Hcq8XZOOf5CmmF+fSvVrJGazFRZTup2OS8WNSRowWBwlgCGKE7ZdzrnN/aQ7tsfnAKUgzKBSxq
 Jxnuv0ZQmu4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="222866221"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="222866221"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 10:04:53 -0700
IronPort-SDR: KDanZRwTytFzeqS85DpnF2fKLfi3DsNqKf+HtjGevk65PZnypGXgmJVqD7oujDKuZMPfeeeIel
 RWCoja5s/wzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="511697105"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2020 10:04:51 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v3 2/5] fpga: dfl: fix the definitions of type & feature_id for dfl devices
Date:   Fri, 25 Sep 2020 00:59:58 +0800
Message-Id: <1600966801-30586-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
References: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The value of the field fpga_dfl_device.type comes from the 12 bits
register field DFH_ID according to DFL spec. So this patch changes the
definition of the type field to u16.

Also it is not necessary to illustrate the valid bits of the type field
in comments. Instead we should explicitly define the possible values in
the enumeration type for it, because they are shared by hardware spec.
We should not let the compiler decide these values.

Similar changes are also applied to fpga_dfl_device.feature_id.

This patch also fixed the MODALIAS format according to the changes
above.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl.c |  3 +--
 drivers/fpga/dfl.h | 16 +++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index f146cda..a906fa7 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -299,8 +299,7 @@ static int fpga_dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct fpga_dfl_device *fddev = to_fpga_dfl_dev(dev);
 
-	/* The type has 4 valid bits and feature_id has 12 valid bits */
-	return add_uevent_var(env, "MODALIAS=fpga-dfl:t%01Xf%03X",
+	return add_uevent_var(env, "MODALIAS=fpga-dfl:t%04Xf%04X",
 			      fddev->type, fddev->feature_id);
 }
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index ba930a7..78f7c6f 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -520,21 +520,19 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
  * enum fpga_dfl_id_type - define the FPGA DFL FIU types
  */
 enum fpga_dfl_id_type {
-	FPGA_DFL_FME_ID,
-	FPGA_DFL_PORT_ID,
+	FPGA_DFL_FME_ID = 0,
+	FPGA_DFL_PORT_ID = 1,
 	FPGA_DFL_ID_MAX,
 };
 
 /**
  * struct fpga_dfl_device_id - fpga dfl device identifier
- * @type: contains 4 bits FPGA DFL FIU type of the device, see
- *	  enum fpga_dfl_id_type.
- * @feature_id: contains 12 bits feature identifier local to its FPGA DFL FIU
- *		type.
+ * @type: FPGA DFL FIU type of the device, see enum fpga_dfl_id_type.
+ * @feature_id: feature identifier local to its FPGA DFL FIU type.
  * @driver_data: driver specific data.
  */
 struct fpga_dfl_device_id {
-	u8 type;
+	u16 type;
 	u16 feature_id;
 	unsigned long driver_data;
 };
@@ -545,7 +543,7 @@ struct fpga_dfl_device_id {
  * @dev: generic device interface.
  * @id: id of the fpga dfl device.
  * @type: FPGA DFL FIU type of the device, see enum fpga_dfl_id_type.
- * @feature_id: 16 bits feature identifier local to its FPGA DFL FIU type.
+ * @feature_id: feature identifier local to its FPGA DFL FIU type.
  * @mmio_res: mmio resource of this fpga dfl device.
  * @irqs: list of Linux IRQ numbers of this fpga dfl device.
  * @num_irqs: number of IRQs supported by this fpga dfl device.
@@ -555,7 +553,7 @@ struct fpga_dfl_device_id {
 struct fpga_dfl_device {
 	struct device dev;
 	int id;
-	u8 type;
+	u16 type;
 	u16 feature_id;
 	struct resource mmio_res;
 	int *irqs;
-- 
2.7.4

