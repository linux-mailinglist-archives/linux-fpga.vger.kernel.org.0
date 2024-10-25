Return-Path: <linux-fpga+bounces-910-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B159B12DF
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229F11C220D1
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D321B87D;
	Fri, 25 Oct 2024 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+9C30Yj"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705121A4AA;
	Fri, 25 Oct 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895875; cv=none; b=sPCZ/U6GV2rBvG5zGA5kbBAw9b5Fas+jYUMhPEvlXdB6GxOHozc8lje6e7EOWnBi6jdM44DvXJdRkd6PckDwsOrdA++owzuG2JpG7jtnWcujEqmj37XIwJTQbPz+lygppvMOdlCde+9Qw5TV0S3KB8BrNsoAhwRPz1Q1e1UWzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895875; c=relaxed/simple;
	bh=VimVeM4KDSyxdLFDthXrXB3zhIn6pWiF+ub88+5FCZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACwMAT5CkE9xwjJUmr++xruV9FeQmDktxL2yjPhR74VN1MVRV7G874APywURrsWaEIh12753SgPi2LBZxHncR5iNZy1XFWIita6Q6N+M3cyPKjXAo4yr/1k4FJ5J4zQaee9C9Go8JMfkRru51al6zxnIjrf7gYHXUetEYmb2lwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+9C30Yj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895873; x=1761431873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VimVeM4KDSyxdLFDthXrXB3zhIn6pWiF+ub88+5FCZQ=;
  b=N+9C30YjZGlnBQsoLTu61ckN5hn+LTRRiSNjkU6ETzrfu2JoQH0ybQtq
   zgd8HlGHusG222B8dzSExQyGZZee4G+SQmFi36IkDaYgH0YzqqmVa3JIj
   SupV8BTEHImW0nzxS5Ho6O8qYxRvSkguYgjE6t7DhcW3wg4pwsfNRq6W5
   aD81urZv57N+8wAXmXMSGttkBuIVpAm7M2bKs4QnR8O96XSKRn0DoRZK2
   j/Jaf0wEvuhWo/KFTp43VdZWMJthtYCPFqmopw6oabIXrHDSv/M6Poic7
   v1X+ZCkJMzlGAYYdQdQIrrALbNrJWcTZbc3rZSGuu2fBX/L5UykHBN5r4
   A==;
X-CSE-ConnectionGUID: 40mvbc7XSkyGEr2tUZpMZA==
X-CSE-MsgGUID: JNW4Z3hRSui+ZSRua1iyLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474682"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474682"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
X-CSE-ConnectionGUID: plKLCS7TQTalG3Zv5TiCxg==
X-CSE-MsgGUID: loZk0Q6sTJ6C8QdAa0irvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596186"
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
Subject: [PATCH v4 16/19] fpga: dfl: allocate platform device after feature device data
Date: Fri, 25 Oct 2024 18:37:11 -0400
Message-ID: <20241025223714.394533-17-peter.colberg@intel.com>
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

Delay calling platform_device_alloc() from build_info_create_dev() to
feature_dev_register(), now that the feature device data contains all
necessary data to create the feature device. This completes the new
function feature_dev_register(), which will be reused in a subsequent
commit to fully recreate the feature device when assigning a port.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 59 +++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index a9ec37278b2d..d9cef150ed0d 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -681,7 +681,6 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
  * @nr_irqs: number of irqs for all feature devices.
  * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
  *	       this device.
- * @feature_dev: current feature device.
  * @type: the current FIU type.
  * @ioaddr: header register region address of current FIU in enumeration.
  * @start: register resource start of current FIU.
