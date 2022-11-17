Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C487E62DA60
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Nov 2022 13:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiKQMHa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Nov 2022 07:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbiKQMH3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Nov 2022 07:07:29 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64156E558;
        Thu, 17 Nov 2022 04:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668686848; x=1700222848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQ4ZBn56vAYZE+qDC/UdFlMegKu8SoAZMjAoBq1UUaY=;
  b=VHGTnnL1cK4Q4A9kubjWFl9sq/yG/O6WeUjKXAZzu9bHKrBlNEeeRbQe
   mw85YFp4dL3NJ2/4w7Ov7JAQJ4XBFy7Qv8YYEI2WVjhNhEtE1Z/H6h4n2
   xoU5nGjSNJ/OJRS9t/4ry9rl+58HIj4HOVkhIsGPH5RqAk0lPnImNnyhY
   RpY8kec9kR6wyqOqrhlKyflPwR1azBGT2WA1Hw5nek2+q8gdMFHSX9/ve
   Akgp9gtV9/f0C4K8a4wZiZVHjt05MnkvAC45+Y02RYrP2TEG9bXfWLJsb
   Ebf44j3gaVPjBwx2Mt0E+z8qa0LcND/J5F3SCdoB12IVdbuupypqgZBHu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300365628"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="300365628"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968855752"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968855752"
Received: from kvehmane-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.61.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:07 -0800
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
Subject: [PATCH v2 05/11] fpga: intel-m10-bmc: Add flash ops for sec update
Date:   Thu, 17 Nov 2022 14:05:09 +0200
Message-Id: <20221117120515.37807-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Access to flash staging area is different for N6000 from that of the
SPI interfaced counterparts.

Introduce intel_m10bmc_flash_ops to allow interface specific
differentiations for the flash access path for sec update, add flash
ops for SPI-based MAX10 interface, and make sec update driver to use
the new operations.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 79 ++++++-------------------
 drivers/mfd/intel-m10-bmc-spi.c         | 62 +++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h       | 14 +++++
 3 files changed, 94 insertions(+), 61 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index dbe8aff95da3..3bd22d03616a 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -38,11 +38,9 @@ show_root_entry_hash(struct device *dev, u32 exp_magic,
 	struct m10bmc_sec *sec = dev_get_drvdata(dev);
 	int sha_num_bytes, i, ret, cnt = 0;
 	u8 hash[REH_SHA384_SIZE];
-	unsigned int stride;
 	u32 magic;
 
-	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
-	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
+	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, (u8 *)&magic, prog_addr, sizeof(magic));
 	if (ret)
 		return ret;
 
@@ -50,19 +48,16 @@ show_root_entry_hash(struct device *dev, u32 exp_magic,
 		return sysfs_emit(buf, "hash not programmed\n");
 
 	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
-	if ((sha_num_bytes % stride) ||
-	    (sha_num_bytes != REH_SHA256_SIZE &&
-	     sha_num_bytes != REH_SHA384_SIZE))   {
+	if (sha_num_bytes != REH_SHA256_SIZE &&
+	    sha_num_bytes != REH_SHA384_SIZE) {
 		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
 			sha_num_bytes);
 		return -EINVAL;
 	}
 
-	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
-			       hash, sha_num_bytes / stride);
+	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, hash, reh_addr, sha_num_bytes);
 	if (ret) {
-		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
-			reh_addr, sha_num_bytes / stride, ret);
+		dev_err(dev, "failed to read root entry hash\n");
 		return ret;
 	}
 
