Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841686D7633
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Apr 2023 10:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbjDEICW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjDEICT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 04:02:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD340EE;
        Wed,  5 Apr 2023 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680681738; x=1712217738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5O3kpADpDKviaqUjctZBRUN1WdPPnVBWYgqfDgkMEqo=;
  b=HjvVOzik2rrOD23vuSuMIoCVn0t6+UIxHMTKxz6Y9eX7Mrd5Tbe/QuUb
   9VnaiBDpgH39FSa4VLP+vH2PDrVAhit36SijPnuBommRBtMou34ErB7Le
   Y5x/hYAuzSRoSJVegPP0EwrFHam/sEzKBL/vy2oP1or9Iw2cPVqFUYwwp
   HqXuLcH0xfLFa79Tbf4tgSBFKlqSeEgqOfNZGlqq7Mn7BwabGo+Ta4UlQ
   U5cIdlBO/qG+unF0JVlWKBERoW0PhKvzsSQ7v9OVVQ4UivpmPCV/g6qMS
   Sre055REEycQXuF8ePL6OfaKZSHEpLnPeprHzgiCe3iXP+bpNDZc/Bta7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428680225"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428680225"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775959628"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="775959628"
Received: from wtedesch-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.53.134])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:02:08 -0700
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
Subject: [PATCH 2/4] mfd: intel-m10-bmc: Create m10bmc_sys_update_bits()
Date:   Wed,  5 Apr 2023 11:01:50 +0300
Message-Id: <20230405080152.6732-3-ilpo.jarvinen@linux.intel.com>
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

Wrap regmap_update_bits() with m10bmc_sys_update_bits() in order to be
able to add additional checks into it.

Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 30 ++++++++++++-------------
 drivers/mfd/intel-m10-bmc-core.c        |  9 ++++++++
 include/linux/mfd/intel-m10-bmc.h       |  4 ++++
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index d7e2f9f461bc..fe0127a58eff 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -376,12 +376,11 @@ static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
 	u32 doorbell_reg, progress, status;
 	int ret, err;
 
-	ret = regmap_update_bits(sec->m10bmc->regmap,
-				 csr_map->base + csr_map->doorbell,
-				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
-				 DRBL_RSU_REQUEST |
-				 FIELD_PREP(DRBL_HOST_STATUS,
-					    HOST_STATUS_IDLE));
+	ret = m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
+				     DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
+				     DRBL_RSU_REQUEST |
+				     FIELD_PREP(DRBL_HOST_STATUS,
+						HOST_STATUS_IDLE));
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
@@ -450,11 +449,10 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
 	u32 doorbell_reg, status;
 	int ret;
 
-	ret = regmap_update_bits(sec->m10bmc->regmap,
-				 csr_map->base + csr_map->doorbell,
-				 DRBL_HOST_STATUS,
-				 FIELD_PREP(DRBL_HOST_STATUS,
-					    HOST_STATUS_WRITE_DONE));
+	ret = m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
+				     DRBL_HOST_STATUS,
+				     FIELD_PREP(DRBL_HOST_STATUS,
+						HOST_STATUS_WRITE_DONE));
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
@@ -517,11 +515,10 @@ static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
 	if (rsu_prog(doorbell) != RSU_PROG_READY)
 		return FW_UPLOAD_ERR_BUSY;
 
-	ret = regmap_update_bits(sec->m10bmc->regmap,
-				 csr_map->base + csr_map->doorbell,
-				 DRBL_HOST_STATUS,
-				 FIELD_PREP(DRBL_HOST_STATUS,
-					    HOST_STATUS_ABORT_RSU));
+	ret = m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
+				     DRBL_HOST_STATUS,
+				     FIELD_PREP(DRBL_HOST_STATUS,
+						HOST_STATUS_ABORT_RSU));
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
@@ -764,3 +761,4 @@ module_platform_driver(intel_m10bmc_sec_driver);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);
diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index b94412813887..879d98b9b14d 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -12,6 +12,15 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 
+int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
+			   unsigned int msk, unsigned int val)
+{
+	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
+
+	return regmap_update_bits(m10bmc->regmap, csr_map->base + offset, msk, val);
+}
+EXPORT_SYMBOL_NS_GPL(m10bmc_sys_update_bits, INTEL_M10_BMC_CORE);
+
 static ssize_t bmc_version_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 1812ebfa11a8..5418f7279ed0 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -251,6 +251,7 @@ struct intel_m10bmc {
  *
  * m10bmc_raw_read - read m10bmc register per addr
  * m10bmc_sys_read - read m10bmc system register per offset
+ * m10bmc_sys_update_bits - update m10bmc system register per offset
  */
 static inline int
 m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
@@ -282,6 +283,9 @@ static inline int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offs
 	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
 }
 
+int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
+			   unsigned int msk, unsigned int val);
+
 /*
  * MAX10 BMC Core support
  */
-- 
2.30.2

