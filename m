Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671E74DABA5
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Mar 2022 08:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbiCPHNL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 03:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354231AbiCPHMz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 03:12:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C09A5DE54;
        Wed, 16 Mar 2022 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647414702; x=1678950702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BbcJfJHFs7h3DBzP//dTgYkN4sqD2gOtwRAt4y/7sbQ=;
  b=ISA3UHjm0e4IDet9v7Q7ALfvOPkAdmXpCWfFQBxCUngtvv7m3QTT0qy1
   +6w/qWQ/7xtroFC8PPIIABNhJ/xXrrc/NSAsQDdsc7+8mLaOHyy67W5tT
   P8luulIQRAJ4kzlhzy2Z1dyWF0EIKVg05mUjO3UdxVGBZw0WBAmUfuA66
   gILqDZ8vFgunbsDTsE4vGt065XU7sB1oPGW767Vpib9/QvSPRxMOPfNIN
   obEfxbgf3UUvA9dr9E9ryNecTVpM4Z3M2Rr9FyAzZY+91V5ssDgla6jU4
   JB4HZ6miSxQKa1DAAOFZnsH1Fza2BUJNPHFoke8d36U703TRcd2XMqjOL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281289028"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281289028"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646538338"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 00:11:38 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v6 2/6] fpga: dfl: tracking port conntected with AFU
Date:   Wed, 16 Mar 2022 03:08:10 -0400
Message-Id: <20220316070814.1916017-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220316070814.1916017-1-tianfei.zhang@intel.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
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

