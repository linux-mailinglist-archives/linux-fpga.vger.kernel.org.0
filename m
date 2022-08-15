Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2559296D
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Aug 2022 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiHOGLW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 15 Aug 2022 02:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiHOGLN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 15 Aug 2022 02:11:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DC18B0C
        for <linux-fpga@vger.kernel.org>; Sun, 14 Aug 2022 23:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660543870; x=1692079870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZTqvSG1BNFaNusd7hzSX/klXn2WVjuljLZ4aH0u2Stw=;
  b=ely7rnCPwaot4CEeo0cSDlZgGPFI9EJwVBKudQ4wOphKvHf1G2vaakMc
   2CFVtlz6009cqnRvA5xqGOIX1Ooam5DWvQWwBeWyE12jNhWWiZh3i9rtF
   7qEYZ3sPdYpyDE8nvK9Du0Ml2kn0nPU/5mCHd57oOTBP6BkxWWGXLeYA3
   G8/7WAIWgwZ3Mb0p/U3OTZ8jIIB6mr9hnR4uh5tKsK2XkDwJd9xNCk4w3
   wzTXc/8bJnf1/FKr1yuZd+v2RwATya7uLtpM4LOq8K55KEKgYD5RI3qAU
   EUypWGpamhiDGuQaQu+K2sNh4GSVkMYov8sbXSTk5OCy0Q8C0YW6PKO7s
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="271670718"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="271670718"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 23:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="639544890"
Received: from unknown (HELO opae-zj-2.sh.intel.com) ([10.238.175.107])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2022 23:11:07 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        lee.jones@linaro.org, russell.h.weight@intel.com
Cc:     hao.wu@intel.com, trix@redhat.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4 2/2] fpga: m10bmc-sec: add m10bmc_sec_retimer_load callback
Date:   Mon, 15 Aug 2022 02:07:15 -0400
Message-Id: <20220815060715.37712-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220815060715.37712-1-tianfei.zhang@intel.com>
References: <20220815060715.37712-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Create m10bmc_sec_retimer_load() callback function
to provide a trigger to update a new retimer (Intel
C827 Ethernet transceiver) firmware on Intel PAC
N3000 Card.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
v3:
uses regmap_update_bits() API instead of m10bmc_sys_update_bits().
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 148 ++++++++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h       |  31 +++++
 2 files changed, 179 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 3a082911cf67..bef07e97c107 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -300,6 +300,150 @@ static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
 	return m10bmc_sec_bmc_image_load(sec, 1);
 }
 
