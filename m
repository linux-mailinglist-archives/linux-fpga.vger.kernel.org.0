Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB2D3AE3CC
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 09:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhFUHJA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 03:09:00 -0400
Received: from first.geanix.com ([116.203.34.67]:54126 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhFUHIw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 03:08:52 -0400
Received: from 185.17.218.86 (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 76C904C3BBC;
        Mon, 21 Jun 2021 07:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=silicom.dk; s=first;
        t=1624259195; bh=1YwLc2H2BckkRj4vXarfWOOaU87sQ2pkK5QQqGvScrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ljBIetRDvDNk1Wi57+NSQK2gErXzawHV/SpY31t300IVoZP58COWVdymENVN5Duvk
         LR2HJaPm6Me5lTjgShpi9xsz0GbjabCcGZsXUkRZGYOkLxNiBg4ccBRInpkXN5+dcE
         TIP6Mn2wisOAZtKZBqIrx6Ly7uQoU/lKzMOumYQAiS47IHO6GUv9XIvtC0xuyX8f6P
         CzvSW7+ePHI2GfLln/pumcqNc50v+xmJliTPi/YFiEo80+EcIJhcGRXPcgqYO8Y1CN
         RMEJgBcSI8UrwBPjDiCO8OFcx8KLBNeMDmnTYztgO2VT3ZfcBvrSZ5BwQh5A7o8TTZ
         URNdd7I8Noezg==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
Subject: [PATCH 4/4] hwmon: intel-m10-bmc: add sensor support for Silicom N5010 card
Date:   Mon, 21 Jun 2021 09:06:21 +0200
Message-Id: <20210621070621.431482-5-mhu@silicom.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210621070621.431482-1-mhu@silicom.dk>
References: <20210621070621.431482-1-mhu@silicom.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=4.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_INVALID,DKIM_SIGNED,TVD_RCVD_IP,TVD_RCVD_IP4,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The Silicom N5010 PAC is similar to Intel N3000 and D5005. Enable
monitoring of its sensors like it is done for the two Intel cards.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---
 drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c         |  12 ++-
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
index bd7ed2ed3a1e..7a08e4c44a4b 100644
--- a/drivers/hwmon/intel-m10-bmc-hwmon.c
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -228,6 +228,118 @@ static const struct m10bmc_hwmon_board_data d5005bmc_hwmon_bdata = {
 	.hinfo = d5005bmc_hinfo,
 };
 
+static const struct m10bmc_sdata n5010bmc_temp_tbl[] = {
+	{ 0x100, 0x0, 0x104, 0x0, 0x0, 1000, "Board Local Temperature" },
+	{ 0x108, 0x0, 0x10c, 0x0, 0x0, 1000, "FPGA 1 Temperature" },
+	{ 0x110, 0x0, 0x114, 0x0, 0x0, 1000, "FPGA 2 Temperature" },
+	{ 0x118, 0x0, 0x0, 0x0, 0x0, 1000, "Card Top Temperature" },
+	{ 0x11c, 0x0, 0x0, 0x0, 0x0, 1000, "Card Bottom Temperature" },
+	{ 0x128, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 1.2V Temperature" },
+	{ 0x134, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 5V Temperature" },
+	{ 0x140, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 0.9V Temperature" },
+	{ 0x14c, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 0.85V Temperature" },
+	{ 0x158, 0x0, 0x0, 0x0, 0x0, 1000, "AUX 12V Temperature" },
+	{ 0x164, 0x0, 0x0, 0x0, 0x0, 1000, "Backplane 12V Temperature" },
+	{ 0x1a8, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-1 Temperature" },
+	{ 0x1ac, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-2 Temperature" },
+	{ 0x1b0, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-3 Temperature" },
+	{ 0x1b4, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-4 Temperature" },
+	{ 0x1b8, 0x0, 0x0, 0x0, 0x0, 1000, "CVL1 Internal Temperature" },
+	{ 0x1bc, 0x0, 0x0, 0x0, 0x0, 1000, "CVL2 Internal Temperature" },
+};
+
+static const struct m10bmc_sdata n5010bmc_in_tbl[] = {
+	{ 0x120, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.2V Voltage" },
+	{ 0x12c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 5V Voltage" },
+	{ 0x138, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.9V Voltage" },
+	{ 0x144, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.85V Voltage" },
+	{ 0x150, 0x0, 0x0, 0x0, 0x0, 1, "AUX 12V Voltage" },
+	{ 0x15c, 0x0, 0x0, 0x0, 0x0, 1, "Backplane 12V Voltage" },
+	{ 0x16c, 0x0, 0x0, 0x0, 0x0, 1, "DDR4 1.2V Voltage" },
+	{ 0x17c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.8V Voltage" },
+	{ 0x184, 0x0, 0x0, 0x0, 0x0, 1, "QDR 1.3V Voltage" },
+	{ 0x18c, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 0.8V Voltage" },
+	{ 0x194, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 1.05V Voltage" },
+	{ 0x19c, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 1.05V Voltage" },
+	{ 0x1a4, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 0.8V Voltage" },
+};
+
+static const struct m10bmc_sdata n5010bmc_curr_tbl[] = {
+	{ 0x124, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.2V Current" },
+	{ 0x130, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 5V Current" },
+	{ 0x13c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.9V Current" },
+	{ 0x148, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.85V Current" },
+	{ 0x154, 0x0, 0x0, 0x0, 0x0, 1, "AUX 12V Current" },
+	{ 0x160, 0x0, 0x0, 0x0, 0x0, 1, "Backplane 12V Current" },
+	{ 0x168, 0x0, 0x0, 0x0, 0x0, 1, "DDR4 1.2V Current" },
+	{ 0x178, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.8V Current" },
+	{ 0x180, 0x0, 0x0, 0x0, 0x0, 1, "QDR 1.3V Current" },
+	{ 0x188, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 0.8V Current" },
+	{ 0x190, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 1.05V Current" },
+	{ 0x198, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 1.05V Current" },
+	{ 0x1a0, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 0.8V Current" },
+};
+
+static const struct hwmon_channel_info *n5010bmc_hinfo[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL),
+	NULL
+};
+
+static const struct m10bmc_hwmon_board_data n5010bmc_hwmon_bdata = {
+	.tables = {
+		[hwmon_temp] = n5010bmc_temp_tbl,
+		[hwmon_in] = n5010bmc_in_tbl,
+		[hwmon_curr] = n5010bmc_curr_tbl,
+	},
+
+	.hinfo = n5010bmc_hinfo,
+};
+
 static umode_t
 m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
 			u32 attr, int channel)
@@ -438,6 +550,10 @@ static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
 		.name = "d5005bmc-hwmon",
 		.driver_data = (unsigned long)&d5005bmc_hwmon_bdata,
 	},
+	{
+		.name = "n5010bmc-hwmon",
+		.driver_data = (unsigned long)&n5010bmc_hwmon_bdata,
+	},
 	{ }
 };
 
diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 1a9bfb7f48cd..8db3bcf5fccc 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -15,7 +15,8 @@
 
 enum m10bmc_type {
 	M10_N3000,
-	M10_D5005
+	M10_D5005,
+	M10_N5010,
 };
 
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
@@ -28,6 +29,10 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
 	{ .name = "n3000bmc-secure" },
 };
 
+static struct mfd_cell m10bmc_n5010_subdevs[] = {
+	{ .name = "n5010bmc-hwmon" },
+};
+
 static const struct regmap_range m10bmc_regmap_range[] = {
 	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
 	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
@@ -192,6 +197,10 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 		cells = m10bmc_d5005_subdevs;
 		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
 		break;
+	case M10_N5010:
+		cells = m10bmc_n5010_subdevs;
+		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -207,6 +216,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 static const struct spi_device_id m10bmc_spi_id[] = {
 	{ "m10-n3000", M10_N3000 },
 	{ "m10-d5005", M10_D5005 },
+	{ "m10-n5010", M10_N5010 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
-- 
2.31.0

