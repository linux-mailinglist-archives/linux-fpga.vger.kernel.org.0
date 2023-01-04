Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C966665E0F6
	for <lists+linux-fpga@lfdr.de>; Thu,  5 Jan 2023 00:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjADXWb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Jan 2023 18:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjADXW0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Jan 2023 18:22:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709253C38E;
        Wed,  4 Jan 2023 15:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672874545; x=1704410545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCgfauidajrv9/cEqYwEKvd7v3XpG9nxGIkGfvqWclg=;
  b=Tzt+6KvMl7wCUkK4fBm+W/Z9vaEnJWbYZyvROOPVVzQbtYJ1NMWPSplP
   CnwpUvV0vNa1kgjT4aVIuO8L2BntVBDCtaN0/vBkG44jot0kqzKRcghCf
   osK/LoH0fz5p+ADBPGNuoIKGjW/ZwXWuBh+EXK1M1BQ4NUZdSMXpwx1t6
   lDU5peRt8bH+qfYxma7JL6ZWkLnj3585/6VlQ5r50Ia32BI9MMlxa2R/P
   2T4ljNcToqf64Ld1bV0TonWfXtUqaxMhPDRHu9p0VjfbTRbBqQdWFt5bk
   Pji5gql28sbrFxK6QIWxhd8YMHmLEVPk2tDaz4QcScOF//G21FOUIsotb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301762143"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="301762143"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:22:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900739376"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="900739376"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:22:23 -0800
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v9 3/4] fpga: dfl: add basic support for DFHv1
Date:   Wed,  4 Jan 2023 15:22:52 -0800
Message-Id: <20230104232253.24743-4-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104232253.24743-1-matthew.gerlach@linux.intel.com>
References: <20230104232253.24743-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Version 1 of the Device Feature Header (DFH) definition adds
functionality to the Device Feature List (DFL) bus.

A DFHv1 header may have one or more parameter blocks that
further describes the HW to SW. Add support to the DFL bus
to parse the MSI-X parameter.

The location of a feature's register set is explicitly
described in DFHv1 and can be relative to the base of the DFHv1
or an absolute address. Parse the location and pass the information
to DFL driver.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v9: fix spacing errors in commit message and code
    s/dfh_get_psize/dfh_get_param_size/
    put new structure members at the end of the stucture
    update dfh_find_param API
    remove dfh_get_u64_param_vals

v8: use struct_size() from overflow.h
    add dfh_get_u64_param_vals()

v7: no change

v6: move MSI_X parameter definitions to drivers/fpga/dfl.h

v5: update field names
    fix find_param/dfh_get_psize
    clean up mmio_res assignments
    use u64* instead of void*
    use FIELD_GET instead of masking

v4: s/MSIX/MSI_X
    move kernel doc to implementation
    use structure assignment
    fix decode of absolute address
    clean up comment in parse_feature_irqs
    remove use of csr_res

v3: remove unneeded blank line
    use clearer variable name
    pass finfo into parse_feature_irqs()
    refactor code for better indentation
    use switch statement for irq parsing
    squash in code parsing register location

v2: fix kernel doc
    clarify use of DFH_VERSION field
---
 drivers/fpga/dfl.c  | 245 +++++++++++++++++++++++++++++++++++---------
 drivers/fpga/dfl.h  |  11 ++
 include/linux/dfl.h |   8 ++
 3 files changed, 213 insertions(+), 51 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b9aae85ba930..dd387cf72edc 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -13,6 +13,7 @@
 #include <linux/dfl.h>
 #include <linux/fpga-dfl.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/uaccess.h>
 
 #include "dfl.h"
@@ -342,6 +343,8 @@ static void release_dfl_dev(struct device *dev)
 	if (ddev->mmio_res.parent)
 		release_resource(&ddev->mmio_res);
 
+	kfree(ddev->params);
+
 	ida_free(&dfl_device_ida, ddev->id);
 	kfree(ddev->irqs);
 	kfree(ddev);
@@ -380,7 +383,16 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
 	ddev->type = feature_dev_id_type(pdev);
 	ddev->feature_id = feature->id;
 	ddev->revision = feature->revision;
+	ddev->dfh_version = feature->dfh_version;
 	ddev->cdev = pdata->dfl_cdev;
+	if (feature->param_size) {
+		ddev->params = kmemdup(feature->params, feature->param_size, GFP_KERNEL);
+		if (!ddev->params) {
+			ret = -ENOMEM;
+			goto put_dev;
+		}
+		ddev->param_size = feature->param_size;
+	}
 
 	/* add mmio resource */
 	parent_res = &pdev->resource[feature->resource_index];
