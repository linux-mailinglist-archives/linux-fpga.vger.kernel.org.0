Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799314564BE
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Nov 2021 22:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhKRVGn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 16:06:43 -0500
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:3008
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233033AbhKRVGl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 16:06:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGGko2W2/EwFmvWF3VLtgp3bk9METBPWGi6azrl7cCQhKQq3oWATNOVwaxxadWbDCsVn/6IvPopIT2QqqZoX3ZM0jIagcNVq9xRsHFjiewVec71HFFcs8KBafFK2s5Y7t60RvHlCeflfYbW5PQTCdJhb8w966CVHc/UdRRFV+BnoRIRiJhsECME9qXcaBGAc1kJYT8/zZVX8M6BnJv4jkk04iKOl4SY+xqLIs8FUPBvElNumlz3I+KYrrdDfN40fWBc3c0UsCPw1OdQ1Y3ZKYosL1L6WbWTlR5+EL6SFUD1akxiay1eVG4T2N4xDh6pHqaMrbBx06jFXn81kFQLDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7Q4vNd0znRVPwo9gso9EKmXLAnz30P1D1TqhtUPNo8=;
 b=dTXnfKkdZdFjErI808rjQpN4W7YH1UIXt2Uo2ggm8g95wUPPIgmcOshQrJlh+3c82iwYTLGb2pS/FpyDugkreBUpt5P5CffDYEXympHdA9EiKaFoMBS3RkQf5MMJQGKmi/PnxDG5omQFeNBZcgqmOUkC2fEUsp38P+GZMhfPgZddSdexDa9DAtC6st+fnWOY8Q7+hiCzsFGiEgYan6/ITOUhY5qARYD395zs4T0BzX35NSRGN9EMNwI16+39xE/AquxcyeiUyZbJfwppi3Qt2WBH/2YyUjxQlEFRPgpo+rHnBZvTMLNWRajIHi01erXoWrawnCOmtaiYadWwIkH4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7Q4vNd0znRVPwo9gso9EKmXLAnz30P1D1TqhtUPNo8=;
 b=RDehNOOfFZ4bAqxOVKWNvJtC86Fgt8SiKQQt+AkITeQ94t1l7XzdbE+Nn5PBhSysvSNNlQbYB32ahk8UKhbegHGqPYgKIGeJt4ca/QAGAfsefbgWtFSF+8ngQ4+Zw9iwaFyLkNb5N/nJEUCu3aBPtQCPZHc6GJ9z/SjWzYgSJ0k=
Received: from SA9PR13CA0171.namprd13.prod.outlook.com (2603:10b6:806:28::26)
 by MWHPR02MB2830.namprd02.prod.outlook.com (2603:10b6:300:107::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 21:03:38 +0000
Received: from SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:28:cafe::73) by SA9PR13CA0171.outlook.office365.com
 (2603:10b6:806:28::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.11 via Frontend
 Transport; Thu, 18 Nov 2021 21:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0029.mail.protection.outlook.com (10.97.4.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 21:03:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 13:03:36 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 13:03:36 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=37748 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mnoZE-0007CN-O9; Thu, 18 Nov 2021 13:03:36 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 5CB5A600093; Thu, 18 Nov 2021 13:03:36 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>
Subject: [PATCH V1 XRT Alveo Infrastructure 0/9] XRT Alveo driver infrastructure overview
Date:   Thu, 18 Nov 2021 13:03:14 -0800
Message-ID: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb480ad7-fc18-4981-f519-08d9aad6e439
X-MS-TrafficTypeDiagnostic: MWHPR02MB2830:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2830461B44E7A270D77BBB40A19B9@MWHPR02MB2830.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dqw+NYqCCSiprmPXrckmc+Hia0ZibcWk85OiuFhmFyNXbCC4RdYm5A1p+IgWnJ5UNpMtTg2caC/nipzkSd6TONavDoGJk3HyRD2zbvTYyv3ZCXkPvbAeVXp5cibgOk41Wjgi7XWZwSkBAxa0TIhJKpmxbVs1JkG5/66dwFvryOWbJBm7EjWKaQM+VBk+utAqFJXeJxBsqjjb7AMkL01B0TSd6vQ1Fc/qGX8cTE5onwdDiTCcs9DydNLvSqpHJzEnR0lxGtF3tTbK8gWB0xBAOz+FIfljB/nSlJZur2OagG1I4q08oOzRC+W9LHLfTz2rFfwfLYYaloaFW5/Ry4v5nA10geZPRJ8jicvDUMo1ihV6A2rjZuNyLsmdECWH5sxD9pweZahuhNGCSYvzibNmzZM52/I/Jbhw0PvLYKLpG57smGH/IuSX/ZVgcRb7nYWUJU8WJeHpqQNm2WRkysf8kn/sEtF90/fJWaXQNTjtCPa7IFU+WGbxEB/c/sjas9TZdZ8AMvnLt1d2DuoY4M0eJ7JEgx84Mj5y6tc1dNtuoEankMEPmlv2Y62j6BsGHcYP2Gyu6ITEnUYOHpClHq+aKyURVLLyJLpMYOFXwyos7g7twVLxh6qJ6LZCD295+A2JZANbdqhMJfRUHzIlM1DiLpZI6ZkS04fB4iL8pbv3TCdMOFBqMVKmjCO/VqEZrmGC6AClT3q0ax9RhFb+TpljY9/p4y+mNKCiZq1G9qMLKICC+3/GDrzMQU4rqnjGwhLn6LydwIacyjWnkqIXswwHptKL5omwRlhXg7sfHLB+N7Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(8676002)(6666004)(26005)(426003)(336012)(83380400001)(5660300002)(186003)(44832011)(82310400003)(8936002)(36860700001)(7636003)(356005)(2616005)(6916009)(2906002)(6266002)(4326008)(36756003)(316002)(42186006)(966005)(47076005)(1076003)(36906005)(54906003)(70586007)(508600001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:03:37.7563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb480ad7-fc18-4981-f519-08d9aad6e439
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2830
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

 .../bindings/xrt/xlnx,xrt-group.yaml          |  59 ++
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
 25 files changed, 1651 insertions(+), 2 deletions(-)
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

