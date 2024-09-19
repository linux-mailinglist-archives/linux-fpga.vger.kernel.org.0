Return-Path: <linux-fpga+bounces-715-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D625597CE7E
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127C51C21588
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B85814F12C;
	Thu, 19 Sep 2024 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6X1Soiy"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F314B941;
	Thu, 19 Sep 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778108; cv=none; b=n80tA5BT+uduEt3TvVJb+mKjm6g6+g7R4WqzQ+5ASWBS3yZRcrwYG261Wg2GDc13Usjg+U9/c+zZdlPI3hVuGonRIKFo1M7NF6JIN+h9L/Ol8TAciQehEUHpw6+u38UPtxi+M4k3nksl3mDPh65YfpIgQL5GDy2Kg3MymXftV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778108; c=relaxed/simple;
	bh=7pDw73oAwTdRwnHeH+BpT6SaKdBgGtwnhyxAW3Q0XE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNIhSDScTL13DGP8QQGjxhoq42meq9y06PNJO3VYSylLI10KyjzHGOcoxR9nCBn0FmCiO7veDgRHheFNSRW/UVn/vgfyOQHl+lIxiX/pEJ47KdI69zidCOAZT6t5xXVokft9ZVeUfvtIuPYQvR5laDMTCHxz2vE0+nLCdiDW6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6X1Soiy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726778107; x=1758314107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7pDw73oAwTdRwnHeH+BpT6SaKdBgGtwnhyxAW3Q0XE4=;
  b=K6X1SoiyrFXYF87SVkqLW7MRsVYbKIQbwPKemqoCEGyVX+WjEiHowmEq
   bcJG1LmZxZR+McvJT1Magw5KjTHI0evpZrILSX83OvWfKlCJDfHUUgawQ
   OLzum8m8mPcD0OVJNmCKFiFZS1TfVFf1xxydKHmio1/6WtrPJZfwtBP43
   lHlrn8ZPxRrp/h5i25yvZfgUhBzvX0Zz0n6ml1HkeK2sDoGEgA3uD41/n
   Ce90oNiAZLgC9ova1Gv6c+jpka3u7J4k1Fz2bF6xfnagkUWko+zZD9O/f
   iOpnYYlbFfXQox3pXHrr6NVk3KUNllpNl1XFdSab6IgzpLAUOg4FoA1E9
   g==;
X-CSE-ConnectionGUID: /6TF+AwgT4KwAX9z1iOkzg==
X-CSE-MsgGUID: Qhw+Yq3wTwG2ia3VDWT8SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25912943"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25912943"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:06 -0700
X-CSE-ConnectionGUID: 0qK5STviSti0cJgLquQOyA==
X-CSE-MsgGUID: hfQm4io+Q6Wilitgn9hfKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="93338321"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:05 -0700
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
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v3 2/9] fpga: dfl: omit unneeded null pointer check from {afu,fme}_open()
Date: Thu, 19 Sep 2024 16:34:23 -0400
Message-ID: <20240919203430.1278067-3-peter.colberg@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240919203430.1278067-1-peter.colberg@intel.com>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The feature platform device is guaranteed to have an associated platform
data. Refactor dfl_fpga_inode_to_feature_dev_data() to directly return
the platform data and retrieve the device from the data.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
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
2.46.1


