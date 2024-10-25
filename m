Return-Path: <linux-fpga+bounces-895-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B0F9B12C1
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F23FB210AB
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E684121440D;
	Fri, 25 Oct 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9lKcBiG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7420C32A;
	Fri, 25 Oct 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895859; cv=none; b=Jq1ttOy9U0F5aEXUg2kCROo4q02cVwNsKAUZF8lnRLwu+Jz8sMvIBBZP/7jkkINccSY0E/guNinFWc78AZEwD7Y7fMKDAcOnxBfMWz/wPbt3gquTnzSnaX9BFI8yzLZRAgzS7A433zuoKpI0Lgj2qVvuMf7zG3YBKkNRaaZEf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895859; c=relaxed/simple;
	bh=t/eDquHdQtPksxf+cN85hxasPj4P3jziW0jkWuve/9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmJ/wWglS8Axm1SnX4ksCXSK5NvEsx8QVfAWs53mEM5fbnLIgh4Mz+67+dRISFGtKMHvfB09O1oBCOF9cFYSHrYz/rCVS2NNcgZylOL7+tcrY9BpquULm6QtO0Vo1sY3OA7U5YU1zor2Xt6kPRVzvC9P7Awy3VVRezjJz/OW8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9lKcBiG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895857; x=1761431857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t/eDquHdQtPksxf+cN85hxasPj4P3jziW0jkWuve/9w=;
  b=Q9lKcBiGNrvgYobff63tdNSyA0MgScpgPQpPmZywNM79SQkfJdUZFHyS
   y4WX54OZrFcLe5ciwP+y7Qivph1O1CfWl31Yn8A2bTZqdwJ4AfGeTgULr
   o5CgF+7M8QmoT3AiqFFssQA/QA4pEUijqRlLBhwPej0zpWzXt3LqxM9Yf
   NIriL3WxSvw1pUwhQdu7c6OFKdXFrueYlaVT4oh9PBO9fpBIHKqzFWKDn
   YnQ+ceuA8BjN8lFTTUVlR5C7p+HZG/7+OjrWjEhIgqUKEvyPJH09Gj9ou
   rqTTyJSfOJILQ1cHxd9kwJCdhucN3bEKHLmtsRHm9utUAbPrwpfyofctf
   A==;
X-CSE-ConnectionGUID: Fgo6GRAgSE2bmgn9ofbYdw==
X-CSE-MsgGUID: ut0miWxbRYiXMApoPXyEeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474624"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474624"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:36 -0700
X-CSE-ConnectionGUID: QmXDFlBlR0KlWFnZuYxElw==
X-CSE-MsgGUID: BYSEru3KQsGJnhqKoulsJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596135"
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
Subject: [PATCH v4 02/19] fpga: dfl: return platform data from dfl_fpga_inode_to_feature_dev_data()
Date: Fri, 25 Oct 2024 18:36:57 -0400
Message-ID: <20241025223714.394533-3-peter.colberg@intel.com>
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
---
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


