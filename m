Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7818662DA68
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Nov 2022 13:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiKQMKt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Nov 2022 07:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbiKQMH3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Nov 2022 07:07:29 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F79697ED;
        Thu, 17 Nov 2022 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668686848; x=1700222848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7j6xB4dqCifUK7v7pS/sRbLqtaJUBPfl+MTlBhEJwUU=;
  b=IfObAuQDj0pWJCS9/F8fgjRJlNB2UQxEiYTS09hcCDl0Oh2Zk5+it2qa
   sqi/ny/Lc8NjrpxY5G4e5ZWq7NRA1mFFwcLOlq7LWZc2seuY6OWL81pKE
   HeA7Q5xKgAnm41l7lFoyizgqXWZa5fvnKvbx2f7lcrWZ7riXj4recWsdT
   wCqFP+y/3D0FlGUsWChGP70CEy5KTAsyPt4hsBiTnP4n5rw6pwpXyV3tF
   HKIu+aXomeUdXvmRZj2IhkTXrdytPw1KkN1Vsv54VEtMHNOUd1XKhdKwO
   sNUfIRbnZ49Ml8VGVHFEXhYhNs4fyTV+zUsdfPTPDtdwZDPkOv3LK/AJx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314648844"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314648844"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968855781"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968855781"
Received: from kvehmane-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.61.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:13 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 06/11] mfd: intel-m10-bmc: Downscope SPI defines & prefix with M10BMC_SPI
Date:   Thu, 17 Nov 2022 14:05:10 +0200
Message-Id: <20221117120515.37807-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
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

Move SPI based board definitions to per interface file from the global
header. This makes it harder to use them accidently in the
generic/interface agnostic code. Prefix the defines with M10BMC_SPI
to make it more obvious these are related to SPI only.

