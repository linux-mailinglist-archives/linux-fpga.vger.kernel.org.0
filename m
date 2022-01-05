Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAC485BD1
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jan 2022 23:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbiAEWua (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jan 2022 17:50:30 -0500
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:43841
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231808AbiAEWu1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Jan 2022 17:50:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSdXM7ybP2cRbPvYHL2l1DkGw2qQfo000Mw+bjkZYC+7ESTjnP/vSu5l3HSBO/XYyq/SfVNLFPRK3nVIrf+i0lLpTFmD7xGYFVjQDvt7PTQE6E2CnrrYr9hc3b1nmUFf2O9595ZL0PRfN5B9xTO3GCLM5AjAHw3Sn4dxjgowxqG4s8rHyRUy5gyqN0yRjS4WY20canso5cbN3W/dg/jeCr5H1jYFhHWB2Zal5zR5pjN2uLiU9ArkThkXKUH39DaXkY0paOpcHoP5WNAsv7Dn+W2dCZvl0Vi6I+jvnCo+70DsTJw414s7R6ZKYiZ8+z0Llfa0B54JrcJ+f/4ocUJJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pas56UL0W5c5UepgdKE1I+cdmcR/xWose1QOqimgeG0=;
 b=XLOvjVTmF+WX0zCChu4njyp3PMfyqUAAdkdVuJWKMvyKfJCzFdAxBpngUYo8UVynR/iAZq2YoUgABGeOj4THvmctgB7IKFxkgfVmVj2pGmQrpkSNrrqe4zjFHzG1Q8s3ji3qFg3QifZfflf5KYqDjUY6Ykv6FHKw9q/i4KCguQ3FYQC7NL0D8TYCetYMM8DnEfHttK/wdbONCcP7/jOUPsXwPCVmKYISO2eKnscELX3jaKSV9W9SLmHROq566sFKmmeOUadUMXppeCyWy86neECJJM4SQYtLJ6FmqkrUEZ3SyUugvykjHuAkWKgY+Hvwz87Uh5ScppBwZpkgmcyABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pas56UL0W5c5UepgdKE1I+cdmcR/xWose1QOqimgeG0=;
 b=aiRUpXQrmsPR3Gfrx1Z8F/msUn1hMU4bvAWErBSa6qSSSELrA1E4vc5AtM+O3lyJen4GiEh4l2MKMetC/FfKNTMfFFdx/7bUe0QfmbqOB14UJYRDsV/0hrP+HzA5bOGaMDmfPPnI2KxRUQF9W77GjckuesLgThUFKzb+oTPyV8c=
Received: from DM6PR03CA0042.namprd03.prod.outlook.com (2603:10b6:5:100::19)
 by BL0PR02MB5650.namprd02.prod.outlook.com (2603:10b6:208:83::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 22:50:24 +0000
Received: from DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::c3) by DM6PR03CA0042.outlook.office365.com
 (2603:10b6:5:100::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 22:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT034.mail.protection.outlook.com (10.13.4.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 22:50:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 5 Jan 2022 14:50:23 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 5 Jan 2022 14:50:23 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=56772 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1n5F6s-000AlG-Rb; Wed, 05 Jan 2022 14:50:22 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 77B55600860; Wed,  5 Jan 2022 14:50:22 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>
Subject: [PATCH V4 XRT Alveo Infrastructure 0/5] XRT Alveo driver infrastructure overview
Date:   Wed, 5 Jan 2022 14:50:08 -0800
Message-ID: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac2ffff6-523f-44b6-9b44-08d9d09dc283
X-MS-TrafficTypeDiagnostic: BL0PR02MB5650:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB5650681404CC8C7940B8D0EDA14B9@BL0PR02MB5650.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXUL3otRpSorz0kGja7M5yL5S9NMZJXExesRiHXmnBK7FMuUn5qLDkT9umwxsykHxWoCtESfFuu9hUvlb1aCbTxwtpVCxlkdt+0HSsyR0X4UZ64wegZjI9syMGG6BdM0n/Gz7nDkn1Dr9MNAC4AGNiFLIfx8nxZBqh4ia1SA3ZA24IqlHcJwU63yWJ7eEbqaTR9CvYyYBlhzabpzbX/YXPQZUSJc4j/YNU2IGORo5X1hojeNvJV5t9AtskwNuJSzMp1FayWqif5ohMCLBWKf0VR8UnUc96plsNt4N6usX34iTNlPKJyCKF1d9hN8ciRYFwlE1Uc8bksWOCvC5+AqGNPwYbDW9oCs7J3jsftv82SAalXlp4Qi4kfLDG0Tx3YmjJfh7wbYTxaJs/+BU2/p4rQ/oE1PtzSi+KNzAKhzea7Fe7cQYZ5A7fuSl5sUyrBqr1zdsmi3uldCUO7Rl/6C2/h4ZIQzv90GuVYwGYAWjSjFd8Gy0GaJXlOJi3bymU6UTg9xF8H9oNDeAKUbwxLsmgFai8q3rTIYGbmG4ztnhJXM/C/cBrYLl7wRlYmjpaBvib9xViXQ9cb7QL+3kiyJVLpExd/KDFZ5/5cgurDS28ji3p/8aDmgmny8R7rY5fWV18VoMTyuaTP70hiiF5K0pQ1cFRfm1tWKoIx1piZfasU6jwuDkmOFtfF9owhUZ3qRZwmkWciOsmszCVwU5nOJBe2zzlvcvWFhkr+vUPnV21tI6x+tpXsR2pNVnUuXoYvFOqaAc7KIic5Lj3+A/rq/sm1FdEpX7zhein7yIoaB+WzEvo+mJygZXaB2NvN1WIW4VhBau94mVjxt2xncfXnzzA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(1076003)(336012)(83380400001)(4326008)(316002)(6916009)(5660300002)(47076005)(186003)(44832011)(42186006)(426003)(2616005)(82310400004)(36860700001)(7636003)(966005)(8936002)(6666004)(70206006)(508600001)(70586007)(2906002)(356005)(36756003)(26005)(54906003)(8676002)(6266002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:50:24.0546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2ffff6-523f-44b6-9b44-08d9d09dc283
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5650
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This V4 of patch series builds the core infrastructure for Xilinx Alveo PCIe 
accelerator cards. This patch series incorporates feedback on the usage of
device tree for describing HW subsystems or endpoints as they are called
here. An endpoint is exposed as an addressable range in a PCIe BAR exposed
by the Alveo device and optionally includes an interrupt specification.

The patch series includes Documentation/xrt.rst which describes Alveo
platform, XRT driver architecture and deployment model in more detail.

The Alveo PCIe device uses Device Tree blob to describe its HW subsystems.
Each device tree node represents a hardware endpoint and each endpoint
is an hardware unit which requires a driver. XRT driver infrastructure 
unflattens the device tree blob and overlays the device nodes
to the system device tree. of/unittest.c, pci/hotplug/pnv_php.c and other
linux kernel code are referenced for usage of OF functions.

The unflattened device nodes will be populated by existing Linux platform
device and OF infrastructure. This means a platform device will be created
for each endpoint node. And the platform driver will be bound based on
'compatible' property defined in endpoint node.

This patch series uses a builtin test device tree blob which contains only
one endpoint as an input.

--
Changes since v3:
- Removed xrt bus type, device and driver. Instead, the device nodes are
  populated by existing platform device and OF infrastructure.
- fixed issue reported by kernel robot

Changes since v2:
- reversed the change of of_fdt_unflatten_tree()
- unified default of_root creation with unittest code

Changes since v1:
- fixed 'make dt_binding_check' errors.

--
References:
- V3 version of patch series.
    https://lore.kernel.org/lkml/20211204003957.1448567-1-lizhi.hou@xilinx.com/
- XRT V9 driver patch series before major restructure.
    https://lore.kernel.org/lkml/20210802160521.331031-1-lizhi.hou@xilinx.com/

Lizhi Hou (5):
  Documentation: fpga: Add a document describing XRT Alveo driver
    infrastructure
  Documentation: devicetree: bindings: add binding for Alveo platform
  of: create empty of root
  fpga: xrt: xrt-lib common interfaces
  fpga: xrt: management physical function driver

 .../bindings/fpga/xlnx,alveo-partition.yaml   |  76 ++++
 .../fpga/xlnx,alveo-pr-isolation.yaml         |  40 +++
 Documentation/fpga/index.rst                  |   1 +
 Documentation/fpga/xrt.rst                    | 337 ++++++++++++++++++
 MAINTAINERS                                   |  10 +
 drivers/fpga/Kconfig                          |   3 +
 drivers/fpga/Makefile                         |   4 +
 drivers/fpga/xrt/Kconfig                      |   7 +
 drivers/fpga/xrt/include/xpartition.h         |  28 ++
 drivers/fpga/xrt/lib/Kconfig                  |  17 +
 drivers/fpga/xrt/lib/Makefile                 |  15 +
 drivers/fpga/xrt/lib/lib-drv.c                | 178 +++++++++
 drivers/fpga/xrt/lib/lib-drv.h                |  15 +
 drivers/fpga/xrt/mgmt/Kconfig                 |  14 +
 drivers/fpga/xrt/mgmt/Makefile                |  16 +
 drivers/fpga/xrt/mgmt/dt-test.dts             |  12 +
 drivers/fpga/xrt/mgmt/dt-test.h               |  15 +
 drivers/fpga/xrt/mgmt/xmgmt-drv.c             | 158 ++++++++
 drivers/of/Makefile                           |   5 +
 drivers/of/fdt.c                              |  90 +++++
 drivers/of/fdt_default.dts                    |   5 +
 drivers/of/of_private.h                       |  17 +
 drivers/of/unittest.c                         |  72 +---
 23 files changed, 1066 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,alveo-partition.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,alveo-pr-isolation.yaml
 create mode 100644 Documentation/fpga/xrt.rst
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/include/xpartition.h
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
 create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.dts
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c
 create mode 100644 drivers/of/fdt_default.dts

-- 
2.27.0

