Return-Path: <linux-fpga+bounces-720-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315DF97CE87
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C821C226D7
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D68B170A0C;
	Thu, 19 Sep 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SApqt0iV"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47EE157465;
	Thu, 19 Sep 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778111; cv=none; b=e0mAWkzZfaK0DGizyjBQykvSnPv8wbnWQoLpixJM1yLJzwGi0CkHnlHkEFhMwblhPGdiNFgZehRVV+C6zA5YlEusMfiyOys1KPeY10A8EiKuKqTUpBseMtasV60D3Bh84lA0F5I0b4aHs0M5e6AdkCTfSV1t+00EAiwUTiSCbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778111; c=relaxed/simple;
	bh=tcactYcFOJ3QcniLaKKMNBJB97lRHixOipaNhLMVIhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT87Hetom8hVmo6Rp/848HaDTqxKgKTF0B1SuMzppyZ6krZFWAcAmEVCAUnjo6jrYQDW+otYBAM1m4Ko+K3mWbAu61HZRnCq+X4V/CPQW8epc8c7HJchDh/7ek3NX6QAXdh4RlrFtiiYs96Surz02tRFteuI2UeMKkGKvFJqAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SApqt0iV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726778110; x=1758314110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tcactYcFOJ3QcniLaKKMNBJB97lRHixOipaNhLMVIhs=;
  b=SApqt0iVquel2JqMSDWLw0ByuVFGfJeIEAvC2FYTCUHWRotMjiAnVvbu
   TGB5vEeP5fbQ0fKO+gVAaVsWS4A+vabywWgmo06NmWRk5rdxPgtlD0qg5
   aKGTre883hZ6uk4EL2MCWHL3JB2vD92t1pze9//rwG5WIrbXCaa94e4Uh
   hTM5ReZ4ylPWIi61dlwHzEEQKv9fatSbLlRN6LbNW0riipbb0k3OdKZvA
   9n7FDOmnWhx7I46GbQ+UHG8a4V9pqGhSpzE2mKVM1KAzdxhuWpat3A0Oe
   GSWNXDv+SL1QYGb9Xeev7D3QMM5GfJMB7vZno5cipJ1qIoXbsFucWbuEX
   Q==;
X-CSE-ConnectionGUID: toBt4iiQQkqq25gQfJWxQw==
X-CSE-MsgGUID: MRXVcxEXQ5yTjVX+jZhyLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25912963"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25912963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:06 -0700
X-CSE-ConnectionGUID: ieHY0fYXQESko/lF8GLJww==
X-CSE-MsgGUID: opUpF4BgTTeEorbbv0wHzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="93338337"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:06 -0700
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
Subject: [PATCH v3 7/9] fpga: dfl: store FIU type in feature platform data
Date: Thu, 19 Sep 2024 16:34:28 -0400
Message-ID: <20240919203430.1278067-8-peter.colberg@intel.com>
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

Remove the local function feature_dev_id_type() in favour of persisting
the FIU type in struct dfl_feature_platform_data. Add type to struct
build_feature_devs_info and drop argument to build_info_create_dev().

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl.c | 57 ++++++++++++++++++++++------------------------
 drivers/fpga/dfl.h |  3 +++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index e644eb9fde39..9610ef1ec2ff 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -119,17 +119,6 @@ static void dfl_id_free(enum dfl_id_type type, int id)
 	mutex_unlock(&dfl_id_mutex);
 }
 
