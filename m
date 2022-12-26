Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36B656477
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 19:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiLZSAP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 13:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiLZSAK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 13:00:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A532619;
        Mon, 26 Dec 2022 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672077608; x=1703613608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rPIhxDdydNDJFSZPcNRu+MqC1lc70tZR9CA6qxZxD2Y=;
  b=hmewVuyr4t1LKsvXtbfuqYPAm6wuHtPdlOIHc4ibIdX473hP1xAdllpq
   y9/BBYRvrfm3EmSb1nCwzZ1ybwVx1os/qNQ/Gk3ph3t/5BIZY+ySBsK17
   hb/m7h2JJKvrVawoGrDMEePZ1pkXFTQBLwRvuAmflxQkC7qSF//U0WeYd
   f+2AAsfUIjaAlyg9qTSr7EtGcRwIJFnKuXT09ROWUu9ucb+KbWZtsGBLW
   fufEKwTD1/b5MxEuDiOEQyS070rf4UP66e0wH/U7R+8JM9x3mIY5rqx6Z
   YhnTD4FMIf6EOXB7t6A+tuht11sYmPEnKMhmpy9ZVRmaluDwrHrwzeLqi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322571065"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="322571065"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 10:00:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="654810401"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="654810401"
Received: from ptelkov-mobl2.ccr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 10:00:03 -0800
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
Subject: [PATCH v5 10/10] fpga: m10bmc-sec: Add support for N6000
Date:   Mon, 26 Dec 2022 19:58:49 +0200
Message-Id: <20221226175849.13056-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
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

Add support for PMCI-based flash access path and N6000 sec update
support. Access to flash staging area is different for N6000 from that
of the SPI interfaced counterparts.

Introduce intel_m10bmc_flash_bulk_ops to allow interface specific
differentiations for the flash access path for sec update and make
m10bmc_sec_read/write() in sec update driver to use the new operations.

If a failure is detected while altering the flash MUX, it seems safer
to try to set it back and doesn't seem harmful. Likely there are enough
troubles in that case anyway so setting it back fails too (which is
harmless sans the small extra delay) or just confirms that the value
wasn't changed.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c |  65 ++++++++++-
 drivers/mfd/intel-m10-bmc-pmci.c        | 145 ++++++++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h       |  14 +++
 3 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 1fe8b7ff594c..13f429860b03 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -14,6 +14,20 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define M10BMC_PMCI_FLASH_MUX_CTRL	0x1d0
