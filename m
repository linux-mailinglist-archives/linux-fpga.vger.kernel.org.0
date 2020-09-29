Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA1E27D17F
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Sep 2020 16:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbgI2Oki (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Sep 2020 10:40:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29348 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730303AbgI2Okd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Sep 2020 10:40:33 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TEbcgU004650;
        Tue, 29 Sep 2020 10:40:25 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4kehp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 10:40:25 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08TEeOMs041994
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 10:40:24 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 10:40:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 10:40:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 10:40:16 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08TEdkc6028450;
        Tue, 29 Sep 2020 10:40:19 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>, Mathias Tausen <mta@gomspace.com>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v4 5/7] clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits
Date:   Tue, 29 Sep 2020 17:44:15 +0300
Message-ID: <20200929144417.89816-14-alexandru.ardelean@analog.com>
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
 bulkscore=0 clxscore=1015 mlxlogscore=743 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290130
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Mathias Tausen <mta@gomspace.com>

Since axi-clkgen is now supported on ZYNQMP, make sure the max/min
frequencies of the PFD and VCO are respected.

Signed-off-by: Mathias Tausen <mta@gomspace.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 4342b7735590..2319bb1c5c08 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -108,12 +108,21 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
 	return 0x1f1f00fa;
 }
 
+#ifdef ARCH_ZYNQMP
+static const struct axi_clkgen_limits axi_clkgen_default_limits = {
+	.fpfd_min = 10000,
+	.fpfd_max = 450000,
+	.fvco_min = 800000,
+	.fvco_max = 1600000,
+};
+#else
 static const struct axi_clkgen_limits axi_clkgen_default_limits = {
 	.fpfd_min = 10000,
 	.fpfd_max = 300000,
 	.fvco_min = 600000,
 	.fvco_max = 1200000,
 };
+#endif
 
 static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
 	unsigned long fin, unsigned long fout,
-- 
2.17.1

