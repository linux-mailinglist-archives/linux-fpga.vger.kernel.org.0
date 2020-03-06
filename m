Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF717BC2B
	for <lists+linux-fpga@lfdr.de>; Fri,  6 Mar 2020 12:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCFLwC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 6 Mar 2020 06:52:02 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54240 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgCFLwB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 6 Mar 2020 06:52:01 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026BkpbQ032442;
        Fri, 6 Mar 2020 06:51:58 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnrax45h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 06:51:58 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 026BpuTe044776
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Mar 2020 06:51:57 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 6 Mar 2020
 03:51:55 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 6 Mar 2020 03:51:55 -0800
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 026Bpnp8026743;
        Fri, 6 Mar 2020 06:51:52 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nios2-dev@lists.rocketboards.org>
CC:     <ley.foon.tan@intel.com>, <robh+dt@kernel.org>, <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] arch: nios2: remove 'resetvalue' property
Date:   Fri, 6 Mar 2020 13:54:50 +0200
Message-ID: <20200306115450.3352-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306115450.3352-1-alexandru.ardelean@analog.com>
References: <20200306115450.3352-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_03:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=626 bulkscore=0
 adultscore=1 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060085
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The 'altr,pio-1.0' driver does not handle the 'resetvalue', so remove it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 -
 arch/nios2/boot/dts/10m50_devboard.dts                 | 2 --
 2 files changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index b0dacb6a3390..8ab19d1d3f9a 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -469,7 +469,6 @@ programming is the FPGA based bridge of fpga_region1.
 				reg = <0x10040 0x20>;
 				clocks = <0x2>;
 				altr,ngpio = <0x4>;
-				resetvalue = <0x0>;
 				#gpio-cells = <0x2>;
 				gpio-controller;
 			};
diff --git a/arch/nios2/boot/dts/10m50_devboard.dts b/arch/nios2/boot/dts/10m50_devboard.dts
index 739ad96a6cc1..56339bef3247 100644
--- a/arch/nios2/boot/dts/10m50_devboard.dts
+++ b/arch/nios2/boot/dts/10m50_devboard.dts
@@ -180,7 +180,6 @@
 			compatible = "altr,pio-1.0";
 			reg = <0x180014d0 0x00000010>;
 			altr,ngpio = <4>;
-			resetvalue = <15>;
 			#gpio-cells = <2>;
 			gpio-controller;
 		};
@@ -194,7 +193,6 @@
 			altr,interrupt-type = <2>;
 			edge_type = <1>;
 			level_trigger = <0>;
-			resetvalue = <0>;
 			#gpio-cells = <2>;
 			gpio-controller;
 		};
-- 
2.20.1

