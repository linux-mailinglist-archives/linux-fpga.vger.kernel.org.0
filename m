Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA73D468167
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Dec 2021 01:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383841AbhLDAoN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 19:44:13 -0500
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:25796
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1383834AbhLDAoG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 3 Dec 2021 19:44:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRRCqCU4Eimm5fxNOgqdNcJdt/CnQuq+Psbj72p6sFKYJQzT+dk2ptikhXO302RCv6UaxUPhVsR4pZ78loZO1l3unfogRJ1vbsxSa4K5JqZwXrvTG9a2EkNqoDQxZqb0488ajthZKnxZD9V9jzzwRex9CQKDTgHPVwZJo+GkVcPIP8dKtyMByUjoHPXkUfqS+OHe7f9jLL7HzRs7LlS6H96UlWUfbduIreQwfEe2pX+bCHDOiWmd0YHkRo/GaMaSWiNDkwvKjiNS6Lgt8jbk0XOHfBabMCH+Lu4CSvkZ/7saKoBDmCW8oinGV5jb6sqdjYkkH8d55oa4LST8qiKebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqCJ9uuK6CYrGXTIrXJQ8gAi2aNPu2y0d2u1DckFUHM=;
 b=c/X67WeYfIL9KeH8wAqGU8jMBF4ODLYvwSMcoz3fR56hbEj2z/sI5/M6WIVWyfVPKyPun9xV/JN7uaeglL/xxCX9hPWVIVyst4THtEWD3Px00mDsYvlDslUOTLuf1JiUuVAGjEK2pup8guFnXs4d1ccBU796/Lrv3U2si1pq4N7jbxu1+bujW5vN6nzND2m1k1maRp2gbfv4yiFFlj3I6ouLfYCF1kVZHGVAaUy+Lo22kIAStH0yK9YsOhPCoXgZYxZV1Eta4Jpwv1B2fYh1AimROGyIxWvCE98QHTLbdmKcvU6DsaetaLfwyj16Kkl8eM11KhB6iK6FYqj/ehmHDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqCJ9uuK6CYrGXTIrXJQ8gAi2aNPu2y0d2u1DckFUHM=;
 b=hOPlciSsnfDA2AxSjVGEJhbPGiirjqQz1H6jvvUiZDSxwmCQllMtkWcexU7ep2pcpzR02R06sNnoMqFRNNZHhIHcPc21h7nl3dwv1l5mRYK0OyKa1c02h1xuydZAH9cckloZfnVhQbKQG7AIl/suVKp8T/1rfZOIVTABZ9w1pEs=
Received: from BN6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:404:65::31)
 by BYAPR02MB5397.namprd02.prod.outlook.com (2603:10b6:a03:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 4 Dec
 2021 00:40:39 +0000
Received: from BN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::2f) by BN6PR17CA0021.outlook.office365.com
 (2603:10b6:404:65::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Sat, 4 Dec 2021 00:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT044.mail.protection.outlook.com (10.13.2.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 00:40:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 16:40:17 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 16:40:17 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55510 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mtJ66-000DIu-RV; Fri, 03 Dec 2021 16:40:14 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 1EC5C600838; Fri,  3 Dec 2021 16:40:02 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo Infrastructure 2/8] Documentation: devicetree: bindings: add xrt group binding
Date:   Fri, 3 Dec 2021 16:39:51 -0800
Message-ID: <20211204003957.1448567-3-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
References: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b6416f9-b871-4f7d-6b36-08d9b6beb169
X-MS-TrafficTypeDiagnostic: BYAPR02MB5397:
X-Microsoft-Antispam-PRVS: <BYAPR02MB539714EECE6FD70A3B6F962BA16B9@BYAPR02MB5397.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dO0qqaRnDnS5g4oi45oHFyUk/87tYODBgeq2P5F0rgYVJQ6d632KPWZqGqc4VQKJWWnjWELe3mtL+HO+B9pxIemdKRORy6SsErpjDoNr3c49cQXm3L7Ij05Rf8FxWkT/hkKIt8RnJCoSnNzMjinUzfQ+buvHQzC6Np7ZsNFDXnVMTXO2MBJz6p+VoZBMcM4NzL0n7bDUA7ZCK/MKz1XkzG7cWcqkyMK6DFJ8ZhJKDDM4IFEp2BVwJ4yBow2LhppnDFEweBzjnY3vJW6wCJ7MPCf0rBatT1TK+EB7QrOs9qOVup84SiKArfxeFD88Is4kfWhl2c/n/roqtdUULdzvzQsaC+y4pxc021WufBjZG+zi0fZYBKZsb/0O7g1nEQYZUbgnCFD2cd8tsaBZBjTEjGvk0lWLvHo1elwJfEaObEAd6QKrOB+5167tarOk2WrTYwqDRkbSljLCObMmZqBc/rFYyPBMo/5OWoXTUS4vwDyS6xd5rYw8aOoMYpFVCRUHh/aZD7lfCuA99PdOYebhWN4SohK1KKvkpQ6rn03EjSeH70pAnDKOwFFi2ij6N9uKUyJ5ZiPThECZ2T6rkk76XBIzQF7qLU5OQnHxvPxabsTYBgyq8WlGKVHvKSai6pYLovZDqLxCrzd4kbcwXb3NlkPfVDIxBhXmBL6TZkLr+lyzU9xpVDQ817XEQegOTJ3ExAlDDKconfK0BdW31bQpzC2YbXO2UTU3RlBqemWaig+7VOKzgIyU5kkJsxIvRlLHEWoG95HWUB8er6Tl3xqWauh2VjgFRhOviWZU6WANw49QLAM41vwlURZggrQLxsrXXsf0w48ljEp+pWXY+6iOMQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(107886003)(5660300002)(336012)(6916009)(36860700001)(6266002)(2616005)(186003)(508600001)(426003)(44832011)(26005)(36756003)(82310400004)(316002)(4326008)(1076003)(70206006)(356005)(8936002)(70586007)(966005)(7636003)(2906002)(8676002)(47076005)(54906003)(42186006)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 00:40:38.4747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6416f9-b871-4f7d-6b36-08d9b6beb169
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5397
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

