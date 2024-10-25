Return-Path: <linux-fpga+bounces-901-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D689B12CD
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B34B2838A8
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD40216E1B;
	Fri, 25 Oct 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDURgIVD"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739F216DE1;
	Fri, 25 Oct 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895866; cv=none; b=LgD0OgH9UX0hK2F0ZQfitspPhG67b1vUSJN+A8WuuC+4UGFFx7xv1qdgMUiEQRI5MxAptuppFItA2JO3BvaexLhnmmzDhEzbSNvCTZxsC00QreZxlTc3D+tMq4TEYeKoftyAs/86m7Lqe8b8vzV7n/5iyFhWmtwYgVOrUhgTfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895866; c=relaxed/simple;
	bh=IqcFsxiGHZDj2X9ysBIZdeO53g5MyV5tMg30qgptar4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLTb6FZKwpz0Kl/ciwnUElLoZKQ7hKvWiti78Cws//be3+KqdsBtoum4dWbDjlzwJCYke5P8lvh2ny/k+KriQvwwEP88gUapgUUkWzRBHSWRrNAZ6/dtY4EDz0yWABhM4GiTKoGtVNj94zvgiJN1yxuSiqNyDxsbM3nsu61+Ulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDURgIVD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895863; x=1761431863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IqcFsxiGHZDj2X9ysBIZdeO53g5MyV5tMg30qgptar4=;
  b=UDURgIVDDGn0nGpLJaohKxmBhJxo7S5gZg0RAN2rxWqpF2fMJ2VzU7zT
   6Q6g2x4hv9kZ0FhzJapQphH6bkakABlswanyRLtpwafC4opB+FdygqI91
   Im6rJJ6cytwFD/VzmP+evfGXQQHJZGh+9QAyplz5dEyxlIp6KsDD1sW1n
   aeY1MMtoakAnraPQ3amap0wn0/Zp9xmAZ3ZuvFNF9/uC2O2oKKKHAslVm
   fyx+GhgbkTlPHh2zPPx4IyMJLveyJ6+PVugsTdjul4srwexvp2j+XNY4r
   WA135KFPo96PBDZ0RMM/P/RBguIR8wrMInpB0w/gjstkjr2o4S+ia3gMe
   w==;
X-CSE-ConnectionGUID: GA8k+UtgSMyFR1OwBmIQkA==
X-CSE-MsgGUID: YurKg3KhQ5KAx6tC1JY22A==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474659"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474659"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:37 -0700
X-CSE-ConnectionGUID: KrDUgKizQimnO36nR4OgHQ==
X-CSE-MsgGUID: 5WRN3aoCSOi8va8+qc9h2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596167"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v4 10/19] fpga: dfl: factor out feature device data from platform device data
Date: Fri, 25 Oct 2024 18:37:05 -0400
Message-ID: <20241025223714.394533-11-peter.colberg@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025223714.394533-1-peter.colberg@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a structure dfl_feature_dev_data to hold the DFL enumeration
info previously held in dfl_feature_platform_data. Allocate the new
structure using device-managed memory whose lifetime is bound to the
lifetime of the physical DFL, e.g., PCIe FPGA device. In a subsequent
commit, this will allow the feature platform device to be completely
destroyed and recreated on port release and assign, respectively, while
retaining the feature data in the new dfl_feature_dev_data structure.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 16 +++++++---------
 drivers/fpga/dfl.h | 42 ++++++++++++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 13787b216e23..4268a61bb9f7 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -752,13 +752,7 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
 		return ERR_PTR(-EINVAL);
 
-	/*
-	 * we do not need to care for the memory which is associated with
-	 * the platform device. After calling platform_device_unregister(),
-	 * it will be automatically freed by device's release() callback,
-	 * platform_device_release().
-	 */
-	fdata = kzalloc(struct_size(fdata, features, binfo->feature_num), GFP_KERNEL);
+	fdata = devm_kzalloc(binfo->dev, struct_size(fdata, features, binfo->feature_num), GFP_KERNEL);
 	if (!fdata)
 		return ERR_PTR(-ENOMEM);
 
@@ -779,8 +773,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	 */
 	WARN_ON(fdata->disable_count);
 
