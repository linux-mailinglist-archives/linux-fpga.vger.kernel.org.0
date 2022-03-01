Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC94C83FD
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 07:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiCAGZh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 01:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiCAGZb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 01:25:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA0D70875;
        Mon, 28 Feb 2022 22:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646115890; x=1677651890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F0E2/5Hvi1dKlgzTz/LMJ5M0zuY2mwCJOJpe1sFOdKg=;
  b=UJIHUXGiBOyGt0yvacdjD0BcpMhA4X2c+K3LIEjnNUoKV7qVUbWiFvfX
   Ip4fOs39Upj75I/rmedK/wIbW18v64nniNZXZfp4YzeN781jWULS8vryO
   rzMbud8Ee558k45nc2xGjqSxX50HPjxoLypWzoSf8Q0lWMGjsXfzBABzJ
   PZIZZ/w4hBAqGTmk75Yop0wdreoBdlvLDtOIN3sHtSnoDbwSSpY8eGo8Z
   XU0xj2lNLZnd8RTYeXHxwP01OvMrCiIOJr2nXcHqBuBvdclEZoWNtyje8
   NNIiZaI16OJU/hOfgXiXhLP998aTlJjM+qzW0RyaJaHt94kHFPD8sWZIl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251900313"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="251900313"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:24:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="708941753"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 22:24:39 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3 2/5] fpga: dfl: add features in dfl_fpga_cdev
Date:   Tue,  1 Mar 2022 01:21:20 -0500
Message-Id: <20220301062123.818687-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220301062123.818687-1-tianfei.zhang@intel.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Introducing features in dfl_fpga_cdev during DFL enumeration.
On OFS, we will add more extensions or features in DFL in
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
index 599bb21d86af..5872031c2e9f 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1124,6 +1124,7 @@ static void build_info_complete(struct build_feature_devs_info *binfo)
 static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 			     resource_size_t ofst)
 {
+	struct dfl_fpga_cdev *cdev = binfo->cdev;
 	int ret = 0;
 	u32 offset;
 	u16 id;
@@ -1160,8 +1161,11 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
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

