Return-Path: <linux-fpga+bounces-967-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FB49D31C8
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CFDB244B8
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8DA15532A;
	Wed, 20 Nov 2024 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVMYIBjN"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFC14F12D;
	Wed, 20 Nov 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065114; cv=none; b=ONcyp2582jzSAS790TOlopQofab4pmciDZ3N6glML/yH4ngo++m5dWklfzw7D4jPXSDyP910+qVhmsoR0FYz+Z36xU/f4c/J9ig68ylfqrWr+AYyPmvd2gQno+eVKdS0omqqhzrFQyuIG3OF7pbHY7+wCXDEPxsnm3jnUUytmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065114; c=relaxed/simple;
	bh=RxW4J+F2v4aAnLswBVya46uekQUHr6rRIs+ONgrBVms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnbrxBJ3B+OFuWkR3Jf4YXwKhSwAc8Svq7hk6B3HqtcZtv6aj3u77gyhlZhmyjDjd0IHWEYtLn0Le+m+mcbyqcX6DLOa6nGh9TpOZT9Allwj/aHsMuO4lOWve+IFOuDleie2hw50mnsQogrkJ4DBBQ5P9WY8g4f+CtOOHi8qrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVMYIBjN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065112; x=1763601112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RxW4J+F2v4aAnLswBVya46uekQUHr6rRIs+ONgrBVms=;
  b=WVMYIBjN9kF6oVfxvV3Ru8ZQeOOE6Gg3BD4cs51HkpxvUHdbaGhL1lcM
   qdoBqJZHcJj6yDS2Ev15WfhI+o49LTBtP2LiHMEoYJRrbrMZSQKBsw+UO
   a7bbWXOEdNadCiPvhG2u6zd0/fjj7UaRi8E6QqRitH0PiuT1OJfMVbmn0
   sESHzWtZxCZ4Yr5EdM1zz4m0rZGYYA9itsi0/ToOL2+1u0zRU4OajmwY2
   8ZbrAOcEtV0ee3X2D5h9Oo3kQOPSm4CpEiBptC0kUXBHTF8SpY8liEJfp
   4KUhwwFxGZs0FGQvNAewavZYpgH6eRIYCXHg8ZwMCDfutP6r5pvcdl3PB
   Q==;
X-CSE-ConnectionGUID: A1J6WQOhQFiEYoRBFBn0SQ==
X-CSE-MsgGUID: EFGN/TUeQfyrfFqqLdtRpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42613036"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42613036"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
X-CSE-ConnectionGUID: PGl6GEhpTI+M3LxY+QUkhQ==
X-CSE-MsgGUID: 9qf0cGapSHe0hVRjCZKFgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813622"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
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
Subject: [PATCH v5 18/18] fpga: dfl: destroy/recreate feature platform device on port release/assign
Date: Tue, 19 Nov 2024 20:10:34 -0500
Message-ID: <20241120011035.230574-19-peter.colberg@intel.com>
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
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index d4b8df4e0ebc..b01fb446bc7c 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1630,21 +1630,10 @@ EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_enumerate);
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
-		if (!device_is_registered(&port_dev->dev))
-			platform_device_put(port_dev);
-
-		list_del(&fdata->node);
-	}
 	mutex_unlock(&cdev->lock);
 
 	remove_feature_devs(cdev);
@@ -1724,7 +1713,7 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 	if (!fdata)
 		goto unlock_exit;
 
-	if (!device_is_registered(&fdata->dev->dev)) {
+	if (!fdata->dev) {
 		ret = -EBUSY;
 		goto unlock_exit;
 	}
@@ -1735,7 +1724,7 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 	if (ret)
 		goto unlock_exit;
 
-	platform_device_del(fdata->dev);
+	feature_dev_unregister(fdata);
 	cdev->released_port_num++;
 unlock_exit:
 	mutex_unlock(&cdev->lock);
@@ -1765,12 +1754,12 @@ int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
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
 
@@ -1820,7 +1809,7 @@ void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev)
 
 	mutex_lock(&cdev->lock);
 	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&fdata->dev->dev))
+		if (fdata->dev)
 			continue;
 
 		config_port_pf_mode(cdev->fme_dev, fdata->id);
@@ -1857,7 +1846,7 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 	}
 
 	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&fdata->dev->dev))
+		if (fdata->dev)
 			continue;
 
 		config_port_vf_mode(cdev->fme_dev, fdata->id);
-- 
2.47.0


