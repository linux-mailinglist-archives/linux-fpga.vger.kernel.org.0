Return-Path: <linux-fpga+bounces-911-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28789B12E0
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025B51C22032
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8D21C2C5;
	Fri, 25 Oct 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qm307agz"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F421A4D5;
	Fri, 25 Oct 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895876; cv=none; b=ubPtnmWCsdPSqRrUr9ClYh68HFACJjp6wtp33WUtV8k4vHMxzNy/jsP2bhTJivJrBqrFRk5zCmUPjO1mffY7ZJv6mJEaEHsz4ulJ4cqmXodlMcrGcN0xjKVcJb/bWycFtOaqjavsmBjkXlH8DH1qIeVwSlEDyGppeWVY0lqRr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895876; c=relaxed/simple;
	bh=A5lv/DaRe4r3eZdv9i77hRkmE1RSUozBNErpGGa+Yhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYdUO21VLH4QgAxS5+oGiJacaJ/qqQh7IIeiNsSvhC5LzvbeR+NEWAT8ayliiuF+A/PGS37KryPEOmi2Kc+fmrR2UM1C1vMh47MI9seMO+TRfFSUmZojEM3PdWSTahDmzkqx8Ay0YkrhtAYyM1OXdKdlDOaavGMOhlUUmNa/0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qm307agz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895873; x=1761431873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A5lv/DaRe4r3eZdv9i77hRkmE1RSUozBNErpGGa+Yhk=;
  b=Qm307agzN+tAOe41thzuaWHfG/56Um7d3YWfzaS/xGQCb5kDpSgmeDBl
   ubevDM23QefVat6LnUVG91GpRo0eV/ep5+VOB3gt6wvRy8h6U9fOl3ALt
   wek17Z2OtFLjENeXVaXO5l5FR9MyeQH8cXxriSvMkccr3VZh6o+gBC9j5
   6Bf9NZwiS5LDGJ/vMWm3uls8Z5YScucU3tqMJF3twUZ3zivRoMxWCV2ik
   sYPl0jh1S7JD6X7NIrKsRv9cSfJm0S/FwzTsAIkPUn3G2uGc0GAAhcAWz
   M4t3aypd0ZZ9qe6xhJGXel/4V9PD9qbyl+vyKjnfu5H3ZxCbWu/NkYrtA
   Q==;
X-CSE-ConnectionGUID: fLv1r3IwR3Cbm0QuAIiRpA==
X-CSE-MsgGUID: hiX6JacVQ4CKSJa4usr+Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474690"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474690"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
X-CSE-ConnectionGUID: uFHXqLuaTdqjBceOB4Yawg==
X-CSE-MsgGUID: k1DF94XfQGq9Or7XRpQzrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596192"
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
Subject: [PATCH v4 18/19] fpga: dfl: drop unneeded get_device() and put_device() of feature device
Date: Fri, 25 Oct 2024 18:37:13 -0400
Message-ID: <20241025223714.394533-19-peter.colberg@intel.com>
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

The feature device data was originally stored as platform data, hence
the memory allocation was tied to the lifetime of the feature device.
Now that the feature device data is tied to the lifetime of the DFL PCIe
FPGA device instead, get_device() and put_device() are no longer needed.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
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
index a2459b0cbc68..ed38e5ec84b6 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -734,7 +734,6 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
 {
 	mutex_lock(&cdev->lock);
 	list_add(&fdata->node, &cdev->port_dev_list);
-	get_device(&fdata->dev->dev);
 	mutex_unlock(&cdev->lock);
 }
 
@@ -1636,7 +1635,6 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 		}
 
 		list_del(&fdata->node);
-		put_device(&port_dev->dev);
 	}
 	mutex_unlock(&cdev->lock);
 
@@ -1668,7 +1666,7 @@ __dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
 	struct dfl_feature_dev_data *fdata;
 
 	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
-		if (match(fdata, data) && get_device(&fdata->dev->dev))
+		if (match(fdata, data))
 			return fdata;
 	}
 
@@ -1719,19 +1717,17 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 
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
@@ -1762,20 +1758,18 @@ int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
 
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


