Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39467389F8C
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 10:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhETIMk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 04:12:40 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:3798
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229953AbhETIMk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 04:12:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQOPTog2kIm2YhxBjMqYf+Mm1UjO9KY04f7+aG5Om6u0CNMCDNwF11KfwxlWNtYUB/CrvJk7u3aU+lRw+511QkLUyySR217T9ZBbOf2Qg6isb4179363Ah4NNhCMVyy3OxrJ7yIfhGZi6SlxS5/tdiH9BznfBEOvDP2jtdBD/lDxsg7xwGC3ZMpCJhbF/mSmyqReDk2lvg+7sb5TAOM5Bj4bHPyWhfETGmvzeJ3HUi6gVxs1TdEP335EbBi/KVbPM/7wiZHL6CI9gUqmxGyPrdKZwCoqMoQ6HoT/WeJCBjGP5GyWdS5r+ft0pDtQWDogZrg/FMP/s6oqjKY9OsLjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d9OPnim+dQ8PjkhePuL2xqi4lRmnMRAVgszwGm5eUM=;
 b=WKyItFfoG33A+zZrlFha3j1od4P7obeBiTjCspWl+1UiLT5MIQiZk9NnShhCx2GHehWJ8jbRWHrqf8vvDM8Zmf6mGKCTpCB7QqKmf1Pq1BgTfPp1GrsBwFAgSZlLaMJOAxjdZwCIH5IYEcLhzq3jFn1bYISNLHGWbivUT4CykT1evnR/lKPaN97gaNijnQ9POxa/MF6WN+S9FUfbbien8VU0O7tXcMWGNKoHfYqbCYQdtKOqp18mnpVmrvYGPthSx8NyyREycGQLZHCbv2Q1xheYkHTOR5/iepbfHe49zFKu6MIYE+83x9Aoq/BILdSGdIuzf0Wtj4dtncRmx6E99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d9OPnim+dQ8PjkhePuL2xqi4lRmnMRAVgszwGm5eUM=;
 b=seJkMg7l+YswFfy+tnhcKhBCAdkiO2FrWY6/nvUIoWVqgEs1ZeF2T7vCGSEyNl3Kuns21XGWAdUq23h+vCHEM/wILkQbMbbsrVmqrT+nN8SeeQmW5SSP/6oB1lz96ZTRQ2DIJMLrsywKrsR0dFnHOm5bdcUjFfciVQp5vSo+vQI=
Received: from SN6PR05CA0028.namprd05.prod.outlook.com (2603:10b6:805:de::41)
 by CH2PR02MB6294.namprd02.prod.outlook.com (2603:10b6:610:e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.31; Thu, 20 May
 2021 08:11:17 +0000
Received: from SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::72) by SN6PR05CA0028.outlook.office365.com
 (2603:10b6:805:de::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend
 Transport; Thu, 20 May 2021 08:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0042.mail.protection.outlook.com (10.97.4.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Thu, 20 May 2021 08:11:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 01:10:14 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 20 May 2021 01:10:14 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=42624 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ljdkz-0007IV-8Z; Thu, 20 May 2021 01:10:13 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <amit.sunil.dhamne@xilinx.com>, <tejas.patel@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <ravi.patel@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v6 2/4] dt-bindings: fpga: Add binding doc for versal fpga manager
Date:   Thu, 20 May 2021 13:39:52 +0530
Message-ID: <20210520080954.1393-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520080954.1393-1-nava.manne@xilinx.com>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1474629-b071-4e9d-1e55-08d91b66d7a3
X-MS-TrafficTypeDiagnostic: CH2PR02MB6294:
X-Microsoft-Antispam-PRVS: <CH2PR02MB62942A2E56C32A47BB9EDDA4C22A9@CH2PR02MB6294.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+2zQNtXl+XJzNFPcJ8mX7bCTnKT98a6AondExH1HecyokcfeX0ZN3sDERuVygr3Uiuofx7VJbbzADOzZ0m+qENFXJjnOzLA5/C5QVdJYr601ta/MqDSWj9MnWz1sVJ6fCurKqaTCFu+4Z4whWuFtGWOarZALeyVQ1O0lF12h8H694GtMWCpZMatXmlh9rXUyxDiKyCYvavJhI/oHL0Tf4TpB1+OW+PTMp36fh+Xc/PDUTpOGjM4xUVZ0dBVqXxlBBimOFBUGlTNui9NYl/IyHZ6bg9t1xaZKxb4nOoXxRuckGOYzWUv8JrxMJLtZLNNp1pAb3rNejv37e26nsBG6HvrhEkXhxQp9ZoKeAFavsPSq0XsPw7PUZAz7stfS/TqnTdeZb2ll3nal+9PwrG3thiFU5z8ETHLOPD9aCwhQMtJkK8+BgebePzEJRsuGUTg2vaMr0iAEq1Hrn9WCD845rkuTsMmqCxwxA8YJal0YFtvuej5V4zklSIybXOtNQO+uoh2gkdAu7ri3OHGLCwGpRWCxTFH1JDIVfD1XE/7K5/2Gko3dtLowTqKYQkwC3azKGVe+oA54ZJ9GcwoOicDD3dXCWxuSBafHG7v0mYXrrv/48bHu36jzU+TFHw3q4xuGsHo3QnM7/5AZZTTTDbfB9l3GF4HavinuYZUb1djoHFZUWFQpohjgF/MllABvZF2CbuwfK/QmmbLwuRalyoJBVdTWyRpENtxpeBm3EjFHwpQky9vS0sRGe/acv5VPi6IoJXFPYPR7qxVHLKW1/03eG5kR92ZT1PoiilD+2BB4Ipw38lw4CUHxqfDgFQzChZB
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39850400004)(376002)(46966006)(36840700001)(47076005)(8936002)(2616005)(70586007)(478600001)(70206006)(336012)(316002)(36906005)(26005)(82310400003)(1076003)(110136005)(2906002)(966005)(107886003)(82740400003)(7696005)(4326008)(426003)(356005)(36756003)(7636003)(9786002)(5660300002)(36860700001)(83380400001)(8676002)(6666004)(7416002)(921005)(186003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:11:16.7241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1474629-b071-4e9d-1e55-08d91b66d7a3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6294
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

This patch adds binding doc for versal fpga manager driver.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v2:
                -Fixed file format and syntax issues.
Changes for v3:
                -Removed unwated extra spaces.
Changes for v4:
                -Rebased the changes on linux-next.
                 No functional changes
Changes for v5:
                -Updated fpga node name to versal_fpga.

Changes for v6:
               -None.

 .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
new file mode 100644
index 000000000000..ac6a207278d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,versal-fpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal FPGA driver.
+
+maintainers:
+  - Nava kishore Manne <nava.manne@xilinx.com>
+
+description: |
+  Device Tree Versal FPGA bindings for the Versal SoC, controlled
+  using firmware interface.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,versal-fpga
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    versal_fpga: versal_fpga {
+         compatible = "xlnx,versal-fpga";
+    };
+
+...
-- 
2.17.1

