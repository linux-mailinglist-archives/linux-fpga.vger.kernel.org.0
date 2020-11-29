Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF72C76B2
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Nov 2020 01:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgK2ACd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Nov 2020 19:02:33 -0500
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:56672
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgK2ACd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Nov 2020 19:02:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfMJqWoPHkkrBBpfcCfgiH6Dh70GqKL7T4hRu5jfGOXGaqBGy0GD3KwmgK14zhlADlmrugqQM55KuNU59T2svl7S7HTPkGp5CNNgV56Pe2Qn4Ja5htyfOVNAcOeEclP4/iCUoyWWbUOyrgbE4fjh932PHQ+tis+cj4DzpPLBjz4ecr/k1plhRZAh/BkHR7S7zziOLEo/xrruQVoeIHr/UwcTnthncWYvsVS95qoMTLwlzK+AYKfbwzlF8TXCxE8qte6M8CTJ22nKL+wtlx8WfTkEBqbtrfiT2cNahxGSLMiXttciCVc/d4kiZa2alxE3VzsesPfBTk9h6tksbzW4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4x/9h3IRmnE4xImE9iZZl98dU9et7O0tYfp3x+XiNQ=;
 b=Ba0X/g1xiqVPX5BIrDzhmyi41hmGgmr7NrAsfVDq0Qjil3Uz/sSWGsKKKI4qhPVbersJnb1fcVEa+1jHlnfpMkv2KjsYfPwGw+qOz/kksm1ugZ1Yz1uMeFR6qboSxO1+zAwc0DXze2txpJHlaCmzr/Fr35ZIpkk2vvClLH4c5WOfQqMgKvHwFSRlxFP0Pg/1Ob3WMzB7tmdKb4cQ55TxCqurvpuILYpHDaHrikRXuGX2L/Lzsrgt2vFkSyge5g2F0MVqEX7Umy3Hihy/2d0aAtBChytqenzNIOg6KXrc7lfMRcP9J8xBCmN0GnYqngsXEFzKMblNpOtSqDO2cwR3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4x/9h3IRmnE4xImE9iZZl98dU9et7O0tYfp3x+XiNQ=;
 b=dipDdEOZByzpDRZ38yVQo+HBrKS+oEVs/UuvvWalR7DWqEuhl5IBv+hzTaVW2zWLpZGj/w8IaSQU74MyPKd2Mryc4oPhTrwwKfx9GmwNo8PUuPzXjHQuwfTPpKWLYlhYw5QjoSUCl5NvwpXKe5l0Gubm8a2+wjWtkhhVwModEP0=
