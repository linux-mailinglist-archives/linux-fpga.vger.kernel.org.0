Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B126D7632
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Apr 2023 10:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbjDEICV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbjDEICT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 04:02:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3736C4236;
        Wed,  5 Apr 2023 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680681738; x=1712217738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ys3C2wRBEsybGWReoS1y6LBFNQYIzJzXBbmVnoIbRU4=;
  b=bwfV/PuB4KGFbe+GoygMjEbipV/xqT2Qn/kqgxB8Y8PeEbaC2VsbWaC+
   XGJad1EbCVDvcNY2/RQH5r3IAelBZMDb3Wz4jNKAqTHTpmkAF1YBX0D+j
   ulzpSEPJ6rQMSglg37QT1eIczus+O5FXkDIl9N7rP32XyWrnJGuyJmVdx
   7d5Qhl+P1keRInJZuVl2Efy2WQCsz19/ZyknvJs1eonDGlpRQYtEqP9YQ
   xQC5AKzKJoo9rqUN1wxKEB0tUqxo0JftrbMHhiLt3hIyaPkDW9OLjbeb0
   YnoBhAOY3R8MlcniF792r8V3AiwdgGmmjv9WDI5XtA33S8AuoGT1eTzLT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428680231"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428680231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775959633"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="775959633"
Received: from wtedesch-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.53.134])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:02:12 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/4] mfd: intel-m10-bmc: Move m10bmc_sys_read() away from header
Date:   Wed,  5 Apr 2023 11:01:51 +0300
Message-Id: <20230405080152.6732-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Move m10bmc_sys_read() out from the header to prepare it for adding
more code into the function which would make it too large to be a
static inline any more.

While at it, replace the vague wording in function comment with more
precise statements.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/hwmon/intel-m10-bmc-hwmon.c |  1 +
 drivers/mfd/intel-m10-bmc-core.c    | 14 ++++++++++++++
 include/linux/mfd/intel-m10-bmc.h   | 17 +----------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
index 2f0323c14bab..92900ce7986b 100644
--- a/drivers/hwmon/intel-m10-bmc-hwmon.c
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -794,3 +794,4 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_hwmon_ids);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Intel MAX 10 BMC hardware monitor");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);
diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index 879d98b9b14d..4a1bfe135293 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -12,6 +12,20 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 
+/*
+ * This function helps to simplify the accessing of the system registers.
+ *
+ * The base of the system registers is configured through the struct
+ * csr_map.
+ */
+int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset, unsigned int *val)
+{
+	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
+
+	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
+}
+EXPORT_SYMBOL_NS_GPL(m10bmc_sys_read, INTEL_M10_BMC_CORE);
+
 int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
 			   unsigned int msk, unsigned int val)
 {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 5418f7279ed0..252644fa61be 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -267,22 +267,7 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
 	return ret;
 }
 
-/*
- * The base of the system registers could be configured by HW developers, and
- * in HW SPEC, the base is not added to the addresses of the system registers.
- *
- * This function helps to simplify the accessing of the system registers. And if
- * the base is reconfigured in HW, SW developers could simply change the
- * csr_map's base accordingly.
- */
-static inline int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset,
-				  unsigned int *val)
-{
-	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
-
-	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
-}
-
+int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset, unsigned int *val);
 int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
 			   unsigned int msk, unsigned int val);
 
-- 
2.30.2

