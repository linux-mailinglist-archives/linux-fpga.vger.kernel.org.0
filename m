Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A659B393A7D
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhE1AwG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:52:06 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:41568
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234809AbhE1AwC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:52:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay6DR9d7R5LmuU9AIDGnj273yIZYOqa63GVO9TU5v8X7lxRoHfK3AWLu7wldelAP1NIjpM4UZNTdM4J9wUkN/oviDn9Ku8kfdj6oGEGaiVebmx6WNqBJiOhcMb2z3YkkWrhLi/Y9uJ9XMBSO7JL6ijOa5+9RstaNYKQvcaCPzec+o0bykcF2AT5U3EHBi2xO2qeOhC26d8CPBNXjpfZoAoEu+L0GUk51A7VWq1MJOXiGksQop985PFa3B00l0VsDL8Rbx9dTy6UQmDTa5d21KGtHNq3FvgMPi1FeFWp6bxRPgKBFvjYaD90B2Qpkl/W+uy/43HZtgdNMMxY+GXJxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pdsGdhESrX699sAzFxXEKP6j19IZ8ILN/8Pfz7h5eo=;
 b=CUbESulZEcjkGYMgw51mwUhdTT7lhGy7nn0XMo+witUqIv+9Yehmz/TCOT7Dezr3QJKIi3OOq8dkLFblhqb7Uq33eMaDbkyA+hgPEzeRRolm4UpVpapgN70m/R0cnPAs5cvvvB5JHNP0cUvkmpk6Vc7A3sdy8TUQLtDT9KD4DnUa9w5oWSeg5y9L+JlM2tzIIjQ9z3x74aypQ07uI8qP0zbbodIbghxiQ/S/w0hfrDXjilMS5it8rV0h8cviCjsHJlSr1w9492evCCLF0a2YuGbZxQasB+Hx8WmF70IPY7SBp/jEI63265RPbSLCj3w6WcSdKlRcKTbEFI7UNXJ/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pdsGdhESrX699sAzFxXEKP6j19IZ8ILN/8Pfz7h5eo=;
 b=F9/LiYdB4vTgHur/To1+ymOGHvr3bmc+4AZnoBtVWbX8X5y+FGLcXtWjAEbc4G7i5113Tlr/ODztl6BFTiMnZtzyQ4Ld8sBchAlcT+Hxd9idKImP3M4xAGzXM3pD+HP58PVW1th9m6ekOnVWuTx3nn8Y2yCL7JVypsPQ2Fm286M=
