Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF14621752
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiKHOrd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 09:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiKHOoC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 09:44:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5DD1EEC9;
        Tue,  8 Nov 2022 06:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667918637; x=1699454637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8/1DN3ia10j7d8/dz3FWGCML2gfx829duro15qP8/E=;
  b=RNAizjIwtOO/6esSBOxr0m+pevg9ZWlR6r07KyE87P52w3yj8VWQcqUQ
   MBJs4czWSLC8WSwbLMvMt4yE27Jgwc6eJcJBauSCJg0LbJLqSEnWkIjIZ
   GaaiWuR/SEguLAN1WsFGifmSCc20AvBZ8voW6nTiS7BygAukd9s5jjfKm
   O99a2QKpCqOs/4ISC8sRwUV94/Qo57mBpD9YTsr8f5gXVvz3Tt66+u+aq
   +HxZwtipHyaVP/6fbCAbS5GKdOg1dGN0tnnidXQkTzGw491X2J2wewxk9
   jaexGq2cRG4X8VqKl/cqnSCPUA/FEbn5uxNXX0iPkskUwBoBuU3PN60aq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312497975"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="312497975"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:43:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="638809830"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="638809830"
Received: from ppkrause-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:43:51 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 07/12] mfd: intel-m10-bmc: Downscope SPI related defines
Date:   Tue,  8 Nov 2022 16:43:00 +0200
Message-Id: <20221108144305.45424-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Move SPI related defines to per interface from the global header. This
makes it harder to shoot oneself into foot.

Some bitfield defs are also moved to intel-m10-bmc-core which seems
more appropriate for them.

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc-core.c  | 11 ++++++++
 drivers/mfd/intel-m10-bmc-spi.c   | 39 +++++++++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h | 47 -------------------------------
 3 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index 51b78b868235..50a4ec758bdb 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -12,6 +12,17 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 
+/* Register fields of system registers */
+#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
+#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
+#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
+#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
+#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
+#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
+#define M10BMC_MAC_COUNT		GENMASK(23, 16)
+#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
+#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
+
 static ssize_t bmc_version_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index e3b2edb8bc07..4a7a16d9f8d6 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -13,6 +13,45 @@
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
+#define M10BMC_LEGACY_BUILD_VER		0x300468
+#define M10BMC_SYS_BASE			0x300800
+#define M10BMC_SYS_END			0x300fff
+#define M10BMC_FLASH_BASE		0x10000000
+#define M10BMC_FLASH_END		0x1fffffff
+#define M10BMC_MEM_END			M10BMC_FLASH_END
+
+#define M10BMC_STAGING_BASE		0x18000000
+
+/* Register offset of system registers */
+#define NIOS2_FW_VERSION		0x0
+#define M10BMC_MAC_LOW			0x10
+#define M10BMC_MAC_HIGH			0x14
+#define M10BMC_TEST_REG			0x3c
+#define M10BMC_BUILD_VER		0x68
+#define M10BMC_VER_LEGACY_INVALID	0xffffffff
+
+/* Secure update doorbell register, in system register region */
+#define M10BMC_DOORBELL			0x400
+
+/* Authorization Result register, in system register region */
+#define M10BMC_AUTH_RESULT		0x404
+
+/* Addresses for security related data in FLASH */
+#define BMC_REH_ADDR	0x17ffc004
+#define BMC_PROG_ADDR	0x17ffc000
+#define BMC_PROG_MAGIC	0x5746
+
+#define SR_REH_ADDR	0x17ffd004
+#define SR_PROG_ADDR	0x17ffd000
+#define SR_PROG_MAGIC	0x5253
+
+#define PR_REH_ADDR	0x17ffe004
+#define PR_PROG_ADDR	0x17ffe000
+#define PR_PROG_MAGIC	0x5250
+
+/* Address of 4KB inverted bit vector containing staging area FLASH count */
+#define STAGING_FLASH_COUNT	0x17ffb000
+
 static const struct regmap_range m10bmc_regmap_range[] = {
 	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
 	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 860408aa8db3..ed920f76d3c8 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -15,39 +15,8 @@ enum m10bmc_type {
 	M10_N5010,
 };
 
-#define M10BMC_LEGACY_BUILD_VER		0x300468
-#define M10BMC_SYS_BASE			0x300800
-#define M10BMC_SYS_END			0x300fff
-#define M10BMC_FLASH_BASE		0x10000000
-#define M10BMC_FLASH_END		0x1fffffff
-#define M10BMC_MEM_END			M10BMC_FLASH_END
-
-#define M10BMC_STAGING_BASE		0x18000000
 #define M10BMC_STAGING_SIZE		0x3800000
 
-/* Register offset of system registers */
-#define NIOS2_FW_VERSION		0x0
-#define M10BMC_MAC_LOW			0x10
-#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
-#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
-#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
-#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
-#define M10BMC_MAC_HIGH			0x14
-#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
-#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
-#define M10BMC_MAC_COUNT		GENMASK(23, 16)
-#define M10BMC_TEST_REG			0x3c
-#define M10BMC_BUILD_VER		0x68
-#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
-#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
-#define M10BMC_VER_LEGACY_INVALID	0xffffffff
-
-/* Secure update doorbell register, in system register region */
-#define M10BMC_DOORBELL			0x400
-
-/* Authorization Result register, in system register region */
-#define M10BMC_AUTH_RESULT		0x404
-
 /* Doorbell register fields */
 #define DRBL_RSU_REQUEST		BIT(0)
 #define DRBL_RSU_PROGRESS		GENMASK(7, 4)
@@ -108,22 +77,6 @@ enum m10bmc_type {
 #define RSU_COMPLETE_INTERVAL_MS	1000
 #define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
 
-/* Addresses for security related data in FLASH */
-#define BMC_REH_ADDR	0x17ffc004
-#define BMC_PROG_ADDR	0x17ffc000
-#define BMC_PROG_MAGIC	0x5746
-
-#define SR_REH_ADDR	0x17ffd004
-#define SR_PROG_ADDR	0x17ffd000
-#define SR_PROG_MAGIC	0x5253
-
-#define PR_REH_ADDR	0x17ffe004
-#define PR_PROG_ADDR	0x17ffe000
-#define PR_PROG_MAGIC	0x5250
-
-/* Address of 4KB inverted bit vector containing staging area FLASH count */
-#define STAGING_FLASH_COUNT	0x17ffb000
-
 /**
  * struct m10bmc_csr_map - Intel MAX 10 BMC CSR register map
  */
-- 
2.30.2

