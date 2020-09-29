Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1227D17D
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Sep 2020 16:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgI2Oke (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Sep 2020 10:40:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14630 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731390AbgI2Ok0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Sep 2020 10:40:26 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TEbONM004125;
        Tue, 29 Sep 2020 10:40:24 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4kehk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 10:40:24 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08TEeMtg053432
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 10:40:22 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 29 Sep
 2020 07:40:14 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 07:40:14 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08TEdkc5028450;
        Tue, 29 Sep 2020 10:40:16 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 4/7] clk: axi-clkgen: wrap limits in a struct and keep copy on the state object
Date:   Tue, 29 Sep 2020 17:44:14 +0300
Message-ID: <20200929144417.89816-13-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929144417.89816-1-alexandru.ardelean@analog.com>
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_07:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290130
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Up until the these limits were global/hard-coded, since they are typically
limits of the fabric.

However, since this is an FPGA generated clock, this may run on setups
where one clock is on a fabric, and another one synthesized on another
fabric connected via PCIe, and then these limits need to be adjusted for
each instance of the AXI clock.

This change wraps the current constants in 'axi_clkgen_limits' struct and
the 'axi_clkgen' instance keeps a copy of these limits, which is
initialized at probe from the default limits.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 39 ++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 14d803e6af62..4342b7735590 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -46,9 +46,17 @@
 #define MMCM_CLK_DIV_DIVIDE	BIT(11)
 #define MMCM_CLK_DIV_NOCOUNT	BIT(12)
 
+struct axi_clkgen_limits {
+	unsigned int fpfd_min;
+	unsigned int fpfd_max;
+	unsigned int fvco_min;
+	unsigned int fvco_max;
+};
+
 struct axi_clkgen {
 	void __iomem *base;
 	struct clk_hw clk_hw;
+	struct axi_clkgen_limits limits;
 };
 
 static uint32_t axi_clkgen_lookup_filter(unsigned int m)
@@ -100,12 +108,15 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
 	return 0x1f1f00fa;
 }
 
-static const unsigned int fpfd_min = 10000;
-static const unsigned int fpfd_max = 300000;
-static const unsigned int fvco_min = 600000;
-static const unsigned int fvco_max = 1200000;
+static const struct axi_clkgen_limits axi_clkgen_default_limits = {
+	.fpfd_min = 10000,
+	.fpfd_max = 300000,
+	.fvco_min = 600000,
+	.fvco_max = 1200000,
+};
 
-static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
+static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
+	unsigned long fin, unsigned long fout,
 	unsigned int *best_d, unsigned int *best_m, unsigned int *best_dout)
 {
 	unsigned long d, d_min, d_max, _d_min, _d_max;
@@ -122,12 +133,12 @@ static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
 	*best_m = 0;
 	*best_dout = 0;
 
-	d_min = max_t(unsigned long, DIV_ROUND_UP(fin, fpfd_max), 1);
-	d_max = min_t(unsigned long, fin / fpfd_min, 80);
+	d_min = max_t(unsigned long, DIV_ROUND_UP(fin, limits->fpfd_max), 1);
+	d_max = min_t(unsigned long, fin / limits->fpfd_min, 80);
 
 again:
-	fvco_min_fract = fvco_min << fract_shift;
-	fvco_max_fract = fvco_max << fract_shift;
+	fvco_min_fract = limits->fvco_min << fract_shift;
+	fvco_max_fract = limits->fvco_max << fract_shift;
 
 	m_min = max_t(unsigned long, DIV_ROUND_UP(fvco_min_fract, fin) * d_min, 1);
 	m_max = min_t(unsigned long, fvco_max_fract * d_max / fin, 64 << fract_shift);
@@ -319,6 +330,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 	unsigned long rate, unsigned long parent_rate)
 {
 	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
+	const struct axi_clkgen_limits *limits = &axi_clkgen->limits;
 	unsigned int d, m, dout;
 	struct axi_clkgen_div_params params;
 	uint32_t power = 0;
@@ -328,7 +340,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 	if (parent_rate == 0 || rate == 0)
 		return -EINVAL;
 
-	axi_clkgen_calc_params(parent_rate, rate, &d, &m, &dout);
+	axi_clkgen_calc_params(limits, parent_rate, rate, &d, &m, &dout);
 
 	if (d == 0 || dout == 0 || m == 0)
 		return -EINVAL;
@@ -368,10 +380,12 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 static long axi_clkgen_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long *parent_rate)
 {
+	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(hw);
+	const struct axi_clkgen_limits *limits = &axi_clkgen->limits;
 	unsigned int d, m, dout;
 	unsigned long long tmp;
 
-	axi_clkgen_calc_params(*parent_rate, rate, &d, &m, &dout);
+	axi_clkgen_calc_params(limits, *parent_rate, rate, &d, &m, &dout);
 
 	if (d == 0 || dout == 0 || m == 0)
 		return -EINVAL;
@@ -527,6 +541,9 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
+	memcpy(&axi_clkgen->limits, &axi_clkgen_default_limits,
+	       sizeof(axi_clkgen->limits));
+
 	clk_name = pdev->dev.of_node->name;
 	of_property_read_string(pdev->dev.of_node, "clock-output-names",
 		&clk_name);
-- 
2.17.1

