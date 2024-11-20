Return-Path: <linux-fpga+bounces-966-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A39D31C7
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD154283D23
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A917D154BFF;
	Wed, 20 Nov 2024 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqPwCOY1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94014B088;
	Wed, 20 Nov 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065113; cv=none; b=KOJ7MDDYpTTHOmhDY7UwZSV/g/GZKXEzOzBy3oH9n2tVtWMHGZevLi2ZKbPkKXP+cnZnNFOYpZIO4FQ0GeOQhaXv6Lm/KFvTdsp8AFdo/QzhVZqONkdnp1F+XK1mV5q331rA+ynRIXJ+cARtOX/kCsJYmS5r/MIYzd9LoBgUuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065113; c=relaxed/simple;
	bh=irwkpZ+704CLODc8zeWp2W9IR0cCge5818bXU4du3n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAMQwgEGGBSnN6UgN7msZgb+l5TPAREUaUFh9kNI9WVYtTB0YAgf8FqYE1zn3aoGdAZ6hf+wxp2aGrvqQ73kvCyfujxPCqSZgl/EMPvVucgD1U66Rz5b2DdcKisF8iKRfGGU2efusDyPT6ivy5AeewTGBID+4Atravlz3gF7Et8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqPwCOY1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065111; x=1763601111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=irwkpZ+704CLODc8zeWp2W9IR0cCge5818bXU4du3n4=;
  b=KqPwCOY1f93LHVUQ/Y2oq/ZbSjqPKG77w10WmrBplc2QHcXqGtbBKUOR
   sdRHvNK0IRzrlKzHkvpytx40+OKctjzFYELo4NH+zbYJHmb5mHaXRH4dg
   02xD3ZuP0+Z7D7sL2WmonoNBFpJ4x/6fZxEjd3ExbM2KmmxVxXCIr7GPO
   A0NwfEfu1yW662lPK/OWgy/KKRp33Gz17TI2XEGJMsFAch7tOeD/htjV9
   3xsk5ONcg3XeS2OU5tsOUcUSeC7GUyN55S6r7+06gLq0lqvYlbkCxWRLR
   rolhJu0Ug2hbASjgBhvODeKxFhOUgypTqSNkqpXb6vec+WiWkPsm1kpqh
   w==;
X-CSE-ConnectionGUID: gv94d31xRJu0eG0jbTgpzA==
X-CSE-MsgGUID: 2MqB9IGnTcaSFICXZ8mLng==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42613027"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42613027"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
X-CSE-ConnectionGUID: 3dP0M356QPuePM5RDvqqrQ==
X-CSE-MsgGUID: lq8yFelOR1q/zJ6xYPrG8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813609"
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
Subject: [PATCH v5 14/18] fpga: dfl: store platform device id in feature device data
Date: Tue, 19 Nov 2024 20:10:30 -0500
Message-ID: <20241120011035.230574-15-peter.colberg@intel.com>
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

Delay the feature device id allocation from build_info_create_dev() to
binfo_create_feature_dev_data() and store the id in the feature device
data before copying it to the device. This will allow reusing the same
id in a subsequent commit which completely destroys and recreates the
feature device when releasing and reassigning the corresponding port.

Instead of manually freeing the id when no longer needed, use a
device-managed resource with a custom action to automatically free
the id right before the feature device data is freed. The id registry
is guaranteed to be allocated when dfl_id_free_action() is invoked,
since the DFL PCIe device and its device-managed resources will be
destroyed before dfl_ids_destroy() is called in dfl_fpga_exit().

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v4:
- In the function dfl_fpga_feature_devs_remove(), remove braces around
  single-line conditional statement.

Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 46 +++++++++++++++++++++++-----------------------
 drivers/fpga/dfl.h |  2 ++
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c8e4b977a233..aeae5befc6c6 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -740,6 +740,13 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
 	mutex_unlock(&cdev->lock);
 }
 
