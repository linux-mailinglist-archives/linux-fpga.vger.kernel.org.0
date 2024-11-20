Return-Path: <linux-fpga+bounces-958-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0089D31B8
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23CD5B23FF7
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302D143871;
	Wed, 20 Nov 2024 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQKm5ta5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA013C67E;
	Wed, 20 Nov 2024 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065107; cv=none; b=hmlZKzKIfvbYF8zeLY6lfaLahL5MyPzYqoBRrWALUUikaEytqtiFGw1ub+PiWYHVl+lnCiFO8YzMxPclgruWG360uRZRCUgdh5eXez4xfdzquGmBJJE5vNJu+TI3jIZ8oHVq5ZISLLk5AzfK641VjRpkvwAp6oEAwHBYYTw35rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065107; c=relaxed/simple;
	bh=OqQH/7HhYEF9LsLZP5s5myha4/KZLpxLrerhkDtUd5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1IIi3LXFg0EsRjHpVgkdAopxWZN2SFJOTecLP6tdNPL17NOSxt2OgZVjqrA/wuQuBuk7It/EyyuUdwEazAXIHTQ6PZ9abl1AgsBwU3IpYhpgaUYHXwN989Ue6dsHqU15B0qUiZkXauxgEFTxcUkbyZZtCyRMnox9+Vz3qqwnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQKm5ta5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065106; x=1763601106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OqQH/7HhYEF9LsLZP5s5myha4/KZLpxLrerhkDtUd5M=;
  b=TQKm5ta5dcnrTy8yslRCqSb3/Lj3z7pmN9b1ufWnTzw1kGyFlt/jSGVr
   OIa9pSxhEiAmeo/vzk72SQQtUXzqCEL44GC8iARW1xRuG/U2vEBCluMBv
   GBZHeBvGBicmteZ29CdPZcZPtuWYMove+ArpNqltd9sjChSBwb5Cb8KpC
   46pWY+NQOH1Zj5jrETb74gcj0Ke2Bf/Zq1TPiSi4iI4G7q/89HoYzZlX0
   VdiEUmOd9qeEbX1TIxCJKblSjnAZIevr3rzl9Auc1RnppA0CN/N8TpJCZ
   IK4oV3ckWYsTXjHZpR2m8AY+gC5TBla3Z9LLWXGOq9K8gu144jGRQbrWX
   w==;
X-CSE-ConnectionGUID: 99f1xzcXSICMfvh96VUdvQ==
X-CSE-MsgGUID: ngZiI+3/TbimdBy4kZUNzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42612995"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42612995"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:40 -0800
X-CSE-ConnectionGUID: vHaT6XkaSQ+bJN1+Cz6Paw==
X-CSE-MsgGUID: 6GXc2frBSA23banNXJmSzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813592"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:40 -0800
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
Subject: [PATCH v5 09/18] fpga: dfl: factor out feature device registration
Date: Tue, 19 Nov 2024 20:10:25 -0500
Message-ID: <20241120011035.230574-10-peter.colberg@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120011035.230574-1-peter.colberg@intel.com>
References: <20241120011035.230574-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add separate functions, feature_dev_{register,unregister}(), that wrap
platform_device_add() and platform_device_unregister(), respectively.
These are invoked once per feature device in this commit but will be
reused in a subsequent commit to destroy and recreate the platform
device when the corresponding port is released and reassigned.

The function feature_dev_register() will be extended in subsequent
commits to allocate the platform device, add resources and platform
data, and finally add the platform device to the device hierarchy.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- Move reset of device pointer in feature data to NULL in the function
  feature_dev_unregister() from this patch to the patch "allocate
  platform device after feature device data", which contains the
  corresponding initialization of the device pointer in
  feature_dev_register().

Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index e8488a771337..e681b100524c 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -872,12 +872,34 @@ build_info_create_dev(struct build_feature_devs_info *binfo)
 	if (fdev->id < 0)
 		return fdev->id;
 
-	fdev->dev.parent = &binfo->cdev->region->dev;
-	fdev->dev.devt = dfl_get_devt(dfl_devs[type].devt_type, fdev->id);
+	return 0;
+}
+
+/*
+ * register current feature device, it is called when we need to switch to
+ * another feature parsing or we have parsed all features on given device
+ * feature list.
+ */
+static int feature_dev_register(struct dfl_feature_dev_data *fdata)
+{
+	struct platform_device *fdev = fdata->dev;
+	int ret;
+
+	fdev->dev.parent = &fdata->dfl_cdev->region->dev;
+	fdev->dev.devt = dfl_get_devt(dfl_devs[fdata->type].devt_type, fdev->id);
+
+	ret = platform_device_add(fdev);
+	if (ret)
+		return ret;
 
 	return 0;
 }
 
+static void feature_dev_unregister(struct dfl_feature_dev_data *fdata)
+{
+	platform_device_unregister(fdata->dev);
+}
+
 static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 {
 	struct dfl_feature_dev_data *fdata;
@@ -887,7 +909,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	if (IS_ERR(fdata))
 		return PTR_ERR(fdata);
 
-	ret = platform_device_add(binfo->feature_dev);
+	ret = feature_dev_register(fdata);
 	if (ret)
 		return ret;
 
@@ -1519,7 +1541,7 @@ static int remove_feature_dev(struct device *dev, void *data)
 	struct platform_device *pdev = to_platform_device(dev);
 	int id = pdev->id;
 
-	platform_device_unregister(pdev);
+	feature_dev_unregister(fdata);
 
 	dfl_id_free(fdata->type, id);
 
-- 
2.47.0


