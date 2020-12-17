Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD642DCD1B
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 08:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgLQHxR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 02:53:17 -0500
Received: from mail-eopbgr770058.outbound.protection.outlook.com ([40.107.77.58]:28736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726470AbgLQHxQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 02:53:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYFqvh1ZXBtYFqDkvMP1SCZI3+tu5LzERauU1QuR2iMBplnplXCqsz0SZRcKNltoHqBD0Plfwn/hHJI2K2ifWZmzneiTFpelc2H8aJOS1PmZlqLvYKMBIoABVII3TN9rPz/WB4vh8slOTd3h+CAQFgjgAlP/CeOTySI0If+tuBeLb2Yq8k/OCVIU56pVIxFwwjJc7pKurMANmUy+dS5bw42bIRW3DCuAJHvW0FYe8ziwZOtxKFg0BqYlIslj5e9/EaCJxNuYZsg7YBbmC+ifqLLK6BDBEh99m5HuTJ77B0U1RN9/hSOLdTNGqsL+SNj/IiJITM7mq2SJajsAL/jdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZhF2BKQDdZbCN+9IYm54rtcACJUYNPI1CvxS86jDno=;
 b=N3eh4Ucwkm/tQXKrofRwdx88g3ddJrd32O5wQg7SZuz723jlCOKZn9unguGfvMxGbVTNjZgbqWSAGSsLnv/beDFojOi/3m7gygLM1LpglckI0VslKa23hLlOTcr4VwermFt9PYF7oeuMRA/32YTCvZpi21WIjHTl1QgxQTPO5tvkJWPfU559/jzThTDBy+xs+Xc99fW5gkltM4JofVmYo0luafA9oQCTZcLz7tSuJJ5izrHUsnRsrcqbbGAD4QBHYmuUNBVhXZM3XLVfpVdejvlHaXUuOXcWMT085dN3VoKPtWt5F4dZumcZFvAkUZ1XqxvCVkfB1HXt1Zi28Nl01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZhF2BKQDdZbCN+9IYm54rtcACJUYNPI1CvxS86jDno=;
 b=qt1ilMX5lqFTX0JG39O/DsgbXD3CMzKnNIvMBSvM9bDOY0c34efMm7r8viwZ+rMMyUlC+6vbUNGCwARSxfWv2U+AGFsau7KwY1xrdXrL+7kCzn1h5549yGPg1n87NRjVYNFfWNAZq+aMdmcuJsz61Sm4LkBC3uVvXbtTl6sRxtk=
Received: from DM6PR02CA0166.namprd02.prod.outlook.com (2603:10b6:5:332::33)
 by BYAPR02MB4085.namprd02.prod.outlook.com (2603:10b6:a02:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Thu, 17 Dec
 2020 07:52:27 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::5c) by DM6PR02CA0166.outlook.office365.com
 (2603:10b6:5:332::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 17 Dec 2020 07:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 07:52:27 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 16 Dec 2020 23:52:27 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 16 Dec 2020 23:52:27 -0800
Envelope-to: michal.simek@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 sonals@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=42036 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kpo5K-0007XC-V2; Wed, 16 Dec 2020 23:52:26 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id F24C060010B; Wed, 16 Dec 2020 23:51:07 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonals@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <trix@redhat.com>, <mdf@kernel.org>
Subject: [PATCH V2 XRT Alveo 0/6] XRT Alveo driver overview 
Date:   Wed, 16 Dec 2020 23:50:40 -0800
Message-ID: <20201217075046.28553-1-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a442aae6-c177-48d6-2efb-08d8a260b2f8
X-MS-TrafficTypeDiagnostic: BYAPR02MB4085:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4085D8CA20264516BDB4B94FBBC40@BYAPR02MB4085.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJbmruI1YhSOu0oRZAsgvihDPmza0cqQQmWZrQ755j2lk7Yaqu7awief8YcMAN9XvoAyQLiOqQ2FvX8Dmpf+kW2dE6x2nw9Bgg0S1nbRmN/mlyQzu7FHx7xbZ21m2c/25uZ39ZTYmDoMp66JS85u8SjRxSzPLyjsnGdKVmc5BWAnHl8fjXntcMw8wCUzTxFdrxQaCPYI2Wn15g/N+JuC+9VPuPXjKnHS/IhwVIPmso2CTSNS0HaJHeNRCi2iG0DDwQZ8hWDIEd5QutSUzSHMh4y3yX36Lh2eDZlIcKdhXouEXd7fQcBg2WZE+jYV/JLajIDCWmR1hHX5Vz3T9X/X64ueB7Etbumjiof7mR88zwM7lVvRkwFT2OoVpk+0U3VryescRr7ZEcMg5co9VPl+FY8chJVpe0Ggl1QBnwF/NKxGbgkslzp4teafoSMMVsjnHFgvJV8wmW5eFArKZN2yvD1EzDdS6sW6m/BtFgnMrT6DZcAH+eUoZ3nAzqDGlRQJ9ZKf9v598pE7GAizR+RKXw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966005)(36906005)(4326008)(2616005)(5660300002)(6666004)(44832011)(316002)(26005)(426003)(1076003)(42186006)(8676002)(336012)(6916009)(7636003)(83380400001)(356005)(36756003)(54906003)(186003)(478600001)(82740400003)(8936002)(966005)(47076004)(4743002)(6266002)(2906002)(82310400003)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 07:52:27.5470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a442aae6-c177-48d6-2efb-08d8a260b2f8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4085
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hello,

This is V2 of patch series which adds management physical function driver
for Xilinx Alveo PCIe accelerator cards,
https://www.xilinx.com/products/boards-and-kits/alveo.html
This driver is part of Xilinx Runtime (XRT) open source stack.

The patch series depends on libfdt patches which were posted before:
https://lore.kernel.org/lkml/20201128235659.24679-1-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201128235659.24679-2-sonals@xilinx.com/

ALVEO PLATFORM ARCHITECTURE

Alveo PCIe FPGA based platforms have a static *shell* partition and a partial
re-configurable *user* partition. The shell partition is automatically loaded from
flash when host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
till the next cold reboot. The shell exposes two PCIe physical functions:

1. management physical function
2. user physical function

The patch series includes Documentation/xrt.rst which describes Alveo
platform, XRT driver architecture and deployment model in more detail.

Users compile their high level design in C/C++/OpenCL or RTL into FPGA image
using Vitis https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
tools. The compiled image is packaged as xclbin and contains partial bitstream
for the user partition and necessary metadata. Users can dynamically swap the
image running on the user partition in order to switch between different workloads.

XRT DRIVERS FOR ALVEO

XRT Linux kernel driver *xmgmt* binds to management physical function of
Alveo platform. The modular driver framework is organized into several
platform drivers which primarily handle the following functionality:

1.  Loading firmware container also called xsabin at driver attach time
2.  Loading of user compiled xclbin with FPGA Manager integration
3.  Clock scaling of image running on user partition
4.  In-band sensors: temp, voltage, power, etc.
5.  Device reset and rescan
6.  Flash upgrade of static *shell* partition

The platform drivers are packaged into *xrt-lib* helper module with a well
defined interfaces the details of which can be found in Documentation/xrt.rst.

User physical function driver is not included in this patch series.

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

Changes since v1:
- Updated the driver to use fpga_region and fpga_bridge for FPGA
  programming
- Dropped subdev drivers not related to PR programming to focus on XRT
  core framework
- Updated Documentation/fpga/xrt.rst with information on XRT core framework
- Addressed checkpatch issues 
- Dropped xrt- prefix from some header files

For reference V1 version of patch series can be found here--
https://lore.kernel.org/lkml/20201129000040.24777-1-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201129000040.24777-2-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201129000040.24777-3-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201129000040.24777-4-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201129000040.24777-5-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201129000040.24777-6-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201129000040.24777-7-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201129000040.24777-8-sonals@xilinx.com/
https://lore.kernel.org/lkml/20201129000040.24777-9-sonals@xilinx.com/

Thanks,
-Sonal

Sonal Santan (6):
  Documentation: fpga: Add a document describing XRT Alveo drivers
  fpga: xrt: infrastructure support for xmgmt driver
  fpga: xrt: core infrastructure for xrt-lib module
  fpga: xrt: XRT Alveo management physical function driver
  fpga: xrt: platform drivers for subsystems in shell partition
  fpga: xrt: Kconfig and Makefile updates for XRT drivers

 Documentation/fpga/index.rst                 |    1 +
 Documentation/fpga/xrt.rst                   |  649 +++++++++++
 drivers/fpga/Kconfig                         |    2 +
 drivers/fpga/Makefile                        |    4 +
 drivers/fpga/xrt/Kconfig                     |    7 +
 drivers/fpga/xrt/Makefile                    |   21 +
 drivers/fpga/xrt/common/xrt-metadata.c       |  590 ++++++++++
 drivers/fpga/xrt/common/xrt-root.c           |  737 +++++++++++++
 drivers/fpga/xrt/common/xrt-root.h           |   26 +
 drivers/fpga/xrt/common/xrt-xclbin.c         |  387 +++++++
 drivers/fpga/xrt/common/xrt-xclbin.h         |   48 +
 drivers/fpga/xrt/include/metadata.h          |  184 ++++
 drivers/fpga/xrt/include/parent.h            |  103 ++
 drivers/fpga/xrt/include/partition.h         |   33 +
 drivers/fpga/xrt/include/subdev.h            |  333 ++++++
 drivers/fpga/xrt/include/subdev/axigate.h    |   31 +
 drivers/fpga/xrt/include/subdev/calib.h      |   28 +
 drivers/fpga/xrt/include/subdev/clkfreq.h    |   21 +
 drivers/fpga/xrt/include/subdev/clock.h      |   29 +
 drivers/fpga/xrt/include/subdev/gpio.h       |   41 +
 drivers/fpga/xrt/include/subdev/icap.h       |   27 +
 drivers/fpga/xrt/include/subdev/ucs.h        |   22 +
 drivers/fpga/xrt/include/xmgmt-main.h        |   34 +
 drivers/fpga/xrt/lib/Kconfig                 |   11 +
 drivers/fpga/xrt/lib/Makefile                |   30 +
 drivers/fpga/xrt/lib/subdevs/xrt-axigate.c   |  298 ++++++
 drivers/fpga/xrt/lib/subdevs/xrt-calib.c     |  226 ++++
 drivers/fpga/xrt/lib/subdevs/xrt-clkfreq.c   |  214 ++++
 drivers/fpga/xrt/lib/subdevs/xrt-clock.c     |  638 +++++++++++
 drivers/fpga/xrt/lib/subdevs/xrt-gpio.c      |  198 ++++
 drivers/fpga/xrt/lib/subdevs/xrt-icap.c      |  306 ++++++
 drivers/fpga/xrt/lib/subdevs/xrt-partition.c |  261 +++++
 drivers/fpga/xrt/lib/subdevs/xrt-ucs.c       |  238 +++++
 drivers/fpga/xrt/lib/subdevs/xrt-vsec.c      |  337 ++++++
 drivers/fpga/xrt/lib/xrt-cdev.c              |  234 ++++
 drivers/fpga/xrt/lib/xrt-main.c              |  270 +++++
 drivers/fpga/xrt/lib/xrt-main.h              |   46 +
 drivers/fpga/xrt/lib/xrt-subdev.c            | 1007 ++++++++++++++++++
 drivers/fpga/xrt/mgmt/Kconfig                |   11 +
 drivers/fpga/xrt/mgmt/Makefile               |   27 +
 drivers/fpga/xrt/mgmt/xmgmt-fmgr-drv.c       |  179 ++++
 drivers/fpga/xrt/mgmt/xmgmt-fmgr.h           |   29 +
 drivers/fpga/xrt/mgmt/xmgmt-main-impl.h      |   35 +
 drivers/fpga/xrt/mgmt/xmgmt-main-region.c    |  476 +++++++++
 drivers/fpga/xrt/mgmt/xmgmt-main.c           |  738 +++++++++++++
 drivers/fpga/xrt/mgmt/xmgmt-root.c           |  375 +++++++
 include/uapi/linux/xrt/xclbin.h              |  386 +++++++
 include/uapi/linux/xrt/xmgmt-ioctl.h         |   72 ++
 48 files changed, 10000 insertions(+)
 create mode 100644 Documentation/fpga/xrt.rst
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/Makefile
 create mode 100644 drivers/fpga/xrt/common/xrt-metadata.c
 create mode 100644 drivers/fpga/xrt/common/xrt-root.c
 create mode 100644 drivers/fpga/xrt/common/xrt-root.h
 create mode 100644 drivers/fpga/xrt/common/xrt-xclbin.c
 create mode 100644 drivers/fpga/xrt/common/xrt-xclbin.h
 create mode 100644 drivers/fpga/xrt/include/metadata.h
 create mode 100644 drivers/fpga/xrt/include/parent.h
 create mode 100644 drivers/fpga/xrt/include/partition.h
 create mode 100644 drivers/fpga/xrt/include/subdev.h
 create mode 100644 drivers/fpga/xrt/include/subdev/axigate.h
 create mode 100644 drivers/fpga/xrt/include/subdev/calib.h
 create mode 100644 drivers/fpga/xrt/include/subdev/clkfreq.h
 create mode 100644 drivers/fpga/xrt/include/subdev/clock.h
 create mode 100644 drivers/fpga/xrt/include/subdev/gpio.h
 create mode 100644 drivers/fpga/xrt/include/subdev/icap.h
 create mode 100644 drivers/fpga/xrt/include/subdev/ucs.h
 create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-axigate.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-calib.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-clkfreq.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-clock.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-gpio.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-icap.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-partition.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-ucs.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-vsec.c
 create mode 100644 drivers/fpga/xrt/lib/xrt-cdev.c
 create mode 100644 drivers/fpga/xrt/lib/xrt-main.c
 create mode 100644 drivers/fpga/xrt/lib/xrt-main.h
 create mode 100644 drivers/fpga/xrt/lib/xrt-subdev.c
 create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-fmgr-drv.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-fmgr.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-impl.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-region.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-root.c
 create mode 100644 include/uapi/linux/xrt/xclbin.h
 create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h

-- 
2.17.1