@@ -695,7 +694,6 @@ struct build_feature_devs_info {
 	unsigned int nr_irqs;
 	int *irq_table;
 
-	struct platform_device *feature_dev;
 	enum dfl_id_type type;
 	void __iomem *ioaddr;
 	resource_size_t start;
@@ -750,7 +748,6 @@ static void dfl_id_free_action(void *arg)
 static struct dfl_feature_dev_data *
 binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 {
-	struct platform_device *fdev = binfo->feature_dev;
 	enum dfl_id_type type = binfo->type;
 	struct dfl_feature_info *finfo, *p;
 	struct dfl_feature_dev_data *fdata;
@@ -773,7 +770,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	if (!fdata->resources)
 		return ERR_PTR(-ENOMEM);
 
-	fdata->dev = fdev;
 	fdata->type = type;
 
 	fdata->pdev_id = dfl_id_alloc(type, binfo->dev);
@@ -784,8 +780,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	if (ret)
 		return ERR_PTR(ret);
 
-	fdev->id = fdata->pdev_id;
-
 	fdata->pdev_name = dfl_devs[type].name;
 	fdata->num = binfo->feature_num;
 	fdata->dfl_cdev = binfo->cdev;
@@ -809,7 +803,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 		unsigned int i;
 
 		/* save resource information for each feature */
-		feature->dev = fdev;
 		feature->id = finfo->fid;
 		feature->revision = finfo->revision;
 		feature->dfh_version = finfo->dfh_version;
@@ -868,18 +861,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 static int
 build_info_create_dev(struct build_feature_devs_info *binfo)
 {
-	enum dfl_id_type type = binfo->type;
-	struct platform_device *fdev;
-
-	/*
-	 * we use -ENODEV as the initialization indicator which indicates
-	 * whether the id need to be reclaimed
-	 */
-	fdev = platform_device_alloc(dfl_devs[type].name, -ENODEV);
-	if (!fdev)
-		return -ENOMEM;
-
-	binfo->feature_dev = fdev;
 	binfo->feature_num = 0;
 
 	INIT_LIST_HEAD(&binfo->sub_features);
@@ -895,27 +876,43 @@ build_info_create_dev(struct build_feature_devs_info *binfo)
 static int feature_dev_register(struct dfl_feature_dev_data *fdata)
 {
 	struct dfl_feature_platform_data pdata = {};
-	struct platform_device *fdev = fdata->dev;
+	struct platform_device *fdev;
+	struct dfl_feature *feature;
 	int ret;
 
+	fdev = platform_device_alloc(fdata->pdev_name, fdata->pdev_id);
+	if (!fdev)
+		return -ENOMEM;
+
+	fdata->dev = fdev;
+
 	fdev->dev.parent = &fdata->dfl_cdev->region->dev;
 	fdev->dev.devt = dfl_get_devt(dfl_devs[fdata->type].devt_type, fdev->id);
 
+	dfl_fpga_dev_for_each_feature(fdata, feature)
+		feature->dev = fdev;
+
 	ret = platform_device_add_resources(fdev, fdata->resources,
 					    fdata->resource_num);
 	if (ret)
-		return ret;
+		goto err_put_dev;
 
 	pdata.fdata = fdata;
 	ret = platform_device_add_data(fdev, &pdata, sizeof(pdata));
 	if (ret)
-		return ret;
+		goto err_put_dev;
 
 	ret = platform_device_add(fdev);
 	if (ret)
-		return ret;
+		goto err_put_dev;
 
 	return 0;
+
+err_put_dev:
+	platform_device_put(fdev);
+	fdata->dev = NULL;
+
+	return ret;
 }
 
 static void feature_dev_unregister(struct dfl_feature_dev_data *fdata)
@@ -940,16 +937,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	if (binfo->type == PORT_ID)
 		dfl_fpga_cdev_add_port_data(binfo->cdev, fdata);
 	else
-		binfo->cdev->fme_dev = get_device(&binfo->feature_dev->dev);
-
-	/*
-	 * reset it to avoid build_info_free() freeing their resource.
-	 *
-	 * The resource of successfully registered feature devices
-	 * will be freed by platform_device_unregister(). See the
-	 * comments in build_info_create_dev().
-	 */
-	binfo->feature_dev = NULL;
+		binfo->cdev->fme_dev = get_device(&fdata->dev->dev);
 
 	/* reset the binfo for next FIU */
 	binfo->type = DFL_ID_MAX;
@@ -966,8 +954,6 @@ static void build_info_free(struct build_feature_devs_info *binfo)
 		kfree(finfo);
 	}
 
-	platform_device_put(binfo->feature_dev);
-
 	devm_kfree(binfo->dev, binfo);
 }
 
@@ -1262,8 +1248,7 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
 	case PORT_ID:
 		return parse_feature_port_afu(binfo, ofst);
 	default:
-		dev_info(binfo->dev, "AFU belonging to FIU %s is not supported yet.\n",
-			 binfo->feature_dev->name);
+		dev_info(binfo->dev, "AFU belonging to FIU is not supported yet.\n");
 	}
 
 	return 0;
-- 
2.47.0


