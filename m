Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED02318517
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 07:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhBKGNT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 01:13:19 -0500
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:25153
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229538AbhBKGNR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Feb 2021 01:13:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkgdGpQ+vxGHnVEYm3gvhwDHRpFGh05ETIMIOB7tH31LfW4THa3x/LC+suK7IDOLFgGZTzAUrpi65BOblDGFxyWJS3IT6JM1DOxJZKMggRqmnrqSLsMEyk73mWIKcDbXNfU3IkaMNASD3Ltgx59ZYRQ3B80VFAQDCplc8+k+hOQl3SoXLr+n3lK/14jl6L3HNkNW7e9Qywn/QnPxUmQm+KRxNJXgvb5b2OSoxQS5CGU0zqeX6loDKbKuB4/c59WTvOMSTxX9UPLsuTqVuZc2JuRT5arLG8TdLGqvPAsLrIm4MA7fI766CckXR2culKXqVS8WEeEUpVaeF1Jxd6MMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edspjjef6Fo9Lmb5sxUo85szKIwl+ew6k68wR7hkMKg=;
 b=RrSDkmy0eu03GcJBr5ooZX8zodBzn03BwVVZRI7RMR6bUFIzLoPhwnFa66xMNE0DuucWTJSpy6m9nnTxz0T4nQND3yM1WBvORRcdO91W5y9Q4AgqLsnSXiZQdVeUem62Q4x3ae0EKf7bxw26XR/CeGhyCFd1BhbK7GfFLndoodSAn+JDXpOhkIDISskOjtXaN2xa6xNDFpxXFUK2KWGdOnD2eC/tVlhX520tLVvEniKUaBZvU3TOweQbGJZywhZzhY362u51aLAKdn8QM52tbYFjFhdwUo2mSmJ9KLKMXU5ih6PNActRVaObEmnowB/aJJSuzOA5yKgohRPiqEMcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edspjjef6Fo9Lmb5sxUo85szKIwl+ew6k68wR7hkMKg=;
 b=qwtD2PggYiHhhXGKchpY/hh9FeM3O/tw57rZjGAKsX4T7qqC883IpCN26jUInl/ySySc1iBLpLT+HCxYVvya2Ohf/+MNRy3k3vLpDJ8yPnXgB9w+vQEvZxKsljkOuDDAuQdb9YbmxSL1H8Ae6PT7sGi+JJp1fEEaGCSJvdx+vTQ=
Received: from SN4PR0501CA0102.namprd05.prod.outlook.com
 (2603:10b6:803:42::19) by BN6PR02MB3156.namprd02.prod.outlook.com
 (2603:10b6:405:69::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Thu, 11 Feb
 2021 06:12:22 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::51) by SN4PR0501CA0102.outlook.office365.com
 (2603:10b6:803:42::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11 via Frontend
 Transport; Thu, 11 Feb 2021 06:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 06:12:22 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 10 Feb 2021 22:12:11 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 10 Feb 2021 22:12:11 -0800
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
        id 1lA5Cy-0001Jy-Fp; Wed, 10 Feb 2021 22:12:08 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     <git@xilinx.com>, Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 0/3] Add Bitstream configuration support for Versal
Date:   Thu, 11 Feb 2021 11:35:29 +0530
Message-ID: <20210211060532.23662-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f170eda4-dda5-4446-0b46-08d8ce53fe88
X-MS-TrafficTypeDiagnostic: BN6PR02MB3156:
X-Microsoft-Antispam-PRVS: <BN6PR02MB3156078F08B41D2F27C0F85BC28C9@BN6PR02MB3156.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lS3tAL3jv0tgYkk34OOjNy07xgI0uikfX29x5ttqHs/bXSUEeKVduSzAt28Gs+eeXPAdKn6exJxWmqy0zGDXZuSuhHsu8M9zZmCeHp6wuWMXsk5e53jBohoqrz4JgmiCTkvQK3fXOMB1GZwFTjvHD8ApsrkaHuYcT/MxPun8oL4cd/+m4rk+8in1h6+G3uOs76fQpB+m13hnJV323RXep1eFyV99BM5AGSWIfvVZXWfB8gRThZvg3g6MQdHsIe1RLQprejNig+0eJazGkAEMfuA4t3Vs4rGjjl8PH9cEdspVWHzISpXOAm0aQGf0tVFrGSkuhV+YeSnQTvghM6c74TS1rF6yxN7zgy0xAn4lyEyUyrFViNuKVL46sQq55MPBtLgj33P45LtvWjbZ0TF+musgMLZU2MAzBCCNze2Sr+KqnbP38EtJ3W0MArRnCjIfVcnqe1ClRZLGbs+JvAXvN4l4vIwg8/7lEAssQTuj35v0G4e3wAF/kekUKQuEMhkjQBwP9Hr5ESkipgcgKhokenuPnO4/SN0Y7wXCLmH97902T4UlqD5EosYM6DTdDVy5NON/jWYVLr6JX6D6ilD/XOQ+DTNFc4Nj3jnyJKpvLMvrq4V0XyWgMAJTqJh+YFOazcQD+3MjLZqr8qlgtbtNyhp8CZi9sq11B5TdVxUiiwHUJ01xztje2Ls9Heii3E399xbodzWSzcoqDliyAAREQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(47076005)(8676002)(316002)(336012)(70206006)(2906002)(4744005)(70586007)(26005)(356005)(186003)(54906003)(107886003)(5660300002)(8936002)(110136005)(7636003)(36756003)(4326008)(6666004)(2616005)(478600001)(36906005)(7696005)(9786002)(1076003)(426003)(82310400003)(82740400003)(36860700001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 06:12:22.0061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f170eda4-dda5-4446-0b46-08d8ce53fe88
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3156
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Appana Durga Kedareswara rao (1):
  dt-bindings: fpga: Add binding doc for versal fpga manager

Nava kishore Manne (2):
  drivers: firmware: Add PDI load API support
  fpga: versal-fpga: Add versal fpga manager driver

 .../bindings/fpga/xlnx,versal-fpga.yaml       |  33 +++++
 drivers/firmware/xilinx/zynqmp.c              |  17 +++
 drivers/fpga/Kconfig                          |   8 ++
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/versal-fpga.c                    | 120 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   9 ++
 6 files changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
 create mode 100644 drivers/fpga/versal-fpga.c

-- 
2.18.0

