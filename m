Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8043CF045
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Jul 2021 01:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhGSXLy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Jul 2021 19:11:54 -0400
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:44449
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388213AbhGSUqE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Jul 2021 16:46:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fefx6qnDMd8gyKSnqNl5XK4PV0wDi4xWLFo+tcuih64JIYIG+dJJwsfXvLF0j+kFXMdpXdMRk1cO1xCSTFEDWJun+xw4FTF2Xln9xlTxj5uIvejZ9JM0/M/16a6JOTcEKSs82UWOzMNmlJzOzc+CVl3RihdZJnBxd0x5oRB1xXG9YW9wxy4PWzbBLuty8gC3+O0/YCwcEcp69M2kE47k4bHVA5UuavywrCyYK0e9xzR1ajR7vLwKmgt2sQxKSb6nwDmvfWMNEkbiV7VIaSwsU57BQx/qU3AyVy/dNsrMnebpUkBK6zpM9EbPDIV9Dw2DqgFGwh4eFpROpZ6V8cX/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsSvWzvyp3tnYeW/TYvbEEjjtH18KkiD7YsKD3PQGRk=;
 b=BShFkb9UAgza9aqfs+Qi9j8UFYwJLgcYvcf88hW4wHcSfL3hp19N5xSGGIcfuF4rFe8lu7BdcVf583rc2UelpCATIBGLjId2rsKL6laATnxMbHHsvPKn6lrHmlVnoRYZ4JBcRyaGGSG+VOf9UtGZwXpAPreQMWCYjmZIdh7yB2Uy524XxHECFbxnHqVLkyyqapMea80gFBT9EX05PWaZ84ExPftX2raKB/kou8Qy7D2cEY7UXCdHOy0b++nHjx12dw8ALBWMzfE+Xo3tZ+s43mE1yVrgGAvbM17g1c0jBfdWkE8ko/fqPcJ1AAOEFyjqIxkQ9xz1bC9AUzRbnyHOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsSvWzvyp3tnYeW/TYvbEEjjtH18KkiD7YsKD3PQGRk=;
 b=mjbVCOvFP17049B/LS6SmoBj7zAWx+z1Pz/7gnGfa5sREERhEd3goZs5ENPgWdkDtdQg2x7piF3y022gahnhlaXDgqK0sQA6AuJq1VeB3uLOVehEyKJiZKnLnmXoQlm1fR8Uwvzdl4l9DcXI5akgFxpelBNWiYo2belDZi9m6S0=