@@ -708,20 +720,27 @@ struct build_feature_devs_info {
  * struct dfl_feature_info - sub feature info collected during feature dev build
  *
  * @fid: id of this sub feature.
+ * @revision: revision of this sub feature
+ * @dfh_version: version of Device Feature Header (DFH)
  * @mmio_res: mmio resource of this sub feature.
  * @ioaddr: mapped base address of mmio resource.
  * @node: node in sub_features linked list.
  * @irq_base: start of irq index in this sub feature.
  * @nr_irqs: number of irqs of this sub feature.
+ * @param_size: size DFH parameters.
+ * @params: DFH parameter data.
  */
 struct dfl_feature_info {
 	u16 fid;
 	u8 revision;
+	u8 dfh_version;
 	struct resource mmio_res;
 	void __iomem *ioaddr;
 	struct list_head node;
 	unsigned int irq_base;
 	unsigned int nr_irqs;
+	unsigned int param_size;
+	u64 params[];
 };
 
 static void dfl_fpga_cdev_add_port_dev(struct dfl_fpga_cdev *cdev,
@@ -797,7 +816,17 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 		feature->dev = fdev;
 		feature->id = finfo->fid;
 		feature->revision = finfo->revision;
+		feature->dfh_version = finfo->dfh_version;
 
+		if (finfo->param_size) {
+			feature->params = devm_kmemdup(binfo->dev,
+						       finfo->params, finfo->param_size,
+						       GFP_KERNEL);
+			if (!feature->params)
+				return -ENOMEM;
+
+			feature->param_size = finfo->param_size;
+		}
 		/*
 		 * the FIU header feature has some fundamental functions (sriov
 		 * set, port enable/disable) needed for the dfl bus device and
@@ -934,56 +963,115 @@ static u16 feature_id(u64 value)
 	return 0;
 }
 
+static u64 *find_param(u64 *params, resource_size_t max, int param_id)
+{
+	u64 *end = params + max / sizeof(u64);
+	u64 v, next;
+
+	while (params < end) {
+		v = *params;
+		if (param_id == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
+			return params;
+
+		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
+			break;
+
+		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
+		params += next;
+	}
+
+	return NULL;
+}
+
+/**
+ * dfh_find_param() - find parameter block for the given parameter id
+ * @dfl_dev: dfl device
+ * @param_id: id of dfl parameter
+ * @pcount: destination to store size of parameter data in u64 bit words
+ *
+ * Return: pointer to start of parameter data, PTR_ERR otherwise.
+ */
+void *dfh_find_param(struct dfl_device *dfl_dev, int param_id, size_t *pcount)
+{
+	u64 *phdr = find_param(dfl_dev->params, dfl_dev->param_size, param_id);
+
+	if (!phdr)
+		return ERR_PTR(-ENOENT);
+
+	if (pcount)
+		*pcount = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, *phdr) - 1;
+
+	return phdr + 1;
+}
+EXPORT_SYMBOL_GPL(dfh_find_param);
+
 static int parse_feature_irqs(struct build_feature_devs_info *binfo,
-			      resource_size_t ofst, u16 fid,
-			      unsigned int *irq_base, unsigned int *nr_irqs)
+			      resource_size_t ofst, struct dfl_feature_info *finfo)
 {
 	void __iomem *base = binfo->ioaddr + ofst;
 	unsigned int i, ibase, inr = 0;
+	void *params = finfo->params;
 	enum dfl_id_type type;
+	u16 fid = finfo->fid;
 	int virq;
+	u64 *p;
 	u64 v;
 
-	type = feature_dev_id_type(binfo->feature_dev);
+	switch (finfo->dfh_version) {
+	case 0:
+		/*
+		 * DFHv0 only provides MMIO resource information for each feature
+		 * in the DFL header.  There is no generic interrupt information.
+		 * Instead, features with interrupt functionality provide
+		 * the information in feature specific registers.
+		 */
+		type = feature_dev_id_type(binfo->feature_dev);
+		if (type == PORT_ID) {
+			switch (fid) {
+			case PORT_FEATURE_ID_UINT:
+				v = readq(base + PORT_UINT_CAP);
+				ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
+				inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
+				break;
+			case PORT_FEATURE_ID_ERROR:
+				v = readq(base + PORT_ERROR_CAP);
+				ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
+				inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
+				break;
+			}
+		} else if (type == FME_ID) {
+			switch (fid) {
+			case FME_FEATURE_ID_GLOBAL_ERR:
+				v = readq(base + FME_ERROR_CAP);
+				ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
+				inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
+				break;
+			}
+		}
+		break;
 
-	/*
-	 * Ideally DFL framework should only read info from DFL header, but
-	 * current version DFL only provides mmio resources information for
-	 * each feature in DFL Header, no field for interrupt resources.
-	 * Interrupt resource information is provided by specific mmio
-	 * registers of each private feature which supports interrupt. So in
-	 * order to parse and assign irq resources, DFL framework has to look
-	 * into specific capability registers of these private features.
-	 *
-	 * Once future DFL version supports generic interrupt resource
-	 * information in common DFL headers, the generic interrupt parsing
-	 * code will be added. But in order to be compatible to old version
-	 * DFL, the driver may still fall back to these quirks.
-	 */
-	if (type == PORT_ID) {
-		switch (fid) {
-		case PORT_FEATURE_ID_UINT:
-			v = readq(base + PORT_UINT_CAP);
-			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
-			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
-			break;
-		case PORT_FEATURE_ID_ERROR:
-			v = readq(base + PORT_ERROR_CAP);
-			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
-			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
+	case 1:
+		/*
+		 * DFHv1 provides interrupt resource information in DFHv1
+		 * parameter blocks.
+		 */
+		p = find_param(params, finfo->param_size, DFHv1_PARAM_ID_MSI_X);
+		if (!p)
 			break;
-		}
-	} else if (type == FME_ID) {
-		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
-			v = readq(base + FME_ERROR_CAP);
-			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
-			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
-		}
+
+		p++;
+		ibase = FIELD_GET(DFHv1_PARAM_MSI_X_STARTV, *p);
+		inr = FIELD_GET(DFHv1_PARAM_MSI_X_NUMV, *p);
+		break;
+
+	default:
+		dev_warn(binfo->dev, "unexpected DFH version %d\n", finfo->dfh_version);
+		break;
 	}
 
 	if (!inr) {
-		*irq_base = 0;
-		*nr_irqs = 0;
+		finfo->irq_base = 0;
+		finfo->nr_irqs = 0;
 		return 0;
 	}
 
@@ -1006,12 +1094,37 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 		}
 	}
 
