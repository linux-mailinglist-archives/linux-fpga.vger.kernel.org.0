Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B543728C6
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 12:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhEDKYE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 06:24:04 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:16192
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230295AbhEDKYB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 May 2021 06:24:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeKYYGszTkyIKShjxLfQYejnxw88N6vb2ctki3CIEGJyJP9Qui9kE6N+1XMqjjkm31b2DEZdEytS4qQK6+m0nMZvglAdwN7frM/s7+1ezuJqVw80TkaB8YOFySJG/u5ORfBrtRIJkTMZY+oZ1Y1aGjhuld/KyUoYuEAVI17BoR37cA91QUQMqIv2vjodSyOZdfSqKQ+qVgDMWjc9LiOR+A9zAvkMKxBxIE4uFGocWmUZczeuwDtbIejQZdscqeXFOJBHyMsv6aShkaBT/Qp0xvfYPsvPp6OA93U+CW5XAbLd8I/tATOTtLKX8AdgUpu/rOGETw9IwQBEvYDkFZxwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlrlbOYlUDhxgXkeBhVHvvHWvFnIteb+KrZY7dKs0EQ=;
 b=ebC8rlRcSzhBjz0BAdFGKIPz1TNwMdwoJ/2Knm39xsmKob4iIm6V4A1fmBD00icuZIyR/Q5Xwhy/PVa7yWSgq+MdReLMhtjfrCD/JkBD9GXvxFH6yp8yZ9t66JbdAydArbuQI28T5lMx6Oc+js8DT2sHGXMwHUhNtl8qbZOAmylZCXZYU1GkAJUt6QZP6TyNTmAvCstW0rKfIQDjOAU3lqO3lPfLFta91UhM4nAG1w6wacat0RQoqnSbtayidqLmxsoFHPelVwZ2PZ+TTzSWT9J5+X5YORgeoN3GSKizN3ReSWFHYpGAiRZM6DMg6ca3dEMYePkw9B/cR+A0K3AR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlrlbOYlUDhxgXkeBhVHvvHWvFnIteb+KrZY7dKs0EQ=;
 b=SrikZQykZRfcm9EFYfouXxvj+m+6haRMPvf7eRdsQjovH6KGuDlRp5/epgGBUzbHK+AHdMnrsmPoYBkh8benLSajxe8Y4eyYE+AQpShWlTzJeXGbmmV0v/HO05mSy7z6BV4IudF78WqXzwnwb+KIgXIhT/rrZJanlsWhsuq3QSM=
Received: from BN8PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:60::36)
 by BN7PR02MB4993.namprd02.prod.outlook.com (2603:10b6:408:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 10:23:05 +0000
Received: from BN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::fd) by BN8PR12CA0023.outlook.office365.com
 (2603:10b6:408:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Tue, 4 May 2021 10:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT015.mail.protection.outlook.com (10.13.2.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 4 May 2021 10:23:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 03:22:47 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 4 May 2021 03:22:47 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 zou_wei@huawei.com,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=35290 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ldsCU-000192-4y; Tue, 04 May 2021 03:22:46 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <amit.sunil.dhamne@xilinx.com>,
        <tejas.patel@xilinx.com>, <zou_wei@huawei.com>,
        <manish.narani@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <nava.manne@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>,
        <chinnikishore369@gmail.com>
Subject: [RFC PATCH 2/4] fpga: Add new properties to support user-key encrypted bitstream loading
Date:   Tue, 4 May 2021 15:52:25 +0530
Message-ID: <20210504102227.15475-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504102227.15475-1-nava.manne@xilinx.com>
References: <20210504102227.15475-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a67f74-eb95-4564-6a4e-08d90ee69ad1
X-MS-TrafficTypeDiagnostic: BN7PR02MB4993:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4993A2489DA206C684290BB5C25A9@BN7PR02MB4993.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcZbw9ZFPLaiZ5AR8rRtvTjW5nkglqe2prp6kDSYpkMsWmzYxFzDO7FnOJlldl13RF1ry0ydXg4PROzcbZyqJN2PaXuhSE07fZTNjibGbCLwpbXQ0gbL77fdMEQiWv5NNFfwjKbi9IcDZhSUYRJe8fTTPB1UTDGpYVLd78BSqdlLmma203usiMCu6Syf6855dqiFSD+iTfl3Gce4uK7YIEKhAKJGy3JssMmddJGmOzUcphy9E6bW4UxINOv0koIkZd2U7fRfzDv8j0C+KU+/r7QbkUeY3a52HqErql+TWyZm1vsVVmgzVT0JXh9/UoFlL2H11Z3pGKUQ+MGsm6P2ZuFPIf6OFzoNtlvOeu9KUePnGe6KnoFmnqtuURC5JhkZ6NXZ219yIQvgZZeDXGjuaeOXJ/MnD8iYmzn+a+KwpcOSm61+UUfQROjy6I3mzJhixbKaNsI6G8/LALY+KkMaAVS5snoyGHWIGOLu6tQYzx92Am2HzSWXjBBMKx7iCRY8bhwKkLDTT1XbUSgMueOZ5REdNDIOXSnhPFT/mvlToG+YhkuGvFwE0dW7xPVG+dcHP5OCU68GX4XIj13n7H1rXmLtCXkBfwMSTvrjt15t7Ojb8y7sr7qDWchek+Gy4gdJBqVvnYeg357d/SZUZ4QBuOfBb/SghrmHEPRrTL17pHnP65JmJvVDhMyqVKah8AL4/McLlnq6YFjzRBmKj4H6hnVZPqw+Lyq38+0Ih31zTYaff8+v1i/e9uxUxwiDRYv4
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39850400004)(396003)(376002)(136003)(46966006)(36840700001)(8676002)(82310400003)(9786002)(82740400003)(7416002)(83380400001)(8936002)(6666004)(7696005)(36860700001)(2616005)(26005)(186003)(110136005)(70586007)(70206006)(5660300002)(36756003)(921005)(336012)(426003)(47076005)(2906002)(356005)(36906005)(316002)(478600001)(7636003)(1076003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 10:23:05.0898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a67f74-eb95-4564-6a4e-08d90ee69ad1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4993
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch Adds ‘encrypted-key-name’ and
‘encrypted-user-key-fpga-config’ properties
to support user-key encrypted bitstream loading
use case.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index d787d57491a1..957dc6cbcd9e 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -177,6 +177,9 @@ Optional properties:
 	it indicates that the FPGA has already been programmed with this image.
 	If this property is in an overlay targeting a FPGA region, it is a
 	request to program the FPGA with that image.
+- encrypted-key-name : should contain the name of an encrypted key file located
+	on the firmware search path. It will be used to decrypt the FPGA image
+	file.
 - fpga-bridges : should contain a list of phandles to FPGA Bridges that must be
 	controlled during FPGA programming along with the parent FPGA bridge.
 	This property is optional if the FPGA Manager handles the bridges.
@@ -187,6 +190,8 @@ Optional properties:
 - external-fpga-config : boolean, set if the FPGA has already been configured
 	prior to OS boot up.
 - encrypted-fpga-config : boolean, set if the bitstream is encrypted
+- encrypted-user-key-fpga-config : boolean, set if the bitstream is encrypted
+	with user key.
 - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
 	bridges to successfully become enabled after the region has been
 	programmed.
-- 
2.17.1

