Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD73A45789D
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 23:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhKSW1V (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Nov 2021 17:27:21 -0500
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:58176
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235458AbhKSW1U (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Nov 2021 17:27:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkSUPwhZXTgF9Z9nHkmxiIJgga/lmZAZdoHZxT5sBp+EskymDH4M6IBuEwwL+/wq5HYZjEUNSm4QlvohujMe/olPusurPtBsjPqTmh5E0iEGE8Q6L1NaKBCqVknRSQ4D2yn4nUYUJoFX80fKrNlzS+NXEwYAds7MXXwkebkAlA9HDCzgsYVMiNy1Bz8rGsueGZBvOcugGomaMHMiqjucPGHWdyC38Rfln35mAMUTMXAKMH6VrMRLTHyS7lwgf4hZq9YLtUGpJzLWZnJy7uSNqqIEpSmQDi3mjg9kdKwH4TiA6ImtDKsE4X8iFLavIJRtMuZVe4ffxA8vBESV6D8GEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRtToOi2FmhPx9zf5bMTkEW7m5/3NiEb+B2GOiZlzsE=;
 b=O6/YlqvYtmS1suXkufSB2P/J0l8uIGmGoz8skwZB+49pFG3UtyM2dXUYMSoog5ryvNQlXqV4F8tGhsWo2LT3/NDpz5sif6ZOGR5kWWcWafvWZfWJlSFTQ4jzHVdMQnZ+0LtlRlO++AMob7eurg4L2PZxdE+LwfmVZcY1L/4yANnKfAMJRc8l1s4z2vCfYvKf670uMZ/TCuJeNKpBt0HcD9OHmbr3B9KxN0ON2+p5TOb6okLZHIMhraqwB26ASHwFp4IEvGAWzirVncqufDOa2lMKNsCQ/3JDSa7AZeEMJhnzXHxPOkM0uD5pC7IcDNvP6guQ6dKyctqQ75SiBgvPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRtToOi2FmhPx9zf5bMTkEW7m5/3NiEb+B2GOiZlzsE=;
 b=dNdzhQVcDCKVJv+8R3IAX+4gUYYeEmYkkOY0lL8psvWBezKu9tZ1EqKvDWD5QQW0VB2Y616JjJIQ0kK5Zp/FaQ5a3shK3O5ZpCXW/nhC7af32Qs2LCBT/YX3F4NL8VD/1Anq7jiz0Hax8piPXrPLcehhLNifdrEu05Cofol+kAk=
Received: from DM6PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:40::41) by
 CH0PR02MB8136.namprd02.prod.outlook.com (2603:10b6:610:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 22:24:15 +0000
Received: from DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::55) by DM6PR03CA0028.outlook.office365.com
 (2603:10b6:5:40::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 22:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT042.mail.protection.outlook.com (10.13.4.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 22:24:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 14:24:14 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 14:24:14 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=38930 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1moCIo-000ALP-QQ; Fri, 19 Nov 2021 14:24:14 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id AB1E8600139; Fri, 19 Nov 2021 14:24:14 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>
Subject: [PATCH V2 XRT Alveo Infrastructure 0/9] XRT Alveo driver infrastructure overview
Date:   Fri, 19 Nov 2021 14:24:03 -0800
Message-ID: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d4a989f-8433-433e-7c96-08d9abab522f
X-MS-TrafficTypeDiagnostic: CH0PR02MB8136:
X-Microsoft-Antispam-PRVS: <CH0PR02MB8136BD27292A4B145D082CE9A19C9@CH0PR02MB8136.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NnwvkCu7XkXq+w7K4JbS9A/UdllA34YONafDeunoom2Qg+Fl4Dk99yfvkj1h2mPx6924kc6SsjgkMaxjvoGMUzr2PW1hcqnsPUm+kfVQVwFYw5HIv8JLT6K5p7zKsm6cl3ilkhy/2O1Fy+qsY2f+9CBlTRXALnAyZT8jAbGgi6nirkzreqPVeX40fQltlX5k/37bPHuj1ZqZwffObVkbT4ho+UeAxR7Pz3IWCtUMk7EEaCqyD45e8UoQlc/DIO3A6fChULAeh9RJegSQObXZDJuwPqKwMwlA70DolZ4BeAk19n6MdoZ4UMdtOz+HC9kGlsDDrGJHmC7ydyNL8ZxHk+vwop36YraLzxLraSoDUOuV8xoukEwTDiMxNxGDszApq45cw9ySOXZXzOwTHtILvEbCfZhdZCtiUVDOBxhFBKqcOR7KfFL6g1Up9qi0y+QjCh1NeirCjX2Yq+sczbDXdfZ9JIHOGHBsyBSRH/za6i8kdf5Ba8mQ0yJuJfQtDC7TcKKzlSsRFxKA5CmWlLiSECXMnzo+rSrDGwZu0EjCvLhfuBENxxbK1T7ZXDnk+CCA9MEhvvlhDgnZmamQQxZeLn3AJO2u5cPYfAQwPbweZuQ4pHTPCt9mURin/kQNqKWOBfybllkdysL0RsRiq8UD3swJhzxSwBtMq06JHR9VIX+JP1SPfWS6WppxwlKw3oQaDZGcN67MPi7QQnOEWW41/YOeipYz6M+MCyh3+DnFCHRX8O6RbUM1DAySwqOmO/LbykjN7pOOaXbzHK6iI8Df8IqT6lUu52n23cQNFbpqcs=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36756003)(36906005)(2906002)(316002)(336012)(70206006)(42186006)(966005)(508600001)(7636003)(44832011)(4326008)(426003)(2616005)(6266002)(5660300002)(8676002)(1076003)(6666004)(36860700001)(47076005)(186003)(8936002)(26005)(83380400001)(54906003)(70586007)(6916009)(356005)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:24:15.5327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4a989f-8433-433e-7c96-08d9abab522f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8136
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This V1 of patch series is the infrastruture of previous submitted XRT
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
Changes since v1:
- fixed 'make dt_binding_check' errors.

Lizhi Hou (9):
  Documentation: fpga: Add a document describing XRT Alveo driver
    infrastructure
  Documentation: devicetree: bindings: add xrt group binding
  of: handle fdt buffer alignment inside unflatten function
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
 drivers/fpga/xrt/lib/xroot.c                  | 210 ++++++++
 drivers/fpga/xrt/lib/xrt-bus.dts              |  13 +
 drivers/fpga/xrt/mgmt/Kconfig                 |  14 +
 drivers/fpga/xrt/mgmt/Makefile                |  16 +
 drivers/fpga/xrt/mgmt/dt-test.dts             |  13 +
 drivers/fpga/xrt/mgmt/dt-test.h               |  15 +
 drivers/fpga/xrt/mgmt/xmgmt-drv.c             | 166 ++++++
 drivers/of/Makefile                           |   2 +-
 drivers/of/fdt.c                              |  37 +-
 drivers/of/fdt_default.dts                    |   5 +
 drivers/of/of_private.h                       |   5 +
 include/linux/xrt/xdevice.h                   | 128 +++++
 25 files changed, 1649 insertions(+), 2 deletions(-)
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