-	*irq_base = ibase;
-	*nr_irqs = inr;
+	finfo->irq_base = ibase;
+	finfo->nr_irqs = inr;
 
 	return 0;
 }
 
+static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
+{
+	int size = 0;
+	u64 v, next;
+
+	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS,
+		       readq(dfh_base + DFHv1_CSR_SIZE_GRP)))
+		return 0;
+
+	while (size + DFHv1_PARAM_HDR < max) {
+		v = readq(dfh_base + DFHv1_PARAM_HDR + size);
+
+		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
+		if (!next)
+			return -EINVAL;
+
+		size += next * sizeof(u64);
+
+		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
+			return size;
+	}
+
+	return -ENOENT;
+}
+
 /*
  * when create sub feature instances, for private features, it doesn't need
  * to provide resource size and feature id as they could be read from DFH
@@ -1023,39 +1136,69 @@ static int
 create_feature_instance(struct build_feature_devs_info *binfo,
 			resource_size_t ofst, resource_size_t size, u16 fid)
 {
-	unsigned int irq_base, nr_irqs;
 	struct dfl_feature_info *finfo;
+	resource_size_t start, end;
+	int dfh_psize = 0;
 	u8 revision = 0;
+	u64 v, addr_off;
+	u8 dfh_ver = 0;
 	int ret;
-	u64 v;
 
 	if (fid != FEATURE_ID_AFU) {
 		v = readq(binfo->ioaddr + ofst);
 		revision = FIELD_GET(DFH_REVISION, v);
-
+		dfh_ver = FIELD_GET(DFH_VERSION, v);
 		/* read feature size and id if inputs are invalid */
 		size = size ? size : feature_size(v);
 		fid = fid ? fid : feature_id(v);
+		if (dfh_ver == 1) {
+			dfh_psize = dfh_get_param_size(binfo->ioaddr + ofst, size);
+			if (dfh_psize < 0) {
+				dev_err(binfo->dev,
+					"failed to read size of DFHv1 parameters %d\n",
+					dfh_psize);
+				return dfh_psize;
+			}
+			dev_dbg(binfo->dev, "dfhv1_psize %d\n", dfh_psize);
+		}
 	}
 
 	if (binfo->len - ofst < size)
 		return -EINVAL;
 
-	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
-	if (ret)
-		return ret;
-
-	finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
+	finfo = kzalloc(struct_size(finfo, params, dfh_psize / sizeof(u64)), GFP_KERNEL);
 	if (!finfo)
 		return -ENOMEM;
 
