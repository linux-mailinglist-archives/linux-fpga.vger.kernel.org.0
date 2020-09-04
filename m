Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3A25E45E
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 01:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgIDXxW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 19:53:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:64701 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgIDXxV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Sep 2020 19:53:21 -0400
IronPort-SDR: MDaT43Bplui3l5DD8ZNzh4AQDhzZe9rdo9FNDFl1Dq0aQv6EnMwczM1ayv0SGGJs7h3YLsHTeR
 u4Jw5rLo4T7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219386201"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="219386201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 16:53:17 -0700
IronPort-SDR: fhyzUpk1ZvkCpEQ5TCleISxf0+ekzBMUHelbwy91GaoPiLNjYZBCeVYrWxuWk9xXmDgNjGLjxH
 881thOodun8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="284656291"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.151.80])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 16:53:16 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 06/12] fpga: add max10 secure update functions
Date:   Fri,  4 Sep 2020 16:52:59 -0700
Message-Id: <20200904235305.6254-7-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Security Engine driver to include
the functions that enable secure updates of BMC images,
FPGA images, etc.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/intel-m10-bmc-secure.c | 272 +++++++++++++++++++++++++++-
 include/linux/mfd/intel-m10-bmc.h   | 101 +++++++++++
 2 files changed, 372 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 46cd49a08be0..4a66c2d448eb 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
  *
  */
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/fpga/ifpga-sec-mgr.h>
 #include <linux/mfd/intel-m10-bmc.h>
@@ -184,6 +185,271 @@ SYSFS_GET_CSK_VEC(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET)
 SYSFS_GET_CSK_VEC(sr, SR_PROG_ADDR + CSK_VEC_OFFSET)
 SYSFS_GET_CSK_VEC(pr, PR_PROG_ADDR + CSK_VEC_OFFSET)
 
