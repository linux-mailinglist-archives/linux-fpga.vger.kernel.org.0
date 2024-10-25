Return-Path: <linux-fpga+bounces-904-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7959B12D3
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860CF1F2322E
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9121764F;
	Fri, 25 Oct 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeUKF+tZ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443EE216E1A;
	Fri, 25 Oct 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895869; cv=none; b=E4PjqYoWzXi3VkFtM1bi+yy1L1NCNYz1wQm3uwi6O5OsJvWeismX7b7iHxY1k1QcQBFB7Q/7aBjtLf74B/3BgTvh30bMAu60FGWQnWICPqdse6zMtMAnUjSVvZiLGOgw8Dmpn0NaCAbbwZHS/9H63shVFZHcPhhDrHDxbpG/+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895869; c=relaxed/simple;
	bh=SJxrk0bV7nYjymWWLWOqWQzSFmvtQpa4Xj56BdR8DDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qThkjjXqpBguEwH60HqBm19HQJptMrpLtOoJlECAdHT3oS36FIAQ2A8bZ3vVm+IIsh/iQfMzyhwuAG2trYCRZGxLsGBCv1uI4VbMMOLqxpt6f1f0BAq8UTzrLKjzW+ubgawR80zO/rumIa8EG7otnVaWGHXF6/yp5wTaIfZqlok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeUKF+tZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895866; x=1761431866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJxrk0bV7nYjymWWLWOqWQzSFmvtQpa4Xj56BdR8DDw=;
  b=jeUKF+tZWrtMIPxXWq+UinbegEBsUcmM9PXvtnRp2ufhqj+YUyuJN7/H
   JC1hs0MjHPBsHWANyTfTKdEkv804OnJ/93W+3jyJ0hUEkm7YetgH2dZMv
   LV6wrpPbH98RkddHy+U+F1CZTcyhFYUP7i4aJXXlPY8PiflIKA8isnABH
   /fPvhADYq9LORsFO8h+su42wjPgrVVe6g+xWhl+wHTsYTuXzr4Yei5nWL
   iet5MYHR2YBgTohTvJ6f4rUPlgUgi19Gds/kF+iMzxpcg7rLAgVWSjxn5
   lW7QkK+jRK/WmQwBiORn7DD2kvy5wrHhuZInnakK39aui2HSu6e73IGzL
   A==;
X-CSE-ConnectionGUID: P3S54IFLQTyPfiI23HJ4iQ==
X-CSE-MsgGUID: c9PksvHQQ4m37SMulNkYJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474656"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474656"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:37 -0700
X-CSE-ConnectionGUID: fx+UHoORTsOgRkCoiEr6Qg==
X-CSE-MsgGUID: 30ZDK7VcTV+8ikfK73fcog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596163"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:37 -0700
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
Subject: [PATCH v4 09/19] fpga: dfl: factor out feature device registration
Date: Fri, 25 Oct 2024 18:37:04 -0400
Message-ID: <20241025223714.394533-10-peter.colberg@intel.com>
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

Add separate functions, feature_dev_{register,unregister}(), that wrap
platform_device_add() and platform_device_unregister(), respectively.
These are invoked once per feature device in this commit but will be
reused in a subsequent commit to destroy and recreate the platform
device when the corresponding port is released and reassigned.

The function feature_dev_register() will be extended in subsequent
commits to allocate the platform device, add resources and platform
data, and finally add the platform device to the device hierarchy.

The function feature_dev_unregister() is in its final form. After
unregistering the device, the device pointer in the feature data is
reset to NULL to signal that the platform device has been destroyed.
This will substitute device_is_registered() in a subsequent commit.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index e8488a771337..13787b216e23 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -872,12 +872,35 @@ build_info_create_dev(struct build_feature_devs_info *binfo)
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
+	fdata->dev = NULL;
+}
+
 static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 {
 	struct dfl_feature_dev_data *fdata;
@@ -887,7 +910,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	if (IS_ERR(fdata))
 		return PTR_ERR(fdata);
 
-	ret = platform_device_add(binfo->feature_dev);
+	ret = feature_dev_register(fdata);
 	if (ret)
 		return ret;
 
@@ -1519,7 +1542,7 @@ static int remove_feature_dev(struct device *dev, void *data)
 	struct platform_device *pdev = to_platform_device(dev);
 	int id = pdev->id;
 
-	platform_device_unregister(pdev);
+	feature_dev_unregister(fdata);
 
 	dfl_id_free(fdata->type, id);
 
-- 
2.47.0