Received: from DM5PR20CA0004.namprd20.prod.outlook.com (2603:10b6:3:93::14) by
 BYAPR02MB4856.namprd02.prod.outlook.com (2603:10b6:a03:51::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.30; Mon, 19 Jul 2021 21:26:36 +0000
Received: from DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::32) by DM5PR20CA0004.outlook.office365.com
 (2603:10b6:3:93::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 21:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT020.mail.protection.outlook.com (10.13.4.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:26:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 14:26:31 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 19 Jul 2021 14:26:31 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=38264 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1m5amV-000F5H-LV; Mon, 19 Jul 2021 14:26:31 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 3556060011C; Mon, 19 Jul 2021 14:26:31 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>
Subject: [PATCH V8 XRT Alveo 00/14] XRT Alveo driver overview
Date:   Mon, 19 Jul 2021 14:26:14 -0700
Message-ID: <20210719212628.134129-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c48998-0abc-493a-bce3-08d94afbe365
X-MS-TrafficTypeDiagnostic: BYAPR02MB4856:
X-Microsoft-Antispam-PRVS: <BYAPR02MB485645348F883E15D42D3117A1E19@BYAPR02MB4856.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLtOVyxHUNcm9QUUF0Eq+MDtGqlEj87/bQviCsX39flhlV1h07Z7amcH5yu5H1gi0Ypp05zbUbj8ha7t5MpU8zhkBZonOf1kyw/I//14jLPJWXBOwaYLBTS7bPMCtSpldihxT91entlDa0h+/Cp7xWgWT0WFMLrOIsdLgvcfxTuSBaorTHpI8zBXbncrd2huNhK4U1OJCL/4dWFie3LZDJAi3NjBt59PGb/aNxDxGiJ/VueXvPS4NGTvhqf0C6HyALYZLIBtFktLO81pADIC2A594Q2G0v6tUgCnIL/m3rUNAEIUQi+0KJz9k+8kUBPsqc+rRVLd/8eWMBTHlUDt+95pb1q2XITO1CHIoznYopjxmTQySCC5u8QGfNxlEJk0yEQUC6tjnUiaInd0QH/TnQiXDy/LEQAGKFyGzotkMBI/dc9I2IzIzFotaydKOcM2YfYCzSy0pRpMmwkS4PVP2cCZCan7dihp5WF+38tq/4rgp5LURY9BjmiDX0+tiMD8dYOpkHnjyRmZAfh2JO5JzLxzaUQ+veSfR04hjmhvbQL5+qRVFuGSYQDkmsHPPOWXN658J1amS8zVl28MnHo3LSn7eP336xH5/c8DEv/F4HGXNaYDpq2fhPYqMK68IWv7cJ7Vz6UVXIETjrul2yA3UbJbvtt/asIubvkJLCPWozalh/LHO6CUGKj9V6baJsQF3xdE+GavN7Z3iMI0E6MRM6TAGkQPaPRTb3y4jjnHFvOUnuuVH8TW/A/Wdvh33RTvnsZi0M61YjHhQLlEPIPUdQfKX3VwEpN0dHhM4rlMrWyZb1JfGziMduSL5te8zE8eKN6BVZKHJgWSs+ainO9tdA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6916009)(70586007)(70206006)(54906003)(966005)(82310400003)(8936002)(336012)(2906002)(83380400001)(2616005)(6666004)(30864003)(36756003)(26005)(1076003)(42186006)(6266002)(47076005)(186003)(356005)(426003)(508600001)(36860700001)(44832011)(5660300002)(7636003)(316002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:26:36.1038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c48998-0abc-493a-bce3-08d94afbe365
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4856
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This is V8 of patch series which adds management physical function driver
for Xilinx Alveo PCIe accelerator cards.
    https://www.xilinx.com/products/boards-and-kits/alveo.html

This driver is part of Xilinx Runtime (XRT) open source stack.

XILINX ALVEO PLATFORM ARCHITECTURE

Alveo PCIe FPGA based platforms have a static *shell* partition and a
partial re-configurable *user* partition. The shell partition is
automatically loaded from flash when host is booted and PCIe is enumerated
by BIOS. Shell cannot be changed till the next cold reboot. The shell
exposes two PCIe physical functions:

1. management physical function
2. user physical function

The patch series includes Documentation/xrt.rst which describes Alveo
platform, XRT driver architecture and deployment model in more detail.

Users compile their high level design in C/C++/OpenCL or RTL into FPGA
image using Vitis tools.
    https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html

The compiled image is packaged as xclbin which contains partial bitstream
for the user partition and necessary metadata. Users can dynamically swap
the image running on the user partition in order to switch between
different workloads by loading different xclbins.

XRT DRIVERS FOR XILINX ALVEO

XRT Linux kernel driver *xrt-mgmt* binds to management physical function of
Alveo platform. The modular driver framework is organized into several
platform drivers which primarily handle the following functionality:

1.  Loading firmware container also called xsabin at driver attach time
2.  Loading of user compiled xclbin with FPGA Manager integration
3.  Clock scaling of image running on user partition
4.  In-band sensors: temp, voltage, power, etc.
5.  Device reset and rescan

The platform drivers are packaged into *xrt-lib* helper module with well
defined interfaces. The module provides a pseudo-bus implementation for the
platform drivers. More details on the driver model can be found in
Documentation/xrt.rst.

User physical function driver is not included in this patch series.

LIBFDT REQUIREMENT

XRT driver infrastructure uses Device Tree as a metadata format to discover
HW subsystems in the Alveo PCIe device. The Device Tree schema used by XRT
is documented in Documentation/xrt.rst.

TESTING AND VALIDATION

xrt-mgmt driver can be tested with full XRT open source stack which
includes user space libraries, board utilities and (out of tree) first
generation user physical function driver xocl. XRT open source runtime
stack is available at https://github.com/Xilinx/XRT

Complete documentation for XRT open source stack including sections on
Alveo/XRT security and platform architecture can be found here:

https://xilinx.github.io/XRT/master/html/index.html
https://xilinx.github.io/XRT/master/html/security.html
https://xilinx.github.io/XRT/master/html/platforms_partitions.html

Changes since v7:
- Followed review comment to remove non fpga subdevices:
   clock, clkfrq, ucs, ddr_calibaration, devctl and vsec
- Collapsed include/uapi/linux/xrt/*.h into include/uapi/linux/fpga-xrt.h
- Cleaned up comments in fpga-xrt.h
- Fixed spelling errors in xrt.rst

Changes since v6:
- Resolved grammatical errors and cleaned up taxonomy in xrt.rst
  documentation.
- Fixed clang warnings.
- Updated code base to include v6 code review comments.

Changes since v5:
- Revert all changes 'mgnt/MGNT' back to 'mgmt/MGMT'
- Updated code base to include v5 code review comments.
   xrt.rst: address grammar and taxonomy
   subdev_id.h: defines XRT_SUBDEV_INVALID = 0
   xclbin.c: change shift operation to be_to_cpu
- Resolved kernel test robot errors.

Changes since v4:
- Added xrt_bus_type and xrt_device. All sub devices were changed from
  platform_bus_type/platform_device to xrt_bus_type/xrt_device.
- Renamed xrt-mgmt driver to xrt-mgnt driver.
- Replaced 'MGMT' with 'MGNT' and 'mgmt' with 'mgnt' in code and file names
- Moved pci function calls from infrastructure to xrt-mgnt driver.
- Renamed files: mgmt/main.c -> mgnt/xmgnt-main.c
                 mgmt/main-region.c -> mgnt/xmgnt-main-region.c
                 include/xmgmt-main.h -> include/xmgnt-main.h
                 mgmt/fmgr-drv.c -> mgnt/xrt-mgr.c
                 mgmt/fmgr.h -> mgnt/xrt-mgr.h
- Updated code base to include v4 code review comments.

Changes since v3:
- Leaf drivers use regmap-mmio to access hardware registers.
- Renamed driver module: xmgmt.ko -> xrt-mgmt.ko
- Renamed files: calib.[c|h] -> ddr_calibration.[c|h],
                 lib/main.[c|h] -> lib/lib-drv.[c|h],
                 mgmt/main-impl.h - > mgmt/xmgnt.h
- Updated code base to include v3 code review comments.

Changes since v2:
- Streamlined the driver framework into *xleaf*, *group* and *xroot*
- Updated documentation to show the driver model with examples
- Addressed kernel test robot errors
- Added a selftest for basic driver framework
- Documented device tree schema
- Removed need to export libfdt symbols

Changes since v1:
- Updated the driver to use fpga_region and fpga_bridge for FPGA
  programming
- Dropped platform drivers not related to PR programming to focus on XRT
  core framework
- Updated Documentation/fpga/xrt.rst with information on XRT core framework
- Addressed checkpatch issues
- Dropped xrt- prefix from some header files

For reference V7 version of patch series can be found here:
https://lore.kernel.org/lkml/20210528004959.61354-1-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-2-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-3-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-4-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-5-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-6-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-7-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-8-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-9-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-10-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-11-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-12-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-13-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-14-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-15-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-16-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-17-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-18-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-19-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210528004959.61354-20-lizhi.hou@xilinx.com/

Lizhi Hou (14):
  Documentation: fpga: Add a document describing XRT Alveo drivers
  fpga: xrt: driver metadata helper functions
  fpga: xrt: xclbin file helper functions
  fpga: xrt: xrt-lib driver manager
  fpga: xrt: group driver
  fpga: xrt: char dev node helper functions
  fpga: xrt: root driver infrastructure
  fpga: xrt: driver infrastructure
  fpga: xrt: management physical function driver (root)
  fpga: xrt: main driver for management function device
  fpga: xrt: fpga-mgr and region implementation for xclbin download
  fpga: xrt: ICAP driver
  fpga: xrt: partition isolation driver
  fpga: xrt: Kconfig and Makefile updates for XRT drivers

 Documentation/fpga/index.rst                  |   1 +
 Documentation/fpga/xrt.rst                    | 870 ++++++++++++++++++
 MAINTAINERS                                   |  11 +
 drivers/Makefile                              |   1 +
 drivers/fpga/Kconfig                          |   2 +
 drivers/fpga/Makefile                         |   5 +
 drivers/fpga/xrt/Kconfig                      |   8 +
 drivers/fpga/xrt/include/events.h             |  45 +
 drivers/fpga/xrt/include/group.h              |  25 +
 drivers/fpga/xrt/include/metadata.h           | 236 +++++
 drivers/fpga/xrt/include/subdev_id.h          |  39 +
 drivers/fpga/xrt/include/xclbin-helper.h      |  48 +
 drivers/fpga/xrt/include/xdevice.h            | 131 +++
 drivers/fpga/xrt/include/xleaf.h              | 205 +++++
 drivers/fpga/xrt/include/xleaf/axigate.h      |  23 +
 drivers/fpga/xrt/include/xleaf/clkfreq.h      |  21 +
 drivers/fpga/xrt/include/xleaf/clock.h        |  29 +
 .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +
 drivers/fpga/xrt/include/xleaf/devctl.h       |  40 +
 drivers/fpga/xrt/include/xleaf/icap.h         |  27 +
 drivers/fpga/xrt/include/xmgmt-main.h         |  34 +
 drivers/fpga/xrt/include/xroot.h              | 117 +++
 drivers/fpga/xrt/lib/Kconfig                  |  17 +
 drivers/fpga/xrt/lib/Makefile                 |  24 +
 drivers/fpga/xrt/lib/cdev.c                   | 209 +++++
 drivers/fpga/xrt/lib/group.c                  | 278 ++++++
 drivers/fpga/xrt/lib/lib-drv.c                | 322 +++++++
 drivers/fpga/xrt/lib/lib-drv.h                |  21 +
 drivers/fpga/xrt/lib/subdev.c                 | 859 +++++++++++++++++
 drivers/fpga/xrt/lib/subdev_pool.h            |  53 ++
 drivers/fpga/xrt/lib/xclbin.c                 | 381 ++++++++
 drivers/fpga/xrt/lib/xleaf/axigate.c          | 325 +++++++
 drivers/fpga/xrt/lib/xleaf/icap.c             | 328 +++++++
 drivers/fpga/xrt/lib/xroot.c                  | 536 +++++++++++
 drivers/fpga/xrt/metadata/Kconfig             |  12 +
 drivers/fpga/xrt/metadata/Makefile            |  16 +
 drivers/fpga/xrt/metadata/metadata.c          | 578 ++++++++++++
 drivers/fpga/xrt/mgmt/Kconfig                 |  15 +
 drivers/fpga/xrt/mgmt/Makefile                |  19 +
 drivers/fpga/xrt/mgmt/root.c                  | 420 +++++++++
 drivers/fpga/xrt/mgmt/xmgmt-main-region.c     | 483 ++++++++++
 drivers/fpga/xrt/mgmt/xmgmt-main.c            | 662 +++++++++++++
 drivers/fpga/xrt/mgmt/xmgmt.h                 |  33 +
 drivers/fpga/xrt/mgmt/xrt-mgr.c               | 190 ++++
 drivers/fpga/xrt/mgmt/xrt-mgr.h               |  16 +
 include/uapi/linux/fpga-xrt.h                 | 428 +++++++++
 46 files changed, 8171 insertions(+)
 create mode 100644 Documentation/fpga/xrt.rst
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/include/events.h
 create mode 100644 drivers/fpga/xrt/include/group.h
 create mode 100644 drivers/fpga/xrt/include/metadata.h
 create mode 100644 drivers/fpga/xrt/include/subdev_id.h
 create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
 create mode 100644 drivers/fpga/xrt/include/xdevice.h
 create mode 100644 drivers/fpga/xrt/include/xleaf.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
 create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
 create mode 100644 drivers/fpga/xrt/include/xroot.h
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/lib/cdev.c
 create mode 100644 drivers/fpga/xrt/lib/group.c
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
 create mode 100644 drivers/fpga/xrt/lib/subdev.c
 create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
 create mode 100644 drivers/fpga/xrt/lib/xclbin.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
 create mode 100644 drivers/fpga/xrt/lib/xroot.c
 create mode 100644 drivers/fpga/xrt/metadata/Kconfig
 create mode 100644 drivers/fpga/xrt/metadata/Makefile
 create mode 100644 drivers/fpga/xrt/metadata/metadata.c
 create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/root.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-region.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt.h
 create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.c
 create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.h
 create mode 100644 include/uapi/linux/fpga-xrt.h

-- 
2.27.0

