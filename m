Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3F65646F
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiLZR7o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 12:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiLZR7d (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 12:59:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D92652;
        Mon, 26 Dec 2022 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672077572; x=1703613572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmQbpbi1b7qfJzwOUJbGmxnyulYxETMZ6y79Kt7WR5k=;
  b=T2OaxksHC55HipohOf0MoB4X/NDZl7BUsmHNvQz4xmbLWCBAI6WINcEP
   OdCmXMd/oWmmsqKgrFefSnDThGlLNvhyShETIt/V6Tva3OKEF8IU/j4Dy
   mDXPlb5AU3igzpXbJZvu82V+j4qarzwuCkkCRZbkgxH9SSSnn4gdxtwRh
   9Y5pdEDgb40JsYHOyP0sypEZsN4VcKWdfB0oDrbwiHUMepksrod5Hk8bE
   aV5ZtD+OKcgwRISTtKmJeWG6CHtXSuHdkoSQmTynq5FQhKkxml0Ylv0SA
   OdOMHQbmBzV+ppEiDZl5vkDQBvvHYxDnVzK8fmBM8ti2PPVcetgAmE2v9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322570995"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="322570995"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:59:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="654810082"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="654810082"
Received: from ptelkov-mobl2.ccr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:59:27 -0800
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
Subject: [PATCH v5 04/10] mfd: intel-m10-bmc: Support multiple CSR register layouts
Date:   Mon, 26 Dec 2022 19:58:43 +0200
Message-Id: <20221226175849.13056-5-ilpo.jarvinen@linux.intel.com>
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

There are different addresses for the MAX10 CSR registers. Introducing
a new data structure m10bmc_csr_map for the register definition of
MAX10 CSR.

Provide the csr_map for SPI.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 73 +++++++++++++++++--------
 drivers/mfd/intel-m10-bmc-core.c        | 10 ++--
 drivers/mfd/intel-m10-bmc-spi.c         | 24 ++++++++
 include/linux/mfd/intel-m10-bmc.h       | 39 +++++++++++--
 4 files changed, 113 insertions(+), 33 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 03f1bd81c434..798c1828899b 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -73,16 +73,24 @@ show_root_entry_hash(struct device *dev, u32 exp_magic,
 	return cnt;
 }
 
-#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
+#define DEVICE_ATTR_SEC_REH_RO(_name)						\
 static ssize_t _name##_root_entry_hash_show(struct device *dev, \
 					    struct device_attribute *attr, \
 					    char *buf) \
-{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
+{										\
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);				\
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;	\
+										\
+	return show_root_entry_hash(dev, csr_map->_name##_magic,		\
+				    csr_map->_name##_prog_addr,			\
+				    csr_map->_name##_reh_addr,			\
+				    buf);					\
+}										\
 static DEVICE_ATTR_RO(_name##_root_entry_hash)
 
-DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
-DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
-DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
+DEVICE_ATTR_SEC_REH_RO(bmc);
+DEVICE_ATTR_SEC_REH_RO(sr);
+DEVICE_ATTR_SEC_REH_RO(pr);
 
 #define CSK_BIT_LEN		128U
 #define CSK_32ARRAY_SIZE	DIV_ROUND_UP(CSK_BIT_LEN, 32)
@@ -122,18 +130,25 @@ show_canceled_csk(struct device *dev, u32 addr, char *buf)
 	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
 }
 
-#define DEVICE_ATTR_SEC_CSK_RO(_name, _addr) \
+#define DEVICE_ATTR_SEC_CSK_RO(_name)						\
 static ssize_t _name##_canceled_csks_show(struct device *dev, \
 					  struct device_attribute *attr, \
 					  char *buf) \
