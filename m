Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A637B3BB
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 03:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELB6m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 21:58:42 -0400
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:48096
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229848AbhELB6l (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 21:58:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS/MRAVg7hloDsTbDWg6YhKafR2z7eDlh/zUXmVJBi+1M2nzr5e0JFj03P5gk5yAGpEpr3LW4vBOhFOCgryROLGxYVkcRMo0661v03l11amhKdKssVCZu6DaKERA7Qk/8yASvVAXr2Lqlu9KDN9nVHkEf0oZhgms/Ma9SnW6G1DDlNvu2Q7ShUrgy3Kc2MePKHvxP3jXml80Ffrgp7QEy+g1j8NamBsAXYJuP4l6OAccREjy+qpZ0bJv8LOHwAbIazy/H3/uMeVIC1T45SqsHNJkYV/huD9eVTIpnr/YxcCwRjlcRQn/inMPu4FY+VF4MHIJREDLjXpdElEIqQ0DZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fca1FQ4ILs/ynOm0oxBXuD14tmsTIf1rviHNBWTje+A=;
 b=ec8eTYSBXC3OW0cffJMCgjx9F488d7VPR2mZX+WLPZwxcCxnxYbM73OEnwtVCzS8hZL4f5Ja4tiOdhiokTDMDmz1NrGvNAzcDC0lIpiCqlNuVPL/9Yz9l3dIwCCZ7hgU9c8x4JWCruUI2YZk2EUpbrZ5KsLzyLeaiaivKooEVvDlgUgGVbQe3YqiIHt4r+9Am/33EUJEWiYLD9XVllwWTF8XNYKUId3urz4op25HdAxK8UrnYbiqOyzwEjVFSx+6pfeSMmM3OjTufYhPRONiTGAu5WLkgC2vjt6/2JwMok23G3OIB3BUOCLw1Dq+89JBjJlFKVWgp8Z7H9DEspjD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fca1FQ4ILs/ynOm0oxBXuD14tmsTIf1rviHNBWTje+A=;
 b=IEAaptkDibpvgGXTF8mQfbjHgXo9zdRAi4m+OLYuHEOOsqZgbs43hAzhnhPNLeTPqiMr8U2sE22jTqSrJm5bFwbs15Xw7Pc/N2l3x5s/PqpAMU5GjYoTjxKtuEAG2jfmTymkfIy9eMRlfiJhXHNJ5GRgw6tXfxSZg2GZEHkKi7M=
Received: from BN9PR03CA0748.namprd03.prod.outlook.com (2603:10b6:408:110::33)
 by BN7PR02MB5331.namprd02.prod.outlook.com (2603:10b6:408:2b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Wed, 12 May
 2021 01:57:31 +0000
Received: from BN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::ad) by BN9PR03CA0748.outlook.office365.com
 (2603:10b6:408:110::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 01:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT034.mail.protection.outlook.com (10.13.2.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 01:57:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 18:57:18 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 18:57:18 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35710 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lge7i-0005LS-Cx; Tue, 11 May 2021 18:57:18 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id BEA4D600126; Tue, 11 May 2021 18:53:44 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>
Subject: [PATCH V6 XRT Alveo 00/20] XRT Alveo driver overview
Date:   Tue, 11 May 2021 18:53:19 -0700
Message-ID: <20210512015339.5649-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a945ce8-9099-455f-7c03-08d914e94db1
X-MS-TrafficTypeDiagnostic: BN7PR02MB5331:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5331205621AC7AD4BC3A460DA1529@BN7PR02MB5331.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4X0wwHhDmJFSbZOhOVbRtEf7Lw4/1cLAfildV/6SH0fRSl8C0b4NDcvY7rxXvptXh/dZ6hq9Q6mV4OeGJ9lageAN4UUuv+AgaJ5QSULGbYOlYSMsE/SBVtHRsByLQZKPlZ2KlFP+/qtc0ar7chxvrNaX8EY/UamRQjWkp5IXO3qABFzdFpsOxnRBnoiZ6+KBozX15y8KfCy5sXpTZmv54TrD4VWuAiWD+9oxQVJcQYUYlr+BrvoTMXpE28vHPE4+XnPM7S/HacJvNtL9WytHzy0l9cpvjMhvgi61wxolsA87BjVtzLh0VQJdCL0wqKyXVLP9yG7vM7SGFK5miXpbuB6dO/Ov4FtrBqoOaAFZ9HCI87vzz8Cd0LjIe50HpkhU77nz26qsZ8mYEDeNBoAVsu69wFhf7KC6SOcHDZJ5TPeUji2rp7E4YqOtQmiG9yF1n4glzpR1921Wg0urwGsw+cfeSLsQBDe+d/m53j/clh7uXcFFpBo90Xs8QFuYtyDYzVbUEjM+8SPxGMJ6pZ6t2nCOW7fyLcJXhHnZz1h5ubsh8M6O0PDHRFsUq/LEvTekdWLdAsBoFTcRUtrI24yoF3amQvCveCNvOt+fb9pR3HImmPh57jGzhJgkm1Um2CsZie6HzhGUj1n2vjsWLo+4lmNOxt9rzc0jnD2r4N3nruFzhMt84P21DQ9OCRoe1iSYhjxW47zeBP1wXzDPoC3YakcCXBCt8xCGylLtOpfsK9oJtjYI9ZqyfQQP7bFtQcU4wHQ+5rFqinlnTRWBb2Ou9w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39850400004)(36840700001)(46966006)(26005)(6666004)(47076005)(8936002)(82310400003)(2616005)(186003)(83380400001)(426003)(336012)(7636003)(36860700001)(36756003)(356005)(44832011)(54906003)(966005)(30864003)(82740400003)(478600001)(2906002)(1076003)(4326008)(8676002)(36906005)(5660300002)(42186006)(316002)(6266002)(70206006)(70586007)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 01:57:31.1469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a945ce8-9099-455f-7c03-08d914e94db1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5331
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This is V6 of patch series which adds management physical function driver
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

For reference V5 version of patch series can be found here:

https://lore.kernel.org/lkml/20210427205431.23896-1-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-2-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-3-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-4-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-5-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-6-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-7-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-8-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-9-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-10-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-11-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-12-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-13-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-14-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-15-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-16-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-17-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-18-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-19-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-20-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210427205431.23896-21-lizhi.hou@xilinx.com/

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
 Documentation/fpga/xrt.rst                    | 869 ++++++++++++++++++
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
 drivers/fpga/xrt/lib/subdev.c                 | 848 +++++++++++++++++
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
 include/uapi/linux/xrt/xclbin.h               | 409 +++++++++
 include/uapi/linux/xrt/xmgmt-ioctl.h          |  46 +
 53 files changed, 9976 insertions(+)
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

