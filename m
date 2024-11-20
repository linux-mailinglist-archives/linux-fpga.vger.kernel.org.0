Return-Path: <linux-fpga+bounces-953-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265DA9D31AE
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1D8B23F51
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FCE757FC;
	Wed, 20 Nov 2024 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAPv9m9P"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0E4595B;
	Wed, 20 Nov 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065102; cv=none; b=Bjvot0Zd5m8L6UREDV5Bsf/zR0XFAFDWiZEDam1QbC5Pts6eqopGtGxQB+BgmoQSl2sZ10bCiU7tryEtVaPjZ95kH2WifqavfGJXCn6r24EHC/q00F4/WaFNbYONued1sYKNw/5qMWE6/KR40M8qHfSg05n5VoKyIIhe7DXcFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065102; c=relaxed/simple;
	bh=Tbz/23eIFzTJyu6gp5XNuBdaaJKfJM/UihzUDloxrak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5JpirwUDoroiBc3BoRwlMvD0AkGrXXX91AsH25nrSHWm+G/G2TjgJ3nkjxUA4oD+tzJW4BkNw8cSoQzgSvcoXyBoFIvTnrMdCBsNiaJnRDdSv011Pauy8B5nGFBUgc9nVwTzuLYB5OrWPGq6fAhRGZPvfC0YeQVCUMcKvmZETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAPv9m9P; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065100; x=1763601100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tbz/23eIFzTJyu6gp5XNuBdaaJKfJM/UihzUDloxrak=;
  b=mAPv9m9PgOca6LSUiSvnNbqS2f4LzxCVgEjeot41Z4QvZtjEQZbUp800
   jSBvIDiNVjDow/mIh61Cf99zw7RR9xSsexUnJGnwWdRxuqIDNHVZnOCpx
   PrMAzLvo4FvMw2TflNglbKsSoZyZ6fe7FxbN1rStu+nm4xDr+a1B9j0tE
   y/XLaRkOsfOqQbG77y6FTB89gPM4VUGVdjF4x83dgrpY0znZ1dqwRLjQz
   ML7FDg/kQfE7iTPUunpedDZgVJaj86ZMDm6SRvJzFx9zKaR/9iF5EAtWF
   zIvtYi5VANy0r0MSLzI6D4VTTwrNROrbSlA2m/0fzuNEwbbck4KrorHT4
   w==;
X-CSE-ConnectionGUID: SJD8XmNYTJqgfS3aDcA43A==
X-CSE-MsgGUID: Ix0WeFnRQR6Bbgtug6BlxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42612968"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42612968"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:39 -0800
X-CSE-ConnectionGUID: smrALcLhTu2ICjB0ix1pwg==
X-CSE-MsgGUID: b2Tbban9SZe3OHK6WCrAJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813567"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:39 -0800
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
Subject: [PATCH v5 02/18] fpga: dfl: return platform data from dfl_fpga_inode_to_feature_dev_data()
Date: Tue, 19 Nov 2024 20:10:18 -0500
Message-ID: <20241120011035.230574-3-peter.colberg@intel.com>
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

Refactor dfl_fpga_inode_to_feature_dev() to directly return the feature
device platform data instead of the platform device, and retrieve the
device from the data. The null pointer checks are not needed since the
platform device is guaranteed to have associated feature device data.

This patch is part of a refactoring of the internal DFL APIs to move
the feature device data into a new struct dfl_feature_dev_data which
lifetime is independent of the corresponding platform device.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

Changes since v3:
- Revise subject and description to detail the refactoring of
  dfl_fpga_inode_to_feature_dev_data() and mention the reason for the
  refactoring.

Changes since v2:
- New patch extracted from monolithic v1 patch.
---
 drivers/fpga/dfl-afu-main.c | 8 ++------
 drivers/fpga/dfl-fme-main.c | 7 ++-----
 drivers/fpga/dfl.h          | 6 +++---
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 6b97c073849e..6125e2faada8 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -595,14 +595,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
 
 static int afu_open(struct inode *inode, struct file *filp)
 {
-	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_platform_data *pdata = dfl_fpga_inode_to_feature_dev_data(inode);
+	struct platform_device *fdev = pdata->dev;
 	int ret;
 
-	pdata = dev_get_platdata(&fdev->dev);
-	if (WARN_ON(!pdata))
-		return -ENODEV;
-
 	mutex_lock(&pdata->lock);
 	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
 	if (!ret) {
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 864924f68f5e..480a187289bb 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -598,13 +598,10 @@ static long fme_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
 
 static int fme_open(struct inode *inode, struct file *filp)
 {
-	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&fdev->dev);
+	struct dfl_feature_platform_data *pdata = dfl_fpga_inode_to_feature_dev_data(inode);
+	struct platform_device *fdev = pdata->dev;
 	int ret;
 
-	if (WARN_ON(!pdata))
-		return -ENODEV;
-
 	mutex_lock(&pdata->lock);
 	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
 	if (!ret) {
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 5063d73b0d82..2285215f444e 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -398,14 +398,14 @@ int dfl_fpga_dev_ops_register(struct platform_device *pdev,
 			      struct module *owner);
 void dfl_fpga_dev_ops_unregister(struct platform_device *pdev);
 
-static inline
-struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
+static inline struct dfl_feature_platform_data *
+dfl_fpga_inode_to_feature_dev_data(struct inode *inode)
 {
 	struct dfl_feature_platform_data *pdata;
 
 	pdata = container_of(inode->i_cdev, struct dfl_feature_platform_data,
 			     cdev);
-	return pdata->dev;
+	return pdata;
 }
 
 #define dfl_fpga_dev_for_each_feature(pdata, feature)			    \
-- 
2.47.0


