Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538044564C3
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Nov 2021 22:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhKRVHa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 16:07:30 -0500
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:2721
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229830AbhKRVHa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 16:07:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRCBM6oSMY202Up9TjiJJ7prk9wZ5Hv+1zK/GihyvzN/DFdIEGIf71akxZlE7ANkMKOJqv2b2vpNOivVQt8ukquqdJi5cVwbenzx5QRWZqYLPQtMlgMtoPDMS2F+u1lKY8W7ojDtsiVXYdKFLUvuB4OiT5fT062Dfs3fePfMKQNSiB4Rhhd9T56WpxmhsxogtihfgXuP1iyVnm88wlMPhViMP/pzz9B3R6W8JBYO2zfak9RiZlT760lYhYN/ea+HgOCSeS82tP9ZIAfvqkT1VxrFWEALjIEfEYWqMYHjGO4E33/SMp8EYf7Dunwe0IhQ/ce3PuRwilCIM2YgvRqAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QECNB7kmHRaIsQ7iC4f8bVPstXJH1ZGOxqBSelutlXM=;
 b=JhQHtUCc4dp8+YHzdduHJIze0rJmT3SefyRwdxPo0B0M4FeTDhXzs5thLF2T+Vu0kFSWHCS0XWAySsWnW6FGmKDHoGwCFZFMtt2AYFs7Tg/hiVX2H7UMwzdtPf11ZbYBgpjaIefq9DwhQrujrJQyhBmk5jLFQ2lhGmlA+LR7UGqFkiDo7ECYUvqX0wFwD4y2f0NiS20QKfQYTePV2Eownb5ix8h5lA1fL9Nqlc8CuECMUNQbw6/OWO+5XX+YQzPXU9b+1MUEcsRCEC/bqVpWksUiGT0vWQfCvpk2CXlw5u/ld64kBEjp17P5d4gFnVD9ZFQdjbLqD+My3yCnAvZb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QECNB7kmHRaIsQ7iC4f8bVPstXJH1ZGOxqBSelutlXM=;
 b=ituJR5vt9IdHxnWvg5VGa7UwmLNpnVcfgrRnB3QfTRVniZDyzd9C7pDI2tP5663ntxl0yoAFcEW39j1eEtdJz33GMKCmHl86W3UNdmDSJ7OBd2JRdQhcI+awlquZ2m4k1x9S8SDFjWW3sxDh/i8tboKhclq4P0NxR1+eIWahyis=
Received: from SN6PR05CA0015.namprd05.prod.outlook.com (2603:10b6:805:de::28)
 by BN7PR02MB4004.namprd02.prod.outlook.com (2603:10b6:406:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 21:04:26 +0000
Received: from SN1NAM02FT0058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::8f) by SN6PR05CA0015.outlook.office365.com
 (2603:10b6:805:de::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend
 Transport; Thu, 18 Nov 2021 21:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0058.mail.protection.outlook.com (10.97.5.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 21:04:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 13:04:00 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 13:04:00 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=37752 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mnoZc-0007Dk-DU; Thu, 18 Nov 2021 13:04:00 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id B406B600061; Thu, 18 Nov 2021 13:03:36 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 XRT Alveo Infrastructure 2/9] Documentation: devicetree: bindings: add xrt group binding
Date:   Thu, 18 Nov 2021 13:03:16 -0800
Message-ID: <20211118210323.1070283-3-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
References: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a78db70a-b157-4e3e-141b-08d9aad70150
X-MS-TrafficTypeDiagnostic: BN7PR02MB4004:
X-Microsoft-Antispam-PRVS: <BN7PR02MB40049AA8C700082C54FE1AFCA19B9@BN7PR02MB4004.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mH7XRKyYbjiQe13MYtGXD2W8o23tNW0JD2ndlSdJYPN7ljcHCIMKY57Dv2XIp5HRBbaqAGOot03CCXYvy+i7qe54ZCbjHLfrnjdBur9DsdputAuwzgaU3XosPEQcZlFjrQpLYsQdHPMWFt2RIf6Q96mEq6FJHqkJCT+B7icSnUiYz5NnaNTSQ9kYSv1Lbg0BHMxBnQq4XMpGa4zj9MSZ7a4/xzor3kGkBJU7SxquY5RChwyVAHFyVAIwseauqYDnhTCV5fJhRrk4G3U+Kyjl6Fm1jBNok6zI/6wdWbIK35ek3Zj2+4JKXrcBy+1tETwRwow/3uOlkzmQCmNiCBc1jhfC68hkXu60tRISNwxFDhM1bFeF3/fYkrtq2QX4tDOYOZuWwK58wQZb74/wmWH1+OIgFt+5PFsvtGy2GvT6L61lm2Vpu1BYZkfG9VRBga1EBkaw6Xm57XGjDFcvZIYGf8DYUYVehY4da0c2RACT9/lBBRaAJvSOUPMQykE+KYokb+MomTtlJpRIQX1MY5ZKHGKZ8O/vVjhWGQwFnyr8bATP7ijDSPDEG/UXHRCc6BaRJixEhb45X35CXBu+5NdMaTw5Cn24SYQLZIIXhBu/T8gTPCR9MzJ1dGx1k8kpspNk5UaFbY6HMl7vPJO4OV6+JxZaDLFwOSWd0TcmRS/F7DVrEtqtfhhEtKCNm1KOfomt7ecSpL82dQv3Tm5lU0tL2w7DK+eL0E5SSARF4Rxhz8NggVUrq3pKOT/8fsSTwZvBpSmQ0bJGKupXGX5GR1NjpOe7aFCUWgKqA2wgzsd75oNbl1DpO9z33FRm8hwApNlv+7uPsTaL9kaGPT5jI3JrXw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(5660300002)(44832011)(70586007)(2906002)(4326008)(54906003)(36756003)(6666004)(8676002)(426003)(36860700001)(6266002)(336012)(7636003)(26005)(966005)(47076005)(356005)(1076003)(2616005)(8936002)(82310400003)(42186006)(186003)(70206006)(508600001)(36906005)(316002)(107886003)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:04:26.5541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a78db70a-b157-4e3e-141b-08d9aad70150
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4004
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create device tree binding document for xrt group device.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 .../bindings/xrt/xlnx,xrt-group.yaml          | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml

diff --git a/Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml b/Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml
new file mode 100644
index 000000000000..112c493eb2d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml
@@ -0,0 +1,59 @@
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
+     const: 3
+
+  "#size-cells":
+     const: 2
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
+                compatible = "xilinx.com,reg_abs-axi_hwicap-1.0",
+                             "axi_hwicap";
+            };
+        };
+    };
-- 
2.27.0