-static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(dfl_devs); i++)
-		if (!strcmp(dfl_devs[i].name, pdev->name))
-			return i;
-
-	return DFL_ID_MAX;
-}
-
 static enum dfl_id_type dfh_id_to_type(u16 id)
 {
 	int i;
@@ -379,7 +368,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
 	if (ret)
 		goto put_dev;
 
-	ddev->type = feature_dev_id_type(pdev);
+	ddev->type = pdata->type;
 	ddev->feature_id = feature->id;
 	ddev->revision = feature->revision;
 	ddev->dfh_version = feature->dfh_version;
@@ -693,6 +682,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
  * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
  *	       this device.
  * @feature_dev: current feature device.
+ * @type: the current FIU type.
  * @ioaddr: header register region address of current FIU in enumeration.
  * @start: register resource start of current FIU.
  * @len: max register resource length of current FIU.
@@ -706,6 +696,7 @@ struct build_feature_devs_info {
 	int *irq_table;
 
 	struct platform_device *feature_dev;
+	enum dfl_id_type type;
 	void __iomem *ioaddr;
 	resource_size_t start;
 	resource_size_t len;
@@ -752,13 +743,12 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
 static struct dfl_feature_platform_data *
 binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 {
+	enum dfl_id_type type = binfo->type;
 	struct platform_device *fdev = binfo->feature_dev;
 	struct dfl_feature_platform_data *pdata;
 	struct dfl_feature_info *finfo, *p;
-	enum dfl_id_type type;
 	int ret, index = 0, res_idx = 0;
 
-	type = feature_dev_id_type(fdev);
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
 		return ERR_PTR(-EINVAL);
 
@@ -773,6 +763,7 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 		return ERR_PTR(-ENOMEM);
 
 	pdata->dev = fdev;
+	pdata->type = type;
 	pdata->num = binfo->feature_num;
 	pdata->dfl_cdev = binfo->cdev;
 	pdata->id = FEATURE_DEV_ID_UNUSED;
@@ -861,14 +852,11 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 }
 
 static int
-build_info_create_dev(struct build_feature_devs_info *binfo,
-		      enum dfl_id_type type)
+build_info_create_dev(struct build_feature_devs_info *binfo)
 {
+	enum dfl_id_type type = binfo->type;
 	struct platform_device *fdev;
 
-	if (type >= DFL_ID_MAX)
-		return -EINVAL;
-
 	/*
 	 * we use -ENODEV as the initialization indicator which indicates
 	 * whether the id need to be reclaimed
@@ -905,7 +893,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	if (ret)
 		return ret;
 
-	if (feature_dev_id_type(binfo->feature_dev) == PORT_ID)
+	if (binfo->type == PORT_ID)
 		dfl_fpga_cdev_add_port_data(binfo->cdev, pdata);
 	else
 		binfo->cdev->fme_dev = get_device(&binfo->feature_dev->dev);
@@ -919,6 +907,9 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	 */
 	binfo->feature_dev = NULL;
 
+	/* reset the binfo for next FIU */
+	binfo->type = DFL_ID_MAX;
+
 	return 0;
 }
 
@@ -931,8 +922,7 @@ static void build_info_free(struct build_feature_devs_info *binfo)
 	 * build_info_create_dev()
 	 */
 	if (binfo->feature_dev && binfo->feature_dev->id >= 0) {
-		dfl_id_free(feature_dev_id_type(binfo->feature_dev),
-			    binfo->feature_dev->id);
+		dfl_id_free(binfo->type, binfo->feature_dev->id);
 
 		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
 			list_del(&finfo->node);
@@ -1030,7 +1020,7 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 		 * Instead, features with interrupt functionality provide
 		 * the information in feature specific registers.
 		 */
-		type = feature_dev_id_type(binfo->feature_dev);
+		type = binfo->type;
 		if (type == PORT_ID) {
 			switch (fid) {
 			case PORT_FEATURE_ID_UINT:
@@ -1222,7 +1212,7 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
 	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
 }
 
-#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
+#define is_feature_dev_detected(binfo) ((binfo)->type != DFL_ID_MAX)
 
 static int parse_feature_afu(struct build_feature_devs_info *binfo,
 			     resource_size_t ofst)
@@ -1232,7 +1222,7 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
 		return -EINVAL;
 	}
 
-	switch (feature_dev_id_type(binfo->feature_dev)) {
+	switch (binfo->type) {
 	case PORT_ID:
 		return parse_feature_port_afu(binfo, ofst);
 	default:
@@ -1278,6 +1268,7 @@ static void build_info_complete(struct build_feature_devs_info *binfo)
 static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 			     resource_size_t ofst)
 {
+	enum dfl_id_type type;
 	int ret = 0;
 	u32 offset;
 	u16 id;
@@ -1299,8 +1290,14 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 	v = readq(binfo->ioaddr + DFH);
 	id = FIELD_GET(DFH_ID, v);
 
+	type = dfh_id_to_type(id);
+	if (type >= DFL_ID_MAX)
+		return -EINVAL;
+
+	binfo->type = type;
+
 	/* create platform device for dfl feature dev */
-	ret = build_info_create_dev(binfo, dfh_id_to_type(id));
+	ret = build_info_create_dev(binfo);
 	if (ret)
 		return ret;
 
@@ -1520,13 +1517,13 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
 
 static int remove_feature_dev(struct device *dev, void *data)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	struct platform_device *pdev = to_platform_device(dev);
-	enum dfl_id_type type = feature_dev_id_type(pdev);
 	int id = pdev->id;
 
 	platform_device_unregister(pdev);
 
-	dfl_id_free(type, id);
+	dfl_id_free(pdata->type, id);
 
 	return 0;
 }
@@ -1578,6 +1575,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 		goto unregister_region_exit;
 	}
 
+	binfo->type = DFL_ID_MAX;
 	binfo->dev = info->dev;
 	binfo->cdev = cdev;
 
@@ -1630,8 +1628,7 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 
 		/* remove released ports */
 		if (!device_is_registered(&port_dev->dev)) {
-			dfl_id_free(feature_dev_id_type(port_dev),
-				    port_dev->id);
+			dfl_id_free(pdata->type, port_dev->id);
 			platform_device_put(port_dev);
 		}
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 8ef9f33e22c1..d3a8a8ef908b 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/cdev.h>
 #include <linux/delay.h>
+#include <linux/dfl.h>
 #include <linux/eventfd.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
@@ -308,6 +309,7 @@ struct dfl_feature {
  * @lock: mutex to protect platform data.
  * @cdev: cdev of feature dev.
  * @dev: ptr to platform device linked with this platform data.
+ * @type: type of DFL FIU for the feature dev. See enum dfl_id_type.
  * @dfl_cdev: ptr to container device.
  * @id: id used for this feature device.
  * @disable_count: count for port disable.
@@ -322,6 +324,7 @@ struct dfl_feature_platform_data {
 	struct mutex lock;
 	struct cdev cdev;
 	struct platform_device *dev;
+	enum dfl_id_type type;
 	struct dfl_fpga_cdev *dfl_cdev;
 	int id;
 	unsigned int disable_count;
-- 
2.46.1


