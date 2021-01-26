Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EA5303B18
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 12:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404991AbhAZLHL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 06:07:11 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1524 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727404AbhAZLGa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 06:06:30 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QB0KJD002174;
        Tue, 26 Jan 2021 06:05:38 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 368ehahqmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 06:05:37 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10QB5a5V028976
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 26 Jan 2021 06:05:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 26 Jan
 2021 06:05:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 26 Jan 2021 06:05:35 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10QB5PQf007159;
        Tue, 26 Jan 2021 06:05:33 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/3] dt-bindings: clock: adi,axi-clkgen: add compatible string for ZynqMP support
Date:   Tue, 26 Jan 2021 13:08:26 +0200
Message-ID: <20210126110826.24221-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126110826.24221-1-alexandru.ardelean@analog.com>
References: <20210126110826.24221-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260058
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The axi-clkgen driver now supports ZynqMP (UltraScale) as well, however the
driver needs to use different PFD & VCO limits.

For ZynqMP, these needs to be selected by using the
'adi,zynqmp-axi-clkgen-2.00.a' string.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
index 0d06387184d6..983033fe5b17 100644
--- a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
+++ b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - adi,axi-clkgen-2.00.a
+      - adi,zynqmp-axi-clkgen-2.00.a
 
   clocks:
     description:
-- 
2.17.1

