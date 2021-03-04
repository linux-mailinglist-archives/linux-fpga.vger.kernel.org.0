Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC232CD67
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 08:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhCDHLZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Mar 2021 02:11:25 -0500
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:53153
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236020AbhCDHK5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Mar 2021 02:10:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8ie4gCJT4ehlsSFdDqOFGkqST2SxGFJJZtwe6ajaNPhRNwRn2MAmVdqy/cP4nXfnUcPrfXMCpSfnl9Rhyf5yCrTjGSbw2LylGG2MA+pngIyq9TqXdYfLs16AjbELRcDoRq3KMMrJrgPekz9r/xVWjamnnzAWZZPWI+G/jzA/mcN9e4tLaP6OBXUcFGyZc8BvZIWvCpapTTN2DsNz3uWuqbBaNpawgyCYLtnIGllcIoarS8OHEvcaCJ4iWtzZEjdXkNW0REK3e3yXlAvfEVmNnY7f8guggJVccM3zQIQ5CK7hLfWC5iTmuiG12y1vj1DkfFe8ibtGm0vwwUFmJHwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVozJYX9aIwUIsMbEr+hgagDNuwCr7ZdcXawu1aBpo0=;
 b=UwykGUVSQCXxwSXTzqWrHfYHRqlQsDkUPTbYfrvLihgH3hDL6FTHKqUdR2MpT0WYmSQJ1dMX31YBU8MBloXWzPHvmGokZH8I0+wsJ8qtwdid3vj1QsWrcz7Vk0V12NJN6LGDXOufvBvP+KModOB0A5WWe4Y4VFUndAg5gKU7Z5pu6Gs5eF4/cFOlNlR7uHrGqj/yUy3qhrctH+wYA+zIjFoCtDzH0apvMcd5I+M8GKFqZy7EVHoGbj7L8FlL3H+lDzYPHnkzp2X9Fp/otg0WHPr9AFepkD30A/QnljC1HNAqK3p2d6I3axvpjyyeSxSTlEVmsA7yvaIKRreOOOqbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVozJYX9aIwUIsMbEr+hgagDNuwCr7ZdcXawu1aBpo0=;
 b=kUD7B+2C5bPtXDhLytG/Mpo4+a5Ze+AJcCNkrw03nwV+wyum74YF2kCkYc1kpSv8EIBkPqepnSX/SzaAKMb5hRnNz2wsazCNRONW/OequCgXDTmpCvhbUH4ViuuTb3tRcVWDJhQjGOI1+rqyOirI0jRYFT1n4yQbguL2hT9jzc8=
Received: from MN2PR05CA0035.namprd05.prod.outlook.com (2603:10b6:208:c0::48)
 by SN6PR02MB5280.namprd02.prod.outlook.com (2603:10b6:805:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 4 Mar
 2021 07:10:00 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:c0:cafe::da) by MN2PR05CA0035.outlook.office365.com
 (2603:10b6:208:c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend
 Transport; Thu, 4 Mar 2021 07:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 07:10:00 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 3 Mar 2021 23:09:44 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 3 Mar 2021 23:09:44 -0800
Envelope-to: michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 manish.narani@xilinx.com,
 amit.sunil.dhamne@xilinx.com,
 appana.durga.rao@xilinx.com,
 nava.manne@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 arnd@arndb.de,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=51424 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lHi7D-0003nC-TF; Wed, 03 Mar 2021 23:09:44 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <jolly.shah@xilinx.com>, <rajan.vaja@xilinx.com>, <arnd@arndb.de>,
        <manish.narani@xilinx.com>, <amit.sunil.dhamne@xilinx.com>,
        <tejas.patel@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chinnikishore369@gmail.com>
CC:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "Nava kishore Manne" <nava.manne@xilinx.com>
Subject: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal fpga manager
Date:   Thu, 4 Mar 2021 12:32:23 +0530
Message-ID: <20210304070224.22346-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210304070224.22346-1-nava.manne@xilinx.com>
References: <20210304070224.22346-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e27d9b5-8449-415c-4e1e-08d8dedc869c
X-MS-TrafficTypeDiagnostic: SN6PR02MB5280:
X-Microsoft-Antispam-PRVS: <SN6PR02MB52809BDA4B90E52671A4A7D0C2979@SN6PR02MB5280.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCjTS437AAtsCAg7bAI+u6deZHMrS94ht2yJQ1TX78QJzGArigRNRUBNWNWqpR+Clt5hYZSDNMMuHjYRNq4a9mS1yhSLZs8l7XZe2M8flIJJ1HzjSLwOOwhuvIYtoMxFadJLlQBMXLVi1qVByERHE4JFYOpzUxQfMLfXPDYs2jKHZD5wWz/3dVQGtxTIDbePlRQ5rl7uAdor9d1VW2OHTacSnRkUl182RWJB8FxG3Qbj+aovBFfgPHC5BsFGVTqRGt/yyFo6PXiexuVksahsZ5AvdMGiPb/rNVz4OCfHMLfnpud6NH3BPcQ4Ih7qxDA2QokirnULRxfkOI4FSwKaPlw30MSQL5Pn8eduAqkiRgAjxhyEAHGx/mmaHlanbhQnHMWDgi+hHnWjtW+2E/xsa4dqBuYT1AIQu7Vsv4uOG2sabJib1bg2YGVS9i50LjXrCJ7oKZ+2S2shraNzKECqr9aDVb7lqtonfpdF9EO3bimvdYDQ8XRALrqbFpwT7aVOi2hWdRKbPO0FjRHFlNE504fJHWmRz8adyQleRpAREaFv0hGqvsDeAa46aUfKN31lQwSpBcOncjUqsF8/D/ZBtRhjIipJ/Vk97c36bMl7CllPs/f9gJjU5thujXWzIvTBzHtrUsA7m71R0e86JK2pbKE5x45ErIajDoZVpjjmg7RZGP06qfO+E+cj5qLVFM1PGHCW858pSkJeYhpUdb+cSm/PbameiEsSu56WVmgmneycP4XQOUQXRjlSoSXs81BOLnk4c+A9HKCJJ/gT337qk3FLxyLsvRZXbnmcwBGZVWHW71iEeTdyqj4IPUK5Sm/a
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(7636003)(1076003)(36756003)(426003)(7696005)(336012)(70206006)(5660300002)(8936002)(54906003)(7416002)(6666004)(70586007)(9786002)(47076005)(4326008)(966005)(107886003)(110136005)(36906005)(36860700001)(921005)(186003)(498600001)(8676002)(2906002)(26005)(2616005)(82310400003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 07:10:00.4067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e27d9b5-8449-415c-4e1e-08d8dedc869c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5280
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

 .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
new file mode 100644
index 000000000000..fec6144766fe
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
+    versal_fpga: fpga {
+         compatible = "xlnx,versal-fpga";
+    };
+
+...
-- 
2.18.0