Received: from BN8PR04CA0032.namprd04.prod.outlook.com (2603:10b6:408:70::45)
 by DM6PR02MB5290.namprd02.prod.outlook.com (2603:10b6:5:48::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 00:50:25 +0000
Received: from BN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::ed) by BN8PR04CA0032.outlook.office365.com
 (2603:10b6:408:70::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 00:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT063.mail.protection.outlook.com (10.13.2.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:50:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:50:06 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:50:06 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34004 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQhS-0006vd-Qj; Thu, 27 May 2021 17:50:06 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id D16DA600346; Thu, 27 May 2021 17:50:05 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>
Subject: [PATCH V7 XRT Alveo 00/20] XRT Alveo driver overview
Date:   Thu, 27 May 2021 17:49:39 -0700
Message-ID: <20210528004959.61354-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7780f0dc-89d0-4b9f-a4e5-08d9217294af
X-MS-TrafficTypeDiagnostic: DM6PR02MB5290:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5290B2D5599F264C5AAEF303A1229@DM6PR02MB5290.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFDjP4oBXDCg3+P+AH8QN8qx+sV0fm2da0eUyyTyRTCu00456ieGAW5v5ldaqpcJ73yLdL/Ij6MLY0YDIpx5Px0P+G/Q/sD2cZbyu3SUkcVwUabIlZ9zcDZ57Edi3AIALvjb+hzaw2hdxMO4Czr7oITgISS1lIuBSLURp/r/2pj9oC5NlrsxKiM1Xv2yM+E0BYH93r23lEygKbXfQtv7LtBLmBgOwBb+Rn3rGrlljxOGInuo5zQ2QUeAJBkACI0p3ZtLk+Y1SXRqaWUTau/E8298QrCHFzYYEjQ1bouCbWjm0aMt+KYT+664OArsPvrgBQ8fSTdJZ1UoOBr2pv88T/oxuqzkOUYMS58OlbwJYf8/Onlj+3+0f1nFMyuZ3vbK3SUJqrkYOEGBJwb7/5E7FXB2hgOZ8DhwVpiHSkBjBMTMW8oi//J6hKHEhZQ5LAtGOB2S6DoljiL0GNTQ0OwocNYhJMJfmUrVUL+RHG1XIkKOgCgt0s56J0d18ZwsT2OA27mMY+OLYzX80TlxRd1ch7bRoS1X+D3kTt2+dUhC5p6hRDYelCDO8xYWnirWMk5gJhMD1RqmRRbD/MkiRt1mg3Me7Gl1z+4by01YKNjOLSNzcR1LkZhj2m29y2j8YlTYlEe7a0KFfniUDdS0lBDDtqckLqCDy72nE5eaIOp/iGqLRLgQUQpUTnPjph1Q+si/ad5O29Z1snaCmWPcpP61Ebbv8nr9iJizisqQxgp2Nl5ZHhsNOhlZIb3pKTFxKhlNIMyn2+HjRq3PVTc3UxlOaQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(136003)(346002)(376002)(396003)(36840700001)(46966006)(70586007)(36756003)(8936002)(47076005)(54906003)(82740400003)(36860700001)(70206006)(5660300002)(966005)(186003)(2906002)(82310400003)(356005)(8676002)(44832011)(6666004)(426003)(83380400001)(7636003)(6916009)(336012)(30864003)(1076003)(42186006)(316002)(6266002)(4326008)(2616005)(36906005)(478600001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:50:25.2683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7780f0dc-89d0-4b9f-a4e5-08d9217294af
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5290
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This is V7 of patch series which adds management physical function driver
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

For reference V6 version of patch series can be found here:

https://lore.kernel.org/lkml/20210512015339.5649-1-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-2-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-3-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-4-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-5-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-6-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-7-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-8-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-9-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-10-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-11-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-12-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-13-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-14-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-15-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-16-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-17-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-18-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-19-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-20-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210512015339.5649-21-lizhi.hou@xilinx.com/

Lizhi Hou (20):
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
  fpga: xrt: VSEC driver
  fpga: xrt: User Clock Subsystem driver
  fpga: xrt: ICAP driver
  fpga: xrt: devctl xrt driver
  fpga: xrt: clock driver
  fpga: xrt: clock frequency counter driver
  fpga: xrt: DDR calibration driver
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
 drivers/fpga/xrt/lib/Makefile                 |  30 +
 drivers/fpga/xrt/lib/cdev.c                   | 209 +++++
 drivers/fpga/xrt/lib/group.c                  | 278 ++++++
 drivers/fpga/xrt/lib/lib-drv.c                | 328 +++++++
 drivers/fpga/xrt/lib/lib-drv.h                |  21 +
 drivers/fpga/xrt/lib/subdev.c                 | 859 +++++++++++++++++
 drivers/fpga/xrt/lib/subdev_pool.h            |  53 ++
 drivers/fpga/xrt/lib/xclbin.c                 | 381 ++++++++
 drivers/fpga/xrt/lib/xleaf/axigate.c          | 325 +++++++
 drivers/fpga/xrt/lib/xleaf/clkfreq.c          | 223 +++++
 drivers/fpga/xrt/lib/xleaf/clock.c            | 652 +++++++++++++
 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 +++++
 drivers/fpga/xrt/lib/xleaf/devctl.c           | 169 ++++
 drivers/fpga/xrt/lib/xleaf/icap.c             | 328 +++++++
 drivers/fpga/xrt/lib/xleaf/ucs.c              | 152 +++
 drivers/fpga/xrt/lib/xleaf/vsec.c             | 372 ++++++++
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
 include/uapi/linux/xrt/xclbin.h               | 409 ++++++++
 include/uapi/linux/xrt/xmgmt-ioctl.h          |  46 +
 53 files changed, 9988 insertions(+)
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
 create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
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
 create mode 100644 include/uapi/linux/xrt/xclbin.h
 create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h

-- 
2.27.0

