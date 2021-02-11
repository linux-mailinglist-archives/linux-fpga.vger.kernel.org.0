Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959D831848A
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 06:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhBKFTh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 00:19:37 -0500
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:4544
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229447AbhBKFTh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Feb 2021 00:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfFOagcnS+T3j0ZTYaFdIiQi9BTMKA6Dzuvm7psbhLX4fHAR+hv/Mb8WlJwvLwwMrFbu8WVdGxABxG+G01gqR6faSRe6ROnHYDPsWhPPaQKbWOVrPOT9WKaPCbp7H3nJCKE+a3rdDdqdJm0NiaFL3pU5AzXT17/nVK8Ku7c/AunSYBpbbRYuHQTtq3p7/7q4HKqHlY9DANeT71X2a+FQ3QjohjqpCeaagR7xXhWw7Q/RRjZ9WwhRP5gLvxp6OTk6ZXNsZVVgD/HALHSatF57yqxoHcl6AUO1OcETuuIauTLrqm+sO/LYc/REZl02b+RRPTSgocNCwZU4pFZnSpdpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJwYcOlHsW07yVF2QLrRsjdR3JDAlwlfsI9fkLH4518=;
 b=h86qOco7EtfJl+fORol/wtTDlNK8n8fTktDUH4y67C928hH4nc2BwjMylqZarW9QHEAEw/0RzvWeULJPZLnoEykSH5KOzKCQgk2kR0TwbAWv4iQ65wxlMG8I4ReEdhbotEGcNX4Sh5gY7Rf1c9vENdA79MswFwM+d8Pb3/J7TsmM4WPmWnt8220Gz0oA0NFavUFuKApaeTDUrPf5r8Bp4r5ocv2s+Lrt1R9cKfUPpLjbDW7dbe6SQPSe+xIEXp0P1ANdU+hifTu/nuZcObw2nXEg2mQA/bIklf+UdRkCmHrxX2dpct4xQ4vLAgpnuTtzPDFe1NeDSG1LA55eRgCsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJwYcOlHsW07yVF2QLrRsjdR3JDAlwlfsI9fkLH4518=;
 b=rSpkN9oJL6vPJY/HNE4oFmdQyhDd1SHxTBBmojfmGxHIaas/4Btr6TZqLJcgO5ZV1HtuPKoGc/vF2X0ejd1hFVjt2aLdDFLP8XKKY4Aul+6ufhkHMPfoBTsm2hsCNG4epMkoXCR4uNSFjwG3snugKf4eZCzdg6ziWSXWDy7IgHk=
Received: from SA0PR11CA0074.namprd11.prod.outlook.com (2603:10b6:806:d2::19)
 by SJ0PR02MB7312.namprd02.prod.outlook.com (2603:10b6:a03:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 11 Feb
 2021 05:18:44 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::2a) by SA0PR11CA0074.outlook.office365.com
 (2603:10b6:806:d2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Thu, 11 Feb 2021 05:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 05:18:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 10 Feb 2021 21:18:28 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 10 Feb 2021 21:18:28 -0800
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
Received: from [10.140.6.60] (port=49268 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lA4N1-0000QK-Pe; Wed, 10 Feb 2021 21:18:28 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     <git@xilinx.com>, Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 0/2] Add DFX AXI Shutdown manager IP support for Xilinx
Date:   Thu, 11 Feb 2021 10:41:46 +0530
Message-ID: <20210211051148.16722-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e023c88-19f1-4bc5-a34b-08d8ce4c807d
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7312:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB73124D1925F335ED8F6A749BC28C9@SJ0PR02MB7312.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7JQQ2rg+vTKt8r0VXnl/unS/npmLFYjfDMVBCFRAUNYIoJjyOhW04e8M43WahmWN80G4NQDNJIJHF+k1TyMgWd8iHg8kJkoefQgrp/W7XDJ+Axf7vG/LOQXbEO1erXw+R6hd7prpVeqZ+/b6BMKk3NIyh2cXFimYuIYwnaqvAQAaz71f4RytzMfo2jxJf0+KVrb4zdqJulU3s40ij/pRtblxUqC1HnEFOuUwMrG5IeHhGG56ukPY4B//mEo60ZMg0x//alEM52Dhna2X6Vd3MYxVO/LhqMSvMrq/+nHSX/4BV2rTpdmLIBWEvOLJihksSpl/S5E+ZDyT0Mr8yTQcTGNzP6/IXbhoG3g4JykdwfB30JQYM6B5SKeLOAiCLTxamUq8FI4OadP1TvzRvjHtnh5LSywibBOsuCM3WEO1mbf6rdZ8k6p9ASL6fPsarzoMcPQXLQo8hZR7mV/+Ydb3+ganQPM7VA/5d6Cxs5UA11H1ZnvIAQi/dQ2Br2xfIzF7tgVKzx/Udj5O8SjUpp93M09YNqIJQyu5bGFAXr1V7sFBGZ2zTwB3IMcK/q1eS/UZm+Qr1LJYhIZj276l/pgFybm0p79W4hp7Qrh1oRXojNts8hbYZfCn0+H75Z13iFM+bslh6Zxyr6Hdb51l+PmdmZDjAfQ8C31Geehcp9GrnCNn3TJxZ3mCdgGjBJi+VX+6LfGV2wFuVyl38nekgR0fQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(4326008)(478600001)(36756003)(70206006)(82740400003)(70586007)(186003)(83380400001)(47076005)(26005)(7696005)(6666004)(7636003)(36860700001)(356005)(82310400003)(9786002)(2906002)(8676002)(8936002)(2616005)(54906003)(110136005)(4744005)(336012)(316002)(1076003)(36906005)(107886003)(426003)(5660300002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 05:18:44.0679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e023c88-19f1-4bc5-a34b-08d8ce4c807d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7312
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Nava kishore Manne (2):
  dt-bindings: fpga: Add compatible value for Xilinx DFX AXI shutdown
    manager
  fpga: Add support for Xilinx DFX AXI Shutdown manager

 .../bindings/fpga/xilinx-pr-decoupler.txt     | 24 +++++++++++-
 drivers/fpga/Kconfig                          |  9 ++++-
 drivers/fpga/xilinx-pr-decoupler.c            | 37 ++++++++++++++++---
 3 files changed, 63 insertions(+), 7 deletions(-)

-- 
2.18.0

