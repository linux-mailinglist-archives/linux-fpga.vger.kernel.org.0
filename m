Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD182389F7F
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 10:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhETILp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 04:11:45 -0400
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:47616
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230440AbhETILn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 04:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuD0+aRQs7vrSjL3bnKl/VdCywdYY+cIcuEcgfEi7QdDWr8mjNj5riDr0ENGuAJZSHoo54ho+COpUVXx1oR5chQlaoLrUd5kGob8pCbRdZO3tg7rm0J28pm/VE0IFpnPWgyDLtXw/1So6voLn+GdPmqTrb3JF0ErgypONieZMNWVj8hHLXCduAOqH5Kld+UMM2v1eqqPA0I9jIF4RIpPYkhowgp5KpshL/0YtsLKhRNMS/qTHXxy2arITVyydaPZVJBcVx6+xWcdNG3S5W0wE0a9G3zHW8WIjFF/K94xAr5XqdEE/sY06NCnjel1PZ03UZ1tneh+Wcz9fcFYrcgfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud2CfySseDKCiEm5wBtLLIkMBfkwfUEfPnldtmZ09Hw=;
 b=NQAc63188DQgVLjENsdfXqdpzJfLaXDjxk9mC6+lDufzDDp41o1SkCRgvZmMRszeHrPvFscpFyx6V7hpkEVH0kVfX+Nf9DtcgNRhCl0IZi2NHGWhaFKTD1HBJZ/I+AsKGkbG4tTWaOhcIWwoFFH5FN5vNKIZJbJQ/gl0VXrRUKai4PkYoUsrNLUKmm8nnwwRxTwVk/ZqmaPlMAyjhpoR/CdSAmRzp4qhX+Q9nXUYLnumNuBTVDtTkcOJI0pR/atvzwvXMyTeVPhGNFqcwJJXehvVRSG76Bw0WQNMVmFJ7DnY8UNlLOcCJeNTTemuUJIBTQKSomd/PpO83b+f/Kq+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud2CfySseDKCiEm5wBtLLIkMBfkwfUEfPnldtmZ09Hw=;
 b=ABRJ8xhN339bequhylQWoOj+GA4rznT3+SGRVImZkkydcu9knuukg7GsJoUeSAQPpN15eRrtc0tPz9oZEZjCaBQrwUxPvoeRMiCu0/C2+ZvvFNMwEXqutMoEI1wIyzVpqdqyQMlFcz6RQpxn3beEpO68rjWjV5ZSyoVJzP8/BdI=
Received: from SA0PR11CA0100.namprd11.prod.outlook.com (2603:10b6:806:d1::15)
 by MN2PR02MB5824.namprd02.prod.outlook.com (2603:10b6:208:116::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 08:10:18 +0000
Received: from SN1NAM02FT0024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d1:cafe::1a) by SA0PR11CA0100.outlook.office365.com
 (2603:10b6:806:d1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend
 Transport; Thu, 20 May 2021 08:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0024.mail.protection.outlook.com (10.97.5.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Thu, 20 May 2021 08:10:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 01:10:03 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 20 May 2021 01:10:03 -0700
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
Received: from [10.140.6.60] (port=42624 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ljdko-0007IV-Ad; Thu, 20 May 2021 01:10:02 -0700
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
Subject: [PATCH v6 0/4]Add Bitstream configuration support for Versal
Date:   Thu, 20 May 2021 13:39:50 +0530
Message-ID: <20210520080954.1393-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a662ed-86d9-45ae-843a-08d91b66b498
X-MS-TrafficTypeDiagnostic: MN2PR02MB5824:
X-Microsoft-Antispam-PRVS: <MN2PR02MB5824DEDC45586CC5C89A698EC22A9@MN2PR02MB5824.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdvfau9hrpreIIZPC6xQvfgyvGsC5hZRH9nESur18GqfBXDHOsTRpTOzYntVe2Pp35kLt8DMaJ4/5y6Q6kKtDDB7xXO31jwqNC3UhPMj7KPOsNNBwuMN4DY/t8jlREfaBXBrJZzE2xFdA92hMVWlPHUh0UG9qtvAhlWqXacPcUPJbOGaKQ95QH8+4aMjcbLvllwckkBDQ2zbp2nU2nqNssKSm02m0AHPl5tJDk8IwULfIkaxmeqleMoH3qjVOTzCNdA384p6/2SIDx17jfQTzhxqkCyCuqCTLyigpB1rstLDz23ToeKuShnXHT8lgYtpCND8wflg8bC7x7i0ZZKhU3ZgLg7XdZQYozPtdTvLrimMyZ0rTDsmkyBrLH6+R6VwE9I+GIzpQL7zLRCgw8e1/2/rg5wwYqTHvTMg7JCFhcGTNeuneI0bExaCkEra3Fp/zkEY2kHQFpred24av83O/WelCWCUSO6Klod+hQY/DWQUJT1WgHkiFI2GR8AiinQ4Aef0LogCQN3Os8I2t+Ye9vlfg7NJM3FjDq4g672iLUzjZvbb8uhBdoLbY8eGj0wHc4WkI6x4oN+VsrZALTpKENlh/oM7lXSh29MGjxzcUGiH5LICOTtXM+UzPkVMSnNZAERHF+gNEQ2Qd3OhFtYt5RzNuiqH8hubRHn3DPYCq0cMXmCjtjC1eBW4crAlXOWggt2uZfRgGwSHI5MNC0wZl96BIhNQPQ9sxaJ8Ktb5J35yHSJtdiFJ9n7wTv8kzooeAuWMmIGsAicUWfMoUvMCp7wms683K8UlLG4Ed6BPhqmGN/U0RypQ4MnbKJNIcu1Miivmpx1vqekIgjRngjqsS6dBHORPLKkHbt98VNMl8MA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(396003)(376002)(36840700001)(46966006)(6666004)(8936002)(36756003)(7416002)(82310400003)(8676002)(1076003)(26005)(426003)(966005)(5660300002)(70586007)(70206006)(9786002)(336012)(7696005)(478600001)(7636003)(2616005)(186003)(82740400003)(2906002)(356005)(36860700001)(83380400001)(36906005)(110136005)(47076005)(921005)(316002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:10:17.9354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a662ed-86d9-45ae-843a-08d91b66b498
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5824
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This series Adds FPGA manager driver support for Xilinx Versal SoC.
it uses the firmware interface to configure the programmable logic.

Changes for v4:
                -Rebase the patch series on linux-next.
                https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Changes for v5:
                -Updated binding doc's.

Changes for v6:
                -Updated firmware binding doc.

Appana Durga Kedareswara rao (1):
  dt-bindings: fpga: Add binding doc for versal fpga manager

Nava kishore Manne (3):
  drivers: firmware: Add PDI load API support
  dt-bindings: firmware: Add bindings for xilinx firmware
  fpga: versal-fpga: Add versal fpga manager driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 102 +++++++++++++++
 .../bindings/fpga/xlnx,versal-fpga.yaml       |  33 +++++
 drivers/firmware/xilinx/zynqmp.c              |  17 +++
 drivers/fpga/Kconfig                          |   9 ++
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/versal-fpga.c                    | 117 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  10 ++
 7 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
 create mode 100644 drivers/fpga/versal-fpga.c

-- 
2.17.1

