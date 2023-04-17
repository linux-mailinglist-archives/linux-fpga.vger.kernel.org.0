Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E726E43E4
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDQJ2S (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjDQJ1l (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 05:27:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564992D62;
        Mon, 17 Apr 2023 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681723644; x=1713259644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MHGEtcKcY+puHEIF6HdRQcSnr9Fy0usGjiNOAMUcUJU=;
  b=JRaog/aMbbgzc5p1QSjothqEvTy23HYZGWz7kG/BHr1SMuh2TrGo1WOr
   Tb6pu7TostXQGcuGZ5udKXkM/UtAduzxIPcqFedQWqJoGYAydNe9LoWMt
   UKRdKfm21bq4+A39fiO+tRAuVi5ZjvX8wkZGjtOvVIXNfSzRXYORIjvEx
   LmMKAq0fpGQdtmsDl+mUQMJfR9GzwySMvPnicAopaQ5Oixwr9DyKlQQyF
   OGk4t/sSr28KTx4uLI9Gk752Emp++0jGxFQMsk/ts7TWwna7nlXS98a/D
   DoG2s7Bn1LsKXfRMVhl1lzFdcpHMasDq7rrSfVJDcU/3lWlhw3LUMBGI9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="344846521"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="344846521"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="684094864"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="684094864"
Received: from anicosix-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.35.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:27:19 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw handshake registers
Date:   Mon, 17 Apr 2023 12:26:53 +0300
Message-Id: <20230417092653.16487-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
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

On some MAX 10 cards, the BMC firmware is not available to service
handshake registers during secure update erase and write phases at
normal speeds. This problem affects at least hwmon driver. When the MAX
10 hwmon driver tries to read the sensor values during a secure update,
the reads are slowed down (e.g., reading all D5005 sensors takes ~24s
which is magnitudes worse than the normal <0.02s).

Manage access to the handshake registers using a rw semaphore and a FW
state variable to prevent accesses during those secure update phases
and return -EBUSY instead.

If handshake_sys_reg_nranges == 0, don't update bwcfw_state as it is not
used. This avoids the locking cost.

Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Co-developed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 17 +++++--
 drivers/mfd/intel-m10-bmc-core.c        | 67 ++++++++++++++++++++++++-
 drivers/mfd/intel-m10-bmc-spi.c         | 14 ++++++
 include/linux/mfd/intel-m10-bmc.h       | 28 +++++++++++
 4 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index fe0127a58eff..31af2e08c825 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -544,21 +544,28 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
 	if (ret != FW_UPLOAD_ERR_NONE)
 		goto unlock_flash;
 
+	m10bmc_fw_state_set(sec->m10bmc, M10BMC_FW_STATE_SEC_UPDATE_PREPARE);
+
 	ret = rsu_update_init(sec);
 	if (ret != FW_UPLOAD_ERR_NONE)
-		goto unlock_flash;
+		goto fw_state_exit;
 
 	ret = rsu_prog_ready(sec);
 	if (ret != FW_UPLOAD_ERR_NONE)
-		goto unlock_flash;
+		goto fw_state_exit;
 
 	if (sec->cancel_request) {
 		ret = rsu_cancel(sec);
-		goto unlock_flash;
+		goto fw_state_exit;
 	}
 
+	m10bmc_fw_state_set(sec->m10bmc, M10BMC_FW_STATE_SEC_UPDATE_WRITE);
+
 	return FW_UPLOAD_ERR_NONE;
 
+fw_state_exit:
+	m10bmc_fw_state_set(sec->m10bmc, M10BMC_FW_STATE_NORMAL);
+
 unlock_flash:
 	if (sec->m10bmc->flash_bulk_ops)
 		sec->m10bmc->flash_bulk_ops->unlock_write(sec->m10bmc);
@@ -607,6 +614,8 @@ static enum fw_upload_err m10bmc_sec_poll_complete(struct fw_upload *fwl)
 	if (sec->cancel_request)
 		return rsu_cancel(sec);
 
+	m10bmc_fw_state_set(sec->m10bmc, M10BMC_FW_STATE_SEC_UPDATE_PROGRAM);
+
 	result = rsu_send_data(sec);
 	if (result != FW_UPLOAD_ERR_NONE)
 		return result;
@@ -650,6 +659,8 @@ static void m10bmc_sec_cleanup(struct fw_upload *fwl)
 
 	(void)rsu_cancel(sec);
 
+	m10bmc_fw_state_set(sec->m10bmc, M10BMC_FW_STATE_NORMAL);
+
 	if (sec->m10bmc->flash_bulk_ops)
 		sec->m10bmc->flash_bulk_ops->unlock_write(sec->m10bmc);
 }
diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index 51f865174796..8ad5b3821584 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -12,6 +12,46 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 
+void m10bmc_fw_state_set(struct intel_m10bmc *m10bmc, enum m10bmc_fw_state new_state)
+{
+	/* bmcfw_state is only needed if handshake_sys_reg_nranges > 0 */
+	if (!m10bmc->info->handshake_sys_reg_nranges)
+		return;
+
+	down_write(&m10bmc->bmcfw_lock);
+	m10bmc->bmcfw_state = new_state;
+	up_write(&m10bmc->bmcfw_lock);
+}
+EXPORT_SYMBOL_NS_GPL(m10bmc_fw_state_set, INTEL_M10_BMC_CORE);
+
+/*
+ * For some Intel FPGA devices, the BMC firmware is not available to service
+ * handshake registers during a secure update.
+ */
+static bool m10bmc_reg_always_available(struct intel_m10bmc *m10bmc, unsigned int offset)
+{
+	if (!m10bmc->info->handshake_sys_reg_nranges)
+		return true;
+
+	return !regmap_reg_in_ranges(offset, m10bmc->info->handshake_sys_reg_ranges,
+				     m10bmc->info->handshake_sys_reg_nranges);
+}
+
+/*
+ * m10bmc_handshake_reg_unavailable - Checks if reg access collides with secure update state
+ * @m10bmc: M10 BMC structure
+ *
+ * For some Intel FPGA devices, the BMC firmware is not available to service
+ * handshake registers during a secure update erase and write phases.
+ *
+ * Context: @m10bmc->bmcfw_lock must be held.
+ */
+static bool m10bmc_handshake_reg_unavailable(struct intel_m10bmc *m10bmc)
+{
+	return m10bmc->bmcfw_state == M10BMC_FW_STATE_SEC_UPDATE_PREPARE ||
+	       m10bmc->bmcfw_state == M10BMC_FW_STATE_SEC_UPDATE_WRITE;
+}
+
 /*
  * This function helps to simplify the accessing of the system registers.
  *
@@ -21,8 +61,19 @@
 int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset, unsigned int *val)
 {
 	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
+	int ret;
+
+	if (m10bmc_reg_always_available(m10bmc, offset))
+		return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
 
-	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
+	down_read(&m10bmc->bmcfw_lock);
+	if (m10bmc_handshake_reg_unavailable(m10bmc))
+		ret = -EBUSY;	/* Reg not available during secure update */
+	else
+		ret = m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
+	up_read(&m10bmc->bmcfw_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(m10bmc_sys_read, INTEL_M10_BMC_CORE);
 
@@ -30,8 +81,19 @@ int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
 			   unsigned int msk, unsigned int val)
 {
 	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
+	int ret;
 
-	return regmap_update_bits(m10bmc->regmap, csr_map->base + offset, msk, val);
+	if (m10bmc_reg_always_available(m10bmc, offset))
+		return regmap_update_bits(m10bmc->regmap, csr_map->base + offset, msk, val);
+
+	down_read(&m10bmc->bmcfw_lock);
+	if (m10bmc_handshake_reg_unavailable(m10bmc))
+		ret = -EBUSY;	/* Reg not available during secure update */
+	else
+		ret = regmap_update_bits(m10bmc->regmap, csr_map->base + offset, msk, val);
+	up_read(&m10bmc->bmcfw_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(m10bmc_sys_update_bits, INTEL_M10_BMC_CORE);
 
@@ -129,6 +191,7 @@ int m10bmc_dev_init(struct intel_m10bmc *m10bmc, const struct intel_m10bmc_platf
 
 	m10bmc->info = info;
 	dev_set_drvdata(m10bmc->dev, m10bmc);
+	init_rwsem(&m10bmc->bmcfw_lock);
 
 	ret = devm_mfd_add_devices(m10bmc->dev, PLATFORM_DEVID_AUTO,
 				   info->cells, info->n_cells,
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index edd266557ab9..cbeb7de9e041 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -116,12 +116,20 @@ static struct mfd_cell m10bmc_d5005_subdevs[] = {
 	{ .name = "d5005bmc-sec-update" },
 };
 
+static const struct regmap_range m10bmc_d5005_fw_handshake_regs[] = {
+	regmap_reg_range(M10BMC_N3000_TELEM_START, M10BMC_D5005_TELEM_END),
+};
+
 static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
 	{ .name = "n3000bmc-hwmon" },
 	{ .name = "n3000bmc-retimer" },
 	{ .name = "n3000bmc-sec-update" },
 };
 
+static const struct regmap_range m10bmc_n3000_fw_handshake_regs[] = {
+	regmap_reg_range(M10BMC_N3000_TELEM_START, M10BMC_N3000_TELEM_END),
+};
+
 static struct mfd_cell m10bmc_n5010_subdevs[] = {
 	{ .name = "n5010bmc-hwmon" },
 };
@@ -129,18 +137,24 @@ static struct mfd_cell m10bmc_n5010_subdevs[] = {
 static const struct intel_m10bmc_platform_info m10bmc_spi_n3000 = {
 	.cells = m10bmc_pacn3000_subdevs,
 	.n_cells = ARRAY_SIZE(m10bmc_pacn3000_subdevs),
+	.handshake_sys_reg_ranges = m10bmc_n3000_fw_handshake_regs,
+	.handshake_sys_reg_nranges = ARRAY_SIZE(m10bmc_n3000_fw_handshake_regs),
 	.csr_map = &m10bmc_n3000_csr_map,
 };
 
 static const struct intel_m10bmc_platform_info m10bmc_spi_d5005 = {
 	.cells = m10bmc_d5005_subdevs,
 	.n_cells = ARRAY_SIZE(m10bmc_d5005_subdevs),
+	.handshake_sys_reg_ranges = m10bmc_d5005_fw_handshake_regs,
+	.handshake_sys_reg_nranges = ARRAY_SIZE(m10bmc_d5005_fw_handshake_regs),
 	.csr_map = &m10bmc_n3000_csr_map,
 };
 
 static const struct intel_m10bmc_platform_info m10bmc_spi_n5010 = {
 	.cells = m10bmc_n5010_subdevs,
 	.n_cells = ARRAY_SIZE(m10bmc_n5010_subdevs),
+	.handshake_sys_reg_ranges = m10bmc_n3000_fw_handshake_regs,
+	.handshake_sys_reg_nranges = ARRAY_SIZE(m10bmc_n3000_fw_handshake_regs),
 	.csr_map = &m10bmc_n3000_csr_map,
 };
 
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 252644fa61be..ee66c9751003 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -11,6 +11,7 @@
 #include <linux/bits.h>
 #include <linux/dev_printk.h>
 #include <linux/regmap.h>
+#include <linux/rwsem.h>
 
 #define M10BMC_N3000_LEGACY_BUILD_VER	0x300468
 #define M10BMC_N3000_SYS_BASE		0x300800
@@ -39,6 +40,11 @@
 #define M10BMC_N3000_VER_PCB_INFO_MSK	GENMASK(31, 24)
 #define M10BMC_N3000_VER_LEGACY_INVALID	0xffffffff
 
+/* Telemetry registers */
+#define M10BMC_N3000_TELEM_START	0x100
+#define M10BMC_N3000_TELEM_END		0x250
+#define M10BMC_D5005_TELEM_END		0x300
+
 /* Secure update doorbell register, in system register region */
 #define M10BMC_N3000_DOORBELL		0x400
 
@@ -205,11 +211,15 @@ struct m10bmc_csr_map {
  * struct intel_m10bmc_platform_info - Intel MAX 10 BMC platform specific information
  * @cells: MFD cells
  * @n_cells: MFD cells ARRAY_SIZE()
+ * @handshake_sys_reg_ranges: array of register ranges for fw handshake regs
+ * @handshake_sys_reg_nranges: number of register ranges for fw handshake regs
  * @csr_map: the mappings for register definition of MAX10 BMC
  */
 struct intel_m10bmc_platform_info {
 	struct mfd_cell *cells;
 	int n_cells;
+	const struct regmap_range *handshake_sys_reg_ranges;
+	unsigned int handshake_sys_reg_nranges;
 	const struct m10bmc_csr_map *csr_map;
 };
 
@@ -232,18 +242,30 @@ struct intel_m10bmc_flash_bulk_ops {
 	void (*unlock_write)(struct intel_m10bmc *m10bmc);
 };
 
+enum m10bmc_fw_state {
+	M10BMC_FW_STATE_NORMAL,
+	M10BMC_FW_STATE_SEC_UPDATE_PREPARE,
+	M10BMC_FW_STATE_SEC_UPDATE_WRITE,
+	M10BMC_FW_STATE_SEC_UPDATE_PROGRAM,
+};
+
 /**
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
  * @regmap: the regmap used to access registers by m10bmc itself
  * @info: the platform information for MAX10 BMC
  * @flash_bulk_ops: optional device specific operations for flash R/W
+ * @bmcfw_lock: read/write semaphore to BMC firmware running state
+ * @bmcfw_state: BMC firmware running state. Available only when
+ *		 handshake_sys_reg_nranges > 0.
  */
 struct intel_m10bmc {
 	struct device *dev;
 	struct regmap *regmap;
 	const struct intel_m10bmc_platform_info *info;
 	const struct intel_m10bmc_flash_bulk_ops *flash_bulk_ops;
+	struct rw_semaphore bmcfw_lock;		/* Protects bmcfw_state */
+	enum m10bmc_fw_state bmcfw_state;
 };
 
 /*
@@ -271,6 +293,12 @@ int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset, unsigned i
 int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
 			   unsigned int msk, unsigned int val);
 
+/*
+ * Track the state of the firmware, as it is not available for register
+ * handshakes during secure updates on some MAX 10 cards.
+ */
+void m10bmc_fw_state_set(struct intel_m10bmc *m10bmc, enum m10bmc_fw_state new_state);
+
 /*
  * MAX10 BMC Core support
  */
-- 
2.30.2

