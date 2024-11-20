Return-Path: <linux-fpga+bounces-965-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377A9D31C5
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F24281D26
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA614F9E7;
	Wed, 20 Nov 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTNh5pPn"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1514885D;
	Wed, 20 Nov 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065111; cv=none; b=GWFHl3oKmHWMRNZsbVx83cMIXhUTtwDVEysxaC/63qNYoV/u58VbleQxIXbqTdbCuYG7Ak9j+p32UKM0MWKhdcvavJKjRlYv8AOridjV2CO2cYisnWpKI5aaX9hKVHRiG/ilBoc59BlfvO47wKX+9ftGpCFtwOD2OCx7L1l/Kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065111; c=relaxed/simple;
	bh=J098Ry0xDLSZ5e33vmElAllzS+/5XVjHikmeVCGgdHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgdoWi0Qgcc81tVxLa/KlFxrA5SvZPE0ec0VZwgduHFUxpSySiVZ4aQtR1JY6WvtGTM+GbOaaKr9Wol52PyKwsYthouw8bgqNoQwluSo6etXdndthDxh6S98hQAfn8bkmQetGKJqXQayC1DjW99O/yW59vSWxho78q6K7jwyxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTNh5pPn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065110; x=1763601110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J098Ry0xDLSZ5e33vmElAllzS+/5XVjHikmeVCGgdHU=;
  b=aTNh5pPnThZRmCf1NmOph5sPxUEhjsGvhfx3q/WdO3CpWSO/P7Et7ORY
   Keuc/nMmQrH+1O8wfsLP4/tsELnkde5iBn5nPwJKlD/zopZpQ484uFkXW
   sQxJXHgH83wNHV+FIpOGvFaSdNtQo23NnogBiYuJ7Y9LC1m6pCT09NGfo
   /c9aZy8a1HVwIrg8Sk4TD8lYZjbp7IlcQno7+VB621ChszAm1YAo6TWUe
   0Cxr6FGXVluTRvTM98z2+QUZfSy8SPBqhLAmviOgL/Ai2R9WMPjhDPcBR
   Xwzi4FbZvKDrubqYV6tvBZJxYAb17Ru3zjPpO6IDLOwh+5JWwRx0SV/5n
   g==;
X-CSE-ConnectionGUID: KI8euct7SMWWbExPoTfiAA==
X-CSE-MsgGUID: udTWtG+0RdGNCpRfAu63wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42613035"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42613035"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
X-CSE-ConnectionGUID: xR6gDIG+RomifaTMvfIpnw==
X-CSE-MsgGUID: Sye87lmRSYejCVBLTkOqkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813619"
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
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v5 17/18] fpga: dfl: drop unneeded get_device() and put_device() of feature device
Date: Tue, 19 Nov 2024 20:10:33 -0500
Message-ID: <20241120011035.230574-18-peter.colberg@intel.com>
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

The feature device data was originally stored as platform data, hence
the memory allocation was tied to the lifetime of the feature device.
Now that the feature device data is tied to the lifetime of the DFL PCIe
FPGA device instead, get_device() and put_device() are no longer needed.

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
 drivers/fpga/dfl-fme-br.c |  2 --
 drivers/fpga/dfl.c        | 16 +++++-----------
 drivers/fpga/dfl.h        |  5 -----
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index 5c60a38ec76c..a298a041877b 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -85,8 +85,6 @@ static void fme_br_remove(struct platform_device *pdev)
 
 	fpga_bridge_unregister(br);
 
-	if (priv->port_fdata)
-		put_device(&priv->port_fdata->dev->dev);
 	if (priv->port_ops)
 		dfl_fpga_port_ops_put(priv->port_ops);
 }
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 203b14e292b4..d4b8df4e0ebc 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -734,7 +734,6 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
 {
 	mutex_lock(&cdev->lock);
 	list_add(&fdata->node, &cdev->port_dev_list);
-	get_device(&fdata->dev->dev);
 	mutex_unlock(&cdev->lock);
 }
 
@@ -1645,7 +1644,6 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 			platform_device_put(port_dev);
 
 		list_del(&fdata->node);
-		put_device(&port_dev->dev);
 	}
 	mutex_unlock(&cdev->lock);
 
@@ -1677,7 +1675,7 @@ __dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
 	struct dfl_feature_dev_data *fdata;
 
 	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
-		if (match(fdata, data) && get_device(&fdata->dev->dev))
+		if (match(fdata, data))
 			return fdata;
 	}
 
@@ -1728,19 +1726,17 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 
 	if (!device_is_registered(&fdata->dev->dev)) {
 		ret = -EBUSY;
-		goto put_dev_exit;
+		goto unlock_exit;
 	}
 
 	mutex_lock(&fdata->lock);
 	ret = dfl_feature_dev_use_begin(fdata, true);
 	mutex_unlock(&fdata->lock);
 	if (ret)
-		goto put_dev_exit;
+		goto unlock_exit;
 
 	platform_device_del(fdata->dev);
 	cdev->released_port_num++;
-put_dev_exit:
-	put_device(&fdata->dev->dev);
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
@@ -1771,20 +1767,18 @@ int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
 
 	if (device_is_registered(&fdata->dev->dev)) {
 		ret = -EBUSY;
-		goto put_dev_exit;
+		goto unlock_exit;
 	}
 
 	ret = platform_device_add(fdata->dev);
 	if (ret)
-		goto put_dev_exit;
+		goto unlock_exit;
 
 	mutex_lock(&fdata->lock);
 	dfl_feature_dev_use_end(fdata);
 	mutex_unlock(&fdata->lock);
 
 	cdev->released_port_num--;
-put_dev_exit:
-	put_device(&fdata->dev->dev);
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2e38c42b3920..95539f1213cb 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -551,11 +551,6 @@ struct dfl_fpga_cdev *
 dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info);
 void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev);
 
-/*
- * need to drop the device reference with put_device() after use port platform
- * device returned by __dfl_fpga_cdev_find_port and dfl_fpga_cdev_find_port
- * functions.
- */
 struct dfl_feature_dev_data *
 __dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
 			       int (*match)(struct dfl_feature_dev_data *, void *));
-- 
2.47.0


