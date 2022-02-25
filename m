Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16B84C3C42
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Feb 2022 04:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiBYDNz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Feb 2022 22:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbiBYDNu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Feb 2022 22:13:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB047DA91;
        Thu, 24 Feb 2022 19:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645758798; x=1677294798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdPQ6SeVdfaExi695kgdsiaNjw0SiA/pAv18ILKo/QM=;
  b=DMgGq/JzrK3Nq7ONjagHmKCGNUQCMwZoVzK3sNZ5FG88gMQqAvIEqfFX
   FgOE76eVlghnmQefikgXPkcfYhfD9R8kTQSZpTcQ4hQK7QzNKguszoLQ5
   fjwBmR6fk9uA/xGKvCT1Yxj93rD1i7pHi8vX9fyYoYNI+IWvr2CDrJqZ2
   ZP0vFzYCxdjfeE0CDVUHRyVXmTMsS0w0eUNLsAWFmjsO5QNco7PknQ60a
   W4srsR00e5nyYKYlsZJPTvYpSlEjuBggVfofnJLQ/dPHpCSAwiUj19dsY
   nJTvZGq6SLkhEJKLpepDFLDDHC5A/MYdIn/q4jGfjmkm8OVroyHcMNm5I
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252602990"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="252602990"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:13:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="684512463"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 19:13:16 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2 2/5] fpga: dfl: add features in dfl_fpga_cdev
Date:   Thu, 24 Feb 2022 22:09:59 -0500
Message-Id: <20220225031002.261264-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220225031002.261264-1-tianfei.zhang@intel.com>
References: <20220225031002.261264-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Introducing features in dfl_fpga_cdev during DFL enumeration.
On IOFS, we will add more extensions or features in DFL in
future, so adding a new member "features"in dfl_fpga_cdev.
For example, in the legacy model, the AFU was connected to
Port device, but in "multiple VFs per PR slot" model, the
AFU or PR slot without connected to Port device directly,
so in this model, we only can access the resource of AFU
or PR slot via VFs. In this patch, we introducing a new
flags DFL_FEAT_PORT_CONNECTED_AFU to distinguish them.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl.c | 6 +++++-
 drivers/fpga/dfl.h | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 6bff39ff21a0..9b7a01a4af04 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1130,6 +1130,7 @@ static void build_info_complete(struct build_feature_devs_info *binfo)
 static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 			     resource_size_t ofst)
 {
+	struct dfl_fpga_cdev *cdev = binfo->cdev;
 	int ret = 0;
 	u32 offset;
 	u16 id;
@@ -1166,8 +1167,11 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 	v = readq(binfo->ioaddr + NEXT_AFU);
 
 	offset = FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
-	if (offset)
+	if (offset) {
+		if (dfh_id_to_type(id) == PORT_ID)
+			cdev->features |= DFL_FEAT_PORT_CONNECTED_AFU;
 		return parse_feature_afu(binfo, offset);
+	}
 
 	dev_dbg(binfo->dev, "No AFUs detected on FIU %d\n", id);
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 1fd493e82dd8..6171bcdcb3c5 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -461,6 +461,9 @@ int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
 			       unsigned int nr_irqs, int *irq_table);
 void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
 
+/* in legacy model, the AFU was connected to Port device */
+#define DFL_FEAT_PORT_CONNECTED_AFU  BIT_ULL(0)
+
 /**
  * struct dfl_fpga_cdev - container device of DFL based FPGA
  *
@@ -470,6 +473,7 @@ void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
  * @lock: mutex lock to protect the port device list.
  * @port_dev_list: list of all port feature devices under this container device.
  * @released_port_num: released port number under this container device.
+ * @features: features discovered during DFL enumeration.
  */
 struct dfl_fpga_cdev {
 	struct device *parent;
@@ -478,6 +482,7 @@ struct dfl_fpga_cdev {
 	struct mutex lock;
 	struct list_head port_dev_list;
 	int released_port_num;
+	u64 features;
 };
 
 struct dfl_fpga_cdev *
-- 
2.26.2