+static int trigger_retimer_eeprom_load(struct m10bmc_sec *sec)
+{
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_update_bits(m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_PKVL_EEPROM_LOAD_SEC,
+				 DRBL_PKVL_EEPROM_LOAD_SEC);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the current NIOS FW supports this retimer update feature, then
+	 * it will clear the same PKVL_EEPROM_LOAD bit in 2 seconds. Otherwise
+	 * the driver needs to clear the PKVL_EEPROM_LOAD bit manually and
+	 * return an error code.
+	 */
+	ret = regmap_read_poll_timeout(m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL, val,
+				       (!(val & DRBL_PKVL_EEPROM_LOAD_SEC)),
+				       M10BMC_PKVL_LOAD_INTERVAL_US,
+				       M10BMC_PKVL_LOAD_TIMEOUT_US);
+	if (ret == -ETIMEDOUT) {
+		dev_err(sec->dev, "PKVL_EEPROM_LOAD clear timedout\n");
+		regmap_update_bits(m10bmc->regmap,
+				   M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				   DRBL_PKVL_EEPROM_LOAD_SEC, 0);
+		ret = -ENODEV;
+	} else if (ret) {
+		dev_err(sec->dev, "poll EEPROM_LOAD error %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int poll_retimer_eeprom_load_done(struct m10bmc_sec *sec)
+{
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	unsigned int doorbell;
+	int ret;
+
+	/*
+	 * RSU_STAT_PKVL_REJECT indicates that the current image is
+	 * already programmed. RSU_PROG_PKVL_PROM_DONE that the firmware
+	 * update process has finished, but does not necessarily indicate
+	 * a successful update.
+	 */
+	ret = regmap_read_poll_timeout(m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell,
+				       ((rsu_prog(doorbell) ==
+					 RSU_PROG_PKVL_PROM_DONE) ||
+					(rsu_stat(doorbell) ==
+					 RSU_STAT_PKVL_REJECT)),
+				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
+				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(sec->dev,
+				"Doorbell check timedout: 0x%08x\n", doorbell);
+		else
+			dev_err(sec->dev, "poll Doorbell error\n");
+		return ret;
+	}
+
+	if (rsu_stat(doorbell) == RSU_STAT_PKVL_REJECT) {
+		dev_err(sec->dev, "duplicate image rejected\n");
+		return -ECANCELED;
+	}
+
+	return 0;
+}
+
+static int poll_retimer_preload_done(struct m10bmc_sec *sec)
+{
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	unsigned int val;
+	int ret;
+
+	/*
+	 * Wait for the updated firmware to be loaded by the PKVL device
+	 * and confirm that the updated firmware is operational
+	 */
+	ret = regmap_read_poll_timeout(m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_PKVL_POLL_CTRL, val,
+				       ((val & M10BMC_PKVL_PRELOAD) == M10BMC_PKVL_PRELOAD),
+				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
+				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
+	if (ret) {
+		dev_err(sec->dev, "poll M10BMC_PKVL_PRELOAD error %d\n", ret);
+		return ret;
+	}
+
+	if ((val & M10BMC_PKVL_UPG_STATUS_MASK) != M10BMC_PKVL_UPG_STATUS_GOOD) {
+		dev_err(sec->dev, "error detected during upgrade\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int retimer_check_idle(struct m10bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return -EIO;
+
+	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
+	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE &&
+	    rsu_prog(doorbell) != RSU_PROG_PKVL_PROM_DONE) {
+		log_error_regs(sec, doorbell);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int m10bmc_sec_retimer_eeprom_load(struct m10bmc_sec *sec)
+{
+	int ret;
+
+	ret = retimer_check_idle(sec);
+	if (ret)
+		goto exit;
+
+	ret = trigger_retimer_eeprom_load(sec);
+	if (ret)
+		goto exit;
+
+	ret = poll_retimer_eeprom_load_done(sec);
+	if (ret)
+		goto exit;
+
+	ret = poll_retimer_preload_done(sec);
+
+exit:
+	return ret;
+}
+
 static struct image_load m10bmc_image_load_hndlrs[] = {
 	{
 		.name = "bmc_factory",
@@ -309,6 +453,10 @@ static struct image_load m10bmc_image_load_hndlrs[] = {
 		.name = "bmc_user",
 		.load_image = m10bmc_sec_bmc_image_load_0,
 	},
+	{
+		.name = "retimer_fw",
+		.load_image = m10bmc_sec_retimer_eeprom_load,
+	},
 	{}
 };
 
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index f0044b14136e..c06b9d3d1c5d 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -36,6 +36,37 @@
 #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
 #define M10BMC_VER_LEGACY_INVALID	0xffffffff
 
+/* Retimer related registers, in system register region */
+#define M10BMC_PKVL_POLL_CTRL		0x80
+#define M10BMC_PKVL_A_PRELOAD		BIT(16)
+#define M10BMC_PKVL_A_PRELOAD_TO	BIT(17)
+#define M10BMC_PKVL_A_DATA_TOO_BIG	BIT(18)
+#define M10BMC_PKVL_A_HDR_CKSUM	BIT(20)
+#define M10BMC_PKVL_B_PRELOAD		BIT(24)
+#define M10BMC_PKVL_B_PRELOAD_TO	BIT(25)
+#define M10BMC_PKVL_B_DATA_TOO_BIG	BIT(26)
+#define M10BMC_PKVL_B_HDR_CKSUM	BIT(28)
+
+#define M10BMC_PKVL_PRELOAD		(M10BMC_PKVL_A_PRELOAD | M10BMC_PKVL_B_PRELOAD)
+#define M10BMC_PKVL_PRELOAD_TIMEOUT	(M10BMC_PKVL_A_PRELOAD_TO | \
+					 M10BMC_PKVL_B_PRELOAD_TO)
+#define M10BMC_PKVL_DATA_TOO_BIG	(M10BMC_PKVL_A_DATA_TOO_BIG | \
+					 M10BMC_PKVL_B_DATA_TOO_BIG)
+#define M10BMC_PKVL_HDR_CHECKSUM	(M10BMC_PKVL_A_HDR_CKSUM | \
+					 M10BMC_PKVL_B_HDR_CKSUM)
+
+#define M10BMC_PKVL_UPG_STATUS_MASK	(M10BMC_PKVL_PRELOAD | M10BMC_PKVL_PRELOAD_TIMEOUT |\
+					 M10BMC_PKVL_DATA_TOO_BIG | M10BMC_PKVL_HDR_CHECKSUM)
+#define M10BMC_PKVL_UPG_STATUS_GOOD	(M10BMC_PKVL_PRELOAD | M10BMC_PKVL_HDR_CHECKSUM)
+
+/* interval 100ms and timeout 2s */
+#define M10BMC_PKVL_LOAD_INTERVAL_US	(100 * 1000)
+#define M10BMC_PKVL_LOAD_TIMEOUT_US	(2 * 1000 * 1000)
+
+/* interval 100ms and timeout 30s */
+#define M10BMC_PKVL_PRELOAD_INTERVAL_US	(100 * 1000)
+#define M10BMC_PKVL_PRELOAD_TIMEOUT_US	(30 * 1000 * 1000)
+
 /* Secure update doorbell register, in system register region */
 #define M10BMC_DOORBELL			0x400
 
-- 
2.26.2

