Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB0E23BA56
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Aug 2020 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgHDM3e (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Aug 2020 08:29:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20830 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgHDM30 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Aug 2020 08:29:26 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074B58kx007325;
        Tue, 4 Aug 2020 07:05:39 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n69ehhxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 07:05:39 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 074B5cPK005219
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 4 Aug 2020 07:05:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 4 Aug 2020
 07:05:37 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 4 Aug 2020 07:05:37 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 074B5VDt005208;
        Tue, 4 Aug 2020 07:05:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/6] clk: axi-clkgen: Add support for fractional dividers
Date:   Tue, 4 Aug 2020 14:06:53 +0300
Message-ID: <20200804110658.40911-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804110658.40911-1-alexandru.ardelean@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040084
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

The axi-clkgen has (optional) fractional dividers on the output clock
divider and feedback clock divider path. Utilizing the fractional dividers
allows for a better resolution of the output clock, being able to
synthesize more frequencies.

Rework the driver support to support the fractional register fields, both
for setting a new rate as well as reading back the current rate from the
hardware.

For setting the rate if no perfect divider settings were found in
non-fractional mode try again in fractional mode and see if better settings
can be found. This appears to be the recommended mode of operation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 180 +++++++++++++++++++++++++----------
 1 file changed, 129 insertions(+), 51 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 96f351785b41..1df03cc6d089 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -27,8 +27,10 @@
 
 #define AXI_CLKGEN_V2_DRP_STATUS_BUSY	BIT(16)
 
+#define MMCM_REG_CLKOUT5_2	0x07
 #define MMCM_REG_CLKOUT0_1	0x08
 #define MMCM_REG_CLKOUT0_2	0x09
+#define MMCM_REG_CLKOUT6_2	0x13
 #define MMCM_REG_CLK_FB1	0x14
 #define MMCM_REG_CLK_FB2	0x15
 #define MMCM_REG_CLK_DIV	0x16
@@ -40,6 +42,7 @@
 
 #define MMCM_CLKOUT_NOCOUNT	BIT(6)
 
+#define MMCM_CLK_DIV_DIVIDE	BIT(11)
 #define MMCM_CLK_DIV_NOCOUNT	BIT(12)
 
 struct axi_clkgen {
@@ -107,6 +110,8 @@ static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
 	unsigned long d, d_min, d_max, _d_min, _d_max;
 	unsigned long m, m_min, m_max;
 	unsigned long f, dout, best_f, fvco;
+	unsigned long fract_shift = 0;
+	unsigned long fvco_min_fract, fvco_max_fract;
 
 	fin /= 1000;
 	fout /= 1000;
@@ -119,42 +124,89 @@ static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
 	d_min = max_t(unsigned long, DIV_ROUND_UP(fin, fpfd_max), 1);
 	d_max = min_t(unsigned long, fin / fpfd_min, 80);
 
-	m_min = max_t(unsigned long, DIV_ROUND_UP(fvco_min, fin) * d_min, 1);
-	m_max = min_t(unsigned long, fvco_max * d_max / fin, 64);
+again:
+	fvco_min_fract = fvco_min << fract_shift;
+	fvco_max_fract = fvco_max << fract_shift;
+
+	m_min = max_t(unsigned long, DIV_ROUND_UP(fvco_min_fract, fin) * d_min, 1);
+	m_max = min_t(unsigned long, fvco_max_fract * d_max / fin, 64 << fract_shift);
 
 	for (m = m_min; m <= m_max; m++) {
-		_d_min = max(d_min, DIV_ROUND_UP(fin * m, fvco_max));
-		_d_max = min(d_max, fin * m / fvco_min);
+		_d_min = max(d_min, DIV_ROUND_UP(fin * m, fvco_max_fract));
+		_d_max = min(d_max, fin * m / fvco_min_fract);
 
 		for (d = _d_min; d <= _d_max; d++) {
 			fvco = fin * m / d;
 
 			dout = DIV_ROUND_CLOSEST(fvco, fout);
-			dout = clamp_t(unsigned long, dout, 1, 128);
+			dout = clamp_t(unsigned long, dout, 1, 128 << fract_shift);
 			f = fvco / dout;
 			if (abs(f - fout) < abs(best_f - fout)) {
 				best_f = f;
 				*best_d = d;
-				*best_m = m;
-				*best_dout = dout;
+				*best_m = m << (3 - fract_shift);
+				*best_dout = dout << (3 - fract_shift);
 				if (best_f == fout)
 					return;
 			}
 		}
 	}
+
+	/* Lets see if we find a better setting in fractional mode */
+	if (fract_shift == 0) {
+		fract_shift = 3;
+		goto again;
+	}
 }
 
