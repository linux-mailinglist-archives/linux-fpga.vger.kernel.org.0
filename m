Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6336EBE4
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Apr 2021 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhD2OFQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Apr 2021 10:05:16 -0400
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com ([40.107.244.77]:19698
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233602AbhD2OFQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 29 Apr 2021 10:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxzST6PxtlP1HXKsn/nBaFc4uOH7Ipqd2QLCEMLJyyYlzQTX1p3uZP5Bdyd4VnQVMkze/WGrfD7VoYUhYe3J71PueoXgVfi0tAWBN49qLl4RyKapM9Mqt91BPYTbAQRG6jDK5HhJJTx5G2S45vjs6tO+GkGZtlo8oVFZ7CHRKDCdHaNC+33IwaOQDBTG4w9AfGC+oMZSIF5ejltrjJPoX6/GONBD16xNEDNCr6dSY9oV1ZkQFv+ZDe7MxTV5cTWSCRWKNE96C/ofcXbEJGk9sL6St8tgWZs01nkjVLqvqI18Y0yunoiVTBcqTAYeg5T62u5FU1JytDj42frRd7tZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ep+avkAPfieQHq6dnBokQf6VsP89BPJgIgS5V7/LlA=;
 b=cP+LEtz3R8dHEgBoZtFCikbpjTVqDj8prUV+4zTh74Nld17fwt6Q0e47KLVt+X9QSEGiyyfJGkle2m+Fz54Apx5TLAz7N46zv28NXG16kczWzN4/QQWICz92W3h8HkXUPPLYRp2vKoAtV3DjLkG4xdjMHEBUDmPhDQIDXGudpiStjVQXdrtNwsy8kkQhVtr7dMd0cuDSOKVvzf6BLgVPhSTSCW/iKGLiiH/TPNzYB2bpSs+nHawnRpzAP66vC2ogkwobj6vnRinWTvePImBbZYTuFLipn/or9U6hif1hXH60wE9A7oKVhDkVR+kr6VkxvtPsYW7jsWgud5XhX6Umlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ep+avkAPfieQHq6dnBokQf6VsP89BPJgIgS5V7/LlA=;
 b=BFo3x5xKQVaNWVpMEVkvoKVAOAzWXDXgRT3BEae6zyraNEpUC96SYyN9FR79TdOr/bW26rW/hHPVMHmNDyKMgBE0Ii5qNmvNLETFgmYr8yLjsziRNe4lNlA2fPy/D6laFi8QeTSyryFDBL+MyAUCrGnIaXTzwVb2UCy1woAGDPs=
Received: from MN2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:208:234::23)
 by MN2PR02MB6096.namprd02.prod.outlook.com (2603:10b6:208:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 14:04:25 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::f0) by MN2PR16CA0054.outlook.office365.com
 (2603:10b6:208:234::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 14:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 14:04:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 07:04:18 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 29 Apr 2021 07:04:18 -0700
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
        id 1lc7H6-0004zS-Da; Thu, 29 Apr 2021 07:04:16 -0700
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
Subject: [PATCH v4 0/4] Add Bitstream configuration support for Versal
Date:   Thu, 29 Apr 2021 19:34:04 +0530
Message-ID: <20210429140408.23194-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12840864-4d8b-49df-2a86-08d90b17b23b
X-MS-TrafficTypeDiagnostic: MN2PR02MB6096:
X-Microsoft-Antispam-PRVS: <MN2PR02MB60962B81FACE50F258CB4265C25F9@MN2PR02MB6096.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKTwAT99ytyE9JmnA6f2P3E0jd3DNHdTOLGgQv+auaqSTOvLCFNUpoCqYegKc50GjJvg49ldIJTVrNJSAeQQznw9xlmEEL46BkOX71vEwMG/YX9VezOS+ezlhS1H+Zu7ejtz0mQoJKvlDhlAyeFskwiLG+4NCj6wWvAV2xetcM9nsx78iuFbb5cAn46AQoKn6q1ICpHsYyYbK9Ko6ycycXH4+TcVWLBuBXsg2LK01b8gJz/qGcQq8R3PrsU5AW6+4NpNDJuvl78Ua9XRHRrWazurbD+6wBhLrSVOaqSl/74csDBuIc6o8BXUnmik6wYUs5eiF11v2DUtm5ABYMwZtHSZXKfzrAfGpXv1XkJBE7RYc5bxzeOzWA25phdYuYxtMtjDqzNW/TZUVrNKikRe/xLpUaegGyNe3LIHez6qzC9I/kBgJwEaAx/5PMO3UswLvkZzxIi+JoxuVxWR1saY5mO5vOgDkUz0lNH2Gr3mgcGysWBHACp3aeYx2+fCo8yVGqxzvEm9rpdeylzKZrueFo0WYmbrErpM1H0tj4iT/ELNVy9FynkpO3bLEa9HVXgTqIC12zdEnhA7Ey5hgFJUhKOOPmsxCngHvEhLWflLn3qQDCAALX1+QuC3x4sWXXv/Y1JxybZUCQjmqOb5Dy/xtZaU6nalbhUf1UCMvm/tHgHElThn0BXQE3VM35CjNih64737t1MQO9rbX1OIPeMFRHqMwLEq5B3isMA4UIq3M4KLS1tE8984Gqb5Q8CiNsSujBwrFJLW1ZnnA9XSekr2GJ9QipzQMLhLRV8GqT1NNoyGOI4dyVxP5QlWZf2B9yJLm8huEf2Aj9LO5ZxPS1IALA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(9786002)(316002)(82310400003)(36860700001)(7636003)(110136005)(966005)(5660300002)(356005)(6636002)(336012)(47076005)(478600001)(70586007)(8936002)(186003)(70206006)(36906005)(1076003)(2906002)(7416002)(2616005)(26005)(7696005)(921005)(8676002)(82740400003)(6666004)(36756003)(426003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:04:25.0621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12840864-4d8b-49df-2a86-08d90b17b23b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6096
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This series Adds FPGA manager driver support for Xilinx Versal SoC.
it uses the firmware interface to configure the programmable logic.

Changes for v4:
		-Rebase the patch series on linux-next.
		https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Appana Durga Kedareswara rao (1):
  dt-bindings: fpga: Add binding doc for versal fpga manager

Nava kishore Manne (3):
  dt-bindings: firmware: Add bindings for xilinx firmware
  drivers: firmware: Add PDI load API support
  fpga: versal-fpga: Add versal fpga manager driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |  63 ++++++++++
 .../bindings/fpga/xlnx,versal-fpga.yaml       |  33 +++++
 drivers/firmware/xilinx/zynqmp.c              |  17 +++
 drivers/fpga/Kconfig                          |   9 ++
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/versal-fpga.c                    | 117 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  10 ++
 7 files changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
 create mode 100644 drivers/fpga/versal-fpga.c

-- 
2.17.1

