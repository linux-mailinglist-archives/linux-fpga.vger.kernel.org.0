Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74399276B7D
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgIXILX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 04:11:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30936 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbgIXILX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Sep 2020 04:11:23 -0400
X-Greylist: delayed 4844 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 04:11:23 EDT
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O6iehk021055;
        Thu, 24 Sep 2020 02:50:50 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5u9b1t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 02:50:50 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08O6omuf063893
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 02:50:49 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 23 Sep 2020 23:50:47 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 23 Sep 2020 23:50:16 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 23 Sep 2020 23:50:46 -0700
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08O6oSlX022302;
        Thu, 24 Sep 2020 02:50:43 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>, <mircea.caprioru@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: [PATCH v3 6/6] clk: axi-clkgen: Add support for FPGA info
Date:   Thu, 24 Sep 2020 09:50:12 +0300
Message-ID: <20200924065012.59605-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924065012.59605-1-alexandru.ardelean@analog.com>
References: <20200924065012.59605-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_02:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=860 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240052
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
 drivers/clk/clk-axi-clkgen.c | 67 +++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 6ffc19e9d850..b03ea28270cb 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -8,6 +8,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/fpga/adi-axi-common.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -49,6 +50,7 @@
 struct axi_clkgen {
 	void __iomem *base;
 	struct clk_hw clk_hw;
+	unsigned int pcore_version;
 };
 
 static uint32_t axi_clkgen_lookup_filter(unsigned int m)
@@ -101,15 +103,15 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
 }
 
 #ifdef ARCH_ZYNQMP
-static const unsigned int fpfd_min = 10000;
-static const unsigned int fpfd_max = 450000;
-static const unsigned int fvco_min = 800000;
-static const unsigned int fvco_max = 1600000;
+static unsigned int fpfd_min = 10000;
+static unsigned int fpfd_max = 450000;
+static unsigned int fvco_min = 800000;
+static unsigned int fvco_max = 1600000;
 #else
-static const unsigned int fpfd_min = 10000;
-static const unsigned int fpfd_max = 300000;
-static const unsigned int fvco_min = 600000;
-static const unsigned int fvco_max = 1200000;
+static unsigned int fpfd_min = 10000;
+static unsigned int fpfd_max = 300000;
+static unsigned int fvco_min = 600000;
+static unsigned int fvco_max = 1200000;
 #endif
 
 static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
@@ -229,6 +231,49 @@ static void axi_clkgen_read(struct axi_clkgen *axi_clkgen,
 	*val = readl(axi_clkgen->base + reg);
 }
 
+static void axi_clkgen_setup_ranges(struct axi_clkgen *axi_clkgen)
+{
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
+		fvco_max = 1200000;
+		fpfd_max = 450000;
+		break;
+	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_2 ... ADI_AXI_FPGA_SPEED_GRADE_XILINX_2LV:
+		fvco_max = 1440000;
+		fpfd_max = 500000;
+		if ((family == ADI_AXI_FPGA_FAMILY_XILINX_KINTEX) |
+		    (family == ADI_AXI_FPGA_FAMILY_XILINX_ARTIX)) {
+			if (voltage < 950) {
+				fvco_max = 1200000;
+				fpfd_max = 450000;
+			}
+		}
+		break;
+	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_3:
+		fvco_max = 1600000;
+		fpfd_max = 550000;
+		break;
+	default:
+		break;
+	};
+
+	if (tech == ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE_PLUS) {
+		fvco_max = 1600000;
+		fvco_min = 800000;
+	}
+}
+
 static int axi_clkgen_wait_non_busy(struct axi_clkgen *axi_clkgen)
 {
 	unsigned int timeout = 10000;
@@ -524,6 +569,12 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 	if (IS_ERR(axi_clkgen->base))
 		return PTR_ERR(axi_clkgen->base);
 
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_VERSION,
+			&axi_clkgen->pcore_version);
+
+	if (ADI_AXI_PCORE_VER_MAJOR(axi_clkgen->pcore_version) > 0x04)
+		axi_clkgen_setup_ranges(axi_clkgen);
+
 	init.num_parents = of_clk_get_parent_count(pdev->dev.of_node);
 	if (init.num_parents < 1 || init.num_parents > 2)
 		return -EINVAL;
-- 
2.25.1