-{ return show_canceled_csk(dev, _addr, buf); } \
+{										\
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);				\
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;	\
+										\
+	return show_canceled_csk(dev,						\
+				 csr_map->_name##_prog_addr + CSK_VEC_OFFSET,	\
+				 buf);						\
+}										\
 static DEVICE_ATTR_RO(_name##_canceled_csks)
 
 #define CSK_VEC_OFFSET 0x34
 
-DEVICE_ATTR_SEC_CSK_RO(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET);
-DEVICE_ATTR_SEC_CSK_RO(sr, SR_PROG_ADDR + CSK_VEC_OFFSET);
-DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
+DEVICE_ATTR_SEC_CSK_RO(bmc);
+DEVICE_ATTR_SEC_CSK_RO(sr);
+DEVICE_ATTR_SEC_CSK_RO(pr);
 
 #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
 
@@ -141,6 +156,7 @@ static ssize_t flash_count_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	unsigned int stride, num_bits;
 	u8 *flash_buf;
 	int cnt, ret;
@@ -160,12 +176,12 @@ static ssize_t flash_count_show(struct device *dev,
 	if (!flash_buf)
 		return -ENOMEM;
 
-	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
+	ret = regmap_bulk_read(sec->m10bmc->regmap, csr_map->rsu_update_counter,
 			       flash_buf, FLASH_COUNT_SIZE / stride);
 	if (ret) {
 		dev_err(sec->dev,
 			"failed to read flash count: %x cnt %x: %d\n",
-			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
+			csr_map->rsu_update_counter, FLASH_COUNT_SIZE / stride, ret);
 		goto exit_free;
 	}
 	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
@@ -200,20 +216,22 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
 
 static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
 {
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	u32 auth_result;
 
 	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
 
-	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
+	if (!m10bmc_sys_read(sec->m10bmc, csr_map->auth_result, &auth_result))
 		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
 }
 
 static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
 {
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	u32 doorbell;
 	int ret;
 
-	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
@@ -246,11 +264,12 @@ static inline bool rsu_start_done(u32 doorbell)
 
 static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
 {
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	u32 doorbell, status;
 	int ret;
 
 	ret = regmap_update_bits(sec->m10bmc->regmap,
-				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 csr_map->base + csr_map->doorbell,
 				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
 				 DRBL_RSU_REQUEST |
 				 FIELD_PREP(DRBL_HOST_STATUS,
@@ -259,7 +278,7 @@ static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
 	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
-				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       csr_map->base + csr_map->doorbell,
 				       doorbell,
 				       rsu_start_done(doorbell),
 				       NIOS_HANDSHAKE_INTERVAL_US,
@@ -286,11 +305,12 @@ static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
 
 static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
 {
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	unsigned long poll_timeout;
 	u32 doorbell, progress;
 	int ret;
 
-	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
@@ -300,7 +320,7 @@ static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
 		if (time_after(jiffies, poll_timeout))
 			break;
 
-		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+		ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
 		if (ret)
 			return FW_UPLOAD_ERR_RW_ERROR;
 	}
@@ -319,11 +339,12 @@ static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
 
 static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
 {
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	u32 doorbell;
 	int ret;
 
 	ret = regmap_update_bits(sec->m10bmc->regmap,
-				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 csr_map->base + csr_map->doorbell,
 				 DRBL_HOST_STATUS,
 				 FIELD_PREP(DRBL_HOST_STATUS,
 					    HOST_STATUS_WRITE_DONE));
@@ -331,7 +352,7 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
 	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
-				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       csr_map->base + csr_map->doorbell,
 				       doorbell,
 				       rsu_prog(doorbell) != RSU_PROG_READY,
 				       NIOS_HANDSHAKE_INTERVAL_US,
@@ -360,7 +381,9 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
 
 static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
 {
-	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+
+	if (m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, doorbell))
 		return -EIO;
 
 	switch (rsu_stat(*doorbell)) {
@@ -389,10 +412,11 @@ static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
 
 static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
 {
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	u32 doorbell;
 	int ret;
 
-	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
@@ -400,7 +424,7 @@ static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
 		return FW_UPLOAD_ERR_BUSY;
 
 	ret = regmap_update_bits(sec->m10bmc->regmap,
-				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 csr_map->base + csr_map->doorbell,
 				 DRBL_HOST_STATUS,
 				 FIELD_PREP(DRBL_HOST_STATUS,
 					    HOST_STATUS_ABORT_RSU));
@@ -445,6 +469,7 @@ static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data
 					   u32 offset, u32 size, u32 *written)
 {
 	struct m10bmc_sec *sec = fwl->dd_handle;
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	u32 blk_size, doorbell, extra_offset;
 	unsigned int stride, extra = 0;
 	int ret;
@@ -453,7 +478,7 @@ static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data
 	if (sec->cancel_request)
 		return rsu_cancel(sec);
 
-	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
 	if (ret) {
 		return FW_UPLOAD_ERR_RW_ERROR;
 	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index 6630b81b10c4..51b78b868235 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -19,7 +19,7 @@ static ssize_t bmc_version_show(struct device *dev,
 	unsigned int val;
 	int ret;
 
-	ret = m10bmc_sys_read(ddata, M10BMC_BUILD_VER, &val);
+	ret = m10bmc_sys_read(ddata, ddata->info->csr_map->build_version, &val);
 	if (ret)
 		return ret;
 
@@ -34,7 +34,7 @@ static ssize_t bmcfw_version_show(struct device *dev,
 	unsigned int val;
 	int ret;
 
-	ret = m10bmc_sys_read(ddata, NIOS2_FW_VERSION, &val);
+	ret = m10bmc_sys_read(ddata, ddata->info->csr_map->fw_version, &val);
 	if (ret)
 		return ret;
 
@@ -49,11 +49,11 @@ static ssize_t mac_address_show(struct device *dev,
 	unsigned int macaddr_low, macaddr_high;
 	int ret;
 
-	ret = m10bmc_sys_read(ddata, M10BMC_MAC_LOW, &macaddr_low);
+	ret = m10bmc_sys_read(ddata, ddata->info->csr_map->mac_low, &macaddr_low);
 	if (ret)
 		return ret;
 
-	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
+	ret = m10bmc_sys_read(ddata, ddata->info->csr_map->mac_high, &macaddr_high);
 	if (ret)
 		return ret;
 
@@ -74,7 +74,7 @@ static ssize_t mac_count_show(struct device *dev,
 	unsigned int macaddr_high;
 	int ret;
 
-	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
+	ret = m10bmc_sys_read(ddata, ddata->info->csr_map->mac_high, &macaddr_high);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index be1d4ddedabb..e8986154e965 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -91,6 +91,27 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 	return m10bmc_dev_init(ddata, info);
 }
 
+static const struct m10bmc_csr_map m10bmc_n3000_csr_map = {
+	.base = M10BMC_SYS_BASE,
+	.build_version = M10BMC_BUILD_VER,
+	.fw_version = NIOS2_FW_VERSION,
+	.mac_low = M10BMC_MAC_LOW,
+	.mac_high = M10BMC_MAC_HIGH,
+	.doorbell = M10BMC_DOORBELL,
+	.auth_result = M10BMC_AUTH_RESULT,
+	.rsu_status = M10BMC_DOORBELL,
+	.bmc_prog_addr = BMC_PROG_ADDR,
+	.bmc_reh_addr = BMC_REH_ADDR,
+	.bmc_magic = BMC_PROG_MAGIC,
+	.sr_prog_addr = SR_PROG_ADDR,
+	.sr_reh_addr = SR_REH_ADDR,
+	.sr_magic = SR_PROG_MAGIC,
+	.pr_prog_addr = PR_PROG_ADDR,
+	.pr_reh_addr = PR_REH_ADDR,
+	.pr_magic = PR_PROG_MAGIC,
+	.rsu_update_counter = STAGING_FLASH_COUNT,
+};
+
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
 	{ .name = "d5005bmc-hwmon" },
 	{ .name = "d5005bmc-sec-update" },
@@ -109,16 +130,19 @@ static struct mfd_cell m10bmc_n5010_subdevs[] = {
 static const struct intel_m10bmc_platform_info m10bmc_spi_n3000 = {
 	.cells = m10bmc_pacn3000_subdevs,
 	.n_cells = ARRAY_SIZE(m10bmc_pacn3000_subdevs),
+	.csr_map = &m10bmc_n3000_csr_map,
 };
 
 static const struct intel_m10bmc_platform_info m10bmc_spi_d5005 = {
 	.cells = m10bmc_d5005_subdevs,
 	.n_cells = ARRAY_SIZE(m10bmc_d5005_subdevs),
+	.csr_map = &m10bmc_n3000_csr_map,
 };
 
 static const struct intel_m10bmc_platform_info m10bmc_spi_n5010 = {
 	.cells = m10bmc_n5010_subdevs,
 	.n_cells = ARRAY_SIZE(m10bmc_n5010_subdevs),
+	.csr_map = &m10bmc_n3000_csr_map,
 };
 
 static const struct spi_device_id m10bmc_spi_id[] = {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 82e0820e146e..a009dd82f698 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -118,14 +118,40 @@
 /* Address of 4KB inverted bit vector containing staging area FLASH count */
 #define STAGING_FLASH_COUNT	0x17ffb000
 
+/**
+ * struct m10bmc_csr_map - Intel MAX 10 BMC CSR register map
+ */
+struct m10bmc_csr_map {
+	unsigned int base;
+	unsigned int build_version;
+	unsigned int fw_version;
+	unsigned int mac_low;
+	unsigned int mac_high;
+	unsigned int doorbell;
+	unsigned int auth_result;
+	unsigned int rsu_status;
+	unsigned int bmc_prog_addr;
+	unsigned int bmc_reh_addr;
+	unsigned int bmc_magic;
+	unsigned int sr_prog_addr;
+	unsigned int sr_reh_addr;
+	unsigned int sr_magic;
+	unsigned int pr_prog_addr;
+	unsigned int pr_reh_addr;
+	unsigned int pr_magic;
+	unsigned int rsu_update_counter;
+};
+
 /**
  * struct intel_m10bmc_platform_info - Intel MAX 10 BMC platform specific information
  * @cells: MFD cells
  * @n_cells: MFD cells ARRAY_SIZE()
+ * @csr_map: the mappings for register definition of MAX10 BMC
  */
 struct intel_m10bmc_platform_info {
 	struct mfd_cell *cells;
 	int n_cells;
+	const struct m10bmc_csr_map *csr_map;
 };
 
 /**
@@ -164,12 +190,17 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
  * The base of the system registers could be configured by HW developers, and
  * in HW SPEC, the base is not added to the addresses of the system registers.
  *
- * This macro helps to simplify the accessing of the system registers. And if
+ * This function helps to simplify the accessing of the system registers. And if
  * the base is reconfigured in HW, SW developers could simply change the
- * M10BMC_SYS_BASE accordingly.
+ * csr_map's base accordingly.
  */
-#define m10bmc_sys_read(m10bmc, offset, val) \
-	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
+static inline int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset,
+				  unsigned int *val)
+{
+	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
+
+	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
+}
 
 /*
  * MAX10 BMC Core support
-- 
2.30.2

