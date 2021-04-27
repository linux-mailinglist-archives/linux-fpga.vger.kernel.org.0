Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BE336CD5F
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 22:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhD0U6h (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 16:58:37 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:39936
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239019AbhD0U6g (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 16:58:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5xNHyuEveouKZEal5SqGlFdUmkpjXF0ismyN3rBBNJIdTeC7lqwJbQ3bPdW7KFuwazgdA6nnrWyaUPHvKSrfC4g+Hh9DfnH1qgQXRtHZtLPjinL8wxHx6aRGlBenTcXZ4CHkekZEeu59THMnEbtQSHBhfch04+XAiUwbqBIqDnq+BvTvyNcqirHuacZoeaO35wp/ZrneWFCRdZHsQ+pWObE8Xj+Owc3BgkQp/rqSQVjv+j5JyVcuOEZH0phl2p3MosCRKWi6H9DSm4vcGbpAmauQB72f7+nu6RMk6a7hNkM5qA6Fn2bahE6Iaf2oSbTtw/rAeN1nTV08zAJt4nLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5+VfAbcW7h/IassAGSriwGr1PV4uYtm8Mu4RfCGF5U=;
 b=TC7jjmgvbiyFMEufUMmEBJmwGpl451tB87llgS3y/Uk0mKuy+p1NR1fp1lC8dNpjZK8IlkfZ7uAEA5NQFQIzQr2Q7SMPQsBwC6zXAC09eSyXHHksOrK+ASvyz/c5Jz9y5PwJW4ZR8Mc8wkV/gxMEFSggXjocBWB5nYuTx2ngHiwJuloxsYCn0c+LvSOdqYc04KJl/A0cg66SEUraV8yotrMXqge+fbTEyLPQypjVhfV2x17FjlA9tJdckfTQ+iaprxqbAjTF8FrKcs4/SFKAv4l1/BHGqKr+ENY9ZhXj7g9CDr4Zi4u9b3r/k4pazd/jrEh8m7li56lg0aHDWpDbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5+VfAbcW7h/IassAGSriwGr1PV4uYtm8Mu4RfCGF5U=;
 b=a5/AnckiWU/inNk3rhkyi2GRDNu1eaRDFUVSPAURA1xGneaFY1o1rSEsq0pW4Xf6qg8e6BIP9w+F2f/TGeVQlcTs5E0JjlAFfyOmGbzLmW/BHqwGlr+ySWvqOdNntK9iQqDRg7EaNsk5zwalSRow4MyxU4wnqtfG/k3BfrG2okg=
Received: from BL1PR13CA0288.namprd13.prod.outlook.com (2603:10b6:208:2bc::23)
 by PH0PR02MB7701.namprd02.prod.outlook.com (2603:10b6:510:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 20:57:50 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bc:cafe::f) by BL1PR13CA0288.outlook.office365.com
 (2603:10b6:208:2bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend
 Transport; Tue, 27 Apr 2021 20:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 20:57:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 13:57:48 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 13:57:48 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51992 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUmC-0001gB-SH; Tue, 27 Apr 2021 13:57:48 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 1E9EC600125; Tue, 27 Apr 2021 13:54:35 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>
Subject: [PATCH V5 XRT Alveo 00/20] XRT Alveo driver overview
Date:   Tue, 27 Apr 2021 13:54:11 -0700
Message-ID: <20210427205431.23896-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e285e3f0-61a5-44ec-7cea-08d909bf1e82
X-MS-TrafficTypeDiagnostic: PH0PR02MB7701:
X-Microsoft-Antispam-PRVS: <PH0PR02MB7701B2543414CCDB517D38CAA1419@PH0PR02MB7701.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oo1ebRPa3HFxgbdm8xrRMWFaGZHklGUueO9pcTnY1kMdDJwQYGH5ET2WW9w0mS6jmvBtayTfSZji1dkYYmPnEtR16rOn39yS3Wgi+TZG2rOt+/JNgJw46B2Hso9jLyELuugshlVJ3sTOo9MbeKPVRc7MT48UIJ0M47iJN74jQQPkdp6iLtjGjed3FZOSMbp0c/ldstJHTgBj7bi3feoazVchWCpmN04TpOT8iGmaY1O2499OKfRGotu1N1f1qLug+GuQlzoj3iV36qtA84Ub8QRWD+iDZ4swe7YKu2dw2kvliKVNpjVlnZFmHOgWGrfMEdsF1NhDtXsctAoJKHtHO/G4v2wZoWoh/7sRRDyuWcceOHLeOAGDLAZ8jTNdeZwlgQywM254hgQVCGRwY7P5QMEPI/FNlaYmCf7np75zuKEdkBhum+9RV/ZgxYoWDIBpmDHXemNF8f6HVA4mJNYQ/TtQ+cuAZhDVWeDfjwVovT9syQYRQIq2ttg+H7K8vbu3VzFezBq+Oz2y32LxGEluOOmsWCQ0rdDod6QbHHQ0A4TJcxgLHI2S9N5cXUE+xQz6Tm5Zx7ewjHwmAI9hJoOw8Bkh7kQ2xRyrrr1qPd00eP+XHOlOHPlLTwwBHQuWEywchrwzlQU7UBpk+SuANdluSjP11uazD3BT3waMZko/rrimHxBURCP/u/taHJ6rz+LXxyS+Kik1PU3vTC3u5n7yt8LFSv5e0dmapZ4lf7lQnE4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(346002)(376002)(36840700001)(46966006)(82740400003)(356005)(7636003)(83380400001)(70586007)(6916009)(26005)(6266002)(82310400003)(2906002)(70206006)(36906005)(42186006)(316002)(186003)(4326008)(36756003)(8676002)(478600001)(54906003)(966005)(5660300002)(1076003)(6666004)(336012)(2616005)(426003)(44832011)(30864003)(8936002)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 20:57:50.3438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e285e3f0-61a5-44ec-7cea-08d909bf1e82
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7701
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This is V5 of patch series which adds management physical function driver
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

XRT Linux kernel driver *xrt-mgnt* binds to management physical function of
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

xrt-mgnt driver can be tested with full XRT open source stack which
includes user space libraries, board utilities and (out of tree) first
generation user physical function driver xocl. XRT open source runtime
stack is available at https://github.com/Xilinx/XRT

Complete documentation for XRT open source stack including sections on
Alveo/XRT security and platform architecture can be found here:

https://xilinx.github.io/XRT/master/html/index.html
https://xilinx.github.io/XRT/master/html/security.html
https://xilinx.github.io/XRT/master/html/platforms_partitions.html

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

For reference V4 version of patch series can be found here:

https://lore.kernel.org/lkml/20210324052947.27889-1-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-2-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-3-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-4-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-5-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-6-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-7-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-8-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-9-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-10-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-11-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-12-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-13-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-14-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-15-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-16-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-17-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-18-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-19-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-20-lizhi.hou@xilinx.com
https://lore.kernel.org/lkml/20210324052947.27889-21-lizhi.hou@xilinx.com/

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
 Documentation/fpga/xrt.rst                    | 844 +++++++++++++++++
 MAINTAINERS                                   |  11 +
 drivers/Makefile                              |   1 +
 drivers/fpga/Kconfig                          |   2 +
 drivers/fpga/Makefile                         |   5 +
 drivers/fpga/xrt/Kconfig                      |   8 +
 drivers/fpga/xrt/include/events.h             |  45 +
 drivers/fpga/xrt/include/group.h              |  25 +
 drivers/fpga/xrt/include/metadata.h           | 236 +++++
 drivers/fpga/xrt/include/subdev_id.h          |  38 +
 drivers/fpga/xrt/include/xclbin-helper.h      |  48 +
 drivers/fpga/xrt/include/xdevice.h            | 131 +++
 drivers/fpga/xrt/include/xleaf.h              | 205 +++++
 drivers/fpga/xrt/include/xleaf/axigate.h      |  23 +
 drivers/fpga/xrt/include/xleaf/clkfreq.h      |  21 +
 drivers/fpga/xrt/include/xleaf/clock.h        |  29 +
 .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +
 drivers/fpga/xrt/include/xleaf/devctl.h       |  40 +
 drivers/fpga/xrt/include/xleaf/icap.h         |  27 +
 drivers/fpga/xrt/include/xmgnt-main.h         |  34 +
 drivers/fpga/xrt/include/xroot.h              | 117 +++
 drivers/fpga/xrt/lib/Kconfig                  |  17 +
 drivers/fpga/xrt/lib/Makefile                 |  30 +
 drivers/fpga/xrt/lib/cdev.c                   | 210 +++++
 drivers/fpga/xrt/lib/group.c                  | 278 ++++++
 drivers/fpga/xrt/lib/lib-drv.c                | 328 +++++++
 drivers/fpga/xrt/lib/lib-drv.h                |  15 +
 drivers/fpga/xrt/lib/subdev.c                 | 847 ++++++++++++++++++
 drivers/fpga/xrt/lib/subdev_pool.h            |  53 ++
 drivers/fpga/xrt/lib/xclbin.c                 | 369 ++++++++
 drivers/fpga/xrt/lib/xleaf/axigate.c          | 325 +++++++
 drivers/fpga/xrt/lib/xleaf/clkfreq.c          | 223 +++++
 drivers/fpga/xrt/lib/xleaf/clock.c            | 652 ++++++++++++++
 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 +++++
 drivers/fpga/xrt/lib/xleaf/devctl.c           | 169 ++++
 drivers/fpga/xrt/lib/xleaf/icap.c             | 328 +++++++
 drivers/fpga/xrt/lib/xleaf/ucs.c              | 152 ++++
 drivers/fpga/xrt/lib/xleaf/vsec.c             | 372 ++++++++
 drivers/fpga/xrt/lib/xroot.c                  | 536 +++++++++++
 drivers/fpga/xrt/metadata/Kconfig             |  12 +
 drivers/fpga/xrt/metadata/Makefile            |  16 +
 drivers/fpga/xrt/metadata/metadata.c          | 578 ++++++++++++
 drivers/fpga/xrt/mgnt/Kconfig                 |  15 +
 drivers/fpga/xrt/mgnt/Makefile                |  19 +
 drivers/fpga/xrt/mgnt/root.c                  | 419 +++++++++
 drivers/fpga/xrt/mgnt/xmgnt-main-region.c     | 485 ++++++++++
 drivers/fpga/xrt/mgnt/xmgnt-main.c            | 660 ++++++++++++++
 drivers/fpga/xrt/mgnt/xmgnt.h                 |  33 +
 drivers/fpga/xrt/mgnt/xrt-mgr.c               | 190 ++++
 drivers/fpga/xrt/mgnt/xrt-mgr.h               |  16 +
 include/uapi/linux/xrt/xclbin.h               | 409 +++++++++
 include/uapi/linux/xrt/xmgnt-ioctl.h          |  46 +
 53 files changed, 9931 insertions(+)
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
 create mode 100644 drivers/fpga/xrt/include/xmgnt-main.h
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
 create mode 100644 drivers/fpga/xrt/mgnt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgnt/Makefile
 create mode 100644 drivers/fpga/xrt/mgnt/root.c
 create mode 100644 drivers/fpga/xrt/mgnt/xmgnt-main-region.c
 create mode 100644 drivers/fpga/xrt/mgnt/xmgnt-main.c
 create mode 100644 drivers/fpga/xrt/mgnt/xmgnt.h
 create mode 100644 drivers/fpga/xrt/mgnt/xrt-mgr.c
 create mode 100644 drivers/fpga/xrt/mgnt/xrt-mgr.h
 create mode 100644 include/uapi/linux/xrt/xclbin.h
 create mode 100644 include/uapi/linux/xrt/xmgnt-ioctl.h

-- 
2.27.0

