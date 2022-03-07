Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92E34D0034
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Mar 2022 14:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbiCGNg7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Mar 2022 08:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiCGNg7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Mar 2022 08:36:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35B7D028;
        Mon,  7 Mar 2022 05:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646660165; x=1678196165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=df9hhx3nOEjobhQlFbMVux41h3BAEqeI/XnvdkwhqLA=;
  b=DhbBTjo1YUb8m9GcuWDp900RTn2OrouPcf6U864WZqmdRJrF7lD2vKB4
   F4RsqC9uFh8Kf9mBT/DDN+AMtRNGM2Qr1aNR26R4uA4fEVkpOZ+QnE40d
   hcf+8FylB5gMaJjmWSGWTlVmo5H9Ytpow5RlwXAzm9droSlLAUm6CHPIA
   Z9nnjmfQNK5C5fHhQ/LHD1OUolHRkxi5gJYUDFJc/vFaTw07QtOiDNcX4
   /DA90zgNrLoNYArg68Rj5yYi5uiEQv0V9/DKol+fwLVo5KGgGZ2rPEGiG
   5IT6HGe0uxRyzu0rCAZhkyjdKhM47REbeOehRpvycch5cx6uBxpr3pEUx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254579330"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254579330"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643246963"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 05:36:02 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4 2/6] fpga: dfl: tracking port conntected with AFU
Date:   Mon,  7 Mar 2022 08:32:39 -0500
Message-Id: <20220307133243.1426300-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220307133243.1426300-1-tianfei.zhang@intel.com>
References: <20220307133243.1426300-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Introducing flags in dfl_fpga_cdev to track extensions
or new features discovered during DFL enumeration. It uses
some lowest bits of flags to track the port status which
the AFU was connected to port device or not. In legacy
model, the AFU was connected to Port device, but in "multiple
VFs per PR slot" model, the AFU or PR slot without connected
to Port device directly.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl.c | 11 ++++++++++-
 drivers/fpga/dfl.h | 12 ++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 599bb21d86af..712c53363fda 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1124,8 +1124,10 @@ static void build_info_complete(struct build_feature_devs_info *binfo)
 static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 			     resource_size_t ofst)
 {
+	struct dfl_fpga_cdev *cdev = binfo->cdev;
 	int ret = 0;
 	u32 offset;
+	u32 port;
 	u16 id;
 	u64 v;
 
@@ -1160,8 +1162,15 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 	v = readq(binfo->ioaddr + NEXT_AFU);
 
 	offset = FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
-	if (offset)
+	if (offset) {
+		if (dfh_id_to_type(id) == PORT_ID) {
+			port = FIELD_GET(PORT_CAP_PORT_NUM,
+					 readq(binfo->ioaddr + PORT_HDR_CAP));
+			cdev->flags |= dfl_feat_port_connect_afu(port);
+		}
+
 		return parse_feature_afu(binfo, offset);
+	}
 
 	dev_dbg(binfo->dev, "No AFUs detected on FIU %d\n", id);
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 1fd493e82dd8..bc56b7e8c01b 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -461,6 +461,16 @@ int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
 			       unsigned int nr_irqs, int *irq_table);
 void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
 
+/*
+ * Bitfields in flags of dfl_fpga_cdev.
+ *
+ * 0 - (DFL_PORT_CONNECT_BITS -1): AFU was connected with Port device.
+ * DFL_PORT_CONNECT_BITS - 63: reserved.
+ */
+#define dfl_feat_port_connect_afu(port) (BIT_ULL(port))
+#define DFL_PORT_CONNECT_BITS  MAX_DFL_FPGA_PORT_NUM
+#define DFL_FEAT_PORT_CONNECT_MASK ((1UL << (DFL_PORT_CONNECT_BITS)) - 1)
+
 /**
  * struct dfl_fpga_cdev - container device of DFL based FPGA
  *
@@ -470,6 +480,7 @@ void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
  * @lock: mutex lock to protect the port device list.
  * @port_dev_list: list of all port feature devices under this container device.
  * @released_port_num: released port number under this container device.
+ * @flags: extensions discovered during DFL enumeration.
  */
 struct dfl_fpga_cdev {
 	struct device *parent;
@@ -478,6 +489,7 @@ struct dfl_fpga_cdev {
 	struct mutex lock;
 	struct list_head port_dev_list;
 	int released_port_num;
+	u64 flags;
 };
 
 struct dfl_fpga_cdev *
-- 
2.26.2

