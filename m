Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC94223BAE2
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Aug 2020 15:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgHDNJX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Aug 2020 09:09:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21508 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbgHDNJX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Aug 2020 09:09:23 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074B4vol007160;
        Tue, 4 Aug 2020 07:05:44 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n69ehhy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 07:05:44 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 074B5hsO005238
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 4 Aug 2020 07:05:43 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 4 Aug 2020
 07:05:42 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 4 Aug 2020 07:05:42 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 074B5VDw005208;
        Tue, 4 Aug 2020 07:05:39 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        Mathias Tausen <mta@gomspace.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/6] clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits
Date:   Tue, 4 Aug 2020 14:06:56 +0300
Message-ID: <20200804110658.40911-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804110658.40911-1-alexandru.ardelean@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=682 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040084
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Mathias Tausen <mta@gomspace.com>

Since axi-clkgen is now supported on ZYNQMP, make sure the max/min
frequencies of the PFD and VCO are respected.

Signed-off-by: Mathias Tausen <mta@gomspace.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 14d803e6af62..6ffc19e9d850 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -100,10 +100,17 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
 	return 0x1f1f00fa;
 }
 
+#ifdef ARCH_ZYNQMP
+static const unsigned int fpfd_min = 10000;
+static const unsigned int fpfd_max = 450000;
+static const unsigned int fvco_min = 800000;
+static const unsigned int fvco_max = 1600000;
+#else
 static const unsigned int fpfd_min = 10000;
 static const unsigned int fpfd_max = 300000;
 static const unsigned int fvco_min = 600000;
 static const unsigned int fvco_max = 1200000;
+#endif
 
 static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
 	unsigned int *best_d, unsigned int *best_m, unsigned int *best_dout)
-- 
2.17.1

