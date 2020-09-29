Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6E27D195
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Sep 2020 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgI2OkM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Sep 2020 10:40:12 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51830 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730519AbgI2OkM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Sep 2020 10:40:12 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TEdJjk008158;
        Tue, 29 Sep 2020 10:40:09 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg63kka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 10:40:09 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08TEe7JC053378
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 10:40:08 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 07:40:00 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 07:39:59 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 07:39:59 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08TEdkbx028450;
        Tue, 29 Sep 2020 10:40:01 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 6/7] include: fpga: adi-axi-common.h: add definitions for supported FPGAs
Date:   Tue, 29 Sep 2020 17:44:08 +0300
Message-ID: <20200929144417.89816-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929144417.89816-1-alexandru.ardelean@analog.com>
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_07:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=801
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290130
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Mircea Caprioru <mircea.caprioru@analog.com>

All (newer) FPGA IP cores supported by Analog Devices, store information in
the synthesized designs. This information describes various parameters,
including the family of boards on which this is deployed, speed-grade, and
so on.

Currently, some of these definitions are deployed mostly on Xilinx boards,
but they have been considered also for FPGA boards from other vendors.

The register definitions are described at this link:
  https://wiki.analog.com/resources/fpga/docs/hdl/regmap
(the 'Base (common to all cores)' section).

Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/fpga/adi-axi-common.h | 103 ++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
index 141ac3f251e6..1a7f18e3a384 100644
--- a/include/linux/fpga/adi-axi-common.h
+++ b/include/linux/fpga/adi-axi-common.h
@@ -13,6 +13,9 @@
 
 #define ADI_AXI_REG_VERSION			0x0000
 
+#define ADI_AXI_REG_FPGA_INFO			0x001C
+#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
+
 #define ADI_AXI_PCORE_VER(major, minor, patch)	\
 	(((major) << 16) | ((minor) << 8) | (patch))
 
@@ -20,4 +23,104 @@
 #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
 #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
 
+#define ADI_AXI_INFO_FPGA_VOLTAGE(val)		((val) & 0xffff)
+
+#define ADI_AXI_INFO_FPGA_TECH(info)		(((info) >> 24) & 0xff)
+#define ADI_AXI_INFO_FPGA_FAMILY(info)		(((info) >> 16) & 0xff)
+#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)	(((info) >> 8) & 0xff)
+#define ADI_AXI_INFO_FPGA_DEV_PACKAGE(info)	((info) & 0xff)
+
+/**
+ * FPGA Technology definitions
+ */
+#define ADI_AXI_FPGA_TECH_XILINX_UNKNOWN		0
+#define ADI_AXI_FPGA_TECH_XILINS_SERIES7		1
+#define ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE		2
+#define ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE_PLUS	3
+
+#define ADI_AXI_FPGA_TECH_INTEL_UNKNOWN			100
+#define ADI_AXI_FPGA_TECH_INTEL_CYCLONE_5		101
+#define ADI_AXI_FPGA_TECH_INTEL_CYCLONE_10		102
+#define ADI_AXI_FPGA_TECH_INTEL_ARRIA_10		103
+#define ADI_AXI_FPGA_TECH_INTEL_STRATIX_10		104
+
+/**
+ * FPGA Family definitions
+ */
+#define ADI_AXI_FPGA_FAMILY_UNKNOWN			0
+
+#define ADI_AXI_FPGA_FAMILY_XILINX_ARTIX		1
+#define ADI_AXI_FPGA_FAMILY_XILINX_KINTEX		2
+#define ADI_AXI_FPGA_FAMILY_XILINX_VIRTEX		3
+#define ADI_AXI_FPGA_FAMILY_XILINX_ZYNQ			4
+
+#define ADI_AXI_FPGA_FAMILY_INTEL_SX			1
+#define ADI_AXI_FPGA_FAMILY_INTEL_GX			2
+#define ADI_AXI_FPGA_FAMILY_INTEL_GT			3
+#define ADI_AXI_FPGA_FAMILY_INTEL_GZ			4
+
+/**
+ * FPGA Speed-grade definitions
+ */
+#define ADI_AXI_FPGA_SPEED_GRADE_UNKNOWN		0
+
+#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1		10
+#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1L		11
+#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1H		12
+#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1HV		13
+#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1LV		14
+#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2		20
+#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2L		21
+#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2LV		22
+#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_3		30
+
+#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_1		1
+#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_2		2
+#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_3		3
+#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_4		4
+#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_5		5
+#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_6		6
+#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_7		7
+#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_8		8
+#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_9		9
+
+/**
+ * FPGA Device Package definitions
+ */
+#define ADI_AXI_FPGA_DEV_PACKAGE_UNKNOWN		0
+
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RF		1
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FL		2
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FF		3
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FB		4
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_HC		5
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FH		6
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CS		7
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CP		8
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FT		9
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FG		10
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_SB		11
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RB		12
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RS		13
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CL		14
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_SF		15
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_BA		16
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FA		17
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FS		18
+#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FI		19
+
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_BGA		1
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PGA		2
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_FBGA		3
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_HBGA		4
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PDIP		5
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_EQFP		6
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PLCC		7
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PQFP		8
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_RQFP		9
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_TQFP		10
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_UBGA		11
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_UFBGA		12
+#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_MBGA		13
+
 #endif /* ADI_AXI_COMMON_H_ */
-- 
2.17.1

