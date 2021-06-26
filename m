Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3273B4F47
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Jun 2021 17:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFZPz1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Jun 2021 11:55:27 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:52929
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229657AbhFZPz1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 26 Jun 2021 11:55:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJxcxH5+aVjUJ5HIYhDLgzItV9NbsiJWAqBT+sxcGWhzK4md1FV9aGpf+82YdZjYWlcjnnZK6xYhjDTWo7daSX9HWaLYV9SabmH8Ptp8A99FrO/DzDdJFBMqQynxUhcM0NUgZVCbj3cc7v0OK+CMF6k+P+ss9RnybgVfOtKikgy0FNAFrf817Fr/pz6iSLyeo9pl7QD7P29OtBiwGwxl5XtigWmahf5fbm/5lW8LttdYOR2dm8pyENQXIbTCkyMB4+q0YwDyYI/xt42PEc2N0GwSwXpR+NereZ4PwT+L/s7rzPoExmCPUMZXunzv2mzIiCTvF02Q4ZkUVb54S7tdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70ugJnymheOG6ilWzQRbRZL8yPp7e6Ssfyd37HgUhrA=;
 b=muTnjZR2VjxucXhtjTFzH8PDHCGDehQ0X8xWveMY6HK6NfqK02cJVVW6sE86vAUZoZMjv0jcTECGYpjSGwO+chbm3ZzCYPUfVqxxF/Oi6jR1UenOaSvcGtzJSFHyNmWcmTUcjz/3CiAaZtvDlEG67QDBDN71YR8uQ3pYqGEBagmTb9hxO8N1xhqVv2v6PQyns8QcVZt/rK1u6I7htmYc480eFvXE5C6bvxVgEhTOMQsZywdK8Dd4AM06KJ7sT1EVXPDYicAoWDZnJNfqLVLP9FB13i0J8wOK2n9tZkPCLLUJmKqZI60YYtjaBCE2fLwGzNkg65dDdcG1XzuCghg1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70ugJnymheOG6ilWzQRbRZL8yPp7e6Ssfyd37HgUhrA=;
 b=ZvIrBAsgpqUUjlbxoFYldf+00qVKY7mbnKVlLjHyF9D66P+SqZ/uhpnA+GPA4gm4wYjrvahxpyQzDlHJIMD5OffLOXDL+coJu0prRy43m+rRvaS0J62qeHufH7D1Fq2UZz/J/+9VqWAhhkBMopsJSsrx2Qwm0LVGUU+nZAy4EKM=
Received: from DM5PR17CA0053.namprd17.prod.outlook.com (2603:10b6:3:13f::15)
 by BYAPR02MB3992.namprd02.prod.outlook.com (2603:10b6:a02:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Sat, 26 Jun
 2021 15:53:01 +0000
Received: from DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::5f) by DM5PR17CA0053.outlook.office365.com
 (2603:10b6:3:13f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Sat, 26 Jun 2021 15:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT052.mail.protection.outlook.com (10.13.5.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Sat, 26 Jun 2021 15:53:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 08:52:57 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 26 Jun 2021 08:52:57 -0700
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
Received: from [10.140.6.60] (port=59432 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lxAc3-0000uY-Se; Sat, 26 Jun 2021 08:52:56 -0700
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
Subject: [PATCH v8 0/5]Add Bitstream configuration support for Versal
Date:   Sat, 26 Jun 2021 21:22:43 +0530
Message-ID: <20210626155248.5004-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50da772-016d-45eb-79b2-08d938ba7a3a
X-MS-TrafficTypeDiagnostic: BYAPR02MB3992:
X-Microsoft-Antispam-PRVS: <BYAPR02MB399280D262789A7ACAEDF8A6C2059@BYAPR02MB3992.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umOc5gYXXMJfNhbq7SdnrLcHI39imN5ZYsWRLLNyEKqeypXuYfXoQeWmidnNnPCYUdFdXbsFaMS8FcDYGDE0VwuCga4WBF7DAzVyamxpSEAqBListqd+AZ3Infqitgd3U1ljQOh0+SEH/6Xhfuo140MYsu2xMXqpf/qdI+SC6JGADzfzSV4iI3kSEOPlrO79+2lKhhlakYOCHaveqjz7PAL5wXBxylTwqT5vt1DI26TKlY2j3IkZtHBCjbxofaQUII+/v+x2XLDpq4oSIIxGKgQPu9iITmM1Vg3sfP48BCvT6ed79dGsUS1qbxEMo8ewrXQH2zii5zLoB6u7KwrqSNqUDuKkVnHhhloIn2ck5ggPlj9cGNYMbHWad043rOMSzTrdOvJDb81Kxlqg39QQcjHYc9fslg2QZYpgXKBUGF2HoWhzp4WXCEaw1ARD9RahbmT4JXxrxLnSY9MAsFwYAILIYopLWSl0z9cSJPoU7ufbltQRKUmE4TgYk2HkZJYoiz1SS7GYZp8yDn0uGHSAizjVs713LBztvGx0t3/PzccAzTKhDb8lvFdMoRhMF/gWGYDT5SZO1xtWIIYjNkkhilk50pFJI2HnLHMCJOKFg7UkoqQVF+uw8L/k0E5DqDP0DSCrm9frfJm9bNy33s21frE1ih9VQsdeVufOgASlR5D6j5YFUaC7dcRjxZ+34nrNTenLQRc7/F7hp6HLkKR2V7ACUQNaPUN0TkxULSt3O/r2ZY+Agi8xpTp0BZYskIGMxwwi0FE66Kw1KeJDiI+ljEN3OXCXUpBJdcVULalY4oFcEh/XVfz4mkDC3BBIyRmYBHRcZaBzGo6Lkl4MpZDqu691JfSv/rPT5lJSUtY20+M=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(136003)(396003)(46966006)(36840700001)(36906005)(47076005)(6666004)(7696005)(5660300002)(1076003)(8676002)(921005)(110136005)(2616005)(316002)(36860700001)(36756003)(2906002)(70586007)(426003)(26005)(70206006)(186003)(7416002)(83380400001)(356005)(82740400003)(7636003)(336012)(9786002)(8936002)(478600001)(966005)(82310400003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2021 15:53:01.4461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50da772-016d-45eb-79b2-08d938ba7a3a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3992
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

Changes for v7:
               -Updated versal-fpga.c driver to remove unwated priv
                struct dependency.

Changes for v8:
                -Removed xlnx,zynqmp-firmware.txt and fixed some minor issues
                 in xlnx,zynqmp-firmware.yaml file as suggested by rob.


Appana Durga Kedareswara rao (1):
  dt-bindings: fpga: Add binding doc for versal fpga manager

Nava kishore Manne (4):
  drivers: firmware: Add PDI load API support
  dt-bindings: firmware: Add bindings for xilinx firmware
  dt-bindings: firmware: Remove xlnx,zynqmp-firmware.txt file
  fpga: versal-fpga: Add versal fpga manager driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt  | 44 ---------
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 89 +++++++++++++++++
 .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++
 drivers/firmware/xilinx/zynqmp.c              | 17 ++++
 drivers/fpga/Kconfig                          |  9 ++
 drivers/fpga/Makefile                         |  1 +
 drivers/fpga/versal-fpga.c                    | 96 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          | 10 ++
 8 files changed, 255 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
 create mode 100644 drivers/fpga/versal-fpga.c

-- 
2.17.1

