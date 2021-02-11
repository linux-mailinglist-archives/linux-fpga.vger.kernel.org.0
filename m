Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D90318519
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 07:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBKGN2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 01:13:28 -0500
Received: from mail-eopbgr770050.outbound.protection.outlook.com ([40.107.77.50]:58375
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229617AbhBKGNZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Feb 2021 01:13:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORS0kYfGAjJhp+HomVPxFx15sQNJloDN+/N3Lf/d7wYgcNm6c/NOPt+OzJnBU9TjOMReFTj/luAsLvZo2heDstFaazAT57T23zl1rXC4pQ2wURQKz69I2MDepeG8w+RTG+0wc3JY1EufpInKRooQr4wOBTzEGmtu8LWrltAJxkYw8TRkXQ7fIc5NzaIx/pfLPV8C9V2XIM096eO0KEcvmfxqLBQCgnUM+6CNwEjrLk3vEmwomOqhwoBj29BsBokqRoO8Bk4uGwAip4D4FRDIz8YnXbw/D4wc3gqox/DJobJ8LkCxl5lDkVUeoR+/eL2RAe9cPflY0wtqe0EiZXe/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htdOZJEbAOzIHrXU22WEPkzvwo4uJnaQOQfYgP1loGA=;
 b=Qp0hn2NSxAJEtyaWhG54RXSOVzw0tUO2umjhsmKuuXMMpv1X+LYTMshQuT90KiHAfMCeXa1YSCp/D6wMPARs9akW2pD0LvOQD+xy5RJt4xAliT3sJrqPoZAsvcgiDY6X3/nv7BS8GHwUCycm8YOZ7vHhFkpmCgsj5tT2X3wSauHB+dJwOa310/cKwfrZxG4SVtjKYyt4dBkDwtJWDzZ6lF4AKGgvKuga2308oz/yr90bIXo2NcFx64k/FQ5rpPacWVGY/nPN6BzyeWHaOyJGBtK8TY5cY3QorLS7xIicBjBjkNpg0/H50K6ZSEcEr+O41NXfw43/hzX34srfukcufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htdOZJEbAOzIHrXU22WEPkzvwo4uJnaQOQfYgP1loGA=;
 b=rpCARUJNJELp0FaE7Or8Ot4ZXZKN7UhIJdZvN2aU3OCfgVRxj+t3uhj6HbYiRFEcVI05Av1TjVosjClnUAxIBMjwdZHyIxXZ60cA/ozy4P4yodhA+fjztaT/y1E/67qE6VFsDfk8Mrct770omAB0xcEpTwVBTpXCSq/FJIza3EA=
Received: from SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35)
 by CH2PR02MB6373.namprd02.prod.outlook.com (2603:10b6:610:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Thu, 11 Feb
 2021 06:12:33 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bc:cafe::d4) by SA0PR11CA0210.outlook.office365.com
 (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Thu, 11 Feb 2021 06:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 06:12:32 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 10 Feb 2021 22:12:17 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 10 Feb 2021 22:12:17 -0800
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
Received: from [10.140.6.60] (port=34116 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lA5D6-0001Jy-CP; Wed, 10 Feb 2021 22:12:17 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     <git@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 2/3] dt-bindings: fpga: Add binding doc for versal fpga manager
Date:   Thu, 11 Feb 2021 11:35:31 +0530
Message-ID: <20210211060532.23662-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210211060532.23662-1-nava.manne@xilinx.com>
References: <20210211060532.23662-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca3ca485-bc19-4dd3-0485-08d8ce5404e8
X-MS-TrafficTypeDiagnostic: CH2PR02MB6373:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6373CAD34CF31D69DDE2C94CC28C9@CH2PR02MB6373.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZKrTwabY66cgYgbBs2JXozBRzOOs9GU2pEgqvJ1TJPslQKg4pPyyqi++VH23nSDrjlvrDTCIRQWMRuQGdo19yXOK/EDtCzTOMxe7KvpJ7Z2mM9DdAI1fwiMCKVZfEk0OHL6oQQHxHRmyky6eYuB4ylxd6BwW9TDrN7rpfQ8WDyVttl6R2pUbbbPyEkbvkvbBogTRSwhOQ8Et/y1/W7vuxIAXaGt9BNh8yF6esfLIp5F3ZxFOH+pW/lACjxzHcWXo/wD5C1lHzEqcRLc++xobxiRbFFviMO2/wY7eJVP3PQhllUDphs9VQ8pJJm4j0nblmCQuB0tN/zumgH6Vft4rDIZLk0PDYWexzt3SksoegKIay05053NYXtUxnrcgvGgYOM2oPmvlfl7ExF/9HwywClsbYM3PhD88wNtIWta528rd/0Z/yvZq1sYf+hEuh4Zdkh8SA65C2wr1H6nv8HNH3yblWNe8SoZT3o6wLfOHaZgPoGtEoLHnGfQfeeQnkeyytHBZZahA8iEx5WAlbqqSuTqWGsOfnwC1iEhBrMiQTG+yWVCZBEpZb8OmKtbkLNfxHZyFJcJFEAAhrfbUC7s6pIfAKZsU286/bU2n2cHg52T1zg/W/YWlrIWD06Tf5FV3ma4f3ENopECrjKxgbkGXd2vINlGkkd8fJrpW6acdCn4FpQt0h1bZMpz7G0eLxKQzAzP9YFZRkEkQlw10UY3kjkoJMnusb56p/G3vScDjSPbP2yiWB0Tbc04rba5ca6/0xVJt52kYiiHWzHss/Iqbg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(966005)(2906002)(426003)(186003)(36906005)(36860700001)(26005)(110136005)(1076003)(2616005)(8676002)(54906003)(336012)(478600001)(47076005)(36756003)(316002)(6666004)(70206006)(82740400003)(7696005)(9786002)(107886003)(8936002)(82310400003)(4326008)(70586007)(7636003)(356005)(5660300002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 06:12:32.6994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3ca485-bc19-4dd3-0485-08d8ce5404e8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6373
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

 .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
new file mode 100644
index 000000000000..65d6877b913e
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
+description:  |
+  Device Tree Versal FPGA bindings for the Versal SoC, controlled
+  using firmware interface.
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
+additionalProperties: false
+
+examples:
+  - |
+    versal_fpga: fpga {
+         compatible = "xlnx,versal-fpga";
+    };
+
+...
-- 
2.18.0

