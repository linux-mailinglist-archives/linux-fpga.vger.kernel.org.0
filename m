Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4937E35E955
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Apr 2021 00:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347772AbhDMW50 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Apr 2021 18:57:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:32275 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbhDMW50 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 13 Apr 2021 18:57:26 -0400
IronPort-SDR: gIr7VvU8ustFAcRukKkD+BOyDPrktW0FebeYP7j86ezm16NOssTYBn4oXyPUF+zK6SKKi5/MU+
 kfqzfcaG8CeA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="182029001"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="182029001"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 15:57:04 -0700
IronPort-SDR: mUtv5zO/Oh4cbim2VLo6IP3SeZ27KcXlJxsbQfN1p5qKmYI0oUsXxIRY+VW6h+FiyUAnFaXI9K
 3VnouEehO1iw==
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="398943223"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 15:57:04 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@intel.com, broonie@kernel.org,
        linux-spi@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@linux.intel.com>
Subject: [PATCH v2 2/2] hwmon: intel-m10-bmc-hwmon: add sensor support of Intel D5005 card
Date:   Tue, 13 Apr 2021 15:58:35 -0700
Message-Id: <20210413225835.459662-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413225835.459662-1-matthew.gerlach@linux.intel.com>
References: <20210413225835.459662-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Like the Intel N3000 card, the Intel D5005 has a MAX10 based
BMC.  This commit adds support for the D5005 sensors that are
monitored by the MAX10 BMC.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@linux.intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
v2: change variable name from m10bmc_bmc_subdevs to m10bmc_d5005_subdevs
    added Acked-by: Lee Jones
---
 drivers/hwmon/intel-m10-bmc-hwmon.c | 122 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c         |  10 +++
 2 files changed, 132 insertions(+)

diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
index 17d5e6b..bd7ed2e 100644
--- a/drivers/hwmon/intel-m10-bmc-hwmon.c
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -99,6 +99,50 @@ struct m10bmc_hwmon {
 	NULL
 };
 