+static void dfl_id_free_action(void *arg)
+{
+	struct dfl_feature_dev_data *fdata = arg;
+
+	dfl_id_free(fdata->type, fdata->pdev_id);
+}
+
 static struct dfl_feature_dev_data *
 binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 {
@@ -747,7 +754,7 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	enum dfl_id_type type = binfo->type;
 	struct dfl_feature_info *finfo, *p;
 	struct dfl_feature_dev_data *fdata;
-	int index = 0, res_idx = 0;
+	int ret, index = 0, res_idx = 0;
 
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
 		return ERR_PTR(-EINVAL);
@@ -768,6 +775,17 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 
 	fdata->dev = fdev;
 	fdata->type = type;
+
+	fdata->pdev_id = dfl_id_alloc(type, binfo->dev);
+	if (fdata->pdev_id < 0)
+		return ERR_PTR(fdata->pdev_id);
+
+	ret = devm_add_action_or_reset(binfo->dev, dfl_id_free_action, fdata);
+	if (ret)
+		return ERR_PTR(ret);
+
+	fdev->id = fdata->pdev_id;
+
 	fdata->pdev_name = dfl_devs[type].name;
 	fdata->num = binfo->feature_num;
 	fdata->dfl_cdev = binfo->cdev;
@@ -866,10 +884,6 @@ build_info_create_dev(struct build_feature_devs_info *binfo)
 
 	INIT_LIST_HEAD(&binfo->sub_features);
 
-	fdev->id = dfl_id_alloc(type, &fdev->dev);
-	if (fdev->id < 0)
-		return fdev->id;
-
 	return 0;
 }
 
@@ -946,17 +960,9 @@ static void build_info_free(struct build_feature_devs_info *binfo)
 {
 	struct dfl_feature_info *finfo, *p;
 
-	/*
-	 * it is a valid id, free it. See comments in
-	 * build_info_create_dev()
-	 */
-	if (binfo->feature_dev && binfo->feature_dev->id >= 0) {
-		dfl_id_free(binfo->type, binfo->feature_dev->id);
-
-		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
-			list_del(&finfo->node);
-			kfree(finfo);
-		}
+	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
+		list_del(&finfo->node);
+		kfree(finfo);
 	}
 
 	platform_device_put(binfo->feature_dev);
@@ -1547,13 +1553,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
 static int remove_feature_dev(struct device *dev, void *data)
 {
 	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
-	struct platform_device *pdev = to_platform_device(dev);
-	int id = pdev->id;
 
 	feature_dev_unregister(fdata);
 
-	dfl_id_free(fdata->type, id);
-
 	return 0;
 }
 
@@ -1656,10 +1658,8 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 		struct platform_device *port_dev = fdata->dev;
 
 		/* remove released ports */
-		if (!device_is_registered(&port_dev->dev)) {
-			dfl_id_free(fdata->type, port_dev->id);
+		if (!device_is_registered(&port_dev->dev))
 			platform_device_put(port_dev);
-		}
 
 		list_del(&fdata->node);
 		put_device(&port_dev->dev);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index cbff5d543c44..2e38c42b3920 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -309,6 +309,7 @@ struct dfl_feature {
  * @lock: mutex to protect feature dev data.
  * @dev: ptr to the feature's platform device linked with this structure.
  * @type: type of DFL FIU for the feature dev. See enum dfl_id_type.
+ * @pdev_id: platform device id for the feature dev.
  * @pdev_name: platform device name for the feature dev.
  * @dfl_cdev: ptr to container device.
  * @id: id used for the feature device.
@@ -326,6 +327,7 @@ struct dfl_feature_dev_data {
 	struct mutex lock;
 	struct platform_device *dev;
 	enum dfl_id_type type;
+	int pdev_id;
 	const char *pdev_name;
 	struct dfl_fpga_cdev *dfl_cdev;
 	int id;
-- 
2.47.0


