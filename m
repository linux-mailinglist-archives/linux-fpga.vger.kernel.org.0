Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5745664C2
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Jul 2022 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiGEIEh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Jul 2022 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGEIEg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Jul 2022 04:04:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1D6333
        for <linux-fpga@vger.kernel.org>; Tue,  5 Jul 2022 01:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657008275; x=1688544275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYCLhLPVwk8pA42DL08CmkRgLi2ztKgNK8cqO0fxJiw=;
  b=IHS97HAp18OH3MH1CMeSmwoZKMWAuQ/6TTQnOuSbp5ns3zka4j5jGOyS
   PltT8lL+ehyODwZSr9Kd2bqKXplQX0n4KgIpdP1lFNVajsJDshmOzhXJt
   Vchx3QATQsmfNQbdn/3VXL9UpYKR5n1EIe1s9NoW7VIsZ1np+lFBtBB7A
   sRyHuRzxkNmMjKgy47Tt9Rf/AIae6M8R3Wt77A+hrX9V9KBN1H34wi8JI
   +A+FpycC1ZynAsK4YUhzrFAce4N2O7+c/jDGjfkGFytZI3hVueUB6REva
   EiJaaGlanHw8icGVcUz0QwYJ0jvTJF9FakOXvKZHiW7RrfEXhevpTFVcL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369609012"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="369609012"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 01:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="919613413"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 01:04:33 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     mdf@kernel.org, yilun.xu@intel.com, lee.jones@linaro.org,
        russell.h.weight@intel.com
Cc:     hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 1/3] mfd: intel-m10-bmc: add m10bmc_sys_update_bits API
Date:   Tue,  5 Jul 2022 04:00:56 -0400
Message-Id: <20220705080058.92532-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220705080058.92532-1-tianfei.zhang@intel.com>
References: <20220705080058.92532-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds register access helper functions for M10BMC.
m10bmc_raw_update_bits() uses to update m10bmc register
bits per addr.
m10bmc_sys_update_bits() uses to update m10bmc system
register bits per offset.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 include/linux/mfd/intel-m10-bmc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index f0044b14136e..8e434886a5a1 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -133,6 +133,8 @@ struct intel_m10bmc {
  *
  * m10bmc_raw_read - read m10bmc register per addr
  * m10bmc_sys_read - read m10bmc system register per offset
+ * m10bmc_raw_update_bits - update m10bmc register bits per addr
+ * m10bmc_sys_update_bits - update m10bmc system register bits per offset
  */
 static inline int
 m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
@@ -148,6 +150,20 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
 	return ret;
 }
 
+static inline int
+m10bmc_raw_update_bits(struct intel_m10bmc *m10bmc, unsigned int addr,
+		       unsigned int msk, unsigned int val)
+{
+	int ret;
+
+	ret = regmap_update_bits(m10bmc->regmap, addr, msk, val);
+	if (ret)
+		dev_err(m10bmc->dev, "fail to update reg bits %x: %d\n",
+			addr, ret);
+
+	return ret;
+}
+
 /*
  * The base of the system registers could be configured by HW developers, and
  * in HW SPEC, the base is not added to the addresses of the system registers.
@@ -158,5 +174,7 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
  */
 #define m10bmc_sys_read(m10bmc, offset, val) \
 	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
+#define m10bmc_sys_update_bits(m10bmc, offset, msk, val) \
+	m10bmc_raw_update_bits(m10bmc, M10BMC_SYS_BASE + (offset), msk, val)
 
 #endif /* __MFD_INTEL_M10_BMC_H */
-- 
2.26.2

