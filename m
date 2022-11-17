Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0762DA5A
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Nov 2022 13:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbiKQMJq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Nov 2022 07:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239920AbiKQMHp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Nov 2022 07:07:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3F6F375;
        Thu, 17 Nov 2022 04:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668686862; x=1700222862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sbylU5mQHZgpT+zH2xSW1mwbHa0U+ogTN37ao5A38ds=;
  b=KE3GK/hMB2D5+4BEDRbbmlZX2Frj528ilsNeHD+nALUxguWjoWpsYdm+
   PjO2iFJ7geswnz/D3iek4SAGym+G3BOQcxaXTQH6ZmYtTTyEUEjwI4m55
   ftzSPnYi+1ncJikm5CmpjN/LAzN6+eYuu/IlrpihnORcdCFSDPaO2UX+z
   PMouarJU0jBBrIFwnfdIgj+di3kS6U5qgvPLs+XzwsK7nmzPPL5phAm4z
   uHTC4+ZWWwPKtl257UFFEvYL5Xy4Z331NDfy+JRnuHiQBMaFycM9KLRGh
   G+a6WysDGiJaHEHmg0oHscYZrizvYjzfLXs/8mzG7T1mJDNPVnNnwwKbM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="310462973"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="310462973"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968855933"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968855933"
Received: from kvehmane-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.61.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:37 -0800
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
Subject: [PATCH v2 10/11] fpga: m10bmc-sec: Add support for N6000
Date:   Thu, 17 Nov 2022 14:05:14 +0200
Message-Id: <20221117120515.37807-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support for PMCI-based flash access path and N6000 sec update
support.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c |   3 +
 drivers/mfd/intel-m10-bmc-pmci.c        | 209 ++++++++++++++++++++++++
 2 files changed, 212 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 3bd22d03616a..fa5141f3504b 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -590,6 +590,9 @@ static const struct platform_device_id intel_m10bmc_sec_ids[] = {
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
index 8df79056b0b1..7ac77ed15194 100644
--- a/drivers/mfd/intel-m10-bmc-pmci.c
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -7,9 +7,11 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/dfl.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel-m10-bmc.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -45,9 +47,203 @@
 
 #define M10BMC_PMCI_STAGING_FLASH_COUNT	0x7ff5000
 
+#define M10BMC_PMCI_FLASH_CTRL			0x40
+#define M10BMC_PMCI_FLASH_WR_MODE		BIT(0)
+#define M10BMC_PMCI_FLASH_RD_MODE		BIT(1)
+#define M10BMC_PMCI_FLASH_BUSY			BIT(2)
+#define M10BMC_PMCI_FLASH_FIFO_SPACE		GENMASK(13, 4)
+#define M10BMC_PMCI_FLASH_READ_COUNT		GENMASK(25, 16)
+
+#define M10BMC_PMCI_FLASH_INT_US		1
+#define M10BMC_PMCI_FLASH_TIMEOUT_US		10000
+
+#define M10BMC_PMCI_FLASH_ADDR			0x44
+#define M10BMC_PMCI_FLASH_FIFO			0x800
+#define M10BMC_PMCI_READ_BLOCK_SIZE		0x800
+#define M10BMC_PMCI_FIFO_MAX_BYTES		0x800
+#define M10BMC_PMCI_FIFO_WORD_SIZE		4
+#define M10BMC_PMCI_FIFO_MAX_WORDS		(M10BMC_PMCI_FIFO_MAX_BYTES / \
+						 M10BMC_PMCI_FIFO_WORD_SIZE)
+
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
 struct m10bmc_pmci_device {
 	void __iomem *base;
 	struct intel_m10bmc m10bmc;
+	struct mutex flash_mutex;	/* Prevent concurrent flash burst reads */
+};
+
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
+static int m10bmc_pmci_set_flash_host_mux(struct intel_m10bmc *m10bmc, bool request)
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
+static int m10bmc_pmci_flash_write(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size)
+{
+	return pmci_flash_bulk_write(m10bmc, buf + offset, size);
+}
+
+static int m10bmc_pmci_flash_read(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size)
+{
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+	int ret, ret2;
+
+	mutex_lock(&pmci->flash_mutex);
+	ret = m10bmc_pmci_set_flash_host_mux(m10bmc, true);
+	if (ret)
+		goto read_fail;
+
+	ret = pmci_flash_bulk_read(m10bmc, buf, addr, size);
+
+read_fail:
+	ret2 = m10bmc_pmci_set_flash_host_mux(m10bmc, false);
+	mutex_unlock(&pmci->flash_mutex);
+
+	if (ret)
+		return ret;
+	return ret2;
+}
+
+static const struct intel_m10bmc_flash_ops m10bmc_pmci_flash_ops = {
+	.read = m10bmc_pmci_flash_read,
+	.write = m10bmc_pmci_flash_write,
 };
 
 static const struct regmap_range m10bmc_pmci_regmap_range[] = {
@@ -75,6 +271,7 @@ static struct regmap_config m10bmc_pmci_regmap_config = {
 
 static struct mfd_cell m10bmc_pmci_n6000_bmc_subdevs[] = {
 	{ .name = "n6000bmc-hwmon" },
+	{ .name = "n6000bmc-sec-update" },
 };
 
 static const struct m10bmc_csr_map m10bmc_pmci_csr_map = {
@@ -112,6 +309,9 @@ static int m10bmc_pmci_probe(struct dfl_device *ddev)
 	if (!pmci)
 		return -ENOMEM;
 
+	mutex_init(&pmci->flash_mutex);
+	pmci->m10bmc.flash_ops = &m10bmc_pmci_flash_ops;
+
 	pmci->m10bmc.dev = dev;
 
 	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
@@ -128,6 +328,14 @@ static int m10bmc_pmci_probe(struct dfl_device *ddev)
 	return m10bmc_dev_init(&pmci->m10bmc, &m10bmc_pmci_n6000);
 }
 
+static void m10bmc_pmci_remove(struct dfl_device *ddev)
+{
+	struct intel_m10bmc *m10bmc = dev_get_drvdata(&ddev->dev);
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+
+	mutex_destroy(&pmci->flash_mutex);
+}
+
 #define FME_FEATURE_ID_M10BMC_PMCI	0x12
 
 static const struct dfl_device_id m10bmc_pmci_ids[] = {
@@ -143,6 +351,7 @@ static struct dfl_driver m10bmc_pmci_driver = {
 	},
 	.id_table = m10bmc_pmci_ids,
 	.probe    = m10bmc_pmci_probe,
+	.remove   = m10bmc_pmci_remove,
 };
 
 module_dfl_driver(m10bmc_pmci_driver);
-- 
2.30.2