-static void axi_clkgen_calc_clk_params(unsigned int divider, unsigned int *low,
-	unsigned int *high, unsigned int *edge, unsigned int *nocount)
+struct axi_clkgen_div_params {
+	unsigned int low;
+	unsigned int high;
+	unsigned int edge;
+	unsigned int nocount;
+	unsigned int frac_en;
+	unsigned int frac;
+	unsigned int frac_wf_f;
+	unsigned int frac_wf_r;
+	unsigned int frac_phase;
+};
+
+static void axi_clkgen_calc_clk_params(unsigned int divider,
+	unsigned int frac_divider, struct axi_clkgen_div_params *params)
 {
-	if (divider == 1)
-		*nocount = 1;
-	else
-		*nocount = 0;
 
-	*high = divider / 2;
-	*edge = divider % 2;
-	*low = divider - *high;
+	memset(params, 0x0, sizeof(*params));
+
+	if (divider == 1) {
+		params->nocount = 1;
+		return;
+	}
+
+	if (frac_divider == 0) {
+		params->high = divider / 2;
+		params->edge = divider % 2;
+		params->low = divider - params->high;
+	} else {
+		params->frac_en = 1;
+		params->frac = frac_divider;
+
+		params->high = divider / 2;
+		params->edge = divider % 2;
+		params->low = params->high;
+
+		if (params->edge == 0) {
+			params->high--;
+			params->frac_wf_r = 1;
+		}
+
+		if (params->edge == 0 || frac_divider == 1)
+			params->low--;
+		if (((params->edge == 0) ^ (frac_divider == 1)) ||
+			(divider == 2 && frac_divider == 1))
+			params->frac_wf_f = 1;
+
+		params->frac_phase = params->edge * 4 + frac_divider / 2;
+	}
 }
 
 static void axi_clkgen_write(struct axi_clkgen *axi_clkgen,
@@ -246,15 +298,28 @@ static struct axi_clkgen *clk_hw_to_axi_clkgen(struct clk_hw *clk_hw)
 	return container_of(clk_hw, struct axi_clkgen, clk_hw);
 }
 
+static void axi_clkgen_set_div(struct axi_clkgen *axi_clkgen,
+	unsigned int reg1, unsigned int reg2, unsigned int reg3,
+	struct axi_clkgen_div_params *params)
+{
+	axi_clkgen_mmcm_write(axi_clkgen, reg1,
+		(params->high << 6) | params->low, 0xefff);
+	axi_clkgen_mmcm_write(axi_clkgen, reg2,
+		(params->frac << 12) | (params->frac_en << 11) |
+		(params->frac_wf_r << 10) | (params->edge << 7) |
+		(params->nocount << 6), 0x7fff);
+	if (reg3 != 0) {
+		axi_clkgen_mmcm_write(axi_clkgen, reg3,
+			(params->frac_phase << 11) | (params->frac_wf_f << 10), 0x3c00);
+	}
+}
+
 static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 	unsigned long rate, unsigned long parent_rate)
 {
 	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
 	unsigned int d, m, dout;
-	unsigned int nocount;
-	unsigned int high;
-	unsigned int edge;
-	unsigned int low;
+	struct axi_clkgen_div_params params;
 	uint32_t filter;
 	uint32_t lock;
 
@@ -269,21 +334,18 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 	filter = axi_clkgen_lookup_filter(m - 1);
 	lock = axi_clkgen_lookup_lock(m - 1);
 
-	axi_clkgen_calc_clk_params(dout, &low, &high, &edge, &nocount);
-	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_CLKOUT0_1,
-		(high << 6) | low, 0xefff);
-	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_CLKOUT0_2,
-		(edge << 7) | (nocount << 6), 0x03ff);
+	axi_clkgen_calc_clk_params(dout >> 3, dout & 0x7, &params);
+	axi_clkgen_set_div(axi_clkgen,  MMCM_REG_CLKOUT0_1, MMCM_REG_CLKOUT0_2,
+		MMCM_REG_CLKOUT5_2, &params);
 