Received: from MN2PR20CA0016.namprd20.prod.outlook.com (2603:10b6:208:e8::29)
 by MW4PR02MB7345.namprd02.prod.outlook.com (2603:10b6:303:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 00:01:40 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::7e) by MN2PR20CA0016.outlook.office365.com
 (2603:10b6:208:e8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sun, 29 Nov 2020 00:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sun, 29 Nov 2020 00:01:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 16:01:39 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 16:01:39 -0800
Envelope-to: michal.simek@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 sonals@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45046 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjA9r-0000B4-6s; Sat, 28 Nov 2020 16:01:39 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id D36C060010C; Sat, 28 Nov 2020 16:00:44 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonals@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo 0/8] Xilinx Alveo/XRT patch overview 
Date:   Sat, 28 Nov 2020 16:00:32 -0800
Message-ID: <20201129000040.24777-1-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df7c4b36-8b0d-4ec3-d4cb-08d893f9f2cf
X-MS-TrafficTypeDiagnostic: MW4PR02MB7345:
X-Microsoft-Antispam-PRVS: <MW4PR02MB7345E253791491A1FFFA0A65BBF60@MW4PR02MB7345.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6J/mVIaS7bHar0VnhqjarW6AVBn4+2EF2/9TZZnWkp2+SFQ+QwV2z5qwGa3iD3HeSccQCyfe3RKd6r1bW87O1hjmb+yhWvSVZGWHf0eeBzfKPPwSaH772DIv2b7n3kbT6+9L/ssdBSNfOj5Zsta/zyNEVfWlreXbbWDhR3Xg3kDhZNo4Z8TDhV8DJ9jFf/tXwB1VCEWs1ryP0yKds9bJM9/L8ArUNXjs+tbzcIXi/Mn5EfDMAmpDGvPg3y8jFdLxxspkMHT78Vf7xJdvyz88XS7mruhQNdVvebfWHRP2ETKNXnzrpwGefiN0ZZy7MbUA378nDl4sGOwYn0d70GpxKE1ZkonIQNttuosiK4ws/NXsB2u+PdtxP57UAZ7n2k/Iy3DTXqRCD6kSgPU8Pz+rx66x7m0r3os/4B6VcB/vGrHXi/47V5TgE+HaStJBU/BdvKmLOPZzQ7pYebj2HMNfA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39850400004)(46966005)(316002)(44832011)(42186006)(8676002)(54906003)(36906005)(186003)(1076003)(336012)(426003)(2906002)(26005)(2616005)(966005)(4743002)(6916009)(478600001)(4326008)(450100002)(8936002)(6666004)(70586007)(82740400003)(47076004)(7636003)(5660300002)(82310400003)(356005)(30864003)(83380400001)(6266002)(36756003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 00:01:40.1362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7c4b36-8b0d-4ec3-d4cb-08d893f9f2cf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7345
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello,

This patch series adds management physical function driver for Xilinx Alveo PCIe
accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
This driver is part of Xilinx Runtime (XRT) open source stack.

The patch depends on the "PATCH Xilinx Alveo libfdt prep" which was posted
before.

ALVEO PLATFORM ARCHITECTURE

Alveo PCIe FPGA based platforms have a static *shell* partition and a partial
re-configurable *user* partition. The shell partition is automatically loaded from
flash when host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
till the next cold reboot. The shell exposes two PCIe physical functions:

1. management physical function
2. user physical function

The patch series includes Documentation/xrt.rst which describes Alveo
platform, xmgmt driver architecture and deployment model in more more detail.

Users compile their high level design in C/C++/OpenCL or RTL into FPGA image
using Vitis https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
tools. The image is packaged as xclbin and contains partial bitstream for the
user partition and necessary metadata. Users can dynamically swap the image
running on the user partition in order to switch between different workloads.

ALVEO DRIVERS

Alveo Linux kernel driver *xmgmt* binds to management physical function of
Alveo platform. The modular driver framework is organized into several
platform drivers which primarily handle the following functionality:

1.  Loading firmware container also called xsabin at driver attach time
2.  Loading of user compiled xclbin with FPGA Manager integration
3.  Clock scaling of image running on user partition
4.  In-band sensors: temp, voltage, power, etc.
5.  Device reset and rescan
6.  Flashing static *shell* partition

The platform drivers are packaged into *xrt-lib* helper module with a well
defined interfaces the details of which can be found in Documentation/xrt.rst.

xmgmt driver is second generation Alveo management driver and evolution of
the first generation (out of tree) Alveo management driver, xclmgmt. The
sources of the first generation drivers were posted on LKML last year--
https://lore.kernel.org/lkml/20190319215401.6562-1-sonal.santan@xilinx.com/

Changes since the first generation driver include the following: the driver
has been re-architected as data driven modular driver; the driver has been
split into xmgmt and xrt-lib; user physical function driver has been removed
from the patch series.

Alveo/XRT security and platform architecture is documented on the following 
GitHub pages:
https://xilinx.github.io/XRT/master/html/security.html
https://xilinx.github.io/XRT/master/html/platforms_partitions.html

User physical function driver is not included in this patch series.

TESTING AND VALIDATION

xmgmt driver can be tested with full XRT open source stack which includes
user space libraries, board utilities and (out of tree) first generation
user physical function driver xocl. XRT open source runtime stack is
available at https://github.com/Xilinx/XRT. This patch series has been
validated on Alveo U50 platform.

Complete documentation for XRT open source stack can be found here--
https://xilinx.github.io/XRT/master/html/index.html

Thanks,
-Sonal

Sonal Santan (8):
  Documentation: fpga: Add a document describing Alveo XRT drivers
  fpga: xrt: Add UAPI header files
  fpga: xrt: infrastructure support for xmgmt driver
  fpga: xrt: core infrastructure for xrt-lib module
  fpga: xrt: platform drivers for subsystems in shell partition
  fpga: xrt: header file for platform and parent drivers
  fpga: xrt: Alveo management physical function driver
  fpga: xrt: Kconfig and Makefile updates for XRT drivers

 Documentation/fpga/index.rst                  |    1 +
 Documentation/fpga/xrt.rst                    |  588 +++++
 drivers/fpga/Kconfig                          |    2 +
 drivers/fpga/Makefile                         |    3 +
 drivers/fpga/alveo/Kconfig                    |    7 +
 drivers/fpga/alveo/common/xrt-metadata.c      |  590 +++++
 drivers/fpga/alveo/common/xrt-root.c          |  744 +++++++
 drivers/fpga/alveo/common/xrt-root.h          |   24 +
 drivers/fpga/alveo/common/xrt-xclbin.c        |  387 ++++
 drivers/fpga/alveo/common/xrt-xclbin.h        |   46 +
 drivers/fpga/alveo/include/xmgmt-main.h       |   34 +
 drivers/fpga/alveo/include/xrt-axigate.h      |   31 +
 drivers/fpga/alveo/include/xrt-calib.h        |   28 +
 drivers/fpga/alveo/include/xrt-clkfreq.h      |   21 +
 drivers/fpga/alveo/include/xrt-clock.h        |   29 +
 drivers/fpga/alveo/include/xrt-cmc.h          |   23 +
 drivers/fpga/alveo/include/xrt-ddr-srsr.h     |   29 +
 drivers/fpga/alveo/include/xrt-flash.h        |   28 +
 drivers/fpga/alveo/include/xrt-gpio.h         |   41 +
 drivers/fpga/alveo/include/xrt-icap.h         |   27 +
 drivers/fpga/alveo/include/xrt-mailbox.h      |   44 +
 drivers/fpga/alveo/include/xrt-metadata.h     |  184 ++
 drivers/fpga/alveo/include/xrt-parent.h       |  103 +
 drivers/fpga/alveo/include/xrt-partition.h    |   33 +
 drivers/fpga/alveo/include/xrt-subdev.h       |  333 +++
 drivers/fpga/alveo/include/xrt-ucs.h          |   22 +
 drivers/fpga/alveo/lib/Kconfig                |   11 +
 drivers/fpga/alveo/lib/Makefile               |   42 +
 drivers/fpga/alveo/lib/subdevs/xrt-axigate.c  |  298 +++
 drivers/fpga/alveo/lib/subdevs/xrt-calib.c    |  291 +++
 drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c  |  214 ++
 drivers/fpga/alveo/lib/subdevs/xrt-clock.c    |  638 ++++++
 .../fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c   |  343 +++
 drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c |  322 +++
 drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h |  135 ++
 .../fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c  |  320 +++
 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c   |  361 ++++
 .../fpga/alveo/lib/subdevs/xrt-cmc-sensors.c  |  445 ++++
 drivers/fpga/alveo/lib/subdevs/xrt-cmc.c      |  239 +++
 drivers/fpga/alveo/lib/subdevs/xrt-gpio.c     |  198 ++
 drivers/fpga/alveo/lib/subdevs/xrt-icap.c     |  306 +++
 drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c  | 1905 +++++++++++++++++
 .../fpga/alveo/lib/subdevs/xrt-partition.c    |  261 +++
 drivers/fpga/alveo/lib/subdevs/xrt-qspi.c     | 1347 ++++++++++++
 drivers/fpga/alveo/lib/subdevs/xrt-srsr.c     |  322 +++
 drivers/fpga/alveo/lib/subdevs/xrt-test.c     |  274 +++
 drivers/fpga/alveo/lib/subdevs/xrt-ucs.c      |  238 ++
 .../fpga/alveo/lib/subdevs/xrt-vsec-golden.c  |  238 ++
 drivers/fpga/alveo/lib/subdevs/xrt-vsec.c     |  337 +++
 drivers/fpga/alveo/lib/xrt-cdev.c             |  234 ++
 drivers/fpga/alveo/lib/xrt-main.c             |  275 +++
 drivers/fpga/alveo/lib/xrt-main.h             |   46 +
 drivers/fpga/alveo/lib/xrt-subdev.c           | 1007 +++++++++
 drivers/fpga/alveo/mgmt/Kconfig               |   11 +
 drivers/fpga/alveo/mgmt/Makefile              |   28 +
 drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c      |  194 ++
 drivers/fpga/alveo/mgmt/xmgmt-fmgr.h          |   29 +
 drivers/fpga/alveo/mgmt/xmgmt-main-impl.h     |   36 +
 drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c  |  930 ++++++++
 drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c      |  190 ++
 drivers/fpga/alveo/mgmt/xmgmt-main.c          |  843 ++++++++
 drivers/fpga/alveo/mgmt/xmgmt-root.c          |  375 ++++
 include/uapi/linux/xrt/flash_xrt_data.h       |   67 +
 include/uapi/linux/xrt/mailbox_proto.h        |  394 ++++
 include/uapi/linux/xrt/mailbox_transport.h    |   74 +
 include/uapi/linux/xrt/xclbin.h               |  418 ++++
 include/uapi/linux/xrt/xmgmt-ioctl.h          |   72 +
 67 files changed, 17710 insertions(+)
 create mode 100644 Documentation/fpga/xrt.rst
 create mode 100644 drivers/fpga/alveo/Kconfig
 create mode 100644 drivers/fpga/alveo/common/xrt-metadata.c
 create mode 100644 drivers/fpga/alveo/common/xrt-root.c
 create mode 100644 drivers/fpga/alveo/common/xrt-root.h
 create mode 100644 drivers/fpga/alveo/common/xrt-xclbin.c
 create mode 100644 drivers/fpga/alveo/common/xrt-xclbin.h
 create mode 100644 drivers/fpga/alveo/include/xmgmt-main.h
 create mode 100644 drivers/fpga/alveo/include/xrt-axigate.h
 create mode 100644 drivers/fpga/alveo/include/xrt-calib.h
 create mode 100644 drivers/fpga/alveo/include/xrt-clkfreq.h
 create mode 100644 drivers/fpga/alveo/include/xrt-clock.h
 create mode 100644 drivers/fpga/alveo/include/xrt-cmc.h
 create mode 100644 drivers/fpga/alveo/include/xrt-ddr-srsr.h
 create mode 100644 drivers/fpga/alveo/include/xrt-flash.h
 create mode 100644 drivers/fpga/alveo/include/xrt-gpio.h
 create mode 100644 drivers/fpga/alveo/include/xrt-icap.h
 create mode 100644 drivers/fpga/alveo/include/xrt-mailbox.h
 create mode 100644 drivers/fpga/alveo/include/xrt-metadata.h
 create mode 100644 drivers/fpga/alveo/include/xrt-parent.h
 create mode 100644 drivers/fpga/alveo/include/xrt-partition.h
 create mode 100644 drivers/fpga/alveo/include/xrt-subdev.h
 create mode 100644 drivers/fpga/alveo/include/xrt-ucs.h
 create mode 100644 drivers/fpga/alveo/lib/Kconfig
 create mode 100644 drivers/fpga/alveo/lib/Makefile
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-axigate.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-calib.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-clock.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sensors.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-gpio.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-icap.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-partition.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-qspi.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-srsr.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-test.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-ucs.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-vsec-golden.c
 create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-vsec.c
 create mode 100644 drivers/fpga/alveo/lib/xrt-cdev.c
 create mode 100644 drivers/fpga/alveo/lib/xrt-main.c
 create mode 100644 drivers/fpga/alveo/lib/xrt-main.h
 create mode 100644 drivers/fpga/alveo/lib/xrt-subdev.c
 create mode 100644 drivers/fpga/alveo/mgmt/Kconfig
 create mode 100644 drivers/fpga/alveo/mgmt/Makefile
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main.c
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-root.c
 create mode 100644 include/uapi/linux/xrt/flash_xrt_data.h
 create mode 100644 include/uapi/linux/xrt/mailbox_proto.h
 create mode 100644 include/uapi/linux/xrt/mailbox_transport.h
 create mode 100644 include/uapi/linux/xrt/xclbin.h
 create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h

--
2.17.1