+static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
+{
+	u32 auth_result;
+
+	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
+
+	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
+		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
+}
+
+static enum ifpga_sec_err rsu_check_idle(struct m10bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return IFPGA_SEC_ERR_RW_ERROR;
+
+	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
+	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_BUSY;
+	}
+
+	return IFPGA_SEC_ERR_NONE;
+}
+
+static inline bool rsu_start_done(u32 doorbell)
+{
+	return (!(doorbell & RSU_REQUEST) &&
+		(rsu_stat(doorbell) == RSU_STAT_ERASE_FAIL ||
+		rsu_stat(doorbell) == RSU_STAT_WEAROUT ||
+		(rsu_prog(doorbell) != RSU_PROG_IDLE &&
+		 rsu_prog(doorbell) != RSU_PROG_RSU_DONE)));
+}
+
+static enum ifpga_sec_err rsu_update_init(struct m10bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL,
+				     RSU_REQUEST | HOST_STATUS, RSU_REQUEST |
+				     FIELD_PREP(HOST_STATUS, HOST_STATUS_IDLE));
+	if (ret)
+		return IFPGA_SEC_ERR_RW_ERROR;
+
+	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell,
+				       rsu_start_done(doorbell),
+				       NIOS_HANDSHAKE_INTERVAL_US,
+				       NIOS_HANDSHAKE_TIMEOUT_US);
+
+	if (ret == -ETIMEDOUT) {
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_TIMEOUT;
+	} else if (ret) {
+		return IFPGA_SEC_ERR_RW_ERROR;
+	}
+
+	if (rsu_stat(doorbell) == RSU_STAT_WEAROUT) {
+		dev_warn(sec->dev, "Excessive flash update count detected\n");
+		return IFPGA_SEC_ERR_WEAROUT;
+	} else if (rsu_stat(doorbell) == RSU_STAT_ERASE_FAIL) {
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return IFPGA_SEC_ERR_NONE;
+}
+
+static enum ifpga_sec_err rsu_prog_ready(struct m10bmc_sec *sec)
+{
+	unsigned long poll_timeout;
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
+	while (!ret && !time_after(jiffies, poll_timeout)) {
+		if (rsu_prog(doorbell) != RSU_PROG_PREPARE)
+			break;
+		msleep(RSU_PREP_INTERVAL_MS);
+		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	}
+
+	if (ret) {
+		return IFPGA_SEC_ERR_RW_ERROR;
+	} else if (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_TIMEOUT;
+	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return IFPGA_SEC_ERR_NONE;
+}
+
+static enum ifpga_sec_err rsu_send_data(struct m10bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL, HOST_STATUS,
+				     FIELD_PREP(HOST_STATUS,
+						HOST_STATUS_WRITE_DONE));
+	if (ret)
+		return IFPGA_SEC_ERR_RW_ERROR;
+
+	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell,
+				       rsu_prog(doorbell) != RSU_PROG_READY,
+				       NIOS_HANDSHAKE_INTERVAL_US,
+				       NIOS_HANDSHAKE_TIMEOUT_US);
+
+	if (ret == -ETIMEDOUT) {
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_TIMEOUT;
+	} else if (ret) {
+		return IFPGA_SEC_ERR_RW_ERROR;
+	}
+
+	switch (rsu_stat(doorbell)) {
+	case RSU_STAT_NORMAL:
+	case RSU_STAT_NIOS_OK:
+	case RSU_STAT_USER_OK:
+	case RSU_STAT_FACTORY_OK:
+		break;
+	default:
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return IFPGA_SEC_ERR_NONE;
+}
+
+static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
+{
+	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
+		return -EIO;
+
+	switch (rsu_stat(*doorbell)) {
+	case RSU_STAT_NORMAL:
+	case RSU_STAT_NIOS_OK:
+	case RSU_STAT_USER_OK:
+	case RSU_STAT_FACTORY_OK:
+	case RSU_STAT_WEAROUT:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (rsu_prog(*doorbell)) {
+	case RSU_PROG_IDLE:
+	case RSU_PROG_RSU_DONE:
+		return 0;
+	case RSU_PROG_AUTHENTICATING:
+	case RSU_PROG_COPYING:
+	case RSU_PROG_UPDATE_CANCEL:
+	case RSU_PROG_PROGRAM_KEY_HASH:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum ifpga_sec_err m10bmc_sec_prepare(struct ifpga_sec_mgr *imgr)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	enum ifpga_sec_err ret;
+
+	if (imgr->remaining_size > M10BMC_STAGING_SIZE)
+		return IFPGA_SEC_ERR_INVALID_SIZE;
+
+	ret = rsu_check_idle(sec);
+	if (ret)
+		return ret;
+
+	ret = rsu_update_init(sec);
+	if (ret)
+		return ret;
+
+	return rsu_prog_ready(sec);
+}
+
+static enum ifpga_sec_err
+m10bmc_sec_write_blk(struct ifpga_sec_mgr *imgr, u32 offset, u32 size)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret) {
+		return IFPGA_SEC_ERR_RW_ERROR;
+	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_HW_ERROR;
+	}
+
+	ret = m10bmc_raw_bulk_write(sec->m10bmc, M10BMC_STAGING_BASE + offset,
+				    (void *)imgr->data + offset, size / stride);
+
+	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
+}
+
+static enum ifpga_sec_err m10bmc_sec_poll_complete(struct ifpga_sec_mgr *imgr)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	unsigned long poll_timeout;
+	enum ifpga_sec_err result;
+	u32 doorbell;
+	int ret;
+
+	result = rsu_send_data(sec);
+	if (result)
+		return result;
+
+	ret = rsu_check_complete(sec, &doorbell);
+	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
+	while (ret == -EAGAIN && !time_after(jiffies, poll_timeout)) {
+		msleep(RSU_COMPLETE_INTERVAL_MS);
+		ret = rsu_check_complete(sec, &doorbell);
+		if (imgr->driver_unload)
+			return IFPGA_SEC_ERR_CANCELED;
+	}
+
+	if (ret == -EAGAIN) {
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_TIMEOUT;
+	} else if (ret == -EIO) {
+		return IFPGA_SEC_ERR_RW_ERROR;
+	} else if (ret) {
+		log_error_regs(sec, doorbell);
+		return IFPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return IFPGA_SEC_ERR_NONE;
+}
+
+static enum ifpga_sec_err m10bmc_sec_cancel(struct ifpga_sec_mgr *imgr)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return IFPGA_SEC_ERR_RW_ERROR;
+
+	if (rsu_prog(doorbell) != RSU_PROG_READY)
+		return IFPGA_SEC_ERR_BUSY;
+
+	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL, HOST_STATUS,
+				     FIELD_PREP(HOST_STATUS,
+						HOST_STATUS_ABORT_RSU));
+
+	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
+}
+
 static const struct ifpga_sec_mgr_ops m10bmc_iops = {
 	.user_flash_count = get_qspi_flash_count,
 	.bmc_root_entry_hash = get_bmc_root_entry_hash,
@@ -197,7 +463,11 @@ static const struct ifpga_sec_mgr_ops m10bmc_iops = {
 	.pr_reh_size = get_pr_reh_size,
 	.bmc_canceled_csk_nbits = get_bmc_csk_cancel_nbits,
 	.sr_canceled_csk_nbits = get_sr_csk_cancel_nbits,
-	.pr_canceled_csk_nbits = get_pr_csk_cancel_nbits
+	.pr_canceled_csk_nbits = get_pr_csk_cancel_nbits,
+	.prepare = m10bmc_sec_prepare,
+	.write_blk = m10bmc_sec_write_blk,
+	.poll_complete = m10bmc_sec_poll_complete,
+	.cancel = m10bmc_sec_cancel
 };
 
 static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 7fe465c320c2..5d2860d8a0cf 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -13,6 +13,9 @@
 #define M10BMC_SYS_BASE			0x300800
 #define M10BMC_MEM_END			0x200000fc
 
+#define M10BMC_STAGING_BASE		0x18000000
+#define M10BMC_STAGING_SIZE		0x3800000
+
 /* Register offset of system registers */
 #define NIOS2_FW_VERSION		0x0
 #define M10BMC_MACADDR1			0x10
@@ -36,6 +39,70 @@
 #define SERDES_VERSION			GENMASK(15, 0)
 #define SBUS_VERSION			GENMASK(31, 16)
 
+/* Secure update doorbell register, in system register region */
+#define M10BMC_DOORBELL			0x400
+#define RSU_REQUEST			BIT(0)
+#define RSU_PROGRESS			GENMASK(7, 4)
+#define HOST_STATUS			GENMASK(11, 8)
+#define RSU_STATUS			GENMASK(23, 16)
+#define PKVL_EEPROM_LOAD_SEC		BIT(24)
+#define PKVL1_POLL_EN			BIT(25)
+#define PKVL2_POLL_EN			BIT(26)
+#define CONFIG_SEL			BIT(28)
+#define REBOOT_REQ			BIT(29)
+#define REBOOT_DISABLED			BIT(30)
+
+/* Progress states */
+#define RSU_PROG_IDLE			0x0
+#define RSU_PROG_PREPARE		0x1
+#define RSU_PROG_READY			0x3
+#define RSU_PROG_AUTHENTICATING		0x4
+#define RSU_PROG_COPYING		0x5
+#define RSU_PROG_UPDATE_CANCEL		0x6
+#define RSU_PROG_PROGRAM_KEY_HASH	0x7
+#define RSU_PROG_RSU_DONE		0x8
+#define RSU_PROG_PKVL_PROM_DONE		0x9
+
+/* Device and error states */
+#define RSU_STAT_NORMAL			0x0
+#define RSU_STAT_TIMEOUT		0x1
+#define RSU_STAT_AUTH_FAIL		0x2
+#define RSU_STAT_COPY_FAIL		0x3
+#define RSU_STAT_FATAL			0x4
+#define RSU_STAT_PKVL_REJECT		0x5
+#define RSU_STAT_NON_INC		0x6
+#define RSU_STAT_ERASE_FAIL		0x7
+#define RSU_STAT_WEAROUT		0x8
+#define RSU_STAT_NIOS_OK		0x80
+#define RSU_STAT_USER_OK		0x81
+#define RSU_STAT_FACTORY_OK		0x82
+#define RSU_STAT_USER_FAIL		0x83
+#define RSU_STAT_FACTORY_FAIL		0x84
+#define RSU_STAT_NIOS_FLASH_ERR		0x85
+#define RSU_STAT_FPGA_FLASH_ERR		0x86
+
+#define HOST_STATUS_IDLE		0x0
+#define HOST_STATUS_WRITE_DONE		0x1
+#define HOST_STATUS_ABORT_RSU		0x2
+
+#define rsu_prog(doorbell)		FIELD_GET(RSU_PROGRESS, doorbell)
+#define rsu_stat(doorbell)		FIELD_GET(RSU_STATUS, doorbell)
+
+/* interval 100ms and timeout 5s */
+#define NIOS_HANDSHAKE_INTERVAL_US	(100 * 1000)
+#define NIOS_HANDSHAKE_TIMEOUT_US	(5 * 1000 * 1000)
+
+/* RSU PREP Timeout (2 minutes) to erase flash staging area */
+#define RSU_PREP_INTERVAL_MS		100
+#define RSU_PREP_TIMEOUT_MS		(2 * 60 * 1000)
+
+/* RSU Complete Timeout (40 minutes) for full flash update */
+#define RSU_COMPLETE_INTERVAL_MS	1000
+#define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
+
+/* Authorization Result register, in system register region */
+#define M10BMC_AUTH_RESULT		0x404
+
 /**
  * struct intel_m10bmc_retimer_pdata - subdev retimer platform data
  *
@@ -64,7 +131,10 @@ struct intel_m10bmc {
  *
  * m10bmc_raw_read - read m10bmc register per addr
  * m10bmc_raw_bulk_read - bulk_read max10 registers per addr
+ * m10bmc_raw_bulk_write - bulk_write max10 registers per addr
+ * m10bmc_raw_update_bits - update max10 register per addr
  * m10bmc_sys_read - read m10bmc system register per offset
+ * m10bmc_sys_update_bits - update max10 system register per offset
  */
 static inline int
 m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
@@ -94,7 +164,38 @@ m10bmc_raw_bulk_read(struct intel_m10bmc *m10bmc, unsigned int addr,
 	return ret;
 }
 
+static inline int
+m10bmc_raw_bulk_write(struct intel_m10bmc *m10bmc, unsigned int addr,
+		      void *val, size_t cnt)
+{
+	int ret;
+
+	ret = regmap_bulk_write(m10bmc->regmap, addr, val, cnt);
+	if (ret)
+		dev_err(m10bmc->dev, "fail to write raw reg %x cnt %zx: %d\n",
+			addr, cnt, ret);
+
+	return ret;
+}
+
+static inline int
+m10bmc_raw_update_bits(struct intel_m10bmc *m10bmc, unsigned int addr,
+		       unsigned int msk, unsigned int val)
+{
+	int ret;
+
+	ret = regmap_update_bits(m10bmc->regmap, addr, msk, val);
+	if (ret)
+		dev_err(m10bmc->dev, "fail to update raw reg %x: %d\n",
+			addr, ret);
+
+	return ret;
+}
+
 #define m10bmc_sys_read(m10bmc, offset, val) \
 	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
 
+#define m10bmc_sys_update_bits(m10bmc, offset, msk, val) \
+	m10bmc_raw_update_bits(m10bmc, M10BMC_SYS_BASE + (offset), msk, val)
+
 #endif /* __MFD_INTEL_M10_BMC_H */
-- 
2.17.1

