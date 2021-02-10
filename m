Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F331637B
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Feb 2021 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhBJKQL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Feb 2021 05:16:11 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19344 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhBJKOI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Feb 2021 05:14:08 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AAB01Z008183;
        Wed, 10 Feb 2021 05:13:14 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw8v4t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:13:14 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11AADDAC026388
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Feb 2021 05:13:13 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Wed, 10 Feb 2021
 05:13:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Wed, 10 Feb 2021 05:13:12 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11AAD8UD018370;
        Wed, 10 Feb 2021 05:13:10 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] clk: axi-clkgen: Add support for FPGA info
Date:   Wed, 10 Feb 2021 12:15:35 +0200
Message-ID: <20210210101535.47979-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210101535.47979-1-alexandru.ardelean@analog.com>
References: <20210210101535.47979-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100099
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Mircea Caprioru <mircea.caprioru@analog.com>

This patch adds support for vco maximum and minimum ranges in accordance
with fpga speed grade, voltage, device package, technology and family. This
new information is extracted from two new registers implemented in the ip
core: ADI_REG_FPGA_INFO and ADI_REG_FPGA_VOLTAGE, which are stored in the
'include/linux/fpga/adi-axi-common.h' file as they are common to all ADI
FPGA cores.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 52 +++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index ac6ff736ac8f..e4d6c87f8a07 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -8,6 +8,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/fpga/adi-axi-common.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -240,6 +241,50 @@ static void axi_clkgen_read(struct axi_clkgen *axi_clkgen,
 	*val = readl(axi_clkgen->base + reg);
 }
 
+static void axi_clkgen_setup_ranges(struct axi_clkgen *axi_clkgen)
+{
+	struct axi_clkgen_limits *limits = &axi_clkgen->limits;
+	unsigned int reg_value;
+	unsigned int tech, family, speed_grade, voltage;
+
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_INFO, &reg_value);
+	tech = ADI_AXI_INFO_FPGA_TECH(reg_value);
+	family = ADI_AXI_INFO_FPGA_FAMILY(reg_value);
+	speed_grade = ADI_AXI_INFO_FPGA_SPEED_GRADE(reg_value);
+
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_VOLTAGE, &reg_value);
+	voltage = ADI_AXI_INFO_FPGA_VOLTAGE(reg_value);
+
+	switch (speed_grade) {
+	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_1 ... ADI_AXI_FPGA_SPEED_GRADE_XILINX_1LV:
+		limits->fvco_max = 1200000;
+		limits->fpfd_max = 450000;
+		break;
+	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_2 ... ADI_AXI_FPGA_SPEED_GRADE_XILINX_2LV:
+		limits->fvco_max = 1440000;
+		limits->fpfd_max = 500000;
+		if ((family == ADI_AXI_FPGA_FAMILY_XILINX_KINTEX) |
+		    (family == ADI_AXI_FPGA_FAMILY_XILINX_ARTIX)) {
+			if (voltage < 950) {
+				limits->fvco_max = 1200000;
+				limits->fpfd_max = 450000;
+			}
+		}
+		break;
+	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_3:
+		limits->fvco_max = 1600000;
+		limits->fpfd_max = 550000;
+		break;
+	default:
+		break;
+	};
+
+	if (tech == ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE_PLUS) {
+		limits->fvco_max = 1600000;
+		limits->fvco_min = 800000;
+	}
+}
+
 static int axi_clkgen_wait_non_busy(struct axi_clkgen *axi_clkgen)
 {
 	unsigned int timeout = 10000;
@@ -510,7 +555,7 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 	struct clk_init_data init;
 	const char *parent_names[2];
 	const char *clk_name;
-	unsigned int i;
+	unsigned int i, ver;
 	int ret;
 
 	dflt_limits = device_get_match_data(&pdev->dev);
@@ -537,6 +582,11 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 
 	memcpy(&axi_clkgen->limits, dflt_limits, sizeof(axi_clkgen->limits));
 
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_VERSION, &ver);
+
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) > 0x04)
+		axi_clkgen_setup_ranges(axi_clkgen);
+
 	clk_name = pdev->dev.of_node->name;
 	of_property_read_string(pdev->dev.of_node, "clock-output-names",
 		&clk_name);
-- 
2.17.1

