Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45B36493B7
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Dec 2022 11:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiLKKkn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Dec 2022 05:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiLKKkU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Dec 2022 05:40:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F01FAC4;
        Sun, 11 Dec 2022 02:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670755211; x=1702291211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rkEGcfLbCtgBIepaaKMT4C2lnYEzh4SbkbWrBub9CEc=;
  b=D50INeQ6SSI0WMeUTxLDv+HTMcoXfmU9Ox0e3WI6gN3DbbMWWGmuAFcm
   v2QuJvDp4GAmzvJk3nKtRIhoZT9RBmIG5PecBSmSAxfq0KeGYg9Zroucg
   UUzZeLgdJGfXDv9wyx+d/G68YwoG96NP3Q8jt82RNO7QUf+SYGR2ZNESx
   BoQHQlvgreNJZTp5YJ+3uJCR1E9kpWZt4XmPjYs/bZE+oW/wdeerGUOlT
   FyAJqefKCZ1U/nEMIX7pODJ7loyHTrgQL8p8wHk48dCtTRgApg8ECtKAa
   ITCwIQIAeHlsbEcpGfmO/qrQNJ970cNZmub3QLEDlqJkDDiO4Gmuqvqe6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="379899653"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="379899653"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 02:40:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="754575489"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="754575489"
Received: from dratzker-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 02:40:05 -0800
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
Subject: [PATCH v4 5/8] fpga: intel-m10-bmc: Rework flash read/write
Date:   Sun, 11 Dec 2022 12:39:10 +0200
Message-Id: <20221211103913.5287-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221211103913.5287-1-ilpo.jarvinen@linux.intel.com>
References: <20221211103913.5287-1-ilpo.jarvinen@linux.intel.com>
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

Access to flash staging area is different for N6000 from that of the
SPI interfaced counterparts. To make it easier to differentiate flash
access path, move read/write into new functions where the new access
path can be easily placed into. Rework the unaligned access such the
behavior it matches for both read and write.

This change also renames m10bmc_sec_write() to m10bmc_sec_fw_write() as
it would have a name conflict otherwise.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 143 +++++++++++++-----------
 1 file changed, 79 insertions(+), 64 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 798c1828899b..9922027856a4 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -31,6 +31,65 @@ static DEFINE_XARRAY_ALLOC(fw_upload_xa);
 #define REH_MAGIC		GENMASK(15, 0)
 #define REH_SHA_NUM_BYTES	GENMASK(31, 16)
 
+static int m10bmc_sec_write(struct m10bmc_sec *sec, const u8 *buf, u32 offset, u32 size)
+{
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
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
+static int m10bmc_sec_read(struct m10bmc_sec *sec, u8 *buf, u32 addr, u32 size)
+{
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
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
+
 static ssize_t
 show_root_entry_hash(struct device *dev, u32 exp_magic,
 		     u32 prog_addr, u32 reh_addr, char *buf)
@@ -38,11 +97,9 @@ show_root_entry_hash(struct device *dev, u32 exp_magic,
 	struct m10bmc_sec *sec = dev_get_drvdata(dev);
 	int sha_num_bytes, i, ret, cnt = 0;
 	u8 hash[REH_SHA384_SIZE];
-	unsigned int stride;
 	u32 magic;
 
-	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
-	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
+	ret = m10bmc_sec_read(sec, (u8 *)&magic, prog_addr, sizeof(magic));
 	if (ret)
 		return ret;
 
@@ -50,19 +107,16 @@ show_root_entry_hash(struct device *dev, u32 exp_magic,
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
+	ret = m10bmc_sec_read(sec, hash, reh_addr, sha_num_bytes);
 	if (ret) {
-		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
-			reh_addr, sha_num_bytes / stride, ret);
+		dev_err(dev, "failed to read root entry hash\n");
 		return ret;
 	}
 
@@ -98,27 +152,16 @@ DEVICE_ATTR_SEC_REH_RO(pr);
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
+	ret = m10bmc_sec_read(sec, (u8 *)&csk_le32, addr, size);
 	if (ret) {
-		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
-			addr, size / stride, ret);
+		dev_err(sec->dev, "failed to read CSK vector\n");
 		return ret;
 	}
 
@@ -157,31 +200,20 @@ static ssize_t flash_count_show(struct device *dev,
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
+	ret = m10bmc_sec_read(sec, flash_buf, csr_map->rsu_update_counter,
+			      FLASH_COUNT_SIZE);
 	if (ret) {
-		dev_err(sec->dev,
-			"failed to read flash count: %x cnt %x: %d\n",
-			csr_map->rsu_update_counter, FLASH_COUNT_SIZE / stride, ret);
+		dev_err(sec->dev, "failed to read flash count\n");
 		goto exit_free;
 	}
 	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
@@ -465,20 +497,19 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
 
 #define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
 
-static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data,
-					   u32 offset, u32 size, u32 *written)
+static enum fw_upload_err m10bmc_sec_fw_write(struct fw_upload *fwl, const u8 *data,
+					      u32 offset, u32 size, u32 *written)
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
@@ -486,28 +517,12 @@ static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data
 		return FW_UPLOAD_ERR_HW_ERROR;
 	}
 
-	WARN_ON_ONCE(WRITE_BLOCK_SIZE % stride);
+	WARN_ON_ONCE(WRITE_BLOCK_SIZE % regmap_get_reg_stride(m10bmc->regmap));
 	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
-	ret = regmap_bulk_write(sec->m10bmc->regmap,
-				M10BMC_STAGING_BASE + offset,
-				(void *)data + offset,
-				blk_size / stride);
+	ret = m10bmc_sec_write(sec, data, offset, blk_size);
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
@@ -568,7 +583,7 @@ static void m10bmc_sec_cleanup(struct fw_upload *fwl)
 
 static const struct fw_upload_ops m10bmc_ops = {
 	.prepare = m10bmc_sec_prepare,
-	.write = m10bmc_sec_write,
+	.write = m10bmc_sec_fw_write,
 	.poll_complete = m10bmc_sec_poll_complete,
 	.cancel = m10bmc_sec_cancel,
 	.cleanup = m10bmc_sec_cleanup,
-- 
2.30.2

