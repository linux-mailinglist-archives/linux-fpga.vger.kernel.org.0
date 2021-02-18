Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE0631E669
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 07:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhBRGpK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 01:45:10 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:41497
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229885AbhBRGn6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 01:43:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuZKugsBJaZsKfJeWnlP5LHPXUDN+o02aUmgplhtiKBEOsUFEwXMzjUjYfOrf4nZcxjFAVjW0abiOzh58natj1y1JCzc9BhsRmHm/LmGMG4w1+a6DgY5Y7S/OsRvW9OgEnABAR2gOdNXo/ChlBkIkpzI05i+l7e8yoPiPE6IkLJ7rsDxilAg2s67K+GbUF17CFjyEUlzNW1nTGV2tvdsXcsIOcT4EihhfXasMpZJvjFbtoGp5+y5ZhxR6rKj7x5lHR3dXtCwt+F9lE0BcDwGqBIVqWsHnWE0Nb9bCKxQ3R8txpJ+hJrzvdbzWUtYX5SxyjWzC4i4S50G5Ton1EN+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thru5oCwcYXhZSAJuZ2Ol5tp5Hcsnimr//aayFjoIYQ=;
 b=dvPxS0j5NIqWELYtNjlxR3Ym0Bcz4Mvw0+alYLjvc3Iuf3wECQbbLuSNKtRefbIJit2M3VmnYOKnm8pXd5ve5p5YJOMy9NeeI4Kqy8GgmjwjcsJF+wxaQLSs2TcbousF2cFEIKg4KJRrQQ3dFT6oAJTFzF0Fat8ymF6l7cfUsQ4FnLT+2VGMMj8osexYOS9oR/boFWIrIypEPDkn0iP8coXX2Dec9gwFono5KgfN4D4EViweCqY5O7ZepZ6IPj/G2fH/I2eG81hbXv5XNOWYISyV0fzhmE8QL1Vixg94jKkqMSyKyOcavncQfd0KM2Zp8Xd9QnuIS1gfDsSwzKyUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thru5oCwcYXhZSAJuZ2Ol5tp5Hcsnimr//aayFjoIYQ=;
 b=UPv2UKXU2Qudq3yrFMxIAGCTB4qshMZjk7h1h6T4eWKCuckmjgXrAO2vMw6jhg2vxN5TDgElo60blAYfE99PyG9ufugEtjlxMPcFSSJdykLuDKOWrUNvIy12Q/kccqUGarNqCJfZWkyyap8VTNxWGEZ4Qk4xLABTwLbif/AgwCU=
