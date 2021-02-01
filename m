Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA930AAB6
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 16:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBAPNe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 10:13:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46774 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229739AbhBAPK5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Feb 2021 10:10:57 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 111F994U000757;
        Mon, 1 Feb 2021 10:10:05 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36dbucuse2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 10:10:04 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 111FA3ar061905
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 10:10:03 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2; Mon, 1 Feb 2021
 10:10:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 1 Feb 2021 10:10:02 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 111F9uRZ028808;
        Mon, 1 Feb 2021 10:09:59 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v3 1/4] clk: axi-clkgen: replace ARCH dependencies with driver deps
Date:   Mon, 1 Feb 2021 17:12:42 +0200
Message-ID: <20210201151245.21845-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201151245.21845-1-alexandru.ardelean@analog.com>
References: <20210201151245.21845-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=816 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010082
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The intent is to be able to run this driver to access the IP core in setups
where FPGA board is also connected via a PCIe bus. In such cases the number
of combinations explodes, where the host system can be an x86 with Xilinx
Zynq/ZynqMP/Microblaze board connected via PCIe.
Or even a ZynqMP board with a ZynqMP/Zynq/Microblaze connected via PCIe.

To accommodate for these cases, this change removes the limitation for this
driver to be compilable only on Zynq/Microblaze architectures.
And adds dependencies on the mechanisms required by the driver to work (OF
and HAS_IOMEM).

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 85856cff506c..cee1d4e657bc 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -247,7 +247,8 @@ config CLK_TWL6040
 
 config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
+	depends on HAS_IOMEM || COMPILE_TEST
+	depends on OF
 	help
 	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
-- 
2.17.1