-	axi_clkgen_calc_clk_params(d, &low, &high, &edge, &nocount);
+	axi_clkgen_calc_clk_params(d, 0, &params);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_CLK_DIV,
-		(edge << 13) | (nocount << 12) | (high << 6) | low, 0x3fff);
+		(params.edge << 13) | (params.nocount << 12) |
+		(params.high << 6) | params.low, 0x3fff);
 
-	axi_clkgen_calc_clk_params(m, &low, &high, &edge, &nocount);
-	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_CLK_FB1,
-		(high << 6) | low, 0xefff);
-	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_CLK_FB2,
-		(edge << 7) | (nocount << 6), 0x03ff);
+	axi_clkgen_calc_clk_params(m >> 3, m & 0x7, &params);
+	axi_clkgen_set_div(axi_clkgen,  MMCM_REG_CLK_FB1, MMCM_REG_CLK_FB2,
+		MMCM_REG_CLKOUT6_2, &params);
 
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_LOCK1, lock & 0x3ff, 0x3ff);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_LOCK2,
@@ -313,35 +375,51 @@ static long axi_clkgen_round_rate(struct clk_hw *hw, unsigned long rate,
 	return min_t(unsigned long long, tmp, LONG_MAX);
 }
 
+static unsigned int axi_clkgen_get_div(struct axi_clkgen *axi_clkgen,
+	unsigned int reg1, unsigned int reg2)
+{
+	unsigned int val1, val2;
+	unsigned int div;
+
+	axi_clkgen_mmcm_read(axi_clkgen, reg2, &val2);
+	if (val2 & MMCM_CLKOUT_NOCOUNT)
+		return 8;
+
+	axi_clkgen_mmcm_read(axi_clkgen, reg1, &val1);
+
+	div = (val1 & 0x3f) + ((val1 >> 6) & 0x3f);
+	div <<= 3;
+
+	if (val2 & MMCM_CLK_DIV_DIVIDE) {
+		if ((val2 & BIT(7)) && (val2 & 0x7000) != 0x1000)
+			div += 8;
+		else
+			div += 16;
+
+		div += (val2 >> 12) & 0x7;
+	}
+
+	return div;
+}
+
 static unsigned long axi_clkgen_recalc_rate(struct clk_hw *clk_hw,
 	unsigned long parent_rate)
 {
 	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
 	unsigned int d, m, dout;
-	unsigned int reg;
 	unsigned long long tmp;
+	unsigned int val;
 
-	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_2, &reg);
-	if (reg & MMCM_CLKOUT_NOCOUNT) {
-		dout = 1;
-	} else {
-		axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_1, &reg);
-		dout = (reg & 0x3f) + ((reg >> 6) & 0x3f);
-	}
+	dout = axi_clkgen_get_div(axi_clkgen, MMCM_REG_CLKOUT0_1,
+		MMCM_REG_CLKOUT0_2);
+	m = axi_clkgen_get_div(axi_clkgen, MMCM_REG_CLK_FB1,
+		MMCM_REG_CLK_FB2);
 
-	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_DIV, &reg);
-	if (reg & MMCM_CLK_DIV_NOCOUNT)
+	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_DIV, &val);
+	if (val & MMCM_CLK_DIV_NOCOUNT)
 		d = 1;
 	else
-		d = (reg & 0x3f) + ((reg >> 6) & 0x3f);
-
-	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB2, &reg);
-	if (reg & MMCM_CLKOUT_NOCOUNT) {
-		m = 1;
-	} else {
-		axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB1, &reg);
-		m = (reg & 0x3f) + ((reg >> 6) & 0x3f);
-	}
+		d = (val & 0x3f) + ((val >> 6) & 0x3f);
 
 	if (d == 0 || dout == 0)
 		return 0;
-- 
2.17.1

