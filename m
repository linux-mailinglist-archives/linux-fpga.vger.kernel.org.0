Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5148D22BBE5
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jul 2020 04:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGXCMn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Jul 2020 22:12:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:14547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgGXCMn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 23 Jul 2020 22:12:43 -0400
IronPort-SDR: 5JKArJVsNV+j/8RKjjAcDC1uQPxQYUNmFw+qzPrTLHwWPX5YtyLaRP5NQrh7TvA/j3P3CCdQfo
 9VEjOVzfZoXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168780082"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="168780082"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 19:12:42 -0700
IronPort-SDR: cR+B+XSmts1BoYQ7RDAv5MTc5Cm9mJ2BFXmLgCDVjPFZWqroV6rPqcqKZ5TEury+wvXVc0Y+yt
 H+hlhYfgIrPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="271216022"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jul 2020 19:12:40 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 2/4] fpga: dfl: map feature mmio resources in their own feature drivers
Date:   Fri, 24 Jul 2020 10:09:13 +0800
Message-Id: <1595556555-9903-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch makes preparation for modularization of DFL sub feature
drivers.

Currently, if we need to support a new DFL sub feature, an entry should
be added to fme/port_feature_drvs[] in dfl-fme/port-main.c. And we need
to re-compile the whole DFL modules. That make the DFL drivers hard to be
extended.

Another consideration is that DFL may contain some IP blocks which are
already supported by kernel, most of them are supported by platform
device drivers. We could create platform devices for these IP blocks and
get them supported by these drivers.

An important issue is that platform device drivers usually requests mmio
resources on probe. But now dfl mmio is mapped in dfl bus driver (e.g.
dfl-pci) as a whole region. Then platform device drivers for sub features
can't request their own mmio resources again. This is what the patch
trying to resolve.

This patch changes the DFL enumeration. DFL bus driver will unmap mmio
resources after first step enumeration and pass enumeration info to DFL
framework. Then DFL framework will map the mmio resources again, do 2nd
step enumeration, and also unmap the mmio resources. In this way, sub
feature drivers could then request their own mmio resources as needed.

An exception is that mmio resource of FIU headers are still mapped in dfl
bus driver. The FIU headers have some fundamental functions (sriov set,
port enable/disable) needed for dfl bus devices and other sub features.
They should not be unmapped as long as dfl bus device is alive.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Tom Rix <trix@redhat.com>
----
v2: delete dfl_binfo_shift() cause no shift is possible for FIU parsing.
    Only map bar0 for first phase enumeration in dfl-pci, we can find
      all dfl mmio resource info in bar0.
    Some minor fixes for comments from Hao & Tom.
---
 drivers/fpga/dfl-pci.c |  24 +++----
 drivers/fpga/dfl.c     | 185 ++++++++++++++++++++++++++++++++++---------------
 drivers/fpga/dfl.h     |   7 +-
 3 files changed, 140 insertions(+), 76 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index e220bec..a2203d0 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -31,12 +31,12 @@ struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
 
-static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
+static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
 {
-	if (pcim_iomap_regions(pcidev, BIT(bar), DRV_NAME))
+	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
 		return NULL;
 
-	return pcim_iomap_table(pcidev)[bar];
+	return pcim_iomap_table(pcidev)[0];
 }
 
 static int cci_pci_alloc_irq(struct pci_dev *pcidev)
@@ -156,8 +156,8 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 			goto irq_free_exit;
 	}
 
