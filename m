Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB60332CD5F
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 08:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhCDHKy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Mar 2021 02:10:54 -0500
Received: from mail-mw2nam08on2048.outbound.protection.outlook.com ([40.107.101.48]:49217
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235947AbhCDHK3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Mar 2021 02:10:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNWIX+C+5pltPLvi84zUL5E7Xrr/g6hQp53taqIeQiRy0NyD2EtXXkXEFl5VyuyaPXMyloy3kx0OOGvZOG7Plux/B3KXOCJYWkhrqxsUdDnBsxk9pis4Z9C1tQo2IeMO4AatTzBnMMzmdPvqgcqqGGUixJm/2D7+9GUyVUZ8mHBGOfVcLq6enX4j83bmJEfCe5kTxgIuzc2FyZrJ1e8JJdLTo5nq/bkgql5rJrMXSruJstaP5di160Gu7XyGD7WlXAspk9O0b2FK0CaA26qNwkifbqToN8zgzJ5CkUqeBJsty0UNh8wvFfZWotIZ1KlwbTwGec/kPnGA9YnpN+Ggag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQlVoOQJPBZ+guW1YDW8jZ2YBHnYoFKjd1sWg9MflAg=;
 b=OffWgD+Gp/FG35OgGoyB9JgANt63i+XXyYifrplbD6shI0hyiAz/Z3/550DDvgpRmaXKzH72CgKH8YnHzlKKZqZO1djhTQy6f1MWgfvQsXO9ASuU9UeCWQ28SBzctG9wKikcm4fW9B7IOxfWUXgZbvhOAYAGC3E9HY0mw+exkkVmR9uQpgBHyDyaN3eo4av6ZqUCGcMDli62zKcXi/bqymSdcuDtQOiHwISFROy/obIsX5XgPXjB3c+ge4rcr/czsw66ODR/hY6ROad84H2s+WcvpxGppwsGR/6tm7z8q8mMZgucDriYl7UDcg21HW8vXAYkrWil56ISjfP6IMnd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQlVoOQJPBZ+guW1YDW8jZ2YBHnYoFKjd1sWg9MflAg=;
 b=PCPmSBO9o2dcq5rTowKRkoi7UDoIj8SpVl+DzhmE33s5+5hYIFOJ51NAbnNi11NswCnpIyy5rC4xPq5P63o/3axVfL/+MVn6CNLoDqkI/z8rXrcvI8bdrsV1FPs+cOiIJbKDzJtpR3VR6wjj+4cBoYb4KsqsL2/uzdeVNAJaxrQ=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by MN2PR02MB6301.namprd02.prod.outlook.com (2603:10b6:208:1bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 4 Mar
 2021 07:09:36 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23b:cafe::cc) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 07:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 07:09:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 3 Mar 2021 23:09:35 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 3 Mar 2021 23:09:35 -0800
Envelope-to: michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 manish.narani@xilinx.com,
 amit.sunil.dhamne@xilinx.com,
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
        id 1lHi74-0003nC-ML; Wed, 03 Mar 2021 23:09:35 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <jolly.shah@xilinx.com>, <rajan.vaja@xilinx.com>, <arnd@arndb.de>,
        <manish.narani@xilinx.com>, <amit.sunil.dhamne@xilinx.com>,
        <tejas.patel@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 0/3] Add Bitstream configuration support for Versal
Date:   Thu, 4 Mar 2021 12:32:21 +0530
Message-ID: <20210304070224.22346-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beb3dc02-9fea-4705-bd3a-08d8dedc781c
X-MS-TrafficTypeDiagnostic: MN2PR02MB6301:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6301E7AF8699F6249F75A6A5C2979@MN2PR02MB6301.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQH65MIh5zEjp6qxvYOy/3muFnTE9eKd1yCiNPSu1HlHEVp0JgDfwvDMcPvSutu4MbYADLunL/uh0qWADHXbXDd8ebzTje4HaSTLxp5chkjHZTX+45csR7/OH2UDNimmLZlrS5Tg/QjyZIvllQxEJFBu1atBJNwA8x+LRXNGG3HZED/26G/3sYDDEU10lgndNRLzTDB/nmsENxKPt6ZgK3WeNJ5pPacXCb+RYytfnQwyG4fVov+uYXuNtK5yCyAoYXSy6TUO5HUHJzD4ZHkRRxGEHLxTES8lYMwGResI9BA+/dJJ1BevsaosUN5q8do6AwTc5JNmECeJQqYRTDVXve4IQj1Q8N1/mHOIvRgEcl3yPM9lJ+5CnACqXcA44AjCiWS6aUZWG6MDprH+c8nn3ZPwIAgJ4bbXhWOXueFrw2hqx/iu7v4Z5ayW+q1q6UbefWAz2LD+XiBlGaiUUIro+5Be+DaYVkPYN6YXk16LZY0e/kV9DyMpc5vWv0KsnaqGMhjIw734NdzUNaTsE5FmQ6/aINuPEMYv1Vv3aBq9vUUH9d/a8rx/azAeAKt7J067Swk7ZZzvceR3778cu7dE76P1mNp1Z1PqvgpM3h79D1x7DhIS/MPyCzn/5BFQRQIUxEUFTOw0Q+F2VBQuxKH/MdStB8VDd3TGd/xiHcF9PmYB1VS8214Ah0DhDmDlCfhn8ZAF6KGHyVolTD9U8O/+zj7Smvls7txZCJ6PyEM0BVGljMrkWWM4p8OapwRHlRur
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(426003)(4744005)(2616005)(7636003)(336012)(356005)(36906005)(186003)(110136005)(47076005)(82310400003)(26005)(316002)(8676002)(70206006)(70586007)(7416002)(2906002)(478600001)(1076003)(82740400003)(107886003)(6666004)(9786002)(921005)(8936002)(7696005)(36756003)(5660300002)(36860700001)(4326008)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 07:09:36.0856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb3dc02-9fea-4705-bd3a-08d8dedc781c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6301
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This series adds FPGA Manager support for the Xilinx
Versal chip.

Appana Durga Kedareswara rao (1):
  dt-bindings: fpga: Add binding doc for versal fpga manager

Nava kishore Manne (2):
  drivers: firmware: Add PDI load API support
  fpga: versal-fpga: Add versal fpga manager driver

 .../bindings/fpga/xlnx,versal-fpga.yaml       |  33 +++++
 drivers/firmware/xilinx/zynqmp.c              |  17 +++
 drivers/fpga/Kconfig                          |   9 ++
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/versal-fpga.c                    | 117 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  10 ++
 6 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
 create mode 100644 drivers/fpga/versal-fpga.c

-- 
2.18.0

