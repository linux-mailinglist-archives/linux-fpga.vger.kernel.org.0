Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D906C276C1D
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgIXIhT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 04:37:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32792 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727235AbgIXIhT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Sep 2020 04:37:19 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O6kf57024739;
        Thu, 24 Sep 2020 02:50:47 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5p6b12s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 02:50:47 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08O6okno035497
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 02:50:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 24 Sep
 2020 02:50:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 24 Sep 2020 02:50:44 -0400
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08O6oSlW022302;
        Thu, 24 Sep 2020 02:50:41 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>, <mircea.caprioru@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: [PATCH v3 5/6] include: fpga: adi-axi-common.h: add definitions for supported FPGAs
Date:   Thu, 24 Sep 2020 09:50:11 +0300
Message-ID: <20200924065012.59605-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924065012.59605-1-alexandru.ardelean@analog.com>
References: <20200924065012.59605-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_02:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=775 impostorscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240052
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
2.25.1

