Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D097A36EC00
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Apr 2021 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbhD2OHs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Apr 2021 10:07:48 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:56316
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238595AbhD2OHr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 29 Apr 2021 10:07:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrJlP6VbRReQUcCYvek6p8naRzfjepBapedOxSTzxC4e5QnXd3GVLnVxSpHRtZ1UIFk5QXw8ICsuqkOoQr2D2GLjYbXfAjZsbADBoYgUQCvU+b7rT/4uE9ztGnE75unNRJEsfbSqOVAcIKQia6tKuJ/g796+piyE8VFpbd7Zz5EsGsnkZlPd9/tzVtmac3FO1mbM+rugbYwuUszZ74hr8+nnaJ9ZgONb0be+MR7421S8ZcTzW0H6hKtxnreW+ebYTnZ/ANqwRKl/9WuA+R629E2AbUx1OeArMpRc1HL7BjvEmXhCuRgqc3b2Qi2QYNF6DEKmZnYRuT9U57h5maiJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNFustpG6aJvsOw8SGo4r0lk5DQ347HxIBsyFSZYaNw=;
 b=FbUoZvNnIqdZ5N03OrNtEYfQc1dnsQIWvlbDZ0Cq7GU5MFb8ERy7517d12F1jclzgI9eWpzSIfGPvl90aKNU4w1fimKXdnJ2T5cIQCPUzTQHDBMuV4DXHPZRBv3gE7h++/oPZTdSf4IReDR3LgxZErmWyva24KaP5/TleiZ5R7hQ+8MK8NiuG9OdoBBiIZKnE1iwXlBYVmlMrre/27LfJm9RZXt5IBSfd04XuELL49eciJOEJgqpOqgZH6DMW07RTG+w2lwWKqtZb86+N8beTyqGPWYSZ+NIWINnngTx/OfaxUptQXOYZyHj2bKZlSZzss8sbu//hYQCrFtSiembSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNFustpG6aJvsOw8SGo4r0lk5DQ347HxIBsyFSZYaNw=;
 b=V2iIV48s47QXeNSkUziAKaZdc0QOELcPBzLvP8CrGcB8NCsLDh6bbGHrqsvbXAgudz4qOK8h5cSHLHrPFZrh+P3kZcI8mePFsLXY3pUFj/u1jdgwtgLqq6omzr08BtKK/UBJb2O6JEYFL480K8xSsXvJaIr1s4/VHzY+pRA548w=
