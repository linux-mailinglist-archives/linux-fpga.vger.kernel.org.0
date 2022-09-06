Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7094F5AF42B
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Sep 2022 21:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIFTEe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Sep 2022 15:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiIFTEa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Sep 2022 15:04:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFDA6146;
        Tue,  6 Sep 2022 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662491065; x=1694027065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ICHPytA3pO1SwHmblkHrU9c7giwKu6jTGgG0MhX7gT0=;
  b=MtbNYrgRUd2hSeawg8wOIPwwkhSZe6o65izj/vwR4GTpK0XkQP0k0PC7
   9DE8FVsgq3a7GLeA3Y5PR1yhV4uLdQNYN1Cx3ZAn61b0icprfYZpyozih
   mBIZKKiRt57+1nBIabrADQDJMFf4cyDHQe5RkxXRSqWBgcy0B4S9aWW8U
   9tnnA9LrokrDmOHPZ+nPhYYDVe5w+ozq1nHKjnklYLHkon+RA0FCpYU0T
   ZKlZc0ljs9FwxPFT+VtzcLhMNi4jqZt4io2g9iTlJllJs7+kE/O0RNjRZ
   gxDfZgjM6qSK3vIdfZ9C6TioSx0C2egX27rGooCR21b5pi/OBvzDY+NWu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283677339"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283677339"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="789782551"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v1 4/5] fpga: dfl: add generic support for MSIX interrupts
Date:   Tue,  6 Sep 2022 12:04:25 -0700
Message-Id: <20220906190426.3139760-5-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Define and use a DFHv1 parameter to add generic support for MSIX
interrupts for DFL devices.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl.c  | 59 +++++++++++++++++++++++++++++++++------------
 include/linux/dfl.h | 13 ++++++++++
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b9aae85ba930..17f704dc8483 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -941,25 +941,11 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 	void __iomem *base = binfo->ioaddr + ofst;
 	unsigned int i, ibase, inr = 0;
 	enum dfl_id_type type;
-	int virq;
+	int virq, off;
 	u64 v;
 
 	type = feature_dev_id_type(binfo->feature_dev);
 
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
 	if (type == PORT_ID) {
 		switch (fid) {
 		case PORT_FEATURE_ID_UINT:
@@ -981,6 +967,28 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 		}
 	}
 
+	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
+	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
+		v = readq(base);
+		v = FIELD_GET(DFH_VERSION, v);
+
+		if (v == 1) {
+			v =  readq(base + DFHv1_CSR_SIZE_GRP);
+			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
+				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
+						     DFHv1_PARAM_ID_MSIX);
+				if (off >= 0) {
+					ibase = readl(base + DFHv1_PARAM_HDR +
+						      off + DFHv1_PARAM_MSIX_STARTV);
+					inr = readl(base + DFHv1_PARAM_HDR +
+						    off + DFHv1_PARAM_MSIX_NUMV);
+					dev_dbg(binfo->dev, "%s start %d num %d fid 0x%x\n",
+						__func__, ibase, inr, fid);
+				}
+			}
+		}
+	}
+
 	if (!inr) {
 		*irq_base = 0;
 		*nr_irqs = 0;
@@ -1879,6 +1887,27 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(dfl_feature_ioctl_set_irq);
 
+int dfl_find_param(void __iomem *base, resource_size_t max, int param)
+{
+	int off = 0;
+	u64 v, next;
+
+	while (off < max) {
+		v = readq(base + off);
+		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
+			return off;
+
+		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
+		if (!next)
+			break;
+
+		off += next;
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(dfl_find_param);
+
 static void __exit dfl_fpga_exit(void)
 {
 	dfl_chardev_uinit();
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 61bcf20c1bc8..5652879ab48e 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -69,6 +69,10 @@
 #define DFHv1_PARAM_HDR_VERSION		GENMASK_ULL(31, 16) /* Version Param */
 #define DFHv1_PARAM_HDR_NEXT_OFFSET	GENMASK_ULL(63, 32) /* Offset of next Param */
 
+#define DFHv1_PARAM_ID_MSIX	0x1
+#define DFHv1_PARAM_MSIX_STARTV	0x8
+#define DFHv1_PARAM_MSIX_NUMV	0xc
+
 /**
  * enum dfl_id_type - define the DFL FIU types
  */
@@ -142,4 +146,13 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
 	module_driver(__dfl_driver, dfl_driver_register, \
 		      dfl_driver_unregister)
 
+/*
+ * dfl_find_param() - find the offset of the given parameter
+ * @base: base pointer to start of dfl parameters in DFH
+ * @max: maximum offset to search
+ * @param: id of dfl parameter
+ *
+ * Return: positive offset on success, negative error code otherwise.
+ */
+int dfl_find_param(void __iomem *base, resource_size_t max, int param);
 #endif /* __LINUX_DFL_H */
-- 
2.25.1

