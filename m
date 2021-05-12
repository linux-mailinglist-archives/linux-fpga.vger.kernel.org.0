Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2529337BCDB
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhELMwV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 May 2021 08:52:21 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:59040
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230280AbhELMwV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 12 May 2021 08:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl95Er+2AaO89qZYuiLhsd3i4qQwE3WJZ3O083fWXB5rFoXvR6Tt7ifc4r5ZSLHsC7qjMjBPu0zQ3w3LV4BD7uxf8w/nVRcFGpsfTPB5jpSjY8W541cPTe9xLje8CQeEKrk1BR9PLsC323OAQKWoyBq5tLahreHnqg9npb6x/9ZcG4VnIYKtjvcfgv3Sb66CB6SqqvnCVrnq9jVwtTv43zXFrBpEcMKRgguWcBsaZFyLb2jO+XZDcMQvrfQMybpy45o4vsrvks0YtQHu0g2QxAigqF/je7uhk2iQUTlkxg51K5/fwMZIn4NARQ/3djb5UBARosJlhyodlVdfp8CW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShAxb36fePLol1ISbBsaa3rAEECVqFkOu0+wktHo0lg=;
 b=PRchoPbfZTVZ23nT/+KDkd6/A/EUd9KLkRHx37NOXCoxCkv1Rmed7BvXNvtQWVs4gzcPh+wXxE24rNYTnwuS7aIuy1uc7zj/oT4db9jRpZItizKicR/s7yTk0x/4EWxUfoKhBkNEEzb1ovVEGu7qC4d1FJp5bA353wUQx4yyibtC2MTXtPS2jetonosJCuDcRUMACexEfxqd8Eg4jjM3JUL+FNL8gAOQVEg0bD72ATYTdQ3cVhq2aAI1tzjU2krr7cKWkvZx+ItOF/ttMGjcrGiFbwoafQ4QNQWg7EO5lzJ+WZJBcfN7EEvXn3/2sYsCpzffG67FJfgWJ1eiKIO8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShAxb36fePLol1ISbBsaa3rAEECVqFkOu0+wktHo0lg=;
 b=GoF+w4PBLqr2W1IYJehUWDcdoQDHTksuNgqixls/YJBpd6+Ra1ndKn1KoYdhnJZpja62JR2kt4Sye7S3td9GoJ/URUZlPQI3aHKMGow5aWBEGzHxkRw2dr+/PcVYQS5E1br3O5J2cx2q13uC5phnwCan/RIS0l47Hxfb0Koi/uQ=
Received: from DM6PR12CA0004.namprd12.prod.outlook.com (2603:10b6:5:1c0::17)
 by BYAPR02MB4182.namprd02.prod.outlook.com (2603:10b6:a02:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Wed, 12 May
 2021 12:51:10 +0000
Received: from DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::22) by DM6PR12CA0004.outlook.office365.com
 (2603:10b6:5:1c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.50 via Frontend
 Transport; Wed, 12 May 2021 12:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT003.mail.protection.outlook.com (10.13.4.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 12:51:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 05:50:55 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 12 May 2021 05:50:55 -0700
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
Received: from [10.140.6.60] (port=37340 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lgoKE-0002rt-4w; Wed, 12 May 2021 05:50:54 -0700
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
Subject: [PATCH v5 0/4]Add Bitstream configuration support for Versal
Date:   Wed, 12 May 2021 18:20:38 +0530
Message-ID: <20210512125042.30973-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ee86f43-1372-4cac-ec8b-08d915449dec
X-MS-TrafficTypeDiagnostic: BYAPR02MB4182:
X-Microsoft-Antispam-PRVS: <BYAPR02MB418215B73448661DA5601B0CC2529@BYAPR02MB4182.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lG3o+MeMMGQ6kLl1O7qcW79wF41lI0fPzNE6ykCu5Zm7lDieUIQykFMhL6i7aahdQipCLXjIlE1rIjzmUwwpCuNQXjqUPwItJtO+yEXuNFtUX+99LFdQjN7zczUVoyoAJRmayevRxJ7uUS/tJU0zYBGfg/SJchBTI+yIKWzCdhYsCMtjXMQrLTBoMrs/6ZWFzZM/trBWKPVnicsH+eToEJDOqKzlsqp6pmMTNnGtm0peyQ9qVi0K5HCXpN4I6mvHzLz6ANx6aEhHdTFrQgSV4mjTmmTuR0OnxqoOSamFtOmGj4ZYfKfoycxhCgRI8F1AXLEFRWZxPRzoY2emHuKoLVqqGfWkoJUBmXCC4HkGK6r1OP/6XxEHDQfen1gIwe3CIs6AUOd3A2QpXDaYkr2L937pTyeLLqbZzir+rsuRvq9yneVISyNIvEcWf7gSKFZcjw398TUUq8FNvEYLHmTkKG0g/AEHthptQNfZNgEolyYHIA519bEp5OK2IzVzdrUjTqeqdxBmM98uqke/kcLqzbcvIT0MB3Xwza5p7g4liRBdZP7JrF+SdXGovIARL45fS13V7yMBrYhtTLkmhkazLCafwIc+2VvTjipKMt2XTnWnhK2cT/qvG3oK/d/rvQrr0GQyNWjDgMUtUEh3FO+A8OD9gO9A2o+EsMA1xwqGEniqdTJxLfBm8Dl1p13tjNVVOVlGSYh3+Yy9kQRAjJXowyF8eUa8Ld2ZxjWzkfm3CjQsvzkKlf3+7/YPYVy7AI/4QkEyrDR3D6bdMaBZmGW5oYcekxQl7e/QZYtiNTkwBvfHA95j+wXrfPeIF70969h6AmiSxRRlTDPxF4WGuMoVw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(36906005)(36756003)(82310400003)(70586007)(2906002)(83380400001)(9786002)(6666004)(7636003)(110136005)(7416002)(1076003)(186003)(70206006)(8676002)(7696005)(2616005)(8936002)(336012)(82740400003)(921005)(966005)(26005)(426003)(478600001)(356005)(316002)(36860700001)(5660300002)(47076005)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 12:51:10.0245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee86f43-1372-4cac-ec8b-08d915449dec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4182
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

Appana Durga Kedareswara rao (1):
  dt-bindings: fpga: Add binding doc for versal fpga manager

Nava kishore Manne (3):
  drivers: firmware: Add PDI load API support
  dt-bindings: firmware: Add bindings for xilinx firmware
  fpga: versal-fpga: Add versal fpga manager driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |  66 ++++++++++
 .../bindings/fpga/xlnx,versal-fpga.yaml       |  33 +++++
 drivers/firmware/xilinx/zynqmp.c              |  17 +++
 drivers/fpga/Kconfig                          |   9 ++
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/versal-fpga.c                    | 117 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  10 ++
 7 files changed, 253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
 create mode 100644 drivers/fpga/versal-fpga.c

-- 
2.17.1

