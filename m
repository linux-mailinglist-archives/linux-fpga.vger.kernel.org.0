Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334116E437A
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 11:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjDQJRZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjDQJRS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 05:17:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8371729;
        Mon, 17 Apr 2023 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681723034; x=1713259034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p5A4CvVLzk8diPLAi7z6Vbk7cBVxB32lSDtCUn4HIw4=;
  b=RJvfEQWGMeR5T6nkWMgZyVQDipzpM/dVw1+hf4CNPXGRXrkxL6bkCjLo
   JRiBZ/xSRrPRknS8/fAbKQ+wlhuS7XgPTZQ+TXYl3nKnjCD1swPSUtj10
   lUXln0iJwuO2AUlzHr7L0PQ3spglV+3PRX2UtL6PgDKkx6ybqG7L3OBoJ
   zXRuDsFKxioanT5U27gI2apraCAQNZlHPbDC8Zmkia83cZ/Ct0Rc0MXwI
   G0Mig+WTEO9cD3arHvjvkblQ1DCtSUYaMvrs0GUFDxU+kDTRlfdfDMKcV
   f5FruPuzsuLA2CEim6n14hM8gGu49PYbArXowQ0dDIeEM03HD6Fdizmx0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="342338738"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="342338738"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="690595547"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="690595547"
Received: from anicosix-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.35.34])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:16:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/4] mfd: intel-m10-bmc: Move m10bmc_sys_read() away from header
Date:   Mon, 17 Apr 2023 12:16:18 +0300
Message-Id: <20230417091619.14134-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230417091619.14134-1-ilpo.jarvinen@linux.intel.com>
References: <20230417091619.14134-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index dab1bb152fd6..51f865174796 100644
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

