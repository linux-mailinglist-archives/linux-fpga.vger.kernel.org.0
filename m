Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9466BB72
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jan 2023 11:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjAPKNX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Jan 2023 05:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjAPKKC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 16 Jan 2023 05:10:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A5D1A95A;
        Mon, 16 Jan 2023 02:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673863771; x=1705399771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vTl0dJv/nvxoTe7V3yqb7/64dhUhRoKwGAK3TyJ2ynA=;
  b=EToMOmZvC2GKcacw0yYQ6A/ivM1ToNtIYCWmg88KRd3KsRY0iUz4/qwI
   LyR9aFwiaMltB57Y5AwxynIGY5DdhWzgsN4KNBjeZzPCmoIC7oCOHmbwh
   qdPBMs4zdYsZjFCTo5QEFpyMgttXGFbenrwlGOxzjljjdrN0hX9JoWjkR
   I370xlgt1uQiiTl8p6INhKfYpgrHPtzn0XKJxY+sk8onNYGZi/hTc1hTz
   PsByEiTeEzQt8gUXgXOntvvx9M0R//T2G3zN/O85qBVukmuHGiuSZ1JO3
   xl3KRHjczt2yf+9KLvKduwrNMzjBXPLRHYvEx15JkA3pxK5YFL9IZ016h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="326489340"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="326489340"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:09:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="832785792"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="832785792"
Received: from xsanroma-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:09:27 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 07/11] mfd: intel-m10-bmc: Prefix register defines with M10BMC_N3000
Date:   Mon, 16 Jan 2023 12:08:41 +0200
Message-Id: <20230116100845.6153-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
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

Prefix the M10BMC defines register defines with M10BMC_N3000 to make it
more obvious these are related to some board type. All current
non-N3000 board types have the same layout so they'll be reused. The
less generic makes it more obvious they're not meant for the
generic/interface agnostic code.

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc-core.c  | 14 +++----
 drivers/mfd/intel-m10-bmc-spi.c   | 52 ++++++++++++------------
 include/linux/mfd/intel-m10-bmc.h | 66 +++++++++++++++----------------
 3 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index cbea8d4f68fa..dac9cf7bcb4a 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -58,12 +58,12 @@ static ssize_t mac_address_show(struct device *dev,
 		return ret;
 
 	return sysfs_emit(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr_low),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr_low),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr_low),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr_low),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE5, macaddr_high),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE6, macaddr_high));
+			  (u8)FIELD_GET(M10BMC_N3000_MAC_BYTE1, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_N3000_MAC_BYTE2, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_N3000_MAC_BYTE3, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_N3000_MAC_BYTE4, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_N3000_MAC_BYTE5, macaddr_high),
+			  (u8)FIELD_GET(M10BMC_N3000_MAC_BYTE6, macaddr_high));
 }
 static DEVICE_ATTR_RO(mac_address);
 
