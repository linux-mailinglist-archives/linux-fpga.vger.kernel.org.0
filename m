Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F58318488
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 06:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBKFTw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 00:19:52 -0500
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:31556
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229447AbhBKFTs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Feb 2021 00:19:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzLMsMU7D1MHiXhA/P3PiKokk54ikUUj4ERXbkgk5bOe42Q0sz0NLzpd+FKizwG11/Xx7UmglT6KBfuZcIRAlT+MYhFdYVlMJdqM+fczwSexZYkesBwWfKl3hvI98QIswUxk3A/Y9lkc1H27xsPFoFww4gt8E2KZZqnYHGEoIb6FkZGQ2sKcH7V9PbHVQg+Ez0R++LAe7f7v8PHjhHEB7S1mkhsOh1367r6yy+vh4LXyHFnO2IvndUAZVUM3paF/pO7TGHyfz0zWIGZsmj9pMmxfS0a8QHHdfrptdDyaOCMnh3XN8eXc/pa3joWmmJUGzm/MXgutExp29ddYDjQaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLQLDCKfwedPLLriIt4AAFRlVfEwBkyPkrFx7Ioy1gI=;
 b=E+oYdkDMvf4zJ2+NbbK5XfxyEWcGDTVSH5GwvM9y2FRGbSMKnGqhGxPEixOYZo4wlAigaVDHHVW8y9HrJQksiP8S7od9zBeotzTfMBZQkxwQJ+96tGQymig7q0sKs4/PrFGxe6zwi8y1aA044s9kZ8m3MtZCco38oGzxQC6NHSH/WI+Kt6RKZ8Wat/MIeRgZIkvT1hOXAwZMi6S7rhK2OSnoHaa0FhJZYUqk85H1HLcox2ww2o1/9IGe4xzigwmx9vPYZxCNj97N7IueczNbj6wjNdBEWaXcEiOjEoyjqUxuc2GKiAsapxRUiMYb3N2cL6TPZCuuln8sflGQYME06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLQLDCKfwedPLLriIt4AAFRlVfEwBkyPkrFx7Ioy1gI=;
 b=UHIjEidg5QAp/uSL+qHjDvvjNK0vpXcjEBc24E6Bnxl110Cjhs1KFfulIpHjLr/yHMiKiYdHY7clO+NYRnPbwEjqS/4FdawL9ztrGzmBCYsvN/0hi40l3ZDATbzHO+P0TpqPNcRiE1shlDodssGZPkU2i/NpoIG0Bs89soXg2Sw=
Received: from SN4PR0401CA0018.namprd04.prod.outlook.com
 (2603:10b6:803:21::28) by MN2PR02MB6336.namprd02.prod.outlook.com
 (2603:10b6:208:1b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 11 Feb
 2021 05:18:54 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::33) by SN4PR0401CA0018.outlook.office365.com
 (2603:10b6:803:21::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Thu, 11 Feb 2021 05:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 05:18:54 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 10 Feb 2021 21:18:32 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 10 Feb 2021 21:18:32 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=49268 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lA4N5-0000QK-Ev; Wed, 10 Feb 2021 21:18:31 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     <git@xilinx.com>, Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 1/2] dt-bindings: fpga: Add compatible value for Xilinx DFX AXI shutdown manager