@@ -98,27 +93,16 @@ DEVICE_ATTR_SEC_REH_RO(pr);
 static ssize_t
 show_canceled_csk(struct device *dev, u32 addr, char *buf)
 {
-	unsigned int i, stride, size = CSK_32ARRAY_SIZE * sizeof(u32);
+	unsigned int i, size = CSK_32ARRAY_SIZE * sizeof(u32);
 	struct m10bmc_sec *sec = dev_get_drvdata(dev);
 	DECLARE_BITMAP(csk_map, CSK_BIT_LEN);
 	__le32 csk_le32[CSK_32ARRAY_SIZE];
 	u32 csk32[CSK_32ARRAY_SIZE];
 	int ret;
 
-	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
-	if (size % stride) {
-		dev_err(sec->dev,
-			"CSK vector size (0x%x) not aligned to stride (0x%x)\n",
-			size, stride);
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
-
-	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk_le32,
-			       size / stride);
+	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, (u8 *)&csk_le32, addr, size);
 	if (ret) {
-		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
-			addr, size / stride, ret);
+		dev_err(sec->dev, "failed to read CSK vector\n");
 		return ret;
 	}
 
@@ -157,31 +141,21 @@ static ssize_t flash_count_show(struct device *dev,
 {
 	struct m10bmc_sec *sec = dev_get_drvdata(dev);
 	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
-	unsigned int stride, num_bits;
+	unsigned int num_bits;
 	u8 *flash_buf;
 	int cnt, ret;
 
-	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
 	num_bits = FLASH_COUNT_SIZE * 8;
 
-	if (FLASH_COUNT_SIZE % stride) {
-		dev_err(sec->dev,
-			"FLASH_COUNT_SIZE (0x%x) not aligned to stride (0x%x)\n",
-			FLASH_COUNT_SIZE, stride);
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
-
 	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
 	if (!flash_buf)
 		return -ENOMEM;
 
-	ret = regmap_bulk_read(sec->m10bmc->regmap, csr_map->rsu_update_counter,
-			       flash_buf, FLASH_COUNT_SIZE / stride);
+	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, flash_buf,
+					   csr_map->rsu_update_counter,
+					   FLASH_COUNT_SIZE);
 	if (ret) {
-		dev_err(sec->dev,
-			"failed to read flash count: %x cnt %x: %d\n",
-			csr_map->rsu_update_counter, FLASH_COUNT_SIZE / stride, ret);
+		dev_err(sec->dev, "failed to read flash count\n");
 		goto exit_free;
 	}
 	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
@@ -470,15 +444,14 @@ static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data
 {
 	struct m10bmc_sec *sec = fwl->dd_handle;
 	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
-	u32 blk_size, doorbell, extra_offset;
-	unsigned int stride, extra = 0;
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	u32 blk_size, doorbell;
 	int ret;
 
-	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
 	if (sec->cancel_request)
 		return rsu_cancel(sec);
 
-	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
+	ret = m10bmc_sys_read(m10bmc, csr_map->doorbell, &doorbell);
 	if (ret) {
 		return FW_UPLOAD_ERR_RW_ERROR;
 	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
@@ -486,28 +459,12 @@ static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data
 		return FW_UPLOAD_ERR_HW_ERROR;
 	}
 
-	WARN_ON_ONCE(WRITE_BLOCK_SIZE % stride);
+	WARN_ON_ONCE(WRITE_BLOCK_SIZE % regmap_get_reg_stride(m10bmc->regmap));
 	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
-	ret = regmap_bulk_write(sec->m10bmc->regmap,
-				M10BMC_STAGING_BASE + offset,
-				(void *)data + offset,
-				blk_size / stride);
+	ret = m10bmc->flash_ops->write(m10bmc, data, offset, blk_size);
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
-	/*
-	 * If blk_size is not aligned to stride, then handle the extra
-	 * bytes with regmap_write.
-	 */
-	if (blk_size % stride) {
-		extra_offset = offset + ALIGN_DOWN(blk_size, stride);
-		memcpy(&extra, (u8 *)(data + extra_offset), blk_size % stride);
-		ret = regmap_write(sec->m10bmc->regmap,
-				   M10BMC_STAGING_BASE + extra_offset, extra);
-		if (ret)
-			return FW_UPLOAD_ERR_RW_ERROR;
-	}
-
 	*written = blk_size;
 	return FW_UPLOAD_ERR_NONE;
 }
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index 611a4ab42717..b70e3e87600a 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -33,6 +33,67 @@ static struct regmap_config intel_m10bmc_regmap_config = {
 	.max_register = M10BMC_MEM_END,
 };
 
+static int m10bmc_spi_flash_write(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size)
+{
+	unsigned int stride = regmap_get_reg_stride(m10bmc->regmap);
+	u32 write_count = size / stride;
+	u32 leftover_offset = write_count * stride;
+	u32 leftover_size = size - leftover_offset;
+	u32 leftover_tmp = 0;
+	int ret;
+
+	if (WARN_ON_ONCE(stride > sizeof(leftover_tmp)))
+		return -EINVAL;
+
+	ret = regmap_bulk_write(m10bmc->regmap, M10BMC_STAGING_BASE + offset,
+				buf + offset, write_count);
+	if (ret)
+		return ret;
+
+	/* If size is not aligned to stride, handle the remainder bytes with regmap_write() */
+	if (leftover_size) {
+		memcpy(&leftover_tmp, buf + leftover_offset, leftover_size);
+		ret = regmap_write(m10bmc->regmap, M10BMC_STAGING_BASE + offset + leftover_offset,
+				   leftover_tmp);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int m10bmc_spi_flash_read(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size)
+{
+	unsigned int stride = regmap_get_reg_stride(m10bmc->regmap);
+	u32 read_count = size / stride;
+	u32 leftover_offset = read_count * stride;
+	u32 leftover_size = size - leftover_offset;
+	u32 leftover_tmp;
+	int ret;
+
+	if (WARN_ON_ONCE(stride > sizeof(leftover_tmp)))
+		return -EINVAL;
+
+	ret = regmap_bulk_read(m10bmc->regmap, addr, buf, read_count);
+	if (ret)
+		return ret;
+
+	/* If size is not aligned to stride, handle the remainder bytes with regmap_read() */
+	if (leftover_size) {
+		ret = regmap_read(m10bmc->regmap, addr + leftover_offset, &leftover_tmp);
+		if (ret)
+			return ret;
+		memcpy(buf + leftover_offset, &leftover_tmp, leftover_size);
+	}
+
+	return 0;
+}
+
+static const struct intel_m10bmc_flash_ops m10bmc_spi_flash_ops = {
+	.read = m10bmc_spi_flash_read,
+	.write = m10bmc_spi_flash_write,
+};
+
 static int check_m10bmc_version(struct intel_m10bmc *ddata)
 {
 	unsigned int v;
@@ -72,6 +133,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 
 	info = (struct intel_m10bmc_platform_info *)id->driver_data;
 	ddata->dev = dev;
+	ddata->flash_ops = &m10bmc_spi_flash_ops;
 
 	ddata->regmap = devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
 	if (IS_ERR(ddata->regmap)) {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 91567375f1bf..7f87e898a212 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -153,16 +153,30 @@ struct intel_m10bmc_platform_info {
 	const struct m10bmc_csr_map *csr_map;
 };
 
+struct intel_m10bmc;
+
+/**
+ * struct intel_m10bmc_flash_ops - device specific operations for flash R/W
+ * @read: read a block of data from flash
+ * @write: write a block of data to flash
+ */
+struct intel_m10bmc_flash_ops {
+	int (*read)(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size);
+	int (*write)(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size);
+};
+
 /**
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
  * @regmap: the regmap used to access registers by m10bmc itself
  * @info: the platform information for MAX10 BMC
+ * @flash_ops: optional device specific operations for flash R/W
  */
 struct intel_m10bmc {
 	struct device *dev;
 	struct regmap *regmap;
 	const struct intel_m10bmc_platform_info *info;
+	const struct intel_m10bmc_flash_ops *flash_ops;
 };
 
 /*
-- 
2.30.2

