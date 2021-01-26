Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB42303CC9
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 13:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392150AbhAZMTe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 07:19:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62982 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404979AbhAZLG3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 06:06:29 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QB0Jgm002104;
        Tue, 26 Jan 2021 06:05:33 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 368ehahqmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 06:05:33 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10QB5Wp3028966
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 26 Jan 2021 06:05:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 26 Jan
 2021 06:05:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 26 Jan 2021 06:05:31 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10QB5PQd007159;
        Tue, 26 Jan 2021 06:05:28 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v2 1/3] clk: axi-clkgen: remove ARCH dependency in Kconfig
Date:   Tue, 26 Jan 2021 13:08:24 +0200
Message-ID: <20210126110826.24221-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126110826.24221-1-alexandru.ardelean@analog.com>
References: <20210126110826.24221-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=821 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260058
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

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 85856cff506c..d8c2d4593926 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -247,7 +247,6 @@ config CLK_TWL6040
 
 config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
 	help
 	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
-- 
2.17.1