Received: from CY4PR20CA0031.namprd20.prod.outlook.com (2603:10b6:903:cb::17)
 by BN6PR02MB3348.namprd02.prod.outlook.com (2603:10b6:405:64::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 06:42:53 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:cb:cafe::c) by CY4PR20CA0031.outlook.office365.com
 (2603:10b6:903:cb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 06:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:42:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:42:51 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:42:51 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=40158 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd1X-0001ji-72; Wed, 17 Feb 2021 22:42:51 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 7F80C60011B; Wed, 17 Feb 2021 22:41:05 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>
Subject: [PATCH V3 XRT Alveo 00/18] XRT Alveo driver overview
Date:   Wed, 17 Feb 2021 22:40:01 -0800
Message-ID: <20210218064019.29189-1-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f31e43a8-292e-4d27-1ad9-08d8d3d86ac0
X-MS-TrafficTypeDiagnostic: BN6PR02MB3348:
X-Microsoft-Antispam-PRVS: <BN6PR02MB334812DEEBDABAFF53726DB3A1859@BN6PR02MB3348.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kv5jOaqzjot2QGV0UYpA09+nmnHTsQHy+/kqmoZl0t7nIM8QrHHISsL7CQrblt8Orz+dbWSfzkSQliC0jaaUJTpF2QgBu0yfQIrnEMzHDvZnblegijSfSWzvR+YnW+fdkCzcR1vkVrCFyXFqOSc7HoIAyPJR4oxpjZRD3gaiLfjWXn3LnfIlMHQ0A7P3tJZ1ivvckBFPpFW/BR4K8pL5iW/4ZojaxzlDLoqIfIoKGC3eJv295sErnB1V8VvfVt0+1cDC2gGcQkK8O0pdKrSK0gHURX8vknMo0WuyCGAwb2JRON9a4GwlYM0ArGboUaRifqDGZZQOboFuAvoWNJyA4M8vKTl6K2qcP1Yq3c5dv8nOZlTpLjXYO3trCfsnZCjOkirR9PRGUmA0s+1EKnBYB3im8nxJfR5ynwdEQ5hEudKyEWAnqrK5UntMWbfUjKGn+R2euFyKAgG/gcFdZB5xOqEf/qUlze6bjujYHlq8Q9R73VadfN5S82MYLkL/fFR58FsilFn4BieLXBuhNegajyrvEYPZSMiojV1k7CzHQ+4s9/A6uEfnm4zfBljI35KfjVHieHKbVa36paXnOXlys5wrYmMdXWDpuDa1hyauN5nSkvm8A29Fj5YkYgd3t+igLgKrVVBzihVIh5woNEJv38mvrcTD4VGfCVgsedrifsL8iGiUwyCDgxLCEQHFBgZ2l8OpWH+/NKhgCZ1PtRDE+XPatedEx4uPHsgsMjwiZJM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(70586007)(7636003)(2906002)(26005)(47076005)(70206006)(82740400003)(1076003)(5660300002)(4326008)(478600001)(6916009)(54906003)(966005)(316002)(36906005)(336012)(426003)(2616005)(44832011)(8676002)(36756003)(82310400003)(36860700001)(83380400001)(186003)(42186006)(8936002)(6666004)(356005)(6266002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:42:52.9672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31e43a8-292e-4d27-1ad9-08d8d3d86ac0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3348
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This is V3 of patch series which adds management physical function driver for Xilinx
Alveo PCIe accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
This driver is part of Xilinx Runtime (XRT) open source stack.

XILINX ALVEO PLATFORM ARCHITECTURE

Alveo PCIe FPGA based platforms have a static *shell* partition and a partial
re-configurable *user* partition. The shell partition is automatically loaded from
flash when host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
till the next cold reboot. The shell exposes two PCIe physical functions:

1. management physical function
2. user physical function

The patch series includes Documentation/xrt.rst which describes Alveo platform,
XRT driver architecture and deployment model in more detail.

Users compile their high level design in C/C++/OpenCL or RTL into FPGA image using
Vitis https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
tools. The compiled image is packaged as xclbin which contains partial bitstream
for the user partition and necessary metadata. Users can dynamically swap the image
running on the user partition in order to switch between different workloads by
loading different xclbins.

XRT DRIVERS FOR XILINX ALVEO

XRT Linux kernel driver *xmgmt* binds to management physical function of Alveo
platform. The modular driver framework is organized into several platform drivers
which primarily handle the following functionality:

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
is documented in Documentation/xrt.rst. Unlike previous V1 and V2 version
of patch series, V3 version does not require export of libfdt symbols.

TESTING AND VALIDATION

xmgmt driver can be tested with full XRT open source stack which includes user
space libraries, board utilities and (out of tree) first generation user physical
function driver xocl. XRT open source runtime stack is available at
https://github.com/Xilinx/XRT

Complete documentation for XRT open source stack including sections on Alveo/XRT
security and platform architecture can be found here:

https://xilinx.github.io/XRT/master/html/index.html
https://xilinx.github.io/XRT/master/html/security.html
https://xilinx.github.io/XRT/master/html/platforms_partitions.html

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

For reference V1 version of patch series can be found here:

https://lore.kernel.org/lkml/20201217075046.28553-1-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201217075046.28553-2-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201217075046.28553-3-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201217075046.28553-4-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201217075046.28553-5-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201217075046.28553-6-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201217075046.28553-7-sonals@xilinx.com/

Lizhi Hou (18):
  Documentation: fpga: Add a document describing XRT Alveo drivers
  fpga: xrt: driver metadata helper functions
  fpga: xrt: xclbin file helper functions
  fpga: xrt: xrt-lib platform driver manager
  fpga: xrt: group platform driver
  fpga: xrt: platform driver infrastructure
  fpga: xrt: management physical function driver (root)
  fpga: xrt: main platform driver for management function device
  fpga: xrt: fpga-mgr and region implementation for xclbin download
  fpga: xrt: VSEC platform driver
  fpga: xrt: UCS platform driver
  fpga: xrt: ICAP platform driver
  fpga: xrt: devctl platform driver
  fpga: xrt: clock platform driver
  fpga: xrt: clock frequence counter platform driver
  fpga: xrt: DDR calibration platform driver
  fpga: xrt: partition isolation platform driver
  fpga: xrt: Kconfig and Makefile updates for XRT drivers

 Documentation/fpga/index.rst             |   1 +
 Documentation/fpga/xrt.rst               | 842 ++++++++++++++++++++++
 MAINTAINERS                              |  11 +
 drivers/Makefile                         |   1 +
 drivers/fpga/Kconfig                     |   2 +
 drivers/fpga/Makefile                    |   4 +
 drivers/fpga/xrt/Kconfig                 |   8 +
 drivers/fpga/xrt/include/events.h        |  48 ++
 drivers/fpga/xrt/include/group.h         |  27 +
 drivers/fpga/xrt/include/metadata.h      | 229 ++++++
 drivers/fpga/xrt/include/subdev_id.h     |  43 ++
 drivers/fpga/xrt/include/xclbin-helper.h |  52 ++
 drivers/fpga/xrt/include/xleaf.h         | 276 +++++++
 drivers/fpga/xrt/include/xleaf/axigate.h |  25 +
 drivers/fpga/xrt/include/xleaf/calib.h   |  30 +
 drivers/fpga/xrt/include/xleaf/clkfreq.h |  23 +
 drivers/fpga/xrt/include/xleaf/clock.h   |  31 +
 drivers/fpga/xrt/include/xleaf/devctl.h  |  43 ++
 drivers/fpga/xrt/include/xleaf/icap.h    |  29 +
 drivers/fpga/xrt/include/xleaf/ucs.h     |  24 +
 drivers/fpga/xrt/include/xmgmt-main.h    |  37 +
 drivers/fpga/xrt/include/xroot.h         | 114 +++
 drivers/fpga/xrt/lib/Kconfig             |  16 +
 drivers/fpga/xrt/lib/Makefile            |  30 +
 drivers/fpga/xrt/lib/cdev.c              | 231 ++++++
 drivers/fpga/xrt/lib/group.c             | 265 +++++++
 drivers/fpga/xrt/lib/main.c              | 274 +++++++
 drivers/fpga/xrt/lib/main.h              |  17 +
 drivers/fpga/xrt/lib/subdev.c            | 871 +++++++++++++++++++++++
 drivers/fpga/xrt/lib/subdev_pool.h       |  53 ++
 drivers/fpga/xrt/lib/xclbin.c            | 394 ++++++++++
 drivers/fpga/xrt/lib/xleaf/axigate.c     | 298 ++++++++
 drivers/fpga/xrt/lib/xleaf/calib.c       | 226 ++++++
 drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 221 ++++++
 drivers/fpga/xrt/lib/xleaf/clock.c       | 648 +++++++++++++++++
 drivers/fpga/xrt/lib/xleaf/devctl.c      | 206 ++++++
 drivers/fpga/xrt/lib/xleaf/icap.c        | 317 +++++++++
 drivers/fpga/xrt/lib/xleaf/ucs.c         | 235 ++++++
 drivers/fpga/xrt/lib/xleaf/vsec.c        | 359 ++++++++++
 drivers/fpga/xrt/lib/xroot.c             | 598 ++++++++++++++++
 drivers/fpga/xrt/metadata/Kconfig        |  12 +
 drivers/fpga/xrt/metadata/Makefile       |  16 +
 drivers/fpga/xrt/metadata/metadata.c     | 524 ++++++++++++++
 drivers/fpga/xrt/mgmt/Kconfig            |  15 +
 drivers/fpga/xrt/mgmt/Makefile           |  19 +
 drivers/fpga/xrt/mgmt/fmgr-drv.c         | 187 +++++
 drivers/fpga/xrt/mgmt/fmgr.h             |  28 +
 drivers/fpga/xrt/mgmt/main-impl.h        |  37 +
 drivers/fpga/xrt/mgmt/main-region.c      | 471 ++++++++++++
 drivers/fpga/xrt/mgmt/main.c             | 693 ++++++++++++++++++
 drivers/fpga/xrt/mgmt/root.c             | 342 +++++++++
 include/uapi/linux/xrt/xclbin.h          | 408 +++++++++++
 include/uapi/linux/xrt/xmgmt-ioctl.h     |  46 ++
 53 files changed, 9957 insertions(+)
 create mode 100644 Documentation/fpga/xrt.rst
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/include/events.h
 create mode 100644 drivers/fpga/xrt/include/group.h
 create mode 100644 drivers/fpga/xrt/include/metadata.h
 create mode 100644 drivers/fpga/xrt/include/subdev_id.h
 create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
 create mode 100644 drivers/fpga/xrt/include/xleaf.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/calib.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
 create mode 100644 drivers/fpga/xrt/include/xleaf/ucs.h
 create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
 create mode 100644 drivers/fpga/xrt/include/xroot.h
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/lib/cdev.c
 create mode 100644 drivers/fpga/xrt/lib/group.c
 create mode 100644 drivers/fpga/xrt/lib/main.c
 create mode 100644 drivers/fpga/xrt/lib/main.h
 create mode 100644 drivers/fpga/xrt/lib/subdev.c
 create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
 create mode 100644 drivers/fpga/xrt/lib/xclbin.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/calib.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
 create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
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
 create mode 100644 drivers/fpga/xrt/mgmt/fmgr-drv.c
 create mode 100644 drivers/fpga/xrt/mgmt/fmgr.h
 create mode 100644 drivers/fpga/xrt/mgmt/main-impl.h
 create mode 100644 drivers/fpga/xrt/mgmt/main-region.c
 create mode 100644 drivers/fpga/xrt/mgmt/main.c
 create mode 100644 drivers/fpga/xrt/mgmt/root.c
 create mode 100644 include/uapi/linux/xrt/xclbin.h
 create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h

-- 
2.18.4

