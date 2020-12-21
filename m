Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BEF2DFCF1
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Dec 2020 15:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgLUOkN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Dec 2020 09:40:13 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53028 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbgLUOkM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Dec 2020 09:40:12 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLEZCLI006619;
        Mon, 21 Dec 2020 09:39:19 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 35hfa9w8gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 09:39:19 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0BLEdHbQ049459
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 21 Dec 2020 09:39:17 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 21 Dec 2020 06:39:16 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Mon, 21 Dec 2020 06:39:16 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 21 Dec 2020 06:39:16 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BLEd9nG031672;
        Mon, 21 Dec 2020 09:39:13 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] dt-bindings: clock: adi,axi-clkgen: add Zynq & ZynqMP compatible strings
Date:   Mon, 21 Dec 2020 16:42:24 +0200
Message-ID: <20201221144224.50814-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221144224.50814-1-alexandru.ardelean@analog.com>
References: <20201221144224.50814-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_08:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210104
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The axi-clkgen driver now supports ZynqMP (UltraScale) as well, however the
driver needs to use different PFD & VCO limits.

For ZynqMP, these needs to be selected by using the
'adi,zynqmp-axi-clkgen-2.00.a' string. For consistency a
'adi,zynq-axi-clkgen-2.00.a' has been added which should behave as the
original compatible string (i.e. 'adi,axi-clkgen-2.00.a').

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
index 0d06387184d6..398954ec6767 100644
--- a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
+++ b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
@@ -20,6 +20,8 @@ properties:
   compatible:
     enum:
       - adi,axi-clkgen-2.00.a
+      - adi,zynq-axi-clkgen-2.00.a
+      - adi,zynqmp-axi-clkgen-2.00.a
 
   clocks:
     description:
-- 
2.17.1