Date:   Thu, 11 Feb 2021 10:41:47 +0530
Message-ID: <20210211051148.16722-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210211051148.16722-1-nava.manne@xilinx.com>
References: <20210211051148.16722-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e923470f-3964-4796-2e8f-08d8ce4c86a3
X-MS-TrafficTypeDiagnostic: MN2PR02MB6336:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6336F24221F48F1A43AC9A73C28C9@MN2PR02MB6336.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6PoCP9i1k5uFE3TparxmSZWnleRuC8STOq/UONC4XiJw5sTyJgmccEFHE3ZtUGo6/gBkZVXe/UC6qcrZPk63Kg1VeW6++JzDt7nMXIN1dar4AkwY2EUNqMqqzUssUEIN3NhYvozCElEEETzC6dAYKHIWujv2uklBRG8TOUKTOI6LUH0vASAzvCR2yTOvZnenT1bG7bbX/yCKf05PZIEggfjb5e2vc6lFpNdPtaqoHYGn54c3faRnwC8dwNzGGr9HuaT16j7ZAACd4je8x9yYeoj94fCTONEa+OfDZVK/birHYzoyX6Tsxg+nVD7QDOY8de32XTl2mNzPFtEL3Rgqi1qAq19WgZVLRqetPz5liKBYLcA/HMEKq2c7OWBqo0CbohAt/yWuGToGsxUNxWnH/A0l/2qPiH9IzPlpYhJmBBV3pF6pzJDPEtfCYswQivtJ/My+HiP8sLoH1gDk64ILXUUVAM6RSDZhQXzoFmtQ6iekGt1MfhkuxsXWif/o5Uf6CEA7g7egvRoVnWOHU3xpnht5nH5b7GQvJA/uskdYKRl/ol1Ctpv9Q6ZHApZFaiFvAP/AAKZzhn9P5K1wM/TOo78+NCBkS8x7rHeva8h4KGYYvWCCljkyVPdvDW40WgnfofHi3fdbneXRo5V1ou5fbvQ9GpZC2bPu1Giu/oZiTQYkOz/MGZrcpRq4kGdApVxvSIatZ31OjmapBuWD9JvFg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(7696005)(5660300002)(26005)(478600001)(2616005)(1076003)(336012)(36860700001)(186003)(426003)(316002)(36756003)(8936002)(70586007)(36906005)(7636003)(9786002)(82310400003)(107886003)(47076005)(8676002)(2906002)(6666004)(4326008)(82740400003)(110136005)(54906003)(356005)(70206006)(83380400001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 05:18:54.3803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e923470f-3964-4796-2e8f-08d8ce4c86a3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6336
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch Adds compatible value for Xilinx Dynamic Function eXchnage(DFX)
AXI Shutdown manager IP.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Modified the doc and added DFX axi shutdown manager node
                 example node as suggested by Tom Rix.

 .../bindings/fpga/xilinx-pr-decoupler.txt     | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
index 4284d293fa61..0acdfa6d62a4 100644
--- a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
+++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
@@ -7,13 +7,24 @@ changes from passing through the bridge.  The controller can also
 couple / enable the bridges which allows traffic to pass through the
 bridge normally.
 
+Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager
+Softcore is compatible with the Xilinx LogiCORE pr-decoupler.
+
+The Dynamic Function eXchange AXI shutdown manager prevents AXI traffic
+from passing through the bridge. The controller safely handles AXI4MM
+and AXI4-Lite interfaces on a Reconfigurable Partition when it is
+undergoing dynamic reconfiguration, preventing the system deadlock
+that can occur if AXI transactions are interrupted by DFX
+
 The Driver supports only MMIO handling. A PR region can have multiple
 PR Decouplers which can be handled independently or chained via decouple/
 decouple_status signals.
 
 Required properties:
 - compatible		: Should contain "xlnx,pr-decoupler-1.00" followed by
-                          "xlnx,pr-decoupler"
+                          "xlnx,pr-decoupler" or
+                          "xlnx,dfx-axi-shutdown-manager-1.00" followed by
+                          "xlnx,dfx-axi-shutdown-manager"
 - regs			: base address and size for decoupler module
 - clocks		: input clock to IP
 - clock-names		: should contain "aclk"
@@ -22,6 +33,7 @@ See Documentation/devicetree/bindings/fpga/fpga-region.txt and
 Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
 
 Example:
+Partial Reconfig Decoupler:
 	fpga-bridge@100000450 {
 		compatible = "xlnx,pr-decoupler-1.00",
 			     "xlnx-pr-decoupler";
@@ -30,3 +42,13 @@ Example:
 		clock-names = "aclk";
 		bridge-enable = <0>;
 	};
+
+Dynamic Function eXchange AXI shutdown manager:
+	fpga-bridge@100000450 {
+		compatible = "xlnx,dfx-axi-shutdown-manager-1.00",
+			     "xlnx,dfx-axi-shutdown-manager";
+		regs = <0x10000045 0x10>;
+		clocks = <&clkc 15>;
+		clock-names = "aclk";
+		bridge-enable = <0>;
+	};
-- 
2.18.0

