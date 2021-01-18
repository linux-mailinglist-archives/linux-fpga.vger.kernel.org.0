Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C2A2F97F7
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jan 2021 03:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbhARCup (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Jan 2021 21:50:45 -0500
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:53616
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731128AbhARCub (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 17 Jan 2021 21:50:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBQHZ5mGMsuLfo18NlZ1FexpTPb5joTUmNmsg7mjUoP89f4rjincFM6H5ZVvBJS9+lcbTkl27sRky72QXnFeOwBum7Jq8mXI3Dp0nQZPfQnNCEvN3dHKW4tCNpjZEoi7Fx9yxKEkN3h1QysQf855tvqdTXi/YtNWI8+alkMfs60YSmK6up/c4KkA2geyoIZz0UuEy+wuzthRcs4wGiCyty6gDuBWtOtf58rm2lmnauhQ8D9qUQEGcq6Ro6OFiVaHZfrwRoVXMgKk8uHhJz+9CsyypfNafrzx93nTQO2MpmadsCRzN2qUmie0aZrFbwP+tubQmnYjoqrZI/qSL3/Htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ7QZFmViWnhbsWLYMZ0rvdLX/ZWDBDwRUnlyU1ifws=;
 b=HBh3Pb1kNdYzGy+RmoWrq2Umvt08JJtHirws2QrDNBksYVS/cej5uBCKQMycqV9IsbhUmPI/wXfy1T1cepefy6Xk7BdpKI2eqJW8N781HZv+oVBnY13d0oNGn0EzuACkE1Owm2YqaMIhHPP8AQtZqUFVcSNl7tW+7ChI64k9A3+cDI1DYXbM3khFpj2sy+GqRnZes559YsQvt6NNzqAwe3kTgEkfozSAHx1yVtcszG10cxV7Zy9TKLyj7Bl/9Qz7kssyYgdIlPahyV7iait92/pWUxhfwRA3uDOahTa780VqzvGTlf9eP/r6xtQ1CwI73oMtJzLJtk25QpRocN/rcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ7QZFmViWnhbsWLYMZ0rvdLX/ZWDBDwRUnlyU1ifws=;
 b=qthc3ZU6FE2C9Z3jeNuZO3pRIpwCmXgDlPuXTtdDeshPJBT+AZvinhjUpPH3SUrEpjOUTJwkcolKbhdjAH/3hMKUanzjE1Bdbo+xeqkte8tXqnqGBmec7uYck3nWJu1/qPAGgYeCOgNhy/8YIJ7BQfx8MEo83WHH7KANvNKaT4g=
Received: from MN2PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:c0::30)
 by DM6PR02MB6348.namprd02.prod.outlook.com (2603:10b6:5:1f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Mon, 18 Jan
 2021 02:49:38 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:c0:cafe::2c) by MN2PR05CA0017.outlook.office365.com
 (2603:10b6:208:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend
 Transport; Mon, 18 Jan 2021 02:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Mon, 18 Jan 2021 02:49:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 17 Jan 2021 18:49:22 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 17 Jan 2021 18:49:22 -0800
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
Received: from [10.140.6.60] (port=39926 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1l1KbY-0001PD-TM; Sun, 17 Jan 2021 18:49:21 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@xilinx.com>, <chinnikishore369@gmail.com>,
        "Appana Durga Kedareswara rao" <appana.durga.rao@xilinx.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 2/3] dt-bindings: fpga: Add binding doc for versal fpga manager
Date:   Mon, 18 Jan 2021 08:13:17 +0530
Message-ID: <20210118024318.9530-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210118024318.9530-1-nava.manne@xilinx.com>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1552cab0-9ec4-4a4c-796f-08d8bb5bb2a3
X-MS-TrafficTypeDiagnostic: DM6PR02MB6348:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6348EFE282E31E82EC9216A3C2A40@DM6PR02MB6348.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExyduI4f8xrC42gzwdtWs01uYXGz/GIx8j22SoQOAIhrc+cMjwO7CUjRD0Glt5PD4pQLUjmFrFlMULyJv6zJFQqGKfVk9Ot8eBICWxXy9A17aDrmUK/T99O9hZ7/oNhk4VdfSpAMtwMGJwpT/mgKpgW8qZeG6PF0W+lp8FX7XsHZrW6x5wnuijGx5wScgLO8+fvQLn4eQxmaNKTV8Kzkvr2CTKTiZ5i3GCNzlkyONEivXbQXmwmfuNwO1ZFt/2mhUNVwGghJzg9rF05EwMkZ1cBBfvyPjNOBCOI0SnPkT08GTIzAtioWuYACeEUzsobZ3uueqE/s1duGLBJTYHm0d/Ek9tuRoB9Ndigq4qIpItZfh4ejyKnf6qon8VFxPnTFvNzfBdiyTbfxv7JQLSWXpCyp0v/hCC1uWZ3f3Xf9VVBNMzAf9c5B40wwUAKLFYE6IE0XfNaneeoG4t8nwFsNSsN0/TcZy6/k5Npgj8RcCMIjlQam5lBM3p8/Zr3ZceFuQR04vUV8x0H4tWCPytkbR0xbxiLsd1zFwqFx+lvaIaghNntAtysV181UCbL2pDSCbxxVCqxWyaJeLE5hA3DtnQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39850400004)(396003)(346002)(46966006)(47076005)(107886003)(82310400003)(8676002)(5660300002)(36756003)(7636003)(316002)(356005)(70206006)(70586007)(26005)(186003)(4326008)(966005)(82740400003)(7696005)(478600001)(1076003)(2616005)(9786002)(54906003)(2906002)(110136005)(8936002)(6666004)(336012)(36906005)(426003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 02:49:38.4991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1552cab0-9ec4-4a4c-796f-08d8bb5bb2a3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6348
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

This patch adds binding doc for versal fpga manager driver.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
new file mode 100644
index 000000000000..cf3aa7917488
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/fpga/xilinx/xlnx,versal-fpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx versal-fpga driver.
+
+maintainers:
+  - Nava kishore Manne <nava.manne@xilinx.com>
+
+description: |
+Device Tree versal-fpga bindings for the Versal SOC, Controlled
+using Versal SoC firmware interface.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - xlnx,versal-fpga
+
+required:
+  - compatible
+
+Required properties:
+- compatible: should contain "xlnx,versal-fpga"
+
+examples:
+  - |
+    versal_fpga: fpga {
+         compatible = "xlnx,versal-fpga";
+    };
-- 
2.18.0