+static const struct m10bmc_sdata d5005bmc_temp_tbl[] = {
+	{ 0x100, 0x104, 0x108, 0x10c, 0x0, 500, "Board Inlet Air Temperature" },
+	{ 0x110, 0x114, 0x118, 0x0, 0x0, 500, "FPGA Core Temperature" },
+	{ 0x11c, 0x120, 0x124, 0x128, 0x0, 500, "Board Exhaust Air Temperature" },
+	{ 0x12c, 0x130, 0x134, 0x0, 0x0, 500, "FPGA Transceiver Temperature" },
+	{ 0x138, 0x13c, 0x140, 0x144, 0x0, 500, "RDIMM0 Temperature" },
+	{ 0x148, 0x14c, 0x150, 0x154, 0x0, 500, "RDIMM1 Temperature" },
+	{ 0x158, 0x15c, 0x160, 0x164, 0x0, 500, "RDIMM2 Temperature" },
+	{ 0x168, 0x16c, 0x170, 0x174, 0x0, 500, "RDIMM3 Temperature" },
+	{ 0x178, 0x17c, 0x180, 0x0, 0x0, 500, "QSFP0 Temperature" },
+	{ 0x188, 0x18c, 0x190, 0x0, 0x0, 500, "QSFP1 Temperature" },
+	{ 0x1a0, 0x1a4, 0x1a8, 0x0, 0x0, 500, "3.3v Temperature" },
+	{ 0x1bc, 0x1c0, 0x1c4, 0x0, 0x0, 500, "VCCERAM Temperature" },
+	{ 0x1d8, 0x1dc, 0x1e0, 0x0, 0x0, 500, "VCCR Temperature" },
+	{ 0x1f4, 0x1f8, 0x1fc, 0x0, 0x0, 500, "VCCT Temperature" },
+	{ 0x210, 0x214, 0x218, 0x0, 0x0, 500, "1.8v Temperature" },
+	{ 0x22c, 0x230, 0x234, 0x0, 0x0, 500, "12v Backplane Temperature" },
+	{ 0x248, 0x24c, 0x250, 0x0, 0x0, 500, "12v AUX Temperature" },
+};
+
+static const struct m10bmc_sdata d5005bmc_in_tbl[] = {
+	{ 0x184, 0x0, 0x0, 0x0, 0x0, 1, "QSFP0 Supply Voltage" },
+	{ 0x194, 0x0, 0x0, 0x0, 0x0, 1, "QSFP1 Supply Voltage" },
+	{ 0x198, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Voltage" },
+	{ 0x1ac, 0x1b0, 0x1b4, 0x0, 0x0, 1, "3.3v Voltage" },
+	{ 0x1c8, 0x1cc, 0x1d0, 0x0, 0x0, 1, "VCCERAM Voltage" },
+	{ 0x1e4, 0x1e8, 0x1ec, 0x0, 0x0, 1, "VCCR Voltage" },
+	{ 0x200, 0x204, 0x208, 0x0, 0x0, 1, "VCCT Voltage" },
+	{ 0x21c, 0x220, 0x224, 0x0, 0x0, 1, "1.8v Voltage" },
+	{ 0x238, 0x0, 0x0, 0x0, 0x23c, 1, "12v Backplane Voltage" },
+	{ 0x254, 0x0, 0x0, 0x0, 0x258, 1, "12v AUX Voltage" },
+};
+
+static const struct m10bmc_sdata d5005bmc_curr_tbl[] = {
+	{ 0x19c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Current" },
+	{ 0x1b8, 0x0, 0x0, 0x0, 0x0, 1, "3.3v Current" },
+	{ 0x1d4, 0x0, 0x0, 0x0, 0x0, 1, "VCCERAM Current" },
+	{ 0x1f0, 0x0, 0x0, 0x0, 0x0, 1, "VCCR Current" },
+	{ 0x20c, 0x0, 0x0, 0x0, 0x0, 1, "VCCT Current" },
+	{ 0x228, 0x0, 0x0, 0x0, 0x0, 1, "1.8v Current" },
+	{ 0x240, 0x244, 0x0, 0x0, 0x0, 1, "12v Backplane Current" },
+	{ 0x25c, 0x260, 0x0, 0x0, 0x0, 1, "12v AUX Current" },
+};
+
 static const struct m10bmc_hwmon_board_data n3000bmc_hwmon_bdata = {
 	.tables = {
 		[hwmon_temp] = n3000bmc_temp_tbl,
@@ -110,6 +154,80 @@ struct m10bmc_hwmon {
 	.hinfo = n3000bmc_hinfo,
 };
 
+static const struct hwmon_channel_info *d5005bmc_hinfo[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
+			   HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
+			   HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
+			   HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
+			   HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
+			   HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_LABEL),
+	NULL
+};
+
+static const struct m10bmc_hwmon_board_data d5005bmc_hwmon_bdata = {
+	.tables = {
+		[hwmon_temp] = d5005bmc_temp_tbl,
+		[hwmon_in] = d5005bmc_in_tbl,
+		[hwmon_curr] = d5005bmc_curr_tbl,
+	},
+
+	.hinfo = d5005bmc_hinfo,
+};
+
 static umode_t
 m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
 			u32 attr, int channel)
@@ -316,6 +434,10 @@ static int m10bmc_hwmon_probe(struct platform_device *pdev)
 		.name = "n3000bmc-hwmon",
 		.driver_data = (unsigned long)&n3000bmc_hwmon_bdata,
 	},
+	{
+		.name = "d5005bmc-hwmon",
+		.driver_data = (unsigned long)&d5005bmc_hwmon_bdata,
+	},
 	{ }
 };
 
diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 1161933..1a9bfb7 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -15,6 +15,11 @@
 
 enum m10bmc_type {
 	M10_N3000,
+	M10_D5005
+};
+
+static struct mfd_cell m10bmc_d5005_subdevs[] = {
+	{ .name = "d5005bmc-hwmon" },
 };
 
 static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
@@ -183,6 +188,10 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 		cells = m10bmc_pacn3000_subdevs;
 		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
 		break;
+	case M10_D5005:
+		cells = m10bmc_d5005_subdevs;
+		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -197,6 +206,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id m10bmc_spi_id[] = {
 	{ "m10-n3000", M10_N3000 },
+	{ "m10-d5005", M10_D5005 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
-- 
1.8.3.1