Some bitfield defs are also moved to intel-m10-bmc-core which seems
more appropriate for them.

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc-core.c  | 11 ++++
 drivers/mfd/intel-m10-bmc-spi.c   | 94 ++++++++++++++++++++++---------
 include/linux/mfd/intel-m10-bmc.h | 47 ----------------
 3 files changed, 78 insertions(+), 74 deletions(-)

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
index b70e3e87600a..a17a0b50f352 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -13,10 +13,49 @@
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
+#define M10BMC_SPI_LEGACY_BUILD_VER	0x300468
+#define M10BMC_SPI_SYS_BASE		0x300800
+#define M10BMC_SPI_SYS_END		0x300fff
+#define M10BMC_SPI_FLASH_BASE		0x10000000
+#define M10BMC_SPI_FLASH_END		0x1fffffff
+#define M10BMC_SPI_MEM_END		M10BMC_SPI_FLASH_END
+
+#define M10BMC_SPI_STAGING_BASE		0x18000000
+
+/* Register offset of system registers */
+#define NIOS2_FW_VERSION		0x0
+#define M10BMC_SPI_MAC_LOW		0x10
+#define M10BMC_SPI_MAC_HIGH		0x14
+#define M10BMC_SPI_TEST_REG		0x3c
+#define M10BMC_SPI_BUILD_VER		0x68
+#define M10BMC_SPI_VER_LEGACY_INVALID	0xffffffff
+
+/* Secure update doorbell register, in system register region */
+#define M10BMC_SPI_DOORBELL		0x400
+
+/* Authorization Result register, in system register region */
+#define M10BMC_SPI_AUTH_RESULT		0x404
+
+/* Addresses for security related data in FLASH */
+#define M10BMC_SPI_BMC_REH_ADDR		0x17ffc004
+#define M10BMC_SPI_BMC_PROG_ADDR	0x17ffc000
+#define M10BMC_SPI_BMC_PROG_MAGIC	0x5746
+
+#define M10BMC_SPI_SR_REH_ADDR		0x17ffd004
+#define M10BMC_SPI_SR_PROG_ADDR		0x17ffd000
+#define M10BMC_SPI_SR_PROG_MAGIC	0x5253
+
+#define M10BMC_SPI_PR_REH_ADDR		0x17ffe004
+#define M10BMC_SPI_PR_PROG_ADDR		0x17ffe000
+#define M10BMC_SPI_PR_PROG_MAGIC	0x5250
+
+/* Address of 4KB inverted bit vector containing staging area FLASH count */
+#define M10BMC_SPI_STAGING_FLASH_COUNT	0x17ffb000
+
 static const struct regmap_range m10bmc_regmap_range[] = {
-	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
-	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
-	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
+	regmap_reg_range(M10BMC_SPI_LEGACY_BUILD_VER, M10BMC_SPI_LEGACY_BUILD_VER),
+	regmap_reg_range(M10BMC_SPI_SYS_BASE, M10BMC_SPI_SYS_END),
+	regmap_reg_range(M10BMC_SPI_FLASH_BASE, M10BMC_SPI_FLASH_END),
 };
 
 static const struct regmap_access_table m10bmc_access_table = {
@@ -30,7 +69,7 @@ static struct regmap_config intel_m10bmc_regmap_config = {
 	.reg_stride = 4,
 	.wr_table = &m10bmc_access_table,
 	.rd_table = &m10bmc_access_table,
-	.max_register = M10BMC_MEM_END,
+	.max_register = M10BMC_SPI_MEM_END,
 };
 
 static int m10bmc_spi_flash_write(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size)
@@ -45,7 +84,7 @@ static int m10bmc_spi_flash_write(struct intel_m10bmc *m10bmc, const u8 *buf, u3
 	if (WARN_ON_ONCE(stride > sizeof(leftover_tmp)))
 		return -EINVAL;
 
-	ret = regmap_bulk_write(m10bmc->regmap, M10BMC_STAGING_BASE + offset,
+	ret = regmap_bulk_write(m10bmc->regmap, M10BMC_SPI_STAGING_BASE + offset,
 				buf + offset, write_count);
 	if (ret)
 		return ret;
@@ -53,7 +92,8 @@ static int m10bmc_spi_flash_write(struct intel_m10bmc *m10bmc, const u8 *buf, u3
 	/* If size is not aligned to stride, handle the remainder bytes with regmap_write() */
 	if (leftover_size) {
 		memcpy(&leftover_tmp, buf + leftover_offset, leftover_size);
-		ret = regmap_write(m10bmc->regmap, M10BMC_STAGING_BASE + offset + leftover_offset,
+		ret = regmap_write(m10bmc->regmap,
+				   M10BMC_SPI_STAGING_BASE + offset + leftover_offset,
 				   leftover_tmp);
 		if (ret)
 			return ret;
@@ -102,16 +142,16 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
 	/*
 	 * This check is to filter out the very old legacy BMC versions. In the
 	 * old BMC chips, the BMC version info is stored in the old version
-	 * register (M10BMC_LEGACY_BUILD_VER), so its read out value would have
-	 * not been M10BMC_VER_LEGACY_INVALID (0xffffffff). But in new BMC
+	 * register (M10BMC_SPI_LEGACY_BUILD_VER), so its read out value would have
+	 * not been M10BMC_SPI_VER_LEGACY_INVALID (0xffffffff). But in new BMC
 	 * chips that the driver supports, the value of this register should be
-	 * M10BMC_VER_LEGACY_INVALID.
+	 * M10BMC_SPI_VER_LEGACY_INVALID.
 	 */
-	ret = m10bmc_raw_read(ddata, M10BMC_LEGACY_BUILD_VER, &v);
+	ret = m10bmc_raw_read(ddata, M10BMC_SPI_LEGACY_BUILD_VER, &v);
 	if (ret)
 		return -ENODEV;
 
-	if (v != M10BMC_VER_LEGACY_INVALID) {
+	if (v != M10BMC_SPI_VER_LEGACY_INVALID) {
 		dev_err(ddata->dev, "bad version M10BMC detected\n");
 		return -ENODEV;
 	}
@@ -154,23 +194,23 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 }
 
 static const struct m10bmc_csr_map m10bmc_spi_csr_map = {
-	.base = M10BMC_SYS_BASE,
-	.build_version = M10BMC_BUILD_VER,
+	.base = M10BMC_SPI_SYS_BASE,
+	.build_version = M10BMC_SPI_BUILD_VER,
 	.fw_version = NIOS2_FW_VERSION,
-	.mac_low = M10BMC_MAC_LOW,
-	.mac_high = M10BMC_MAC_HIGH,
-	.doorbell = M10BMC_DOORBELL,
-	.auth_result = M10BMC_AUTH_RESULT,
-	.bmc_prog_addr = BMC_PROG_ADDR,
-	.bmc_reh_addr = BMC_REH_ADDR,
-	.bmc_magic = BMC_PROG_MAGIC,
-	.sr_prog_addr = SR_PROG_ADDR,
-	.sr_reh_addr = SR_REH_ADDR,
-	.sr_magic = SR_PROG_MAGIC,
-	.pr_prog_addr = PR_PROG_ADDR,
-	.pr_reh_addr = PR_REH_ADDR,
-	.pr_magic = PR_PROG_MAGIC,
-	.rsu_update_counter = STAGING_FLASH_COUNT,
+	.mac_low = M10BMC_SPI_MAC_LOW,
+	.mac_high = M10BMC_SPI_MAC_HIGH,
+	.doorbell = M10BMC_SPI_DOORBELL,
+	.auth_result = M10BMC_SPI_AUTH_RESULT,
+	.bmc_prog_addr = M10BMC_SPI_BMC_PROG_ADDR,
+	.bmc_reh_addr = M10BMC_SPI_BMC_REH_ADDR,
+	.bmc_magic = M10BMC_SPI_BMC_PROG_MAGIC,
+	.sr_prog_addr = M10BMC_SPI_SR_PROG_ADDR,
+	.sr_reh_addr = M10BMC_SPI_SR_REH_ADDR,
+	.sr_magic = M10BMC_SPI_SR_PROG_MAGIC,
+	.pr_prog_addr = M10BMC_SPI_PR_PROG_ADDR,
+	.pr_reh_addr = M10BMC_SPI_PR_REH_ADDR,
+	.pr_magic = M10BMC_SPI_PR_PROG_MAGIC,
+	.rsu_update_counter = M10BMC_SPI_STAGING_FLASH_COUNT,
 };
 
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 7f87e898a212..200425b5b266 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -9,39 +9,8 @@
 
 #include <linux/regmap.h>
 
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
@@ -102,22 +71,6 @@
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

