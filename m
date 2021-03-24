Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C503470E2
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhCXFcu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:32:50 -0400
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:6240
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232343AbhCXFc1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:32:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4myuOaUg83aeljVvjzuOEy4XGdRouWRb3tWGv722Djz6r7jM4OnswHiYcW2FkwXRr/5gBo3Qu/knHsioUO57P0/F7BM+CtRwMhqgDA79Z4UVcIHrPY5KRn6QzY3SJz4txdTFj9qawGG9yz73kK5MD4waLD+MQN4RFVQyCCuTvVKBXWklFhYh232qakqVF0FsRFkhYGyrQhSHDna96Ee80gcUaE8QKlafTigFnHxi85Du2j023RbQLuDpq6TFenThR/BDhCgCpBATNVqE/HG+Y2VzZepF1VrKka4yPtfRpJ0FDQWw7vE/mMrgoBiUiVZp3gB5voU4+iADaLVeX3uZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq9mbnxVI86OUKNQ793xoJzl2ITUFAAKR1UyoscWNwo=;
 b=muV1LAJnU9ooac04ArJ6HuoAKD6rI/gMslMrcgK3SIVqYAI+9AhjYEwxIFghPcfMT4BZ1fuk8+MHEhMrqqa5d9ZnIqf0VPjsblWgmKrFvZ+EC5m+zLILWedA+3UOq+strREAn+s06GG9fan9lRgSMeTfDQjG0q9UBUesJ5idhbcdTxz+O2wnxAF5gkj5pswBcTI/oZeSxLz4263IlKlBEqVeILkpjax38H48b6dmIpoBalxMqjqwb0KfO6ssM4cFrw+UAhz8MWPFUl6sG0YhUJn/c16VKRQH6g/7mjw0VAoVRzMVO/vyKCR24sx1kDaJWki3fHmpPyCR6lCXDG1uHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq9mbnxVI86OUKNQ793xoJzl2ITUFAAKR1UyoscWNwo=;
 b=ba2kNv6MnG7suWZcqh7bNDZ/47w5kY9lfDIvknOzA9ZQhIA2A3hlHxTgk2MaUoliPC9Q7UKm4mVPX5Xm0QtofVqbkubFq8JFoBivvgFTKrXKHOcvVTRHWBqO4M3bSeT3DlLPq22IOp7Fd5lT+IuPYZ3lXyrS2mXRALBskHQeSWs=