-	/* start to find Device Feature List from Bar 0 */
-	base = cci_pci_ioremap_bar(pcidev, 0);
+	/* start to find Device Feature List in Bar 0 */
+	base = cci_pci_ioremap_bar0(pcidev);
 	if (!base) {
 		ret = -ENOMEM;
 		goto irq_free_exit;
@@ -172,7 +172,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 		start = pci_resource_start(pcidev, 0);
 		len = pci_resource_len(pcidev, 0);
 
-		dfl_fpga_enum_info_add_dfl(info, start, len, base);
+		dfl_fpga_enum_info_add_dfl(info, start, len);
 
 		/*
 		 * find more Device Feature Lists (e.g. Ports) per information
@@ -196,26 +196,24 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
-			base = cci_pci_ioremap_bar(pcidev, bar);
-			if (!base)
-				continue;
-
 			start = pci_resource_start(pcidev, bar) + offset;
 			len = pci_resource_len(pcidev, bar) - offset;
 
-			dfl_fpga_enum_info_add_dfl(info, start, len,
-						   base + offset);
+			dfl_fpga_enum_info_add_dfl(info, start, len);
 		}
 	} else if (dfl_feature_is_port(base)) {
 		start = pci_resource_start(pcidev, 0);
 		len = pci_resource_len(pcidev, 0);
 
-		dfl_fpga_enum_info_add_dfl(info, start, len, base);
+		dfl_fpga_enum_info_add_dfl(info, start, len);
 	} else {
 		ret = -ENODEV;
 		goto irq_free_exit;
 	}
 
+	/* release I/O mappings for next step enumeration */
+	pcim_iounmap_regions(pcidev, BIT(0));
+
 	/* start enumeration with prepared enumeration information */
 	cdev = dfl_fpga_feature_devs_enumerate(info);
 	if (IS_ERR(cdev)) {
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 9bca22e..b675957 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -250,6 +250,8 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
 
+#define is_header_feature(feature) ((feature)->id == FEATURE_ID_FIU_HEADER)
+
 /**
  * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature device
  * @pdev: feature device.
@@ -273,8 +275,22 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
 				     struct dfl_feature *feature,
 				     struct dfl_feature_driver *drv)
 {
+	void __iomem *base;
 	int ret = 0;
 
+	if (!is_header_feature(feature)) {
+		base = devm_platform_ioremap_resource(pdev,
+						      feature->resource_index);
+		if (IS_ERR(base)) {
+			dev_err(&pdev->dev,
+				"ioremap failed for feature 0x%x!\n",
+				feature->id);
+			return PTR_ERR(base);
+		}
+
+		feature->ioaddr = base;
+	}
+
 	if (drv->ops->init) {
 		ret = drv->ops->init(pdev, feature);
 		if (ret)
@@ -427,7 +443,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
  * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
  *	       this device.
  * @feature_dev: current feature device.
- * @ioaddr: header register region address of feature device in enumeration.
+ * @ioaddr: header register region address of current FIU in enumeration.
+ * @start: register resource start of current FIU.
+ * @len: max register resource length of current FIU.
  * @sub_features: a sub features linked list for feature device in enumeration.
  * @feature_num: number of sub features for feature device in enumeration.
  */
@@ -439,6 +457,8 @@ struct build_feature_devs_info {
 
 	struct platform_device *feature_dev;
 	void __iomem *ioaddr;
+	resource_size_t start;
+	resource_size_t len;
 	struct list_head sub_features;
 	int feature_num;
 };
@@ -484,10 +504,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	struct dfl_feature_platform_data *pdata;
 	struct dfl_feature_info *finfo, *p;
 	enum dfl_id_type type;
-	int ret, index = 0;
-
-	if (!fdev)
-		return 0;
+	int ret, index = 0, res_idx = 0;
 
 	type = feature_dev_id_type(fdev);
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
@@ -531,16 +548,30 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 
 	/* fill features and resource information for feature dev */
 	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
-		struct dfl_feature *feature = &pdata->features[index];
+		struct dfl_feature *feature = &pdata->features[index++];
 		struct dfl_feature_irq_ctx *ctx;
 		unsigned int i;
 
 		/* save resource information for each feature */
 		feature->dev = fdev;
 		feature->id = finfo->fid;
-		feature->resource_index = index;
-		feature->ioaddr = finfo->ioaddr;
-		fdev->resource[index++] = finfo->mmio_res;
+
+		/*
+		 * map header resource for dfl bus device. Don't add header
+		 * resource to feature devices, or the resource tree will be
+		 * disordered and cause warning on resource release
+		 */
+		if (is_header_feature(feature)) {
+			feature->resource_index = -1;
+			feature->ioaddr =
+				devm_ioremap_resource(binfo->dev,
+						      &finfo->mmio_res);
+			if (IS_ERR(feature->ioaddr))
+				return PTR_ERR(feature->ioaddr);
+		} else {
+			feature->resource_index = res_idx;
+			fdev->resource[res_idx++] = finfo->mmio_res;
+		}
 
 		if (finfo->nr_irqs) {
 			ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
@@ -583,19 +614,13 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 
 static int
 build_info_create_dev(struct build_feature_devs_info *binfo,
-		      enum dfl_id_type type, void __iomem *ioaddr)
+		      enum dfl_id_type type)
 {
 	struct platform_device *fdev;
-	int ret;
 
 	if (type >= DFL_ID_MAX)
 		return -EINVAL;
 
-	/* we will create a new device, commit current device first */
-	ret = build_info_commit_dev(binfo);
-	if (ret)
-		return ret;
-
 	/*
 	 * we use -ENODEV as the initialization indicator which indicates
 	 * whether the id need to be reclaimed
@@ -606,7 +631,7 @@ build_info_create_dev(struct build_feature_devs_info *binfo,
 
 	binfo->feature_dev = fdev;
 	binfo->feature_num = 0;
-	binfo->ioaddr = ioaddr;
+
 	INIT_LIST_HEAD(&binfo->sub_features);
 
 	fdev->id = dfl_id_alloc(type, &fdev->dev);
@@ -748,18 +773,17 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
  */
 static int
 create_feature_instance(struct build_feature_devs_info *binfo,
-			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
-			resource_size_t size, u16 fid)
+			resource_size_t ofst, resource_size_t size, u16 fid)
 {
 	unsigned int irq_base, nr_irqs;
 	struct dfl_feature_info *finfo;
 	int ret;
 
 	/* read feature size and id if inputs are invalid */
-	size = size ? size : feature_size(dfl->ioaddr + ofst);
-	fid = fid ? fid : feature_id(dfl->ioaddr + ofst);
+	size = size ? size : feature_size(binfo->ioaddr + ofst);
+	fid = fid ? fid : feature_id(binfo->ioaddr + ofst);
 
-	if (dfl->len - ofst < size)
+	if (binfo->len - ofst < size)
 		return -EINVAL;
 
 	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
@@ -771,12 +795,11 @@ create_feature_instance(struct build_feature_devs_info *binfo,
 		return -ENOMEM;
 
 	finfo->fid = fid;
-	finfo->mmio_res.start = dfl->start + ofst;
+	finfo->mmio_res.start = binfo->start + ofst;
 	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
 	finfo->mmio_res.flags = IORESOURCE_MEM;
 	finfo->irq_base = irq_base;
 	finfo->nr_irqs = nr_irqs;
-	finfo->ioaddr = dfl->ioaddr + ofst;
 
 	list_add_tail(&finfo->node, &binfo->sub_features);
 	binfo->feature_num++;
@@ -785,7 +808,6 @@ create_feature_instance(struct build_feature_devs_info *binfo,
 }
 
 static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
-				  struct dfl_fpga_enum_dfl *dfl,
 				  resource_size_t ofst)
 {
 	u64 v = readq(binfo->ioaddr + PORT_HDR_CAP);
@@ -793,21 +815,22 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
 
 	WARN_ON(!size);
 
-	return create_feature_instance(binfo, dfl, ofst, size, FEATURE_ID_AFU);
+	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
 }
 
+#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
+
 static int parse_feature_afu(struct build_feature_devs_info *binfo,
-			     struct dfl_fpga_enum_dfl *dfl,
 			     resource_size_t ofst)
 {
-	if (!binfo->feature_dev) {
+	if (!is_feature_dev_detected(binfo)) {
 		dev_err(binfo->dev, "this AFU does not belong to any FIU.\n");
 		return -EINVAL;
 	}
 
 	switch (feature_dev_id_type(binfo->feature_dev)) {
 	case PORT_ID:
-		return parse_feature_port_afu(binfo, dfl, ofst);
+		return parse_feature_port_afu(binfo, ofst);
 	default:
 		dev_info(binfo->dev, "AFU belonging to FIU %s is not supported yet.\n",
 			 binfo->feature_dev->name);
@@ -816,8 +839,40 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
 	return 0;
 }
 
+static int dfl_binfo_prepare(struct build_feature_devs_info *binfo,
+			     resource_size_t start, resource_size_t len)
+{
+	struct device *dev = binfo->dev;
+	void __iomem *ioaddr;
+
+	if (!devm_request_mem_region(dev, start, len, dev_name(dev))) {
+		dev_err(dev, "request region fail, start:%pa, len:%pa\n",
+			&start, &len);
+		return -EBUSY;
+	}
+
+	ioaddr = devm_ioremap(dev, start, len);
+	if (!ioaddr) {
+		dev_err(dev, "ioremap region fail, start:%pa, len:%pa\n",
+			&start, &len);
+		devm_release_mem_region(dev, start, len);
+		return -ENOMEM;
+	}
+
+	binfo->start = start;
+	binfo->len = len;
+	binfo->ioaddr = ioaddr;
+
+	return 0;
+}
+
+static void dfl_binfo_complete(struct build_feature_devs_info *binfo)
+{
+	devm_iounmap(binfo->dev, binfo->ioaddr);
+	devm_release_mem_region(binfo->dev, binfo->start, binfo->len);
+}
+
 static int parse_feature_fiu(struct build_feature_devs_info *binfo,
-			     struct dfl_fpga_enum_dfl *dfl,
 			     resource_size_t ofst)
 {
 	int ret = 0;
@@ -825,27 +880,39 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 	u16 id;
 	u64 v;
 
-	v = readq(dfl->ioaddr + ofst + DFH);
+	if (is_feature_dev_detected(binfo)) {
+		dfl_binfo_complete(binfo);
+
+		ret = build_info_commit_dev(binfo);
+		if (ret)
+			return ret;
+
+		ret = dfl_binfo_prepare(binfo, binfo->start + ofst,
+					binfo->len - ofst);
+		if (ret)
+			return ret;
+	}
+
+	v = readq(binfo->ioaddr + DFH);
 	id = FIELD_GET(DFH_ID, v);
 
 	/* create platform device for dfl feature dev */
-	ret = build_info_create_dev(binfo, dfh_id_to_type(id),
-				    dfl->ioaddr + ofst);
+	ret = build_info_create_dev(binfo, dfh_id_to_type(id));
 	if (ret)
 		return ret;
 
-	ret = create_feature_instance(binfo, dfl, ofst, 0, 0);
+	ret = create_feature_instance(binfo, 0, 0, 0);
 	if (ret)
 		return ret;
 	/*
 	 * find and parse FIU's child AFU via its NEXT_AFU register.
 	 * please note that only Port has valid NEXT_AFU pointer per spec.
 	 */
-	v = readq(dfl->ioaddr + ofst + NEXT_AFU);
+	v = readq(binfo->ioaddr + NEXT_AFU);
 
 	offset = FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
 	if (offset)
-		return parse_feature_afu(binfo, dfl, ofst + offset);
+		return parse_feature_afu(binfo, offset);
 
 	dev_dbg(binfo->dev, "No AFUs detected on FIU %d\n", id);
 
@@ -853,16 +920,15 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 }
 
 static int parse_feature_private(struct build_feature_devs_info *binfo,
-				 struct dfl_fpga_enum_dfl *dfl,
 				 resource_size_t ofst)
 {
-	if (!binfo->feature_dev) {
+	if (!is_feature_dev_detected(binfo)) {
 		dev_err(binfo->dev, "the private feature 0x%x does not belong to any AFU.\n",
-			feature_id(dfl->ioaddr + ofst));
+			feature_id(binfo->ioaddr + ofst));
 		return -EINVAL;
 	}
 
-	return create_feature_instance(binfo, dfl, ofst, 0, 0);
+	return create_feature_instance(binfo, ofst, 0, 0);
 }
 
 /**
@@ -870,24 +936,24 @@ static int parse_feature_private(struct build_feature_devs_info *binfo,
  *
  * @binfo: build feature devices information.
  * @dfl: device feature list to parse
- * @ofst: offset to feature header on this device feature list
+ * @ofst: offset to current FIU header
  */
 static int parse_feature(struct build_feature_devs_info *binfo,
-			 struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst)
+			 resource_size_t ofst)
 {
 	u64 v;
 	u32 type;
 
-	v = readq(dfl->ioaddr + ofst + DFH);
+	v = readq(binfo->ioaddr + ofst + DFH);
 	type = FIELD_GET(DFH_TYPE, v);
 
 	switch (type) {
 	case DFH_TYPE_AFU:
-		return parse_feature_afu(binfo, dfl, ofst);
+		return parse_feature_afu(binfo, ofst);
 	case DFH_TYPE_PRIVATE:
-		return parse_feature_private(binfo, dfl, ofst);
+		return parse_feature_private(binfo, ofst);
 	case DFH_TYPE_FIU:
-		return parse_feature_fiu(binfo, dfl, ofst);
+		return parse_feature_fiu(binfo, ofst);
 	default:
 		dev_info(binfo->dev,
 			 "Feature Type %x is not supported.\n", type);
@@ -897,14 +963,17 @@ static int parse_feature(struct build_feature_devs_info *binfo,
 }
 
 static int parse_feature_list(struct build_feature_devs_info *binfo,
-			      struct dfl_fpga_enum_dfl *dfl)
+			      resource_size_t start, resource_size_t len)
 {
-	void __iomem *start = dfl->ioaddr;
-	void __iomem *end = dfl->ioaddr + dfl->len;
+	resource_size_t end = start + len;
 	int ret = 0;
 	u32 ofst = 0;
 	u64 v;
 
+	ret = dfl_binfo_prepare(binfo, start, len);
+	if (ret)
+		return ret;
+
 	/* walk through the device feature list via DFH's next DFH pointer. */
 	for (; start < end; start += ofst) {
 		if (end - start < DFH_SIZE) {
@@ -912,11 +981,11 @@ static int parse_feature_list(struct build_feature_devs_info *binfo,
 			return -EINVAL;
 		}
 
-		ret = parse_feature(binfo, dfl, start - dfl->ioaddr);
+		ret = parse_feature(binfo, start - binfo->start);
 		if (ret)
 			return ret;
 
-		v = readq(start + DFH);
+		v = readq(binfo->ioaddr + start - binfo->start + DFH);
 		ofst = FIELD_GET(DFH_NEXT_HDR_OFST, v);
 
 		/* stop parsing if EOL(End of List) is set or offset is 0 */
@@ -925,7 +994,12 @@ static int parse_feature_list(struct build_feature_devs_info *binfo,
 	}
 
 	/* commit current feature device when reach the end of list */
-	return build_info_commit_dev(binfo);
+	dfl_binfo_complete(binfo);
+
+	if (is_feature_dev_detected(binfo))
+		ret = build_info_commit_dev(binfo);
+
+	return ret;
 }
 
 struct dfl_fpga_enum_info *dfl_fpga_enum_info_alloc(struct device *dev)
@@ -978,7 +1052,6 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_free);
  * @info: ptr to dfl_fpga_enum_info
  * @start: mmio resource address of the device feature list.
  * @len: mmio resource length of the device feature list.
- * @ioaddr: mapped mmio resource address of the device feature list.
  *
  * One FPGA device may have one or more Device Feature Lists (DFLs), use this
  * function to add information of each DFL to common data structure for next
@@ -987,8 +1060,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_free);
  * Return: 0 on success, negative error code otherwise.
  */
 int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
-			       resource_size_t start, resource_size_t len,
-			       void __iomem *ioaddr)
+			       resource_size_t start, resource_size_t len)
 {
 	struct dfl_fpga_enum_dfl *dfl;
 
@@ -998,7 +1070,6 @@ int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
 
 	dfl->start = start;
 	dfl->len = len;
-	dfl->ioaddr = ioaddr;
 
 	list_add_tail(&dfl->node, &info->dfls);
 
@@ -1121,7 +1192,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 	 * Lists.
 	 */
 	list_for_each_entry(dfl, &info->dfls, node) {
-		ret = parse_feature_list(binfo, dfl);
+		ret = parse_feature_list(binfo, dfl->start, dfl->len);
 		if (ret) {
 			remove_feature_devs(cdev);
 			build_info_free(binfo);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index b848e3c..704efec 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -447,22 +447,17 @@ struct dfl_fpga_enum_info {
  *
  * @start: base address of this device feature list.
  * @len: size of this device feature list.
- * @ioaddr: mapped base address of this device feature list.
  * @node: node in list of device feature lists.
  */
 struct dfl_fpga_enum_dfl {
 	resource_size_t start;
 	resource_size_t len;
-
-	void __iomem *ioaddr;
-
 	struct list_head node;
 };
 
 struct dfl_fpga_enum_info *dfl_fpga_enum_info_alloc(struct device *dev);
 int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
-			       resource_size_t start, resource_size_t len,
-			       void __iomem *ioaddr);
+			       resource_size_t start, resource_size_t len);
 int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
 			       unsigned int nr_irqs, int *irq_table);
 void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
-- 
2.7.4

