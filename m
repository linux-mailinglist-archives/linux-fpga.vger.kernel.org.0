Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C584578A2
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 23:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhKSW1b (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Nov 2021 17:27:31 -0500
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com ([40.107.94.85]:48097
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235458AbhKSW1b (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Nov 2021 17:27:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COFuW1+Ck1ly9+JQabjfe5epdoG85iJuM0i58ZK3BhxOhdOcjIpow2dd+g3EZYP1DhjTzi+ykhyYLYzjlFoCm/DXM7l15j7/ydO/V7Yv7O91o4TAUM3aybqH741soRCCvdeN0HiT7+ho0npjhQ2H3rf7MQOkg6hQm1203PpiRMKnsVBBInzk72nVoror1V3fOVOpJDMgb7KVjbGN1p8VTps6pfUDbcSE2e3RViWGs004BRH88u7U5Qe/AbA/XAvcDCmulbULLuMeLeRyWWJDbD+qTtyKUmVg/3AFfgDDr1Fcs6OZHyfnnkHnkqQnkc+//L8uJHKT1d+ocHUGVU1j5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqCJ9uuK6CYrGXTIrXJQ8gAi2aNPu2y0d2u1DckFUHM=;
 b=J/hn/PHMzf+PWwQzY8UZ8Y5VgHvnNzbQPGpouvHuepnr41T/VIZqXXFLFBFJ2PLdEouB7GSsH69ZwTmYvNXx7AqS7o/WKsF9fVGqJ/7hFWa8TQ6OaikeoUOu4oriXkz1R6A7y07L8dDMs7Z6Rt7hufRytwNGIdXseDI1AFgySHFSCBr20sV/J8PRY1uuCiOjkQm0YM5sh/5MMQmkWGqOz7bW16zUQ+2vjk9JqQxhCR3QSGL2CuJvMo02tY9YasCPMcmZOjfhMvr0DuHJU4cTorxblUZStufKDzKGEWizsFIZ2+6lkDjYv4NBnsj9AzQSwAOMlGjoM1LpT2eItqb6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqCJ9uuK6CYrGXTIrXJQ8gAi2aNPu2y0d2u1DckFUHM=;
 b=CK6uqvVlBgIMuvvDVBLFau80bnUPpmSJd7KRH4yMqAPd81xNBt690Q+l7ip6yd+8++lclhwnHOdCpDIO1I1hrfXFKnuYGU+2TfyZakyEaEJKUC4XV76vqzKEXSuwbFv1ZuNIjAFE5kzGO1Aa2eUCD5+hxCQv3ScZ2IAlS6jLIvk=
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 DM5PR02MB2266.namprd02.prod.outlook.com (2603:10b6:3:4e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Fri, 19 Nov 2021 22:24:27 +0000
Received: from DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::76) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 22:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT040.mail.protection.outlook.com (10.13.5.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 22:24:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 14:24:26 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 14:24:26 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=38932 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1moCJ0-000AM5-JX; Fri, 19 Nov 2021 14:24:26 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id C45E9600061; Fri, 19 Nov 2021 14:24:14 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V2 XRT Alveo Infrastructure 2/9] Documentation: devicetree: bindings: add xrt group binding
Date:   Fri, 19 Nov 2021 14:24:05 -0800
Message-ID: <20211119222412.1092763-3-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5be8d501-5467-49ef-6455-08d9abab5934
X-MS-TrafficTypeDiagnostic: DM5PR02MB2266:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2266C4F64F7293C80712ED0CA19C9@DM5PR02MB2266.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWKxUfo0oSDwmTDDY3GYPQbPnFkheMjguWy14NUIPjGOaZCiW3Fk2NG0/e7UMW/pkiiWhrvC1RUyHv3Aw8ydC4bvpN0wNZxY6FbsdnMvT97Z1u9rXerJby55T73C0WVkH0CRkjJqWZiNQ9uhOsjycwQ27Kx1qHnngJrpzCxYfxVLm0zjuc5Cnr8631M+3JLy9D+racKSnOxNCmGrpaD9LW9Ij4yAtBteX9zLYUZIWf+u99fI2qd785Yp5yFa/KbHljyDO2aHF49wr1WAbmSJkvFt1NI2zcYP1e+YX6uJ6qEpT9VLigipayc2zFgFTlXUM9Pe+GTBkUzyo8vqWBZtluPd4IrBuv4idLi3n20wIboWdeDJU/qBHLhi3+O3JdRFo/Kh6bMYTr6gTzDbT2FfSgViZnJrNhhuspv7CVy33pNME0mobv73CNx/sdNE1dJoS+DcpT9zropXkgCsORmFa+U5ZUY9O1Tv8lYF8HPB242JiaanmW9x/ueUrv6XeAVVAcMtwjNM2xWool25nsiVg8OUfYE4NBHmjekyIATe7DdFtSiT3HQI3sfeW8CAAbPhhP8pLPmYqIr8kQ7X7O0WDDsOXyE7ZrgliRe+g32OA2PJV7yVUzdjsHpsHNybKQbKQaLog+DFRflIQ9xSVaiiApXxaK6mAXnVGkndNZbf6LeAnV2XsA8YP1ywdCjEar4u5h5KrMLbcgyRlXMBjguA4qQORdF45a//eaFZgr4dv3lrucHaKchnC59HUeW6yqSOhxrXu3L1JdtNcq0MXdz9yjcHuL0yfbpKFtslZmTCz+RXpq6l3y8AfFW3A+1bQM/lsB4+mCjKVjWBijOydzLlTw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(44832011)(1076003)(26005)(8936002)(426003)(2616005)(82310400003)(36756003)(70586007)(36906005)(7636003)(508600001)(336012)(8676002)(4326008)(6666004)(70206006)(47076005)(6266002)(54906003)(5660300002)(42186006)(356005)(36860700001)(6916009)(316002)(186003)(966005)(2906002)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:24:27.3089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be8d501-5467-49ef-6455-08d9abab5934
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2266
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create device tree binding document for xrt group device.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 .../bindings/xrt/xlnx,xrt-group.yaml          | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml

diff --git a/Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml b/Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml
new file mode 100644
index 000000000000..6cc7a83d7c14
--- /dev/null
+++ b/Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/xrt/xlnx,xrt-group.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx XRT group for Alveo platforms
+
+description: |
+  The xrt group is a pseudo device which is used to manage and
+  support xrt devices in the same Alveo partition. It is part
+  of XRT infrastructure.
+
+maintainers:
+  - Lizhi Hou <lizhi.hou@xilinx.com>
+
+properties:
+  compatible:
+    const: xlnx,xrt-group
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+patternProperties:
+  "^.*@[0-5],[0-9a-f]+,[0-9a-f]+$":
+    description: xrt devices belongs to this group
+    type: object
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    xrt-bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        xrt-group@48,0 {
+            compatible = "xlnx,xrt-group";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges = <0 0 0 0 0xe0000000 0 0x2000000
+                      2 0 0 0 0xe4200000 0 0x40000>;
+            ep_fpga_configuration_00@0,0,1e88000 {
+                reg = <0 0 0x1e88000 0 0x8000>;
+            };
+        };
+    };
-- 
2.27.0

