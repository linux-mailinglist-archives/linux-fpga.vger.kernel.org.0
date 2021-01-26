Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C248303B15
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 12:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404982AbhAZLGn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 06:06:43 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5270 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404527AbhAZLGd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 06:06:33 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QB1KK8001778;
        Tue, 26 Jan 2021 06:05:36 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 368hk9hnpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 06:05:36 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10QB5ZGT028972
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 26 Jan 2021 06:05:35 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 26 Jan
 2021 06:05:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 26 Jan 2021 06:05:34 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10QB5PQe007159;
        Tue, 26 Jan 2021 06:05:30 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Mathias Tausen <mta@gomspace.com>
Subject: [PATCH v2 2/3] clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
Date:   Tue, 26 Jan 2021 13:08:25 +0200
Message-ID: <20210126110826.24221-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126110826.24221-1-alexandru.ardelean@analog.com>
References: <20210126110826.24221-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=829 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260058
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

For ZynqMP (Ultrascale) the PFD and VCO limits are different. In order to
support these, this change adds a compatible string (i.e.
'adi,zynqmp-axi-clkgen-2.00.a')  which will take into account for these
limits and apply them.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Mathias Tausen <mta@gomspace.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index ad86e031ba3e..9d1b0fc56c73 100644
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
@@ -560,6 +567,10 @@ static int axi_clkgen_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id axi_clkgen_ids[] = {
+	{
+		.compatible = "adi,zynqmp-axi-clkgen-2.00.a",
+		.data = &axi_clkgen_zynqmp_default_limits,
+	},
 	{
 		.compatible = "adi,axi-clkgen-2.00.a",
 		.data = &axi_clkgen_zynq_default_limits,
-- 
2.17.1