-	fdev->dev.platform_data = fdata;
-
 	/* each sub feature has one MMIO resource */
 	fdev->num_resources = binfo->feature_num;
 	fdev->resource = kcalloc(binfo->feature_num, sizeof(*fdev->resource),
@@ -882,12 +874,18 @@ build_info_create_dev(struct build_feature_devs_info *binfo)
  */
 static int feature_dev_register(struct dfl_feature_dev_data *fdata)
 {
+	struct dfl_feature_platform_data pdata = {};
 	struct platform_device *fdev = fdata->dev;
 	int ret;
 
 	fdev->dev.parent = &fdata->dfl_cdev->region->dev;
 	fdev->dev.devt = dfl_get_devt(dfl_devs[fdata->type].devt_type, fdev->id);
 
+	pdata.fdata = fdata;
+	ret = platform_device_add_data(fdev, &pdata, sizeof(pdata));
+	if (ret)
+		return ret;
+
 	ret = platform_device_add(fdev);
 	if (ret)
 		return ret;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index bbd74e1744a8..bcbdfcdb9742 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -207,8 +207,7 @@
 #define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts num */
 #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
 
-struct dfl_feature_platform_data;
-#define dfl_feature_dev_data dfl_feature_platform_data
+struct dfl_feature_dev_data;
 
 /**
  * struct dfl_fpga_port_ops - port ops
@@ -304,26 +303,24 @@ struct dfl_feature {
 #define FEATURE_DEV_ID_UNUSED	(-1)
 
 /**
- * struct dfl_feature_platform_data - platform data for feature devices
+ * struct dfl_feature_dev_data - dfl enumeration data for dfl feature dev.
  *
- * @node: node to link feature devs to container device's port_dev_list.
- * @lock: mutex to protect platform data.
- * @cdev: cdev of feature dev.
- * @dev: ptr to platform device linked with this platform data.
+ * @node: node to link the data structure to container device's port_dev_list.
+ * @lock: mutex to protect feature dev data.
+ * @dev: ptr to the feature's platform device linked with this structure.
  * @type: type of DFL FIU for the feature dev. See enum dfl_id_type.
  * @dfl_cdev: ptr to container device.
- * @id: id used for this feature device.
+ * @id: id used for the feature device.
  * @disable_count: count for port disable.
  * @excl_open: set on feature device exclusive open.
  * @open_count: count for feature device open.
  * @num: number for sub features.
  * @private: ptr to feature dev private data.
- * @features: sub features of this feature dev.
+ * @features: sub features for the feature dev.
  */
-struct dfl_feature_platform_data {
+struct dfl_feature_dev_data {
 	struct list_head node;
 	struct mutex lock;
-	struct cdev cdev;
 	struct platform_device *dev;
 	enum dfl_id_type type;
 	struct dfl_fpga_cdev *dfl_cdev;
@@ -336,6 +333,17 @@ struct dfl_feature_platform_data {
 	struct dfl_feature features[];
 };
 
+/**
+ * struct dfl_feature_platform_data - platform data for feature devices
+ *
+ * @cdev: cdev of feature dev.
+ * @fdata: dfl enumeration data for the dfl feature device.
+ */
+struct dfl_feature_platform_data {
+	struct cdev cdev;
+	struct dfl_feature_dev_data *fdata;
+};
+
 static inline
 int dfl_feature_dev_use_begin(struct dfl_feature_dev_data *fdata,
 			      bool excl)
@@ -404,14 +412,14 @@ int dfl_fpga_dev_ops_register(struct platform_device *pdev,
 			      struct module *owner);
 void dfl_fpga_dev_ops_unregister(struct platform_device *pdev);
 
-static inline struct dfl_feature_platform_data *
+static inline struct dfl_feature_dev_data *
 dfl_fpga_inode_to_feature_dev_data(struct inode *inode)
 {
 	struct dfl_feature_platform_data *pdata;
 
 	pdata = container_of(inode->i_cdev, struct dfl_feature_platform_data,
 			     cdev);
-	return pdata;
+	return pdata->fdata;
 }
 
 #define dfl_fpga_dev_for_each_feature(fdata, feature)			    \
@@ -442,7 +450,13 @@ dfl_get_feature_ioaddr_by_id(struct dfl_feature_dev_data *fdata, u16 id)
 	return NULL;
 }
 
-#define to_dfl_feature_dev_data dev_get_platdata
+static inline struct dfl_feature_dev_data *
+to_dfl_feature_dev_data(struct device *dev)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+
+	return pdata->fdata;
+}
 
 static inline
 struct device *dfl_fpga_fdata_to_parent(struct dfl_feature_dev_data *fdata)
-- 
2.47.0


