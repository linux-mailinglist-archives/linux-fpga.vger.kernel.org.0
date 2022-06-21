Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB4553258
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349291AbiFUMmb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350512AbiFUMma (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 08:42:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4D029802;
        Tue, 21 Jun 2022 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655815349; x=1687351349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B5CMJ7yoq4UuraH9/OxxfGuGPXrbCc4PcL00oM5amPk=;
  b=HHSz4LY8TJ1eQyxwuJ0cEHl9ojBIF0X6HfcACWolIXmSoM/CqC8VN87e
   1eHVrS11j2w0mQuTc+FndotV15/TGNCqeRsEYJXUJZSfdVgKkcwEs3W8u
   o4tmnbh2eKjUaxUhcm71u1IZHz7LUD/BdEbciWMfapAzWsQPgY2rST5PI
   cXESdwjYa5IlT7jhrakLby/eBMde/uUGcJ/jpkZMcknq85+Ewg2Zglsq5
   vNEMp52n2Q7GJLfPrazzxnXLmF5Kk9j9w3blCQHCLQERhey+tL4/8NLfm
   RW5F5qbYqxSQ3SQqBQ+El9kD7sLGr16WkgmhQkG+LWlz0x7ewUA52LO4f
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341791822"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341791822"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="643607352"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 05:42:26 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     ssantosh@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     trix@redhat.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com,
        Debarati Biswas <debaratix.biswas@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1] memory: dfl-emif: Update the dfl emif driver support revision 1
Date:   Tue, 21 Jun 2022 08:38:54 -0400
Message-Id: <20220621123854.8686-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Debarati Biswas <debaratix.biswas@intel.com>

The next generation (revision 1) of the DFL EMIF feature device requires
support for more than 4 memory banks. It does not support the selective
clearing of memory banks. A capability register replaces the previous
control register, and contains a bitmask to indicate the presence of each
memory bank. This bitmask aligns with the previous control register
bitmask that served the same purpose. The control and capability
registers are treated like a C Union structure in order to support both
the new and old revisions of the EMIF device.

Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/memory/dfl-emif.c | 62 +++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/dfl-emif.c b/drivers/memory/dfl-emif.c
index 3f719816771d..da06cd30a016 100644
--- a/drivers/memory/dfl-emif.c
+++ b/drivers/memory/dfl-emif.c
@@ -24,11 +24,24 @@
 #define EMIF_STAT_CLEAR_BUSY_SFT	16
 #define EMIF_CTRL			0x10
 #define EMIF_CTRL_CLEAR_EN_SFT		0
-#define EMIF_CTRL_CLEAR_EN_MSK		GENMASK_ULL(3, 0)
+#define EMIF_CTRL_CLEAR_EN_MSK		GENMASK_ULL(7, 0)
 
 #define EMIF_POLL_INVL			10000 /* us */
 #define EMIF_POLL_TIMEOUT		5000000 /* us */
 
+/*
+ * The Capability Register replaces the Control Register (at the same
+ * offset) for EMIF feature revisions > 0. The bitmask that indicates
+ * the presence of memory channels exists in both the Capability Register
+ * and Control Register definitions. These can be thought of as a C union.
+ * The Capability Register definitions are used to check for the existence
+ * of a memory channel, and the Control Register definitions are used for
+ * managing the memory-clear functionality in revision 0.
+ */
+#define EMIF_CAPABILITY_BASE		0x10
+#define EMIF_CAPABILITY_CHN_MSK_V0	GENMASK_ULL(3, 0)
+#define EMIF_CAPABILITY_CHN_MSK		GENMASK_ULL(7, 0)
+
 struct dfl_emif {
 	struct device *dev;
 	void __iomem *base;
@@ -106,16 +119,30 @@ emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 0);
 emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 1);
 emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 2);
 emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 3);
+emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 4);
+emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 5);
+emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 6);
+emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 7);
 
 emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 0);
 emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 1);
 emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 2);
 emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 3);
+emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 4);
+emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 5);
+emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 6);
+emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 7);
+
 
 emif_clear_attr(0);
 emif_clear_attr(1);
 emif_clear_attr(2);
 emif_clear_attr(3);
+emif_clear_attr(4);
+emif_clear_attr(5);
+emif_clear_attr(6);
+emif_clear_attr(7);
+
 
 static struct attribute *dfl_emif_attrs[] = {
 	&emif_attr_inf0_init_done.attr.attr,
@@ -134,6 +161,22 @@ static struct attribute *dfl_emif_attrs[] = {
 	&emif_attr_inf3_cal_fail.attr.attr,
 	&emif_attr_inf3_clear.attr.attr,
 
+	&emif_attr_inf4_init_done.attr.attr,
+	&emif_attr_inf4_cal_fail.attr.attr,
+	&emif_attr_inf4_clear.attr.attr,
+
+	&emif_attr_inf5_init_done.attr.attr,
+	&emif_attr_inf5_cal_fail.attr.attr,
+	&emif_attr_inf5_clear.attr.attr,
+
+	&emif_attr_inf6_init_done.attr.attr,
+	&emif_attr_inf6_cal_fail.attr.attr,
+	&emif_attr_inf6_clear.attr.attr,
+
+	&emif_attr_inf7_init_done.attr.attr,
+	&emif_attr_inf7_cal_fail.attr.attr,
+	&emif_attr_inf7_clear.attr.attr,
+
 	NULL,
 };
 
@@ -143,15 +186,24 @@ static umode_t dfl_emif_visible(struct kobject *kobj,
 	struct dfl_emif *de = dev_get_drvdata(kobj_to_dev(kobj));
 	struct emif_attr *eattr = container_of(attr, struct emif_attr,
 					       attr.attr);
+	struct dfl_device *ddev = to_dfl_dev(de->dev);
 	u64 val;
 
 	/*
-	 * This device supports upto 4 memory interfaces, but not all
+	 * This device supports up to 8 memory interfaces, but not all
 	 * interfaces are used on different platforms. The read out value of
-	 * CLEAN_EN field (which is a bitmap) could tell how many interfaces
-	 * are available.
+	 * CAPABILITY_CHN_MSK field (which is a bitmap) indicates which
+	 * interfaces are available.
 	 */
-	val = FIELD_GET(EMIF_CTRL_CLEAR_EN_MSK, readq(de->base + EMIF_CTRL));
+	if (ddev->revision > 0 && strstr(attr->name, "_clear"))
+		return 0;
+
+	if (ddev->revision == 0)
+		val = FIELD_GET(EMIF_CAPABILITY_CHN_MSK_V0,
+				readq(de->base + EMIF_CAPABILITY_BASE));
+	else
+		val = FIELD_GET(EMIF_CAPABILITY_CHN_MSK,
+				readq(de->base + EMIF_CAPABILITY_BASE));
 
 	return (val & BIT_ULL(eattr->index)) ? attr->mode : 0;
 }
-- 
2.26.2

