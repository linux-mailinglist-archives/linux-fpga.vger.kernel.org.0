Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6440F2DFCF3
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Dec 2020 15:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgLUOkS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Dec 2020 09:40:18 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61980 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbgLUOkS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Dec 2020 09:40:18 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLEZCLH006619;
        Mon, 21 Dec 2020 09:39:17 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35hfa9w8gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 09:39:17 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0BLEdFXS033386
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Dec 2020 09:39:16 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 21 Dec 2020 06:39:14 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Mon, 21 Dec 2020 06:39:14 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 21 Dec 2020 06:39:14 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BLEd9nF031672;
        Mon, 21 Dec 2020 09:39:09 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        <dragos.bogdan@analog.com>, Mathias Tausen <mta@gomspace.com>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] clk: axi-clkgen: add support for ZynqMP (UltraScale)
Date:   Mon, 21 Dec 2020 16:42:23 +0200
Message-ID: <20201221144224.50814-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_08:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210104
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

This IP core also works and is supported on the Xilinx ZynqMP (UltraScale)
FPGA boards.
This patch enables the driver to be available on these platforms as well.

Since axi-clkgen is now supported on ZYNQMP, we need to make sure the
max/min frequencies of the PFD and VCO are respected.

This change adds two new compatible strings to select limits for Zynq or
ZynqMP from the device data (in the OF table). The old compatible string
(i.e. adi,axi-clkgen-2.00.a) is the same as adi,zynq-axi-clkgen-2.00.a,
since the original version of this driver was designed on top of that
platform.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Mathias Tausen <mta@gomspace.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

This is a re-spin of an older series.
It needed to wait a txt -> yaml dt conversion:
https://patchwork.kernel.org/project/linux-clk/patch/20201013143421.84188-1-alexandru.ardelean@analog.com/

It's 2 patches squashed into one:
https://patchwork.kernel.org/project/linux-clk/patch/20200929144417.89816-12-alexandru.ardelean@analog.com/
https://patchwork.kernel.org/project/linux-clk/patch/20200929144417.89816-14-alexandru.ardelean@analog.com/

The series from where all this started is:
https://lore.kernel.org/linux-clk/20200929144417.89816-1-alexandru.ardelean@analog.com/

Well, v4 was the point where I decided to split this into smaller
series, and also do the conversion of the binding to yaml.

 drivers/clk/Kconfig          |  2 +-
 drivers/clk/clk-axi-clkgen.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 85856cff506c..252333e585e7 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -247,7 +247,7 @@ config CLK_TWL6040
 
 config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || MICROBLAZE || COMPILE_TEST
 	help
 	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index ad86e031ba3e..a413c13334ff 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -108,6 +108,13 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
 	return 0x1f1f00fa;
 }
 
+static const struct axi_clkgen_limits axi_clkgen_zynqmp_default_limits = {
+	.fpfd_min = 10000,
+	.fpfd_max = 450000,
+	.fvco_min = 800000,
+	.fvco_max = 1600000,
+};
+
 static const struct axi_clkgen_limits axi_clkgen_zynq_default_limits = {
 	.fpfd_min = 10000,
 	.fpfd_max = 300000,
@@ -560,6 +567,14 @@ static int axi_clkgen_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id axi_clkgen_ids[] = {
+	{
+		.compatible = "adi,zynqmp-axi-clkgen-2.00.a",
+		.data = &axi_clkgen_zynqmp_default_limits,
+	},
+	{
+		.compatible = "adi,zynq-axi-clkgen-2.00.a",
+		.data = &axi_clkgen_zynq_default_limits,
+	},
 	{
 		.compatible = "adi,axi-clkgen-2.00.a",
 		.data = &axi_clkgen_zynq_default_limits,
-- 
2.17.1

