Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E937D59F241
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 05:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiHXD4G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Aug 2022 23:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiHXD4E (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Aug 2022 23:56:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8031D335;
        Tue, 23 Aug 2022 20:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZ5s7Rv57UGrn+L8bu7qXSNmPPmBLAO3zDMv90cv27142F1pZfZfilnbTPnvQkDXmYG3myZsawpp27wBmeCfEbKp8EyMkuuA3ZLRPaEyIdEbmeJSL6MEDI7xfVTHJhqasUDR0dMBPf5QvvITQXRORtBuXnR0RnrejtwlF2cWXJ0m/DLvOMrk4Afrhe71hk7QexIyv5gHGcvRoTsIgkpdhRCis9ddFkmiw2ajwxt811ogUB7uKp/xTBc+akKMOX6sKCXd9ffRdPZbWaUXWuq6M3WMNPNZzpEkS4s59JyazyXsE1TSiu+dO+eOTNAuskoMBW7QavoD/rzizO30ASpCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/Nt3KSy/yN64dvDPZMcdjw0Tv6Nf1hWy5ELIDX5E5Q=;
 b=TsQsu1CMWL5UXAvTPASo8yZdkBuw8f0nBhafyOBELxn5umWab4glDs6KxZCSvS1UC9icrNdRe/XriCPiN3pmYJFxPoO3OZ4Ymde5DSS+sMsH3OL8TiBXxn6RkWhKj0rztV/3gAikUTg0U6yn9cvqHL+h9Ok3NJHejxXtgLf1o5B37Q1FkI2IVfb/41gmnXc7XIBsk86lH+Ul2y0zWX3lKFN27lcQ2fa5tSKtYGqzOUlXvqNILKndrU7Y2iLMIeuBRclHlVPq7Ka9aVtxcDHf4m/0Eb1DI0fh+shmbP61ulZdkfgfDgeiLtCMPw7MkuIU47lSyPJ0BkjJY61IcDWheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/Nt3KSy/yN64dvDPZMcdjw0Tv6Nf1hWy5ELIDX5E5Q=;
 b=o2P2a+cIDIcuhks4NRxzyOjABIqVg2huhXPDeO1ZlJ4W0CsydQpvW932vEjAQIOOUVDtvu8w/4DpkndGRGP9WpeZpPAidOcpG/ScJm0BnU9CSXqASH+zHpQREfa8WfHRPCl0NPEZbShcUADJU4HPl+yHOeW1oV0erVvfS2GHDIY=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by BN8PR12MB3251.namprd12.prod.outlook.com (2603:10b6:408:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 03:55:58 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::b3) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Wed, 24 Aug 2022 03:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 03:55:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 22:55:55 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <git@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.kishore.manne@amd.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <piyush.mehta@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <harsha.harsha@xilinx.com>, <linus.walleij@linaro.org>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH 2/4] bindings: fpga: Add binding doc for the zynqmp afi config driver
Date:   Wed, 24 Aug 2022 09:25:40 +0530
Message-ID: <20220824035542.706433-3-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824035542.706433-1-nava.kishore.manne@amd.com>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472d31fd-7036-47aa-e812-08da85848d5d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpllcNI2JxUAAuFxRYr5quv5xL2Dgez+K/Z3YvQewCsQA7d2cDOEBMkEzBBwYxqV0SYGahDkDWrAGTIankgT7sIQg5FBV+F+Hampmt9oSfuUm7/9x53L9e6difhIKp75h3nz5eh5ptoDwlHXHuBYvs4s70oygQ0yX6PtyUUD7j2WuU9DmUNWnwjYR8H32TC8lXHbe511T66/tLXwaOJBmg6CvPDO0q7aCp0kPpypnDgccjZCswe4b/FaTCdiwj1WkiiDkncrz5XVkDgXAfTrkDjT9Q6PZoWrWP4hkRARTUVlh1fuXHCNBrBdBBL0ee/osJUzly+wsM18T5UzycsTHjVYWG9NAxyfXwQi7nxQUVeoMTjVtm/8FcSsTMPjlb4I2rbjFO+/vHLHD4xskK0AFk3k8xIkrzBGcE1/QxYwgTDpNVB6HlLSSQWDfM1fnASOjQjyXExghOgfUaPGrUbsW0+VtXWdx5kZdvsN2akpf3sK9yWVxzjQsEzLY7ejwsYmeCvbiw2vknYuWpGpireM8+qoGoV/6CR3V2aVVM6DBSRgLbKOentwrt2jwIsRBzOk0vU8VeDLW62cSOcwk+dNcAL4e35H2xrIAYFMs/rhxrRWy7wxumCZZKGKpJJPmdEnwuIBSM0C/RArU3QXBpl8iOzoDSjvMAhPWQvtwK0czcT3jsHQHz4RMAbkf6ZqSgLVIpstaPEw0pcv5q7fY413bZ3MMf3ZuBlMVcZBcA2vPNUgLW9ZQc8EYFo3k5Sx0y1uruTmtw+P2pqX01pfxalQ+Dtxg0SEIUpzl9VMLpQ0x1SjAa70AaqTW2U/9DvKaxhbf3SOzt/6hxstQhXT5hhBASZepEJZl1fKQw4h079YjaZOI0WdyXMni92NqFZraUZ8uaSsU2wYbdm51/HFz6o/+yJKi2OvV+nIBXwPCMhVw68G29Zl5DIEKJHv53+Icnjf
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(40470700004)(46966006)(1076003)(336012)(16526019)(47076005)(2616005)(966005)(103116003)(186003)(70586007)(8676002)(2906002)(36756003)(41300700001)(5660300002)(478600001)(70206006)(7416002)(8936002)(36860700001)(86362001)(82310400005)(110136005)(81166007)(82740400003)(426003)(6666004)(26005)(40460700003)(316002)(40480700001)(356005)(83380400001)(921005)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 03:55:57.8390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472d31fd-7036-47aa-e812-08da85848d5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3251
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Xilinx Zynq US+ MPSoC platform connect the PS to the programmable
logic(PL) through the AXI port. This AXI port helps to establish
the data path between the PS and PL. In-order to establish the proper
communication data path between PS and PL the AXI port data path should
be configured with the proper Bus-width values.