@@ -78,7 +78,7 @@ static ssize_t mac_count_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%u\n", (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr_high));
+	return sysfs_emit(buf, "%u\n", (u8)FIELD_GET(M10BMC_N3000_MAC_COUNT, macaddr_high));
 }
 static DEVICE_ATTR_RO(mac_count);
 
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index 3ed7a71a3267..957200e17fed 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -14,9 +14,9 @@
 #include <linux/spi/spi.h>
 
 static const struct regmap_range m10bmc_regmap_range[] = {
-	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
-	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
-	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
+	regmap_reg_range(M10BMC_N3000_LEGACY_BUILD_VER, M10BMC_N3000_LEGACY_BUILD_VER),
+	regmap_reg_range(M10BMC_N3000_SYS_BASE, M10BMC_N3000_SYS_END),
+	regmap_reg_range(M10BMC_N3000_FLASH_BASE, M10BMC_N3000_FLASH_END),
 };
 
 static const struct regmap_access_table m10bmc_access_table = {
@@ -30,7 +30,7 @@ static struct regmap_config intel_m10bmc_regmap_config = {
 	.reg_stride = 4,
 	.wr_table = &m10bmc_access_table,
 	.rd_table = &m10bmc_access_table,
-	.max_register = M10BMC_MEM_END,
+	.max_register = M10BMC_N3000_MEM_END,
 };
 
 static int check_m10bmc_version(struct intel_m10bmc *ddata)
@@ -41,16 +41,16 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
 	/*
 	 * This check is to filter out the very old legacy BMC versions. In the
 	 * old BMC chips, the BMC version info is stored in the old version
-	 * register (M10BMC_LEGACY_BUILD_VER), so its read out value would have
-	 * not been M10BMC_VER_LEGACY_INVALID (0xffffffff). But in new BMC
+	 * register (M10BMC_N3000_LEGACY_BUILD_VER), so its read out value would have
+	 * not been M10BMC_N3000_VER_LEGACY_INVALID (0xffffffff). But in new BMC
 	 * chips that the driver supports, the value of this register should be
-	 * M10BMC_VER_LEGACY_INVALID.
+	 * M10BMC_N3000_VER_LEGACY_INVALID.
 	 */
-	ret = m10bmc_raw_read(ddata, M10BMC_LEGACY_BUILD_VER, &v);
+	ret = m10bmc_raw_read(ddata, M10BMC_N3000_LEGACY_BUILD_VER, &v);
 	if (ret)
 		return -ENODEV;
 
-	if (v != M10BMC_VER_LEGACY_INVALID) {
+	if (v != M10BMC_N3000_VER_LEGACY_INVALID) {
 		dev_err(ddata->dev, "bad version M10BMC detected\n");
 		return -ENODEV;
 	}
@@ -92,23 +92,23 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 }
 
 static const struct m10bmc_csr_map m10bmc_n3000_csr_map = {
-	.base = M10BMC_SYS_BASE,
-	.build_version = M10BMC_BUILD_VER,
-	.fw_version = NIOS2_FW_VERSION,
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
+	.base = M10BMC_N3000_SYS_BASE,
+	.build_version = M10BMC_N3000_BUILD_VER,
+	.fw_version = NIOS2_N3000_FW_VERSION,
+	.mac_low = M10BMC_N3000_MAC_LOW,
+	.mac_high = M10BMC_N3000_MAC_HIGH,
+	.doorbell = M10BMC_N3000_DOORBELL,
+	.auth_result = M10BMC_N3000_AUTH_RESULT,
+	.bmc_prog_addr = M10BMC_N3000_BMC_PROG_ADDR,
+	.bmc_reh_addr = M10BMC_N3000_BMC_REH_ADDR,
+	.bmc_magic = M10BMC_N3000_BMC_PROG_MAGIC,
+	.sr_prog_addr = M10BMC_N3000_SR_PROG_ADDR,
+	.sr_reh_addr = M10BMC_N3000_SR_REH_ADDR,
+	.sr_magic = M10BMC_N3000_SR_PROG_MAGIC,
+	.pr_prog_addr = M10BMC_N3000_PR_PROG_ADDR,
+	.pr_reh_addr = M10BMC_N3000_PR_REH_ADDR,
+	.pr_magic = M10BMC_N3000_PR_PROG_MAGIC,
+	.rsu_update_counter = M10BMC_N3000_STAGING_FLASH_COUNT,
 };
 
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index d569a72c7d4f..470dc3773c01 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -12,38 +12,38 @@
 #include <linux/dev_printk.h>
 #include <linux/regmap.h>
 
-#define M10BMC_LEGACY_BUILD_VER		0x300468
-#define M10BMC_SYS_BASE			0x300800
-#define M10BMC_SYS_END			0x300fff
-#define M10BMC_FLASH_BASE		0x10000000
-#define M10BMC_FLASH_END		0x1fffffff
-#define M10BMC_MEM_END			M10BMC_FLASH_END
+#define M10BMC_N3000_LEGACY_BUILD_VER	0x300468
+#define M10BMC_N3000_SYS_BASE		0x300800
+#define M10BMC_N3000_SYS_END		0x300fff
+#define M10BMC_N3000_FLASH_BASE		0x10000000
+#define M10BMC_N3000_FLASH_END		0x1fffffff
+#define M10BMC_N3000_MEM_END		M10BMC_N3000_FLASH_END
 
 #define M10BMC_STAGING_BASE		0x18000000
 #define M10BMC_STAGING_SIZE		0x3800000
 
 /* Register offset of system registers */
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
+#define NIOS2_N3000_FW_VERSION		0x0
+#define M10BMC_N3000_MAC_LOW		0x10
+#define M10BMC_N3000_MAC_BYTE4		GENMASK(7, 0)
+#define M10BMC_N3000_MAC_BYTE3		GENMASK(15, 8)
+#define M10BMC_N3000_MAC_BYTE2		GENMASK(23, 16)
+#define M10BMC_N3000_MAC_BYTE1		GENMASK(31, 24)
+#define M10BMC_N3000_MAC_HIGH		0x14
+#define M10BMC_N3000_MAC_BYTE6		GENMASK(7, 0)
+#define M10BMC_N3000_MAC_BYTE5		GENMASK(15, 8)
+#define M10BMC_N3000_MAC_COUNT		GENMASK(23, 16)
+#define M10BMC_N3000_TEST_REG		0x3c
+#define M10BMC_N3000_BUILD_VER		0x68
+#define M10BMC_N3000_VER_MAJOR_MSK	GENMASK(23, 16)
+#define M10BMC_N3000_VER_PCB_INFO_MSK	GENMASK(31, 24)
+#define M10BMC_N3000_VER_LEGACY_INVALID	0xffffffff
 
 /* Secure update doorbell register, in system register region */
-#define M10BMC_DOORBELL			0x400
+#define M10BMC_N3000_DOORBELL		0x400
 
 /* Authorization Result register, in system register region */
-#define M10BMC_AUTH_RESULT		0x404
+#define M10BMC_N3000_AUTH_RESULT		0x404
 
 /* Doorbell register fields */
 #define DRBL_RSU_REQUEST		BIT(0)
@@ -106,20 +106,20 @@
 #define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
 
 /* Addresses for security related data in FLASH */
-#define BMC_REH_ADDR	0x17ffc004
-#define BMC_PROG_ADDR	0x17ffc000
-#define BMC_PROG_MAGIC	0x5746
+#define M10BMC_N3000_BMC_REH_ADDR	0x17ffc004
+#define M10BMC_N3000_BMC_PROG_ADDR	0x17ffc000
+#define M10BMC_N3000_BMC_PROG_MAGIC	0x5746
 
-#define SR_REH_ADDR	0x17ffd004
-#define SR_PROG_ADDR	0x17ffd000
-#define SR_PROG_MAGIC	0x5253
+#define M10BMC_N3000_SR_REH_ADDR	0x17ffd004
+#define M10BMC_N3000_SR_PROG_ADDR	0x17ffd000
+#define M10BMC_N3000_SR_PROG_MAGIC	0x5253
 
-#define PR_REH_ADDR	0x17ffe004
-#define PR_PROG_ADDR	0x17ffe000
-#define PR_PROG_MAGIC	0x5250
+#define M10BMC_N3000_PR_REH_ADDR	0x17ffe004
+#define M10BMC_N3000_PR_PROG_ADDR	0x17ffe000
+#define M10BMC_N3000_PR_PROG_MAGIC	0x5250
 
 /* Address of 4KB inverted bit vector containing staging area FLASH count */
-#define STAGING_FLASH_COUNT	0x17ffb000
+#define M10BMC_N3000_STAGING_FLASH_COUNT	0x17ffb000
 
 /**
  * struct m10bmc_csr_map - Intel MAX 10 BMC CSR register map
-- 
2.30.2

