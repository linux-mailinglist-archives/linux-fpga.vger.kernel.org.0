Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509D63A0C03
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 07:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhFIFyl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 01:54:41 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:17888
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233313AbhFIFyk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 01:54:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDFu8v0qBE3YjSvZwRdR0vg41Nckq5WvxHTKYzj0zacghCAGBjL/77b+6s3RipX3uF77ZTpcoPeHGKxXBH1ryb/h++6UUB7yULtTkUJVJhO+gxmHQ4fqSY8YwJnTXtWb+CkErV5djtx0WiFLhJvNOl40Puta08Ax5h/oQbNW82cfL7Ke+UTMIk6OKQmKpn5EgfbmdrzickU7YSuFUgFRU0yFFJKZZLbU3yY3KW5RAKFG06DJs8mHdTkei5/ey5DJsbSYR+VlxipemV5Z8/RcbmQdNCQkdoeePOv6g74N7leY8bKOdpY/h0Bx6JGQ7m/o8OSpnFDZIxxtHPVedWp5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+sWMca+HmpV1WeEqoGoIbpNpxRRL1tyfW+QA5t717U=;
 b=en75qR8ZOgnU8o1Rh5gWzKvuCVeb7amGyaKeqBCYk0x4Gy40q96Xs8QF7Gx94pf/d+JonQ07JMyqvNb4fFIW666NEdMsHNn5rpR2i0WIfJVXnjOCw4rFDeRjV8T9NqTVR4C3O7yungxuTtqQehItIGalW4lawauMEbIHIGzEEpVWdK4u50S6luT0IWpyngksp1wNQTz6Jc1cFbQBkShpMLPmsI+7MuiePSZxKxn5oRb3+vCXnDTHbZc5A1KsAAeEJocHyCjt/35ymMsLTAxd46S4SlBft8nfPyGG5FMt93E78aWitRbFvC31kEErPSaJPjrXN8UuQJpXU9Ai12cjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+sWMca+HmpV1WeEqoGoIbpNpxRRL1tyfW+QA5t717U=;
 b=rAIn1xzdDcl/xnqW387VUNoxZxQTnusjz5foaYKb+vrfwTw+lmdThIMvYNTn3cqFCDeE9H+qryWjPkjnUUUoHPHQmyTX1fiOhAw9ANAxtW3lM4lOAg+HcY3ScbH+ZGZVwb8VLUouq0Gv8/Y2uMbaWIhXB4uc7yboJHR0FR1owLI=
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by SJ0PR02MB7150.namprd02.prod.outlook.com (2603:10b6:a03:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 9 Jun
 2021 05:52:44 +0000
Received: from BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::61) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12 via Frontend
 Transport; Wed, 9 Jun 2021 05:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT029.mail.protection.outlook.com (10.13.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.18 via Frontend Transport; Wed, 9 Jun 2021 05:52:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 22:52:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 8 Jun 2021 22:52:42 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=51918 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lqr8r-0007H3-0d; Tue, 08 Jun 2021 22:52:41 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <amit.sunil.dhamne@xilinx.com>, <tejas.patel@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <ravi.patel@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>, <chinnikishore369@gmail.com>
Subject: [RFC v2 0/4]Fpga: adds support to load the user-key encrypted FPGA Image loading
Date:   Wed, 9 Jun 2021 11:22:28 +0530
Message-ID: <20210609055232.4501-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 156d7224-e98e-46c8-54d0-08d92b0acd3f
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7150:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7150FE50C40FDC91B90B6D9EC2369@SJ0PR02MB7150.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6Ozvt1vTPHFAV5Oq/TKcVKgayUFqm3frl1e3a3atXJ9NRiV3o5Lx7fWcc85R9SSauQOMgTkUKZq5Bv/bQXLQFG3GJPboSmqrLeaomhtkyGWTwUKgeHyMk2vAVgvBt9VNGPN+Qbe0RG9vrAjVa5xo2m5YaG9QcrS/eYqWuhr/YvdlXHLXtdHya2Ve2GFmVGY8SvusjTQ3uIPZRx4wRERsIqS5zkKG+bveW2B2v0HAd41P7S5hBISx/ZpxvauSwrB//g2WmGONO7yd+CNLGCdDtJEkMHuqV8qQnakg0Id+hWENWqGw1QV1a2drA+rHSIFcZrSCP2oxLYq6+Tooum5TgjLGHh7fgKej3WFvPpxMRjRHRIdOGxDiE0iWZ0W6S/cQFPGzURiQnwct0bEO5ZOQg7xajS3AqvTCPCasMBbaObArULfO0jll29q4ccEt9/LgQ/FhZa3TORZB9Gdg4/xF8Pw8RzVlotVE8Cu2rvXDcgzvcAdSryIpayDWycM59fudc8HtTYblUgeGVLDMXkw9c/m+zgYN3gOF/frB7uumW0g3FMW7cYLpvRQXVJUjVYLN9ImiEV9G1vfrVjKFHmC3r+DPZwjN0uLo080VzIgKCncl/RLNp80N/PdTsp+YOpZh+CgnourHp9nonpozlZFSmZDm82HL2qp+pB/zDgWXhMPBKmKRJrT/82+XEM2e6mBn/DZpZhfmHUI3w5KY3z5YluyFJGs9IyDQZ2xfz9/r1GzE/FC7Vn9vtVGGbm4Xkb8
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(2906002)(4744005)(478600001)(82740400003)(7636003)(36860700001)(186003)(921005)(110136005)(8936002)(356005)(70206006)(8676002)(6666004)(36756003)(70586007)(336012)(7696005)(426003)(1076003)(83380400001)(7416002)(82310400003)(5660300002)(316002)(36906005)(26005)(47076005)(2616005)(9786002)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:52:44.1313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156d7224-e98e-46c8-54d0-08d92b0acd3f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7150
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch series adds supports user-key encrypted FPGA Image loading using
FPGA Manager framework.

Nava kishore Manne (4):
  drivers: firmware: Add user encrypted key load API support
  fpga: Add new property to support user-key encrypted bitstream loading
  drivers: fpga: Add user-key encrypted FPGA Image loading support
  fpga: zynqmp: Add user-key encrypted FPGA Image loading support

 .../devicetree/bindings/fpga/fpga-region.txt  |  3 +++
 drivers/firmware/xilinx/zynqmp.c              | 17 +++++++++++++
 drivers/fpga/fpga-mgr.c                       | 15 ++++++++++++
 drivers/fpga/of-fpga-region.c                 | 11 +++++++++
 drivers/fpga/zynqmp-fpga.c                    | 24 +++++++++++++++++--
 include/linux/firmware/xlnx-zynqmp.h          |  9 +++++++
 include/linux/fpga/fpga-mgr.h                 |  7 ++++++
 7 files changed, 84 insertions(+), 2 deletions(-)

-- 
2.17.1

