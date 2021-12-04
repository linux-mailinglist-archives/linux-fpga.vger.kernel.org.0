Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66449468160
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Dec 2021 01:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383755AbhLDAnp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 19:43:45 -0500
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:45856
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236492AbhLDAnp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 3 Dec 2021 19:43:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMvobHHPRk90NZCgiSygFJFZG9X10iHterhz71XSzv51PthZHtz3CxiQdl+0V4MwegzyQ2wLLJrPtiGqRQQaYNNKfr04tnFK/Ira60etu6xaBzPzGCm4d8ZDwB2u7e2Z0rNm/kbQt24NX/wLFrmz4gcFAPpJVnH7L5p6dP6Lv6ZCrP7/27M1rEEWHWN1Z01a8EsFbF8P7THOM4DtHBdrgsQUbhq1Nss7AhiDkUBBZSDQ7xj9i3oSH6SwGB+1f9BPSdECrkTLp40Tp/gaBIKrHH7HYPT8B0xCG3O0iCX4P5rfK68FaErC/kggvPsttGsIUF8QBKA+3txm+di2pcUG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D6AMPo9+xEbpsNJZTJDosl7uIKGd5tJKwC8Yw8whWo=;
 b=Mvitg+S48/fh5Pozy4rHM224PV9oXRqj6Yf6KyMPfkxL7RFjT+mCZNMxK1Mo8CqWtTXOLAww0grKyNYW+B69Mk5Fc7v720wRdlQStw5KH881DNmdnJIxipFkxx1mbQIP56ntcfHKx5eImmgS3N8/wJrtLCC8B03D8TsLqeUPTQky3Kk9BnB9CzUq2sxBHZSOq2kPk6TzkyHRN25NuAVdAiaO5f07CS4Up7loKCwhmPwFae5yl5yiS66pBPvj3riH19+Ysk+o9NPgyuRdwd6A8i4UaZugEkcHEAsdOauYBt42WRhXZgNoVxh96f21jfHoh9xjXg1e+4AbltANwmx6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D6AMPo9+xEbpsNJZTJDosl7uIKGd5tJKwC8Yw8whWo=;
 b=nMZV+A5pPJelQJsutiKlJFZPk/lJ02/RSHCrQR8qT2tkAvJZkTj2xx9ZBFM2YuyCNYr0ckJH6EGBvA4wo0VMvKQV4IOAjqf8BkBEf/SpYMyj+6nZV/U/4+PTqbct8bRmNhC3048kCZo7luP/1sIs7isQUYvh7oq4JKVQ8xwrd+c=
