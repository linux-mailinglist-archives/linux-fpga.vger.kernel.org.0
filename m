Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA023B986
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Aug 2020 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgHDL2b (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Aug 2020 07:28:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38910 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbgHDL2S (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Aug 2020 07:28:18 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074B379Y013054;
        Tue, 4 Aug 2020 07:05:42 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n6cjsqjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 07:05:42 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 074B5ecb065013
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 4 Aug 2020 07:05:41 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 4 Aug 2020
 04:05:39 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 4 Aug 2020 04:05:39 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 074B5VDv005208;
        Tue, 4 Aug 2020 07:05:37 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/6] clk: axi-clkgen: add support for ZynqMP (UltraScale)
Date:   Tue, 4 Aug 2020 14:06:55 +0300
Message-ID: <20200804110658.40911-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804110658.40911-1-alexandru.ardelean@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=665 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040083
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

This IP core also works and is supported on the Xilinx ZynqMP (UltraScale)
FPGA boards.
This patch enables the driver to be available on these platforms as well.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 69934c0c3dd8..eaabc758a7e4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -240,7 +240,7 @@ config CLK_TWL6040
 
 config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || MICROBLAZE || COMPILE_TEST
 	help
 	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
-- 
2.17.1