+#define FLASH_MUX_SELECTION		GENMASK(2, 0)
+#define FLASH_MUX_IDLE			0
+#define FLASH_MUX_NIOS			1
+#define FLASH_MUX_HOST			2
+#define FLASH_MUX_PFL			4
+#define get_flash_mux(mux)		FIELD_GET(FLASH_MUX_SELECTION, mux)
+
+#define FLASH_NIOS_REQUEST		BIT(4)
+#define FLASH_HOST_REQUEST		BIT(5)
+
+#define M10_FLASH_INT_US		1
+#define M10_FLASH_TIMEOUT_US		10000
+
 struct m10bmc_sec {
 	struct device *dev;
 	struct intel_m10bmc *m10bmc;
@@ -21,6 +35,7 @@ struct m10bmc_sec {
 	char *fw_name;
 	u32 fw_name_id;
 	bool cancel_request;
+	struct mutex flash_mutex;
 };
 
 static DEFINE_XARRAY_ALLOC(fw_upload_xa);
@@ -31,6 +46,24 @@ static DEFINE_XARRAY_ALLOC(fw_upload_xa);
 #define REH_MAGIC		GENMASK(15, 0)
 #define REH_SHA_NUM_BYTES	GENMASK(31, 16)
 
+static int m10bmc_sec_set_flash_host_mux(struct intel_m10bmc *m10bmc, bool request)
+{
+	u32 ctrl;
+	int ret;
+
+	ret = regmap_update_bits(m10bmc->regmap, M10BMC_PMCI_FLASH_MUX_CTRL,
+				 FLASH_HOST_REQUEST,
+				 FIELD_PREP(FLASH_HOST_REQUEST, request));
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(m10bmc->regmap,
+					M10BMC_PMCI_FLASH_MUX_CTRL, ctrl,
+					request ? (get_flash_mux(ctrl) == FLASH_MUX_HOST) :
+						  (get_flash_mux(ctrl) != FLASH_MUX_HOST),
+					M10_FLASH_INT_US, M10_FLASH_TIMEOUT_US);
+}
+
 static int m10bmc_sec_write(struct m10bmc_sec *sec, const u8 *buf, u32 offset, u32 size)
 {
 	struct intel_m10bmc *m10bmc = sec->m10bmc;
@@ -41,6 +74,15 @@ static int m10bmc_sec_write(struct m10bmc_sec *sec, const u8 *buf, u32 offset, u
 	u32 leftover_tmp = 0;
 	int ret;
 
+	if (sec->m10bmc->flash_bulk_ops) {
+		mutex_lock(&sec->flash_mutex);
+		/* On write, firmware manages flash MUX */
+		ret = sec->m10bmc->flash_bulk_ops->write(m10bmc, buf, offset, size);
+		mutex_unlock(&sec->flash_mutex);
+
+		return ret;
+	}
+
 	if (WARN_ON_ONCE(stride > sizeof(leftover_tmp)))
 		return -EINVAL;
 
@@ -69,7 +111,21 @@ static int m10bmc_sec_read(struct m10bmc_sec *sec, u8 *buf, u32 addr, u32 size)
 	u32 leftover_offset = read_count * stride;
 	u32 leftover_size = size - leftover_offset;
 	u32 leftover_tmp;
-	int ret;
+	int ret, ret2;
+
+	if (sec->m10bmc->flash_bulk_ops) {
+		mutex_lock(&sec->flash_mutex);
+		ret = m10bmc_sec_set_flash_host_mux(m10bmc, true);
+		if (ret)
+			goto mux_fail;
+		ret = sec->m10bmc->flash_bulk_ops->read(m10bmc, buf, addr, size);
+mux_fail:
+		ret2 = m10bmc_sec_set_flash_host_mux(m10bmc, false);
+		mutex_unlock(&sec->flash_mutex);
+		if (ret)
+			return ret;
+		return ret2;
+	}
 
 	if (WARN_ON_ONCE(stride > sizeof(leftover_tmp)))
 		return -EINVAL;
@@ -636,6 +692,8 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	mutex_init(&sec->flash_mutex);
+
 	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
 			sec->fw_name_id);
 	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
@@ -658,6 +716,7 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
 fw_uploader_fail:
 	kfree(sec->fw_name);
 fw_name_fail:
+	mutex_destroy(&sec->flash_mutex);
 	xa_erase(&fw_upload_xa, sec->fw_name_id);
 	return ret;
 }
@@ -668,6 +727,7 @@ static int m10bmc_sec_remove(struct platform_device *pdev)
 
 	firmware_upload_unregister(sec->fwl);
 	kfree(sec->fw_name);
+	mutex_destroy(&sec->flash_mutex);
 	xa_erase(&fw_upload_xa, sec->fw_name_id);
 
 	return 0;
@@ -680,6 +740,9 @@ static const struct platform_device_id intel_m10bmc_sec_ids[] = {
 	{
 		.name = "d5005bmc-sec-update",
 	},
+	{
+		.name = "n6000bmc-sec-update",
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
index 63ec0f6aba8b..1d8819ace535 100644
--- a/drivers/mfd/intel-m10-bmc-pmci.c
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -6,10 +6,12 @@
  * Copyright (C) 2020-2022 Intel Corporation.
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/dfl.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel-m10-bmc.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -45,6 +47,24 @@
 
 #define M10BMC_N6000_STAGING_FLASH_COUNT	0x7ff5000
 
+#define M10BMC_PMCI_FLASH_CTRL			0x40
+#define M10BMC_PMCI_FLASH_WR_MODE		BIT(0)
+#define M10BMC_PMCI_FLASH_RD_MODE		BIT(1)
+#define M10BMC_PMCI_FLASH_BUSY			BIT(2)
+#define M10BMC_PMCI_FLASH_FIFO_SPACE		GENMASK(13, 4)
+#define M10BMC_PMCI_FLASH_READ_COUNT		GENMASK(25, 16)
+
+#define M10BMC_PMCI_FLASH_ADDR			0x44
+#define M10BMC_PMCI_FLASH_FIFO			0x800
+#define M10BMC_PMCI_READ_BLOCK_SIZE		0x800
+#define M10BMC_PMCI_FIFO_MAX_BYTES		0x800
+#define M10BMC_PMCI_FIFO_WORD_SIZE		4
+#define M10BMC_PMCI_FIFO_MAX_WORDS		(M10BMC_PMCI_FIFO_MAX_BYTES / \
+						 M10BMC_PMCI_FIFO_WORD_SIZE)
+
+#define M10BMC_PMCI_FLASH_INT_US		1
+#define M10BMC_PMCI_FLASH_TIMEOUT_US		10000
+
 struct m10bmc_pmci_device {
 	void __iomem *base;
 	struct intel_m10bmc m10bmc;
@@ -147,6 +167,128 @@ static int indirect_reg_write(void *context, unsigned int reg, unsigned int val)
 	return ret;
 }
 
+static void pmci_write_fifo(void __iomem *base, const u32 *buf, size_t count)
+{
+	while (count--)
+		writel(*buf++, base);
+}
+
+static void pmci_read_fifo(void __iomem *base, u32 *buf, size_t count)
+{
+	while (count--)
+		*buf++ = readl(base);
+}
+
+static u32 pmci_get_write_space(struct m10bmc_pmci_device *pmci)
+{
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout(readl, val,
+				FIELD_GET(M10BMC_PMCI_FLASH_FIFO_SPACE, val) ==
+				M10BMC_PMCI_FIFO_MAX_WORDS,
+				M10BMC_PMCI_FLASH_INT_US, M10BMC_PMCI_FLASH_TIMEOUT_US,
+				false, pmci->base + M10BMC_PMCI_FLASH_CTRL);
+	if (ret == -ETIMEDOUT)
+		return 0;
+
+	return FIELD_GET(M10BMC_PMCI_FLASH_FIFO_SPACE, val) * M10BMC_PMCI_FIFO_WORD_SIZE;
+}
+
+static int pmci_flash_bulk_write(struct intel_m10bmc *m10bmc, const u8 *buf, u32 size)
+{
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+	u32 blk_size, offset = 0, write_count;
+
+	while (size) {
+		blk_size = min(pmci_get_write_space(pmci), size);
+		if (blk_size == 0) {
+			dev_err(m10bmc->dev, "get FIFO available size fail\n");
+			return -EIO;
+		}
+
+		if (size < M10BMC_PMCI_FIFO_WORD_SIZE)
+			break;
+
+		write_count = blk_size / M10BMC_PMCI_FIFO_WORD_SIZE;
+		pmci_write_fifo(pmci->base + M10BMC_PMCI_FLASH_FIFO,
+				(u32 *)(buf + offset), write_count);
+
+		size -= blk_size;
+		offset += blk_size;
+	}
+
+	/* Handle remainder (less than M10BMC_PMCI_FIFO_WORD_SIZE bytes) */
+	if (size) {
+		u32 tmp = 0;
+
+		memcpy(&tmp, buf + offset, size);
+		pmci_write_fifo(pmci->base + M10BMC_PMCI_FLASH_FIFO, &tmp, 1);
+	}
+
+	return 0;
+}
+
+static int pmci_flash_bulk_read(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size)
+{
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+	u32 blk_size, offset = 0, val, full_read_count, read_count;
+	int ret;
+
+	while (size) {
+		blk_size = min_t(u32, size, M10BMC_PMCI_READ_BLOCK_SIZE);
+		full_read_count = blk_size / M10BMC_PMCI_FIFO_WORD_SIZE;
+
+		read_count = full_read_count;
+		if (full_read_count * M10BMC_PMCI_FIFO_WORD_SIZE < blk_size)
+			read_count++;
+
+		writel(addr + offset, pmci->base + M10BMC_PMCI_FLASH_ADDR);
+		writel(FIELD_PREP(M10BMC_PMCI_FLASH_READ_COUNT, read_count) |
+		       M10BMC_PMCI_FLASH_RD_MODE,
+		       pmci->base + M10BMC_PMCI_FLASH_CTRL);
+
+		ret = readl_poll_timeout((pmci->base + M10BMC_PMCI_FLASH_CTRL), val,
+					 !(val & M10BMC_PMCI_FLASH_BUSY),
+					 M10BMC_PMCI_FLASH_INT_US, M10BMC_PMCI_FLASH_TIMEOUT_US);
+		if (ret) {
+			dev_err(m10bmc->dev, "read timed out on reading flash 0x%xn", val);
+			return ret;
+		}
+
+		if (size < M10BMC_PMCI_FIFO_WORD_SIZE)
+			break;
+
+		pmci_read_fifo(pmci->base + M10BMC_PMCI_FLASH_FIFO,
+			       (u32 *)(buf + offset), full_read_count);
+
+		size -= blk_size;
+		offset += blk_size;
+
+		writel(0, pmci->base + M10BMC_PMCI_FLASH_CTRL);
+	}
+
+	/* Handle remainder (less than M10BMC_PMCI_FIFO_WORD_SIZE bytes) */
+	if (size) {
+		u32 tmp;
+
+		pmci_read_fifo(pmci->base + M10BMC_PMCI_FLASH_FIFO, &tmp, 1);
+		memcpy(buf + offset, &tmp, size);
+	}
+
+	return 0;
+}
+
+static int m10bmc_pmci_flash_write(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size)
+{
+	return pmci_flash_bulk_write(m10bmc, buf + offset, size);
+}
+
+static const struct intel_m10bmc_flash_bulk_ops m10bmc_pmci_flash_bulk_ops = {
+	.read = pmci_flash_bulk_read,
+	.write = m10bmc_pmci_flash_write,
+};
+
 static const struct regmap_range m10bmc_pmci_regmap_range[] = {
 	regmap_reg_range(M10BMC_N6000_SYS_BASE, M10BMC_N6000_SYS_END),
 };
@@ -169,6 +311,7 @@ static struct regmap_config m10bmc_pmci_regmap_config = {
 
 static struct mfd_cell m10bmc_pmci_n6000_bmc_subdevs[] = {
 	{ .name = "n6000bmc-hwmon" },
+	{ .name = "n6000bmc-sec-update" },
 };
 
 static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
@@ -208,6 +351,8 @@ static int m10bmc_pmci_probe(struct dfl_device *ddev)
 	if (!pmci)
 		return -ENOMEM;
 
+	pmci->m10bmc.flash_bulk_ops = &m10bmc_pmci_flash_bulk_ops;
+
 	pmci->m10bmc.dev = dev;
 
 	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index cc2d9eb597b0..8e437b996738 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -108,16 +108,30 @@ struct intel_m10bmc_platform_info {
 	const struct m10bmc_csr_map *csr_map;
 };
 
+struct intel_m10bmc;
+
+/**
+ * struct intel_m10bmc_flash_bulk_ops - device specific operations for flash R/W
+ * @read: read a block of data from flash
+ * @write: write a block of data to flash
+ */
+struct intel_m10bmc_flash_bulk_ops {
+	int (*read)(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size);
+	int (*write)(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size);
+};
+
 /**
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
  * @regmap: the regmap used to access registers by m10bmc itself
  * @info: the platform information for MAX10 BMC
+ * @flash_bulk_ops: optional device specific operations for flash R/W
  */
 struct intel_m10bmc {
 	struct device *dev;
 	struct regmap *regmap;
 	const struct intel_m10bmc_platform_info *info;
+	const struct intel_m10bmc_flash_bulk_ops *flash_bulk_ops;
 };
 
 /*
-- 
2.30.2