Received: from BL1PR13CA0148.namprd13.prod.outlook.com (2603:10b6:208:2bb::33)
 by CO6PR02MB7569.namprd02.prod.outlook.com (2603:10b6:303:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 29 Apr
 2021 14:06:59 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bb:cafe::52) by BL1PR13CA0148.outlook.office365.com
 (2603:10b6:208:2bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Thu, 29 Apr 2021 14:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 14:06:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 07:04:23 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 29 Apr 2021 07:04:23 -0700
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
        id 1lc7HB-0004zS-MO; Thu, 29 Apr 2021 07:04:22 -0700
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
Subject: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilinx firmware
Date:   Thu, 29 Apr 2021 19:34:05 +0530
Message-ID: <20210429140408.23194-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429140408.23194-1-nava.manne@xilinx.com>
References: <20210429140408.23194-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 544be203-af4c-4d85-5b0c-08d90b180df7
X-MS-TrafficTypeDiagnostic: CO6PR02MB7569:
X-Microsoft-Antispam-PRVS: <CO6PR02MB7569280999FFB9D874D5562AC25F9@CO6PR02MB7569.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpDhJTY57r/CUx4F6gJH6jpCm54meZAHsItD3OBjW7tG53WURtPmY88Q0zbXtqSpaPsfQ8s1BJnSgx4ulgwY4roJtDLv5kbCjy+B4YtSDiIP/5lCMJgSo4yIACY2phfyRVXYF2ZnJOkInp1Ke45YSMak/q+k0hdXoIP9MY/wBswzGlMGvsBTBkL1SKha2Ealqd32wRZSlF32W7I1LZ5+4SJBXsXDT742asWciZCvsWh69PoUriKoqcgVpsg9csv6NlEnbeTBqv3CCqVETa3i/UiPJCjo4iu4PjH99I73mkV4EiVzq08jRU3HTcL8/5ci4DJw6HztFlOcH1TngdpYjO4hepTHU88sPWwuh6IsHLJOpJbpk9dxxMHZuMDgCtIhvlGZ/QPvG9vfNICfug2Lz1n3lSZcSRGtL7ZCb24qTqPtvq88STYrXqEVkxQ1Mwhlsn2ZP2t3zcjXTBWnATHtxWGqGpScPYVh03FtcvVtRmMouuXawE8kNTY+jXxRt0Qj6HNVEzlELfIAVTmhiFNWUhNhUUcUSw27Ybc8GM+LQtLT2VuINVIJJLfuv6hZaZF5aDi/Y2UL4zyrVHq0oKMX+ipzEGgLyKVb2fNJTaafwugWO3eASbYqYatKyt9CG1assIIb8KsAy/TJVGyrbuaGtC6hpdsVzdbb2Z+MWBtcY9r4EWSwMtInJHMhm4pKa2+OLYGzEoJeV3k+t6gqF0Mw4sdo0KlL5akgv5uQ4BmukteK48fflAxzN8HYkbd2Ho9fOvCgKu1Ebxe7jXxvF8Q+3gkRhMTaaHwiA+MQIUxOcSKIoDiqOS1BKkBpmFGvqB03
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39840400004)(136003)(396003)(46966006)(36840700001)(966005)(6636002)(921005)(36906005)(316002)(2616005)(5660300002)(9786002)(6666004)(2906002)(7416002)(70586007)(70206006)(7696005)(36756003)(47076005)(82310400003)(26005)(110136005)(478600001)(83380400001)(36860700001)(7636003)(8936002)(8676002)(186003)(1076003)(426003)(356005)(336012)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:06:58.9681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 544be203-af4c-4d85-5b0c-08d90b180df7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7569
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add documentation to describe Xilinx firmware driver bindings.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate
to Platform Management Unit.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v4:
                -Added new yaml file for xilinx firmware
                 as suggested by Rob.

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
new file mode 100644
index 000000000000..4b97f005bed7
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/xilinx/xlnx,zynqmp-firmware.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx firmware driver
+
+maintainers:
+  - Nava kishore Manne <nava.manne@xilinx.com>
+
+description:
+  The zynqmp-firmware node describes the interface to platform firmware.
+  ZynqMP has an interface to communicate with secure firmware. Firmware
+  driver provides an interface to firmware APIs. Interface APIs can be
+  used by any driver to communicate to PMUFW(Platform Management Unit).
+  These requests include clock management, pin control, device control,
+  power management service, FPGA service and other platform management
+  services.
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          For implementations complying for Zynq Ultrascale+ MPSoC.
+        const: xlnx,zynqmp-firmware
+
+      - description:
+          For implementations complying for Versal.
+        const: xlnx,versal-firmware
+
+  method:
+    description: The method of calling the PM-API firmware layer.
+                #  Permitted values are:
+                #  - "smc" : SMC #0, following the SMCCC
+                #  - "hvc" : HVC #0, following the SMCCC
+    $ref: /schemas/types.yaml#/definitions/string-array
+    enum:
+      - smc
+      - hvc
+
+patternProperties:
+  "fpga":
+    description: Compatible of the FPGA device.
+    type: object
+
+    required:
+      - compatible
+
+required:
+  - compatible
+
+examples:
+  - |
+    versal-firmware {
+      compatible = "xlnx,versal-firmware";
+      method = "smc";
+      fpga {
+        compatible = "xlnx,versal-fpga";
+      };
+    };
+
+additionalProperties: false
-- 
2.17.1

