Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52F36EC07
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Apr 2021 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhD2OHx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Apr 2021 10:07:53 -0400
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:53984
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240376AbhD2OHv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 29 Apr 2021 10:07:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwss8/IOjsg2FdXgHj+cfkeCyEM5Edu+DUgP/hA3LLJAJPHnwL+m//cIPMP6A1S3YzwKVqaLKlPOGu9gEbcAtAkDJTxFcMXX8auVVRuUZprgsbmwKZru0rk+76Pcy6S48lkPhcMFJoIesE8R3H8JrRfwo1SDfPGLaDJ39XHqNfnmtcvYXz10i9SdBWPNwUQHPnW24BkAPcWOzTK4CorAPi2RLV8uyN83fGrLW6XgviftR9GHcE3RxB1vg7dej5tUNim7ZNKVQ/haSu03Pl5wQrLT0sLW2sVuwrPYzdlTeKHr77vSwZ7kQb13vUtqyJHiRpGJ9GqfR9zJia6a4nzKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEQtAa6RtXK+b9SVI79s7MxdBSBNJg+RWPamXfvBgAM=;
 b=YdeYxfaAJf3c/10BygYPpHhNuYLjOF5rAYhdpdsrZlUxHeX/19HJYzncjt68FWttD7BaZh8xbAxaUVp/NZC/wR3QarL3IO+XOIebp2F76HxeAwWwFGVPEh5R5Sk567AxiMkGMxWZUzOZOl4BhKwEtufBpPQUcZaqMoM5zlYkQUNakRnUimSZrRUmq27IUEz6F2Lw2I1l3EQOJED8OXT4e1NgNR7c2Lmb6/E5oEsnrBlTxF2kj88VqrB7VnWuiz9dC3DoM3z61FhPbs/isfWLg4aKHTokVEflawJ0lNF3e/0Tz33i/UXIAcd5AXcaNSuTioc4N/A0bM9hkVlDhqc1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEQtAa6RtXK+b9SVI79s7MxdBSBNJg+RWPamXfvBgAM=;
 b=oLLlek0YAsuDD5nkzp3sD1Fj5LFCDfkCKnypzhLtqQpynSvV/2D9MWvSiCzwzNHBFPv8IYgPCji3BVhsHoZQcJ5FWr3JOw2sQ+8TLpjejG+Pd1ceo3XqFpUrmumow2m8fR9k9NjCvA0QWThkPZZYV8eASoMaFqCabL0LJHPQSK4=
Received: from MN2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:23a::13)
 by BYAPR02MB5831.namprd02.prod.outlook.com (2603:10b6:a03:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 14:07:03 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23a:cafe::8e) by MN2PR03CA0008.outlook.office365.com
 (2603:10b6:208:23a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend
 Transport; Thu, 29 Apr 2021 14:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 14:07:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 07:04:33 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 29 Apr 2021 07:04:33 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 gregkh@linuxfoundation.org,
 arnd@arndb.de,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 linus.walleij@linaro.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=60740 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lc7HM-0004zS-GO; Thu, 29 Apr 2021 07:04:32 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>,
        <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <amit.sunil.dhamne@xilinx.com>,
        <manish.narani@xilinx.com>, <zou_wei@huawei.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <chinnikishore369@gmail.com>, <git@xilinx.com>
CC:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v4 3/4] dt-bindings: fpga: Add binding doc for versal fpga manager
Date:   Thu, 29 Apr 2021 19:34:07 +0530
Message-ID: <20210429140408.23194-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429140408.23194-1-nava.manne@xilinx.com>
References: <20210429140408.23194-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09fb326d-7b49-48b1-84fd-08d90b18105c
X-MS-TrafficTypeDiagnostic: BYAPR02MB5831:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5831DB60AEFF9B2943923E47C25F9@BYAPR02MB5831.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nocldNTUoKauq/ow3GOKZaPY2HZBAxH8GcSNUOAeY7A6iBVZItut6cG3SefagBTr19/f/BXJiYp02TCE/CeOQlwuegBHEjqSWJUSPxLsdYl2SJm2L1kpb/PHWn6SXNeJ+mqSiKsWt+qJQiWZFf3hjWRvl4d7teDxCklhmO5VGEgnTkvoe10dC2nSDfSMw99HCizqpqCD2ZJ+1Jd4+9mR+6s/Bviyi42GaQ8yZG+P7DgYCdbea+Dd7v3J1AxNJaoGgYfJKkSzDsLu/GfEsuNxDM6AqDN2FrXKwEHq3Ay1LctIBbZj60NUbsjIppnGIStBBZTvVI76KgY/8k6IZqpW3bbVg7WuAXylCDAo6OdId3Qo6KkERZ7cYzETR3csY5HmU0lgohBRMfN+nbllacRrzfpH+ZD2PAbkbg/1FA1Hl+UqHIi60iKM3fc4CT0wQFW8o40oa4tpVRbGF3Oyu5wy5tfAMyU+pxF55Lwyz7NhQ61n1SwTLp+CKKpGBSbId8QhTi1oN22i8nfCQj32DXy3G+o0UA8XMb67e1GGroLHyyuHHc/0eH/2Jz/2fXDH+UANHShV3jx9Xq3y5Pkq217wK+lH+vpzR8GuvRtPmCk2bd7N216KOGdM29xQyxlt1Alv1PZ0HyPwm9L7OTfb7ViE8wrF4j4VVaMcu83GEEhy1It86yygAwRP6cBSeQ98M5jF7TD8Doob/sH4M8sRb48E6Gs94bIL3I8m0s6+KSD4hA2DzYPTAw7Ly6edxTDOXBcDt4aGVXiBDRayPzDBlUUJKRWb6d2GE6a3DCH/v9RXRfi1Dcbjhsqfmr9Vh/6dk+iZ
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(82310400003)(1076003)(921005)(7416002)(6666004)(2906002)(47076005)(6636002)(36860700001)(2616005)(8676002)(7636003)(356005)(36756003)(107886003)(5660300002)(110136005)(82740400003)(478600001)(966005)(36906005)(7696005)(9786002)(70586007)(26005)(70206006)(4326008)(336012)(8936002)(316002)(426003)(186003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:07:02.9865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fb326d-7b49-48b1-84fd-08d90b18105c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5831
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
2.17.1