Received: from DM6PR05CA0062.namprd05.prod.outlook.com (2603:10b6:5:335::31)
 by SA0PR02MB7226.namprd02.prod.outlook.com (2603:10b6:806:da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 05:32:24 +0000
Received: from DM3NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::f6) by DM6PR05CA0062.outlook.office365.com
 (2603:10b6:5:335::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.14 via Frontend
 Transport; Wed, 24 Mar 2021 05:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT014.mail.protection.outlook.com (10.13.5.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 05:32:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:32:22 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:32:22 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51020 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOw7y-0005o8-3m; Tue, 23 Mar 2021 22:32:22 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 85B5B60011E; Tue, 23 Mar 2021 22:29:55 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>
Subject: [PATCH V4 XRT Alveo 00/20] XRT Alveo driver overview
Date:   Tue, 23 Mar 2021 22:29:27 -0700
Message-ID: <20210324052947.27889-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38402d1a-6023-4bca-05d6-08d8ee86340c
X-MS-TrafficTypeDiagnostic: SA0PR02MB7226:
X-Microsoft-Antispam-PRVS: <SA0PR02MB72265E6B36BF0D8843D59289A1639@SA0PR02MB7226.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQ6HNirPqUeHw3fkQ59vtm2oliRjAdCNSBJqdfnTZBjYNjxMuJpjqpcUPLLs8oqBVgKJJdNawGGifhzCYuT+z4UJj8MhJvWkPJoiHUaW8E0xXpcGjLIWJ+mmqeaxuWLfDeXjFVQJX8m88fiEVETI1Vn3E/sI0Eqch1zPSIv68iZ0k3VZj/Pk2F34sPhypMqcKNXJWf4lNVYjlgWQ3cr+EXihSTAxj7B835EItVFszE1AnKQHW3HGkScIMi9R0n9GlgPjPnErblbrQ6rBVlcCTnKTtDhje8fmuID9Gdx4/BjofeQr1yqtT4fSHFKj1NjgvIzMs7rXdnMk09hp0SW7cFje/ae/NdNDz8Zw0zBZ9HKtkDRmnWTD7OWn4quAQmH3v9F4/kDBTxqn88SmzHEIdDbN/2dpBOAXWNC4QipAFfNUCkO1oywYmzhvl01+gkVWvFHrexCQ7LrrNgW5khSsdzf2tFE5H1Eh9Axv8wcA4G6L5YEM1Uw4siUGAcf3YPWERfmgB54dJQFTnlovWVj9wXTy7NJOaZAsSzpR2VdEvdxIFkRn4QcVHoPmmCoLfvR0obUrjUEMGxDZdimHPlh9PII6pUtHVmhUnkPnMwZOaVipbkC0taimGUqlDJ1uEGrzqwNUshDW2RemWMNzS0yTblvNGjkUcst/qIM11TBFZ7R4i6XZHjCHu4thjiVFwbOP6VvXG8oYmti48IDT76xWrItQF/6tpS+sVN5vD8TEA4M=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(46966006)(966005)(478600001)(36860700001)(44832011)(2616005)(4326008)(47076005)(1076003)(82740400003)(30864003)(426003)(336012)(8936002)(2906002)(70586007)(6266002)(70206006)(356005)(8676002)(42186006)(82310400003)(36756003)(26005)(5660300002)(186003)(36906005)(316002)(6666004)(7636003)(83380400001)(6916009)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:32:23.8267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38402d1a-6023-4bca-05d6-08d8ee86340c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7226
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This is V4 of patch series which adds management physical function driver
for Xilinx Alveo PCIe accelerator cards.
    https://www.xilinx.com/products/boards-and-kits/alveo.html

This driver is part of Xilinx Runtime (XRT) open source stack.
The V4 patch series do not include bus_type change as suggested before.
The bus_type change will come with v5 patch series.

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

XRT Linux kernel driver *xmgmt* binds to management physical function of
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

xmgmt driver can be tested with full XRT open source stack which includes
user space libraries, board utilities and (out of tree) first generation
user physical function driver xocl. XRT open source runtime stack is
available at https://github.com/Xilinx/XRT

Complete documentation for XRT open source stack including sections on
Alveo/XRT security and platform architecture can be found here:

https://xilinx.github.io/XRT/master/html/index.html
https://xilinx.github.io/XRT/master/html/security.html
https://xilinx.github.io/XRT/master/html/platforms_partitions.html

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

For reference V3 version of patch series can be found here:

https://lore.kernel.org/lkml/20210218064019.29189-1-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-2-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-3-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-4-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-5-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-6-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-7-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-8-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-9-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-10-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-11-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-12-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-13-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-14-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-15-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-16-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-17-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-18-lizhih@xilinx.com
https://lore.kernel.org/lkml/20210218064019.29189-19-lizhih@xilinx.com

Lizhi Hou (20):
  Documentation: fpga: Add a document describing XRT Alveo drivers
  fpga: xrt: driver metadata helper functions
  fpga: xrt: xclbin file helper functions
  fpga: xrt: xrt-lib platform driver manager
  fpga: xrt: group platform driver
  fpga: xrt: char dev node helper functions
  fpga: xrt: root driver infrastructure
  fpga: xrt: platform driver infrastructure
  fpga: xrt: management physical function driver (root)
  fpga: xrt: main platform driver for management function device
  fpga: xrt: fpga-mgr and region implementation for xclbin download
  fpga: xrt: VSEC platform driver
  fpga: xrt: User Clock Subsystem platform driver
  fpga: xrt: ICAP platform driver
  fpga: xrt: devctl platform driver
  fpga: xrt: clock platform driver
  fpga: xrt: clock frequency counter platform driver
  fpga: xrt: DDR calibration platform driver
  fpga: xrt: partition isolation platform driver
  fpga: xrt: Kconfig and Makefile updates for XRT drivers

 Documentation/fpga/index.rst                  |   1 +
 Documentation/fpga/xrt.rst                    | 844 +++++++++++++++++
 MAINTAINERS                                   |  11 +
 drivers/Makefile                              |   1 +
 drivers/fpga/Kconfig                          |   2 +
 drivers/fpga/Makefile                         |   5 +
 drivers/fpga/xrt/Kconfig                      |   8 +
 drivers/fpga/xrt/include/events.h             |  45 +
 drivers/fpga/xrt/include/group.h              |  25 +
 drivers/fpga/xrt/include/metadata.h           | 233 +++++
 drivers/fpga/xrt/include/subdev_id.h          |  38 +
 drivers/fpga/xrt/include/xclbin-helper.h      |  48 +
 drivers/fpga/xrt/include/xleaf.h              | 264 ++++++
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
 drivers/fpga/xrt/lib/cdev.c                   | 232 +++++
 drivers/fpga/xrt/lib/group.c                  | 286 ++++++
 drivers/fpga/xrt/lib/lib-drv.c                | 277 ++++++
 drivers/fpga/xrt/lib/lib-drv.h                |  17 +
 drivers/fpga/xrt/lib/subdev.c                 | 865 ++++++++++++++++++
 drivers/fpga/xrt/lib/subdev_pool.h            |  53 ++
 drivers/fpga/xrt/lib/xclbin.c                 | 369 ++++++++
 drivers/fpga/xrt/lib/xleaf/axigate.c          | 342 +++++++
 drivers/fpga/xrt/lib/xleaf/clkfreq.c          | 240 +++++
 drivers/fpga/xrt/lib/xleaf/clock.c            | 669 ++++++++++++++
 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 226 +++++
 drivers/fpga/xrt/lib/xleaf/devctl.c           | 183 ++++
 drivers/fpga/xrt/lib/xleaf/icap.c             | 344 +++++++
 drivers/fpga/xrt/lib/xleaf/ucs.c              | 167 ++++
 drivers/fpga/xrt/lib/xleaf/vsec.c             | 388 ++++++++
 drivers/fpga/xrt/lib/xroot.c                  | 589 ++++++++++++
 drivers/fpga/xrt/metadata/Kconfig             |  12 +
 drivers/fpga/xrt/metadata/Makefile            |  16 +
 drivers/fpga/xrt/metadata/metadata.c          | 545 +++++++++++
 drivers/fpga/xrt/mgmt/Kconfig                 |  15 +
 drivers/fpga/xrt/mgmt/Makefile                |  19 +
 drivers/fpga/xrt/mgmt/fmgr-drv.c              | 191 ++++
 drivers/fpga/xrt/mgmt/fmgr.h                  |  19 +
 drivers/fpga/xrt/mgmt/main-region.c           | 483 ++++++++++
 drivers/fpga/xrt/mgmt/main.c                  | 670 ++++++++++++++
 drivers/fpga/xrt/mgmt/root.c                  | 333 +++++++
 drivers/fpga/xrt/mgmt/xmgnt.h                 |  34 +
 include/uapi/linux/xrt/xclbin.h               | 409 +++++++++
 include/uapi/linux/xrt/xmgmt-ioctl.h          |  46 +
 52 files changed, 9930 insertions(+)
 create mode 100644 Documentation/fpga/xrt.rst
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/include/events.h
 create mode 100644 drivers/fpga/xrt/include/group.h
 create mode 100644 drivers/fpga/xrt/include/metadata.h
 create mode 100644 drivers/fpga/xrt/include/subdev_id.h
 create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
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
 create mode 100644 drivers/fpga/xrt/mgmt/fmgr-drv.c
 create mode 100644 drivers/fpga/xrt/mgmt/fmgr.h
 create mode 100644 drivers/fpga/xrt/mgmt/main-region.c
 create mode 100644 drivers/fpga/xrt/mgmt/main.c
 create mode 100644 drivers/fpga/xrt/mgmt/root.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgnt.h
 create mode 100644 include/uapi/linux/xrt/xclbin.h
 create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h

-- 
2.27.0