This patch adds the binding document for the zynqmp afi config driver
to handle the AXI port bus-width configurations and PS-PL resets.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 .../bindings/fpga/xlnx,zynqmp-afi-fpga.yaml   | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
new file mode 100644
index 000000000000..faae4951e991
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,zynqmp-afi-fpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx ZynqMP AFI interface Manager.
+
+maintainers:
+  - Nava kishore Manne <nava.kishore.manne@amd.com>
+
+description: The Zynq UltraScale+ MPSoC Processing System core provides access
+  from PL masters to PS internal peripherals, and memory through AXI FIFO
+  interface(AFI)
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,zynqmp-afi-fpga
+
+  resets:
+    description:
+      A list of phandles for resets listed in reset-names.
+
+  reset-names:
+    items:
+      - const: pl0-rst
+      - const: pl1-rst
+      - const: pl2-rst
+      - const: pl3-rst
+
+patternProperties:
+  "^xlnx,afifm[0-6]-rd-bus-width$":
+    description: bus width used to configure the afifm-rd interface.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 32, 64, 128 ]
+
+  "^xlnx,afifm[0-6]-wr-bus-width$":
+    description: bus width used to configure the afifm-wr interface.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 32, 64, 128 ]
+
+  "^xlnx,afifs-ss[0-2]-bus-width$":
+    description: bus width used to configure the afifs interface.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 32, 64, 128 ]
+
+required:
+  - compatible
+  - xlnx,afifm0-rd-bus-width
+  - xlnx,afifm1-rd-bus-width
+  - xlnx,afifm2-rd-bus-width
+  - xlnx,afifm3-rd-bus-width
+  - xlnx,afifm4-rd-bus-width
+  - xlnx,afifm5-rd-bus-width
+  - xlnx,afifm6-rd-bus-width
+  - xlnx,afifm0-wr-bus-width
+  - xlnx,afifm1-wr-bus-width
+  - xlnx,afifm2-wr-bus-width
+  - xlnx,afifm3-wr-bus-width
+  - xlnx,afifm4-wr-bus-width
+  - xlnx,afifm5-wr-bus-width
+  - xlnx,afifm6-wr-bus-width
+  - xlnx,afifs-ss0-bus-width
+  - xlnx,afifs-ss1-bus-width
+  - xlnx,afifs-ss2-bus-width
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+    zynqmp-afi {
+      compatible = "xlnx,zynqmp-afi-fpga";
+      xlnx,afifm0-rd-bus-width = <32>;
+      xlnx,afifm1-rd-bus-width = <32>;
+      xlnx,afifm2-rd-bus-width = <64>;
+      xlnx,afifm3-rd-bus-width = <128>;
+      xlnx,afifm4-rd-bus-width = <32>;
+      xlnx,afifm5-rd-bus-width = <64>;
+      xlnx,afifm6-rd-bus-width = <128>;
+      xlnx,afifm0-wr-bus-width = <32>;
+      xlnx,afifm1-wr-bus-width = <32>;
+      xlnx,afifm2-wr-bus-width = <64>;
+      xlnx,afifm3-wr-bus-width = <128>;
+      xlnx,afifm4-wr-bus-width = <32>;
+      xlnx,afifm5-wr-bus-width = <64>;
+      xlnx,afifm6-wr-bus-width = <128>;
+      xlnx,afifs-ss0-bus-width = <64>;
+      xlnx,afifs-ss1-bus-width = <64>;
+      xlnx,afifs-ss2-bus-width = <64>;
+      resets = <&zynqmp_reset ZYNQMP_RESET_PS_PL0>,
+               <&zynqmp_reset ZYNQMP_RESET_PS_PL1>,
+               <&zynqmp_reset ZYNQMP_RESET_PS_PL2>,
+               <&zynqmp_reset ZYNQMP_RESET_PS_PL3>;
+      reset-names = "pl0-rst", "pl1-rst", "pl2-rst", "pl3-rst";
+    };
+
+...
-- 
2.25.1