+	memcpy_fromio(finfo->params, binfo->ioaddr + ofst + DFHv1_PARAM_HDR, dfh_psize);
+	finfo->param_size = dfh_psize;
+
 	finfo->fid = fid;
 	finfo->revision = revision;
-	finfo->mmio_res.start = binfo->start + ofst;
-	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
+	finfo->dfh_version = dfh_ver;
+	if (dfh_ver == 1) {
+		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
+		addr_off = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
+		if (FIELD_GET(DFHv1_CSR_ADDR_REL, v))
+			start = addr_off << 1;
+		else
+			start = binfo->start + ofst + addr_off;
+
+		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
+		end = start + FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;
+	} else {
+		start = binfo->start + ofst;
+		end = start + size - 1;
+	}
 	finfo->mmio_res.flags = IORESOURCE_MEM;
-	finfo->irq_base = irq_base;
-	finfo->nr_irqs = nr_irqs;
+	finfo->mmio_res.start = start;
+	finfo->mmio_res.end = end;
+
+	ret = parse_feature_irqs(binfo, ofst, finfo);
+	if (ret) {
+		kfree(finfo);
+		return ret;
+	}
 
 	list_add_tail(&finfo->node, &binfo->sub_features);
 	binfo->feature_num++;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index fc59f33367ee..20eaddce6988 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -111,6 +111,10 @@
 #define DFHv1_PARAM_HDR_NEXT_EOP	BIT_ULL(32)
 #define DFHv1_PARAM_DATA		0x08  /* Offset of Param data from Param header */
 
+#define DFHv1_PARAM_ID_MSI_X		0x1
+#define DFHv1_PARAM_MSI_X_NUMV		GENMASK_ULL(63, 32)
+#define DFHv1_PARAM_MSI_X_STARTV	GENMASK_ULL(31, 0)
+
 /* Next AFU Register Bitfield */
 #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
 
@@ -263,6 +267,7 @@ struct dfl_feature_irq_ctx {
  *
  * @dev: ptr to pdev of the feature device which has the sub feature.
  * @id: sub feature id.
+ * @revision: revisition of the instance of a feature.
  * @resource_index: each sub feature has one mmio resource for its registers.
  *		    this index is used to find its mmio resource from the
  *		    feature dev (platform device)'s resources.
@@ -272,6 +277,9 @@ struct dfl_feature_irq_ctx {
  * @ops: ops of this sub feature.
  * @ddev: ptr to the dfl device of this sub feature.
  * @priv: priv data of this feature.
+ * @dfh_version: version of the DFH
+ * @param_size: size of dfh parameters
+ * @params: point to memory copy of dfh parameters
  */
 struct dfl_feature {
 	struct platform_device *dev;
@@ -284,6 +292,9 @@ struct dfl_feature {
 	const struct dfl_feature_ops *ops;
 	struct dfl_device *ddev;
 	void *priv;
+	u8 dfh_version;
+	unsigned int param_size;
+	void *params;
 };
 
 #define FEATURE_DEV_ID_UNUSED	(-1)
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 431636a0dc78..0a7a00a0ee7f 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -27,11 +27,15 @@ enum dfl_id_type {
  * @id: id of the dfl device.
  * @type: type of DFL FIU of the device. See enum dfl_id_type.
  * @feature_id: feature identifier local to its DFL FIU type.
+ * @revision: revision of this dfl device feature.
  * @mmio_res: mmio resource of this dfl device.
  * @irqs: list of Linux IRQ numbers of this dfl device.
  * @num_irqs: number of IRQs supported by this dfl device.
  * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
  * @id_entry: matched id entry in dfl driver's id table.
+ * @dfh_version: version of DFH for the device
+ * @param_size: size of the block parameters in bytes
+ * @params: pointer to block of parameters copied memory
  */
 struct dfl_device {
 	struct device dev;
@@ -44,6 +48,9 @@ struct dfl_device {
 	unsigned int num_irqs;
 	struct dfl_fpga_cdev *cdev;
 	const struct dfl_device_id *id_entry;
+	u8 dfh_version;
+	unsigned int param_size;
+	void *params;
 };
 
 /**
@@ -84,4 +91,5 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
 	module_driver(__dfl_driver, dfl_driver_register, \
 		      dfl_driver_unregister)
 
+void *dfh_find_param(struct dfl_device *dfl_dev, int param_id, size_t *pcount);
 #endif /* __LINUX_DFL_H */
-- 
2.25.1

