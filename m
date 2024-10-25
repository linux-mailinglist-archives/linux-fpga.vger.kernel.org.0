Return-Path: <linux-fpga+bounces-912-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E69B12E2
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B55C1F2346C
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225421C2DE;
	Fri, 25 Oct 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TObsh4wo"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E021B849;
	Fri, 25 Oct 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895876; cv=none; b=A4QhptbTSkq+TkC44/mZ3dFdvJyUYMiICfYavF7d8qzgvkfN5MzyOZMxiw9nWvVqlbi/Z4nzZ/9A/7dVFqM9YXyqUCbjYmXgUUOieegCGLRdNRW1j/1CjcXQ2d21/2rwsoLl7L+Wo6xnZJbZ/OAgVD7eFv3OeAvi2F+71PRQSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895876; c=relaxed/simple;
	bh=EIYWyyI+XXeIM/gIhaOL+ClCqG20au2otLNv6hsZw8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX34NWMs9g9wWkZvXZvR/nH4YgqP3dxGCT5uzBSL8DwJ7S0mJ2R6/ENW2Tb6zUJ36NEbcty1zwz3jbTxH96p+CJ9EUn4vIf7vQrI8lpfsHw6KucSpM/TkV5PIqDvV6I4vioChQYQ0tH0A0hBlbm+Lfk0LU3+zSF7TkxFQqLmz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TObsh4wo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895874; x=1761431874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIYWyyI+XXeIM/gIhaOL+ClCqG20au2otLNv6hsZw8g=;
  b=TObsh4wobpvhcTnpW05bA05uvVIWfp751wllyjWgMDR/B6cVHTqOkiY7
   hslFhPac2XEqMzmIj/dEGabgWrQU0vN438adxgyvn7tutdj77wN32R+1T
   44oDHZvHaAgcqtFtdALk5g4AktAqrdwrPDn7cxWXap188EgKGolKXctSw
   Dhq1lbfSty6QzYiG2eKzFLW9vL1Qg40aee3yTSGtOiIja6x0E0+Crx2AE
   /JwFg1A13Y9KDqEdetEBGqJaY3/ftuDqLtLpveDXt5ud75wJIiysTf4/h
   1IcvqwgdHULKH1c12E/F0gprehs4AViMNI7YWXBQzWJ+5XmgyW6bnBJ+r
   g==;
X-CSE-ConnectionGUID: +DpuNTYTSfS6Py+Xhb1crQ==
X-CSE-MsgGUID: hdsscam9QPyRiCT0yYizCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474694"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474694"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
X-CSE-ConnectionGUID: S2veJ65dToyCC3AZHuvheA==
X-CSE-MsgGUID: JHB/2s3qSsavZH+8MsliHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596195"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:39 -0700
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
	Russ Weight <russell.h.weight@intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v4 19/19] fpga: dfl: destroy/recreate feature platform device on port release/assign
Date: Fri, 25 Oct 2024 18:37:14 -0400
Message-ID: <20241025223714.394533-20-peter.colberg@intel.com>
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

From: Xu Yilun <yilun.xu@intel.com>

Now that the internal DFL APIs have been converted to consume DFL
enumeration info from a separate structure, dfl_feature_dev_data, which
lifetime is independent of the feature device, proceed to completely
destroy and recreate the feature platform device on port release and
assign, respectively. This resolves a longstanding issue in the use of
platform_device_add(), which states to "not call this routine more than
once for any device structure" and which used to print a kernel warning.

The function feature_dev_unregister() resets the device pointer in the
feature data to NULL to signal that the feature platform device has been
destroyed. This substitutes the previous device_is_registered() checks.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index ed38e5ec84b6..3b3b05ca3ddb 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1620,22 +1620,10 @@ EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_enumerate);
  */
 void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 {
-	struct dfl_feature_dev_data *fdata, *ptmp;
-
 	mutex_lock(&cdev->lock);
 	if (cdev->fme_dev)
 		put_device(cdev->fme_dev);
 
-	list_for_each_entry_safe(fdata, ptmp, &cdev->port_dev_list, node) {
-		struct platform_device *port_dev = fdata->dev;
-
-		/* remove released ports */
-		if (!device_is_registered(&port_dev->dev)) {
-			platform_device_put(port_dev);
-		}
-
-		list_del(&fdata->node);
-	}
 	mutex_unlock(&cdev->lock);
 
 	remove_feature_devs(cdev);
@@ -1715,7 +1703,7 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 	if (!fdata)
 		goto unlock_exit;
 
-	if (!device_is_registered(&fdata->dev->dev)) {
+	if (!fdata->dev) {
 		ret = -EBUSY;
 		goto unlock_exit;
 	}
@@ -1726,7 +1714,7 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 	if (ret)
 		goto unlock_exit;
 
-	platform_device_del(fdata->dev);
+	feature_dev_unregister(fdata);
 	cdev->released_port_num++;
 unlock_exit:
 	mutex_unlock(&cdev->lock);
@@ -1756,12 +1744,12 @@ int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
 	if (!fdata)
 		goto unlock_exit;
 
-	if (device_is_registered(&fdata->dev->dev)) {
+	if (fdata->dev) {
 		ret = -EBUSY;
 		goto unlock_exit;
 	}
 
-	ret = platform_device_add(fdata->dev);
+	ret = feature_dev_register(fdata);
 	if (ret)
 		goto unlock_exit;
 
@@ -1811,7 +1799,7 @@ void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev)
 
 	mutex_lock(&cdev->lock);
 	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&fdata->dev->dev))
+		if (fdata->dev)
 			continue;
 
 		config_port_pf_mode(cdev->fme_dev, fdata->id);
@@ -1848,7 +1836,7 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 	}
 
 	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&fdata->dev->dev))
+		if (fdata->dev)
 			continue;
 
 		config_port_vf_mode(cdev->fme_dev, fdata->id);
-- 
2.47.0


