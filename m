Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAEB3DDD0A
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhHBQFn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 12:05:43 -0400
Received: from mail-dm6nam08on2045.outbound.protection.outlook.com ([40.107.102.45]:14337
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229805AbhHBQFm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Aug 2021 12:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xkbs6cJrsU6qMt2Rjvs4wTD8VV1Q9JPi40di+s7oCkxVai/00asdOyHzjOVi+zWxryARAcueNOxgLdxBMC3ST7BSAk8QMWrjQICt8nd6IyeG1epWOSM/bSknk+Y5X0NE5RQwhaCZkiBEj+D+VDQdjqutHK1SsJqcebRtlRpgNFJp9KxtMTJnMTsqWrXTtu72rjG8yAgKB2fV+3YHoqCWtSV7dApI4+B1o7+0u9ivYN9jBf24keYPD0+FOBWDhF9DmjLYg510+Fsse+VXi83zBeeCFe4xypbHaXFP+XRqbr9SAa3rzdmrLzKOuetbFIbTfOPYrhwrZ72RX9dztjKGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE98iMlSEGuBGthyR3DuiXiuiXscKQH1DyJ2/2Nwchk=;
 b=LIzRwIG8xlJ/4UFen/MnxQ8FlJqOCHmowa271nfHhyuTzat1dwZJACbJOpIIBSq7YkIhyxMTvyiLrd7M5vJWIjV2BDckd5bZYaOCOWburAYrsTZnH2HP10izKof25nfJdc2H3Kt4ne7D1Rx4AwECl6z+MJ/X5/R2uJ1wQyWkvm8FOgfZKCt0INjb/QryBxPwFh7+aYSL5YLmF4Ann4nmNbAnGOWVEhSKqKC8L94cEzE8RpfOpqDTliA+0LLNOEAx7bBglCFKILCeGq96KhBINSc7MG33vvxyDOSebImBX6c5MeJzeQYnas5pdE7bfDxdrHtVGVfxvLrOGLzIQrnQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE98iMlSEGuBGthyR3DuiXiuiXscKQH1DyJ2/2Nwchk=;
 b=tLt2CU97hYDXjxzZZIbVFPqvQnPhphe1hP6jIgX2RqzNGhGjK3yWI6jBeYvYhQ9r3Ubc9Kbn3PdJAw7fYCkx0r8rlOK+mRMbUfsP3vTgE4xo6LPeiKxXg6qcpsEyeRqChoNMiaK2E1Z0N5sLStltBoRK00j48wWZZ0yP/G73eLs=
Received: from DM3PR14CA0146.namprd14.prod.outlook.com (2603:10b6:0:53::30) by
 SN6PR02MB4686.namprd02.prod.outlook.com (2603:10b6:805:9c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.20; Mon, 2 Aug 2021 16:05:30 +0000
Received: from DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::2a) by DM3PR14CA0146.outlook.office365.com
 (2603:10b6:0:53::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 16:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT004.mail.protection.outlook.com (10.13.5.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 16:05:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 09:05:30 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 2 Aug 2021 09:05:30 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.23.145.232] (port=49046 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mAaRV-00055H-VA; Mon, 02 Aug 2021 09:05:29 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id DA425601B21; Mon,  2 Aug 2021 09:05:29 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>
Subject: [PATCH V9 XRT Alveo 00/14] XRT Alveo driver overview
Date:   Mon, 2 Aug 2021 09:05:07 -0700
Message-ID: <20210802160521.331031-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d4d40f3-fc44-45ea-d654-08d955cf5a16
X-MS-TrafficTypeDiagnostic: SN6PR02MB4686:
X-Microsoft-Antispam-PRVS: <SN6PR02MB468638671AD84A5B249D720EA1EF9@SN6PR02MB4686.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NOA0anHvwg4IMEyLtt3fEVdTX92oG4e30WVfyesLXerEEbKMKJoQAqBvTRh1eOhsAujGZ9kXoMDPJavWfcjDdpUzYkzm0WAf4lfhoMooyamkst9/RPqqCITlpO886o5x4AOc1N8ioe5y8s+4IqTNgy1wZP5sh0l+CkB4PdArD8EYu6ZAiMuE0kx0axh032dP9gmPfTTjcGwHNNqqz2/H3PseHdRZD3E/k40rmR1ISFZsPKqcHq1IMo636PQ/W6vHeguiCxPmDkbm4MpYfkL/CpUJxjMmYnMw8suVf5ytsBQj83qYr/qzM6by9d/7rauYRgJj0KepdcoP0rBERyGm7H3yeSARQAn+pEiPmfEhxWbctPTvSVpJPXGxopgeOK+aSJChWBis+BytKLNXbd9S8x7tZUfqZ+mDWoO212cYm/gRg6EeQN/eE8cCLTG3yNypVgiGVfDf33nCt1K37KnykK67B1hjwenQCqZkXg8hIvT5A3Oe8RvT18f4zRIMX2a2eqNRjdkUoc9tzB9tZrPvRq8C8LCi4UHdxX/y73Q//MC0tKAFNFEXzP3NjHcVv6//hj35mZVDxN4kKSP//2/gFKQ974QKsrhBHX5z6HSo60w+YnWGbyShpn8Dyz6I0lKfElpR+ItQKUL3wfuxo09JsKd4HUFc0Vai3OdSK34sFtW29w1GFhsHPKuaF8OdMbRalK88a8eaHQyHn2gm7ypfHYLVXTetLG4OyyWmXaOs17au1O0+m9IkMgPfM5GBdl2IDF+EVg77OSNhylD4YnG0Rs5M3ow+FyUgQt7gwblZtbORPJODP0YNIzO3K6Cyn5TqfSwY14hxV7NZOYHQiYT1A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(1076003)(42186006)(70206006)(966005)(70586007)(316002)(478600001)(4326008)(30864003)(6266002)(36906005)(6916009)(356005)(36860700001)(336012)(54906003)(5660300002)(47076005)(83380400001)(8676002)(82310400003)(2906002)(426003)(2616005)(82740400003)(7636003)(44832011)(26005)(186003)(8936002)(36756003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 16:05:30.6643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4d40f3-fc44-45ea-d654-08d955cf5a16
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4686
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This is V9 of patch series which adds management physical function driver
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

Changes since v8:
- added comments for struct xrt_device, struct xrt_driver.
- removed module version

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

For reference V8 version of patch series can be found here:
https://lore.kernel.org/lkml/20210719212628.134129-1-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-2-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-3-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-4-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-5-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-6-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-7-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-8-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-9-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-10-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-11-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-12-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-13-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-14-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20210719212628.134129-15-lizhi.hou@xilinx.com/

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
 drivers/fpga/xrt/include/xdevice.h            | 141 +++
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
 drivers/fpga/xrt/lib/lib-drv.c                | 318 +++++++
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
 drivers/fpga/xrt/mgmt/root.c                  | 418 +++++++++
 drivers/fpga/xrt/mgmt/xmgmt-main-region.c     | 483 ++++++++++
 drivers/fpga/xrt/mgmt/xmgmt-main.c            | 662 +++++++++++++
 drivers/fpga/xrt/mgmt/xmgmt.h                 |  33 +
 drivers/fpga/xrt/mgmt/xrt-mgr.c               | 190 ++++
 drivers/fpga/xrt/mgmt/xrt-mgr.h               |  16 +
 include/uapi/linux/fpga-xrt.h                 | 428 +++++++++
 46 files changed, 8175 insertions(+)
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

