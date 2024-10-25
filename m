Return-Path: <linux-fpga+bounces-906-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1239B12D7
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F81C21FBC
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771E218933;
	Fri, 25 Oct 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bl13ygAG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65105217650;
	Fri, 25 Oct 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895871; cv=none; b=vEiuy911Qaq4Ud8O6Y34fdfebTtJ3V75jAmIdE1atQlHVT5/1nqa57ub6mISIqyAuPdRs3q7C4w7grlap5TxCKDjxyL3axWP03UJSwBgnQusyvQUIOhHA7mJ25Exal9EMaH3MfZaiV4A6jHDiiMXe55sii4l4/FSDXjLZb5W3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895871; c=relaxed/simple;
	bh=yHSCtip8WZC5ZV34sgV6cAToQV0mnoB6/Ck9qqxq/cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDxvnn0j6f0oW5wmNt0BXZ1OT7xUflIIuQ9S+tu7spqMxhc/qutNnRY1QzoWhmDb7XjtJ9cS0fwYhDCRlXsYijXHwZ7xd3PDLKm3958P4SeyxR+Zg+qxACX4h7AzLSx/RQECOJfrfC3blqwB1KpcAvfibatU58jNeSQv1s8E/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bl13ygAG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895869; x=1761431869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHSCtip8WZC5ZV34sgV6cAToQV0mnoB6/Ck9qqxq/cs=;
  b=bl13ygAGPRDWQjtu6AWd3skYaTNMKbESryiy55GaRql5JBuHEfh+LhuC
   22dRQHbbYue9ExgKT3/8RhkTXm4uKug9+OwinX/kiaTIrLP3YUyI7bGl/
   8ZvxjO7FjpfQM7N6tsHpgCxcY2UwFXKj0Vg5IcfIlj/uNuBNgggJ8Twy/
   /SqlGTiqy+sXcilwZCqRqZ03boUubaWStPWOh4680kqNTMGd+5quJrpot
   MAZ2j8tKN8HKpi3tlT8xNYlCn5PdjuoA45xGZKfRudUXT514xfTI2BG33
   wyGKKycDyZpF3fLJr6R3I8MLEBMtZA5wq3q4JPbvCXQ3DRR9Osy+39kvY
   A==;
X-CSE-ConnectionGUID: fxpKYo4dS3u3Xnrk1u7+qQ==
X-CSE-MsgGUID: nQKRxCwISUqahWMjMDNRpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474673"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474673"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
X-CSE-ConnectionGUID: ToPLgMKqRw2IEosxYr6Osw==
X-CSE-MsgGUID: i5k5oMggSli9aFfwHTIOPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596179"
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
Subject: [PATCH v4 14/19] fpga: dfl: store platform device id in feature device data
Date: Fri, 25 Oct 2024 18:37:09 -0400
Message-ID: <20241025223714.394533-15-peter.colberg@intel.com>
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

Delay the feature device id allocation from build_info_create_dev() to
binfo_create_feature_dev_data() and store the id in the feature device
data before copying it to the device. This will allow reusing the same
id in a subsequent commit which completely destroys and recreates the
feature device when releasing and reassigning the corresponding port.

Instead of manually freeing the id when no longer needed, use a
device-managed resource with a custom action to automatically free
the id right before the feature device data is freed. The id registry
is guaranteed to be allocated when dfl_id_free_action() is invoked,
since the DFL PCIe device and its device-managed resources will be
destroyed before dfl_ids_destroy() is called in dfl_fpga_exit().

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 43 ++++++++++++++++++++++---------------------
 drivers/fpga/dfl.h |  2 ++
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 560d35857405..758673b0290a 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -740,6 +740,13 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
 	mutex_unlock(&cdev->lock);
 }
 
+static void dfl_id_free_action(void *arg)
+{
+	struct dfl_feature_dev_data *fdata = arg;
+
+	dfl_id_free(fdata->type, fdata->pdev_id);
+}
+
 static struct dfl_feature_dev_data *
 binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 {
@@ -747,7 +754,7 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	enum dfl_id_type type = binfo->type;
 	struct dfl_feature_info *finfo, *p;
 	struct dfl_feature_dev_data *fdata;
-	int index = 0, res_idx = 0;
+	int ret, index = 0, res_idx = 0;
 
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
 		return ERR_PTR(-EINVAL);
@@ -768,6 +775,17 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 
 	fdata->dev = fdev;
 	fdata->type = type;
+
+	fdata->pdev_id = dfl_id_alloc(type, binfo->dev);
+	if (fdata->pdev_id < 0)
+		return ERR_PTR(fdata->pdev_id);
+
+	ret = devm_add_action_or_reset(binfo->dev, dfl_id_free_action, fdata);
+	if (ret)
+		return ERR_PTR(ret);
+
+	fdev->id = fdata->pdev_id;
+
 	fdata->pdev_name = dfl_devs[type].name;
 	fdata->num = binfo->feature_num;
 	fdata->dfl_cdev = binfo->cdev;
@@ -866,10 +884,6 @@ build_info_create_dev(struct build_feature_devs_info *binfo)
 
 	INIT_LIST_HEAD(&binfo->sub_features);
 
-	fdev->id = dfl_id_alloc(type, &fdev->dev);
-	if (fdev->id < 0)
-		return fdev->id;
-
 	return 0;
 }
 
@@ -947,17 +961,9 @@ static void build_info_free(struct build_feature_devs_info *binfo)
 {
 	struct dfl_feature_info *finfo, *p;
 
-	/*
-	 * it is a valid id, free it. See comments in
-	 * build_info_create_dev()
-	 */
-	if (binfo->feature_dev && binfo->feature_dev->id >= 0) {
-		dfl_id_free(binfo->type, binfo->feature_dev->id);
-
-		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
-			list_del(&finfo->node);
-			kfree(finfo);
-		}
+	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
+		list_del(&finfo->node);
+		kfree(finfo);
 	}
 
 	platform_device_put(binfo->feature_dev);
@@ -1548,13 +1554,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
 static int remove_feature_dev(struct device *dev, void *data)
 {
 	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
-	struct platform_device *pdev = to_platform_device(dev);
-	int id = pdev->id;
 
 	feature_dev_unregister(fdata);
 
-	dfl_id_free(fdata->type, id);
-
 	return 0;
 }
 
@@ -1658,7 +1660,6 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 
 		/* remove released ports */
 		if (!device_is_registered(&port_dev->dev)) {
-			dfl_id_free(fdata->type, port_dev->id);
 			platform_device_put(port_dev);
 		}
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index cbff5d543c44..2e38c42b3920 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -309,6 +309,7 @@ struct dfl_feature {
  * @lock: mutex to protect feature dev data.
  * @dev: ptr to the feature's platform device linked with this structure.
  * @type: type of DFL FIU for the feature dev. See enum dfl_id_type.
+ * @pdev_id: platform device id for the feature dev.
  * @pdev_name: platform device name for the feature dev.
  * @dfl_cdev: ptr to container device.
  * @id: id used for the feature device.
@@ -326,6 +327,7 @@ struct dfl_feature_dev_data {
 	struct mutex lock;
 	struct platform_device *dev;
 	enum dfl_id_type type;
+	int pdev_id;
 	const char *pdev_name;
 	struct dfl_fpga_cdev *dfl_cdev;
 	int id;
-- 
2.47.0