Received: from BN9PR03CA0936.namprd03.prod.outlook.com (2603:10b6:408:108::11)
 by BY5PR02MB6881.namprd02.prod.outlook.com (2603:10b6:a03:21d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sat, 4 Dec
 2021 00:40:18 +0000
Received: from BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::5a) by BN9PR03CA0936.outlook.office365.com
 (2603:10b6:408:108::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Sat, 4 Dec 2021 00:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT033.mail.protection.outlook.com (10.13.3.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 00:40:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 16:40:03 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 16:40:03 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55508 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mtJ5u-000D6o-4q; Fri, 03 Dec 2021 16:40:02 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id F115660083D; Fri,  3 Dec 2021 16:40:01 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>
Subject: [PATCH V3 XRT Alveo Infrastructure 0/8] XRT Alveo driver infrastructure overview
Date:   Fri, 3 Dec 2021 16:39:49 -0800
Message-ID: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc189130-8346-46a3-a3a7-08d9b6bea45f
X-MS-TrafficTypeDiagnostic: BY5PR02MB6881:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6881F208967D0EA7C7DC7432A16B9@BY5PR02MB6881.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cgEipxwVXEgGd/AhexpVyF7IbWzsMEeHaBgiaS2S2QqoYz7BG1NT+3PUJilS6Q6PjHLM3dEz2AsZIfLGPMqPR91B9et6mixsqglgRQyoYrID/1oq0Fiy7LDZ/WoiMKB/XyQ8CEol3Y9I+CziM4fZe3i3BOjtsP3Z+GyGme+dv8HlZ+Nzq7bmV5UxWhqxbej/GoMYjDSy+rpCLU/i5OAopBPm8b0Pp0V+LuAh5+dWKMc62TknVUhsvPwsUD44mH1zUsbs/DYxnaE2chuoH1Z4bkg9Qpo2CB0OAIEPDYkZotZmk6zCpQgjMY1mMqVKufxxl3Ok5Tx9KzV4M+BYmBTlMD2Zwr+iX7+NGS8cw9Ae8vnGY43y8mTnO7Ke2vqC+/lV+P+Z1cjDPMPr/Ex7n3O7W2xhjXnc0L7pf6dOm4ErZpVFgErsawT3HevuHJMdPioN0P9R/kDVaJpHz007eELwO3sMTf5XU95HJxzJE3jK3d9nyKLjiHIzZgcTb28JK8i1Iq0tqmqekOGc3W9EC2kM9EUoaRNtnZ2LDtlUxp5oj52WGzW9ZQdV+hGNqpmBlPprNz2WRg/NZMwcy7mO2X4XnVJinrx0gnqtwjsojS7fwCSHKhIJ/rE7iQXZnRxa9NV0Cvg9RTRBYY3KtRCpIcLsA5w81KawXzkfXz02uH8DpdBM9VdiuwLy430I2JMbtle31QN5iAA9houKJ3Ao0GFRgr+eBrisE1t+vkOztr0yzIL/a3E1Dw9xbvKvluDAhSfKdkFT/OBPGkhebVm7zdXERGB5lrBLB1vriMzLI4IMQY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(6916009)(6266002)(5660300002)(426003)(7636003)(4326008)(2616005)(54906003)(2906002)(1076003)(186003)(70206006)(36756003)(83380400001)(508600001)(356005)(26005)(316002)(70586007)(966005)(47076005)(336012)(8676002)(36860700001)(42186006)(6666004)(44832011)(82310400004)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 00:40:16.6158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc189130-8346-46a3-a3a7-08d9b6bea45f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6881
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This V3 of patch series is the infrastruture of previous submitted XRT
driver patch set for Xilinx Alveo PCIe accelerator cards.
    https://lore.kernel.org/lkml/20210802160521.331031-1-lizhi.hou@xilinx.com/

The patch series includes Documentation/xrt.rst which describes Alveo
platform, XRT driver architecture and deployment model in more detail.

The Alveo PCIe device uses Device Tree blob to describe its HW subsystems.
Each device tree node respresents a hardware endpoint and each endpoint
is an hardware unit which requires a driver for it. XRT driver
infrastructure unflattens device tree blob and overlay the device nodes
to system device tree. of/unittest.c, pci/hotplug/pnv_php.c and other
linux kernel code are referenced for usage of OF functions.

XRT driver infrastructure implements xrt_device and xrt_driver for Alveo
endpoints. An xrt_bus_type is also implemented to bind xrt driver to
xrt device.

This patch series uses a builtin test device tree blob which contains only
one endpoint as a input. The XRT driver creates a pseudo group xrt_device
for the input device tree blob. And a group xrt_driver is implemented to
discover and create xrt_device for the endpoint contained in the blob.
--
Changes since v2:
- reversed the change of of_fdt_unflatten_tree()
- unified default of_root creation with unittest code

Changes since v1:
- fixed 'make dt_binding_check' errors.

Lizhi Hou (8):
  Documentation: fpga: Add a document describing XRT Alveo driver
    infrastructure
  Documentation: devicetree: bindings: add xrt group binding
  of: create empty of root
  fpga: xrt: xrt-lib initialization
  fpga: xrt: xrt bus and device
  fpga: xrt: lib-xrt xroot APIs
  fpga: xrt: xrt group device driver
  fpga: xrt: management physical function driver

 .../bindings/xrt/xlnx,xrt-group.yaml          |  57 ++
 Documentation/fpga/index.rst                  |   1 +
 Documentation/fpga/xrt.rst                    | 510 ++++++++++++++++++
 MAINTAINERS                                   |  10 +
 drivers/fpga/Kconfig                          |   3 +
 drivers/fpga/Makefile                         |   4 +
 drivers/fpga/xrt/Kconfig                      |   7 +
 drivers/fpga/xrt/include/xroot.h              |  30 ++
 drivers/fpga/xrt/lib/Kconfig                  |  16 +
 drivers/fpga/xrt/lib/Makefile                 |  18 +
 drivers/fpga/xrt/lib/group.c                  |  94 ++++
 drivers/fpga/xrt/lib/lib-drv.c                | 249 +++++++++
 drivers/fpga/xrt/lib/lib-drv.h                |  28 +
 drivers/fpga/xrt/lib/xroot.c                  | 223 ++++++++
 drivers/fpga/xrt/lib/xrt-bus.dts              |  13 +
 drivers/fpga/xrt/mgmt/Kconfig                 |  14 +
 drivers/fpga/xrt/mgmt/Makefile                |  16 +
 drivers/fpga/xrt/mgmt/dt-test.dts             |  11 +
 drivers/fpga/xrt/mgmt/dt-test.h               |  15 +
 drivers/fpga/xrt/mgmt/xmgmt-drv.c             | 167 ++++++
 drivers/of/Makefile                           |   5 +
 drivers/of/fdt.c                              |  61 +++
 drivers/of/fdt_default.dts                    |   5 +
 drivers/of/of_private.h                       |  15 +
 drivers/of/unittest.c                         |  70 +--
 include/linux/xrt/xdevice.h                   | 128 +++++
 26 files changed, 1703 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml
 create mode 100644 Documentation/fpga/xrt.rst
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/include/xroot.h
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/lib/group.c
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
 create mode 100644 drivers/fpga/xrt/lib/xroot.c
 create mode 100644 drivers/fpga/xrt/lib/xrt-bus.dts
 create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.dts
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c
 create mode 100644 drivers/of/fdt_default.dts
 create mode 100644 include/linux/xrt/xdevice.h

-- 
2.27.0

