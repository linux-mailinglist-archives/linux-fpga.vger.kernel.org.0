Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA074D74CF
	for <lists+linux-fpga@lfdr.de>; Sun, 13 Mar 2022 12:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiCMK7o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Mar 2022 06:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiCMK62 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Mar 2022 06:58:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1BA16BF99;
        Sun, 13 Mar 2022 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647169034; x=1678705034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNEHzIzl+3Pg6vc6AYrfG7XUrVFpkOgvAAuyODOWHoM=;
  b=Mxl1+Elp+zDF3YuelqbvrDoItg8+c45OUb3uqtMghtWP4dRYFxHJMCA5
   JtBgeJdNMI7FuDEaJqpEmGOBwzqtfCbrAC9gBcth5X1iCGgPDYXHwYiCR
   ZcOT7VZuGlRU5fxaqfGXx+7p7U9bh3z2ZYi9Xcahmp3XkOe0Y/pJ9bDgR
   CtoQnCUlnpGfw0u72ZeT0JCX9K0BCRUC4n1YwHFko4ZDHE23FkdhrFikg
   D+XvpM4Z9l/Mvtgn6vbn2d4Vo/oE3UQRXEQZfbymRhg0dtdFv8tG8zoZC
   OmjA4lxFPd07KmLItSHfOLb1W+QyXCq5W9i4dUeimJOkFHZ/Qwhxz1ISF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="319086328"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="319086328"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 03:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713380323"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 03:56:04 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v5 2/6] fpga: dfl: tracking port conntected with AFU
Date:   Sun, 13 Mar 2022 06:52:38 -0400
Message-Id: <20220313105242.1567774-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220313105242.1567774-1-tianfei.zhang@intel.com>
References: <20220313105242.1567774-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

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

