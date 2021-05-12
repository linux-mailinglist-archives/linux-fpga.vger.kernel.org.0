Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC137BCE3
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 14:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhELMwj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 May 2021 08:52:39 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:48863
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230455AbhELMwj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 12 May 2021 08:52:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7RSE0X7fuam3mgKVylnM+tZfTBqH39np5+5w8JKlVA6XpXelzAS9d12xWg4BO1Zr89WJ0D501n7bw9It5W4KS+KvTZQZQhgkjATKiji2SqqUlzhAaLmBjTLlHNtkVKhkp70hYusk/N+3094y3ajs/RJUU9PyJBX4FVJP5iZ10GiO0aKNYCTdAbYhKKsonS4fZt+B2ZuIFBbFf1DPwwI9hGCgTK6Bbdf0OEVUWTSDz+5bCwr0MR3YX/S0v0zu8OLXog1Oo7KR49p+8Ybu5Rl1vE9uDzcQYfcYYUmEMxABh+coOurEut3tRsRcUIBpy48lK62c7Bp9PRagXgWoGo4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFB3f0MazmdoYTmpb5sJCoEtD7F6hZVXCuXNmLTIszA=;
 b=QHh5bwIifSDl/bQZEJEtcr0K15iKfjr2G/3wIPooHPD5rzd+A+XRSJkeXOZsHiwuhY7QFlfGzmC5wlAMxG8fo9eJCfULSM7h4Apr85Xz819t3T9H/VKKYu0Zu3CY/d+jB16ILOLRfwM4gYTfuBDk0Xhqwp6BruOluxqmst8ajLGs9cPUNFdrdR3TipWUSCxuusHSj4cnVPDy8XEQxD9FV55cYY7lapNTbkKTwaWRlMittwoBVoH1oSJMuwXZAlYOUfTMOL0n14blDODifQqaHL8ZERd9FNTb75467fzFF+orQOvWZjVDyDG2t4y9mYhaMIlJ9V/EZRK0d/UWbrjiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFB3f0MazmdoYTmpb5sJCoEtD7F6hZVXCuXNmLTIszA=;
 b=VTOEvYGqMEI1bF5FYQS0kk0sT51I37HyYhx6oZedFvhgv8YbQGsJiJBzTFdy7Uf4mAG8rdZKje8t0mcz4xfMEpR1Mp7nxmRkUwYVI97/pd4xNIYmhSXO6UCMNwbQysUYaJgggdGUSoGEVdlmns3O+Ts/WcxddeFbyIobFdVihQ8=
Received: from DM3PR12CA0125.namprd12.prod.outlook.com (2603:10b6:0:51::21) by
 BN8PR02MB5809.namprd02.prod.outlook.com (2603:10b6:408:b6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Wed, 12 May 2021 12:51:28 +0000
Received: from DM3NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::f8) by DM3PR12CA0125.outlook.office365.com
 (2603:10b6:0:51::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 12:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT053.mail.protection.outlook.com (10.13.5.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 12:51:28 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 05:51:14 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 12 May 2021 05:51:14 -0700
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
Received: from [10.140.6.60] (port=37340 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lgoKO-0002rt-Tb; Wed, 12 May 2021 05:51:05 -0700
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
Subject: [PATCH v5 2/4] dt-bindings: fpga: Add binding doc for versal fpga manager
Date:   Wed, 12 May 2021 18:20:40 +0530
Message-ID: <20210512125042.30973-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512125042.30973-1-nava.manne@xilinx.com>
References: <20210512125042.30973-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd1c033b-a481-4690-8f93-08d91544a8c2
X-MS-TrafficTypeDiagnostic: BN8PR02MB5809:
X-Microsoft-Antispam-PRVS: <BN8PR02MB5809654C9FBCB13BBE2B88D6C2529@BN8PR02MB5809.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0IvsVk+UfqVfktEWs4kBAdrwtScHTI92CER3PMAPW2XTJyJL057+aE44mimQJtXDkttgvOUfor4qf01lFqhbMUqUR3rIiggCQoNKptmK93A+/RzNLzDsm3wf+tdU49zLr27BM1ad8D4eEfrIHB6j47/fv2reE2SX2PCfT/DnNOSSO8WNyw4M3p7dMXy78tVLekOjnTB4AKpKjtlpuJ4SB6rj0oAtLCYXlKDgXuo5ZV3Ao3+OsuD7VevIZpov8Genay1aOg0KTQ91CnWPsEr5bGCHaa8tb+osgMYJMcnWWjDaTYBbK2rmqtq9tzJCFzYJsYPgvWwzF0G0UkBRL/hYgjGYlqBVkS6c+rrt3uL8HcaLJcyt0wsk6M02snKZ94c+NHmkUc1CInR3Z33SNz1CuK2Rs288IpZhL4eNOqKznOI0eqIibaQMkDEP/JfF55l4clwFoJ4WQS1A34RjyTMWht3VRq/Byh72NPFN+kabYjbZ9fRnhvinY2j9MbWvgP2iYxmtp2BF1jWQXITxiq+AimrASnKkrN/WyZypMBYGErr4URaTaONiw+Be1s5Hotruuh0g9j0I2UtzUFuoxrJ6PwFXE46qP9uhLvpWeMytsDH3/N6uIAix9Mw3kBKaI8PFQUBpLKGAMyNc+l3gmC2PwPeZZI94C9JBWJs2Q7DKJhEUjR6WUv334FjSJefo/EEWyam0F8uWeHjjRosgc/uGFJzamSHGLaGHwHBMirhGCH8aSGzxZcUC6N38/Vpa4xMq5neQTIO/XFuhxKxasq5e2AsqLMBDg8CXqCJJF1ED4iUKbS9DiZ+3Azp/ljwVhZPQrWXOJJGx8w2PNJa8Z4i0oFXno8UqpznERVNPQ8qlfI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39830400003)(346002)(376002)(46966006)(36840700001)(478600001)(26005)(9786002)(47076005)(36860700001)(1076003)(2616005)(107886003)(426003)(4326008)(921005)(70206006)(8676002)(110136005)(8936002)(6666004)(336012)(7636003)(356005)(82310400003)(2906002)(70586007)(83380400001)(36906005)(7416002)(7696005)(316002)(36756003)(5660300002)(186003)(966005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 12:51:28.2028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1c033b-a481-4690-8f93-08d91544a8c2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5809
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

