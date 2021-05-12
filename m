Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53EA37B3BA
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 03:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELB6m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 21:58:42 -0400
Received: from mail-mw2nam08on2073.outbound.protection.outlook.com ([40.107.101.73]:47777
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229964AbhELB6l (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 21:58:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvEo8dCqcQH/HKNcsNlFDmMym/MVFFFZUaAy0hvM19Zo9jrCJLz86ICjGiySrfU1jXLTWEdYKRjDX0RaVW8x22BxQnafFm38LldYSYPJI7IaxhwbnX0KM5cMPD2MnPa2J4p8tjnHqlzUSFVf7Ox/Xypd6lM8PI03ufWHpxc2NMeo+lVhwjC57R/ImaOE/0++p79abUmWUpcAMCDADECYUZnn5Y4XXupGJxBW1GH2Rhnr5/GqRz9GpAm5z5JIkDmvQ2l7hs6y18KuozYgOOx8vPV5KiQQJSBuNoHxDmo20ORQDS12DJcW5YIGF/gZij1m4dEf22A+JNtGLCo75ux0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5qRBqjeAegWlm8byQnclpQUL5mmijMBndiHSHpBhcM=;
 b=bEJmZ/fqbFD66giPQwhkjfmgbYlBxWsHWdT0RA2RcHaI3eC2bY2YC1xBn1REc0g2IREgGu0IDBg0eei2Zlpa+dMcE4FpP4kcMkkWpq1IqNiyMdT1A45YvHPgwb8AwOAVz90a2N9dLlnPAHHO9ZyQp/UngDP828WUQBWrq4/dlLTLH5OALKRuaIqqamIbknl2vOP1+QOHDAjnIS1BTzpmnEqibo590Bdr0U/NH4e8WK3lLoZqPN1PbpT5+erZzTiujn9qUIwEtEFhvMu0ELEcTyGfTWfLmVv+p50HTe063QCfGWncT9NknfHpsm3o5nCgKvLHgI/nHr0DRVqoek1XVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5qRBqjeAegWlm8byQnclpQUL5mmijMBndiHSHpBhcM=;
 b=NFet/sENgcqjFNh7zTi0COxMDOeKOWsD0DKLsiDObjuGHWVLh2IU5YlONrGYP3G6vSZm0smtX3a2gqPolRCEvfwD7gko/jSKuw+8ruQPRMb3nwkwgoiV+Z6lU2QAfSRU1u5rvft4TylrNsMLi0VmMcvDSpOexADMp/3tx1G4c0Y=
Received: from BN9PR03CA0140.namprd03.prod.outlook.com (2603:10b6:408:fe::25)
 by DM6PR02MB4075.namprd02.prod.outlook.com (2603:10b6:5:9f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30; Wed, 12 May
 2021 01:57:32 +0000
Received: from BN1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::be) by BN9PR03CA0140.outlook.office365.com
 (2603:10b6:408:fe::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 01:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT056.mail.protection.outlook.com (10.13.2.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 01:57:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 18:57:31 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 18:57:31 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35712 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lge7u-0005MG-QE; Tue, 11 May 2021 18:57:30 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id CBF956000F4; Tue, 11 May 2021 18:53:44 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 01/20] Documentation: fpga: Add a document describing XRT Alveo drivers
Date:   Tue, 11 May 2021 18:53:20 -0700
Message-ID: <20210512015339.5649-2-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aa752c8-27fa-4721-305b-08d914e94e08
X-MS-TrafficTypeDiagnostic: DM6PR02MB4075:
X-Microsoft-Antispam-PRVS: <DM6PR02MB407500C218876A71D5CCF98FA1529@DM6PR02MB4075.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIPfAJCPGP+V3qTlgBzEz/l5b2VzO1C6mzvKtgWNRGolQMKR8ZME5B81dhKAuwgvc3N/E5N9dOsliYCc0kmurErUZJwV9ES+8VQvlLk+SuKzLxDXV5hvl+NnqY+9ugZY8990BUWE1vK6ab6gxGzEn2u/dqYeTm2pBrbYMOvymAugTX4FlJ9xKSiFUGnVqMqxYgTn4PgG2VwfXlcWdHjQfVwPTMnWSFQHnS4dEKzhqH2lG3ysWlez90ICo3cL2IVoZ1Js1rNi2MJlYwIeOjdVrGamGRim/L2uH4QcoR28PYYQZ+KWBmYAIDTv68PfLNgmoDJsfh0eLwZagGwzWYawk+4tDkjN/TqbjRy1iwlCxv7eAAQCC0xwzW9fH2MvbX0dKu23bBZoV8Aevq6XFkmdDA7iLxDD90s0SQq19f99YOxzVCv7zQ6wZd2RP0qNI5+cDC5LmIJ/4+bqsV8cx7L/1+2nsXoORQaD/827pYuRd/GPlQX3YzNdMMQHJqTbgmEWoF4t5QzkmV269BOFgTcp/l+5vFzjPPqKCr1SBJDPvXyMFjrivqm3rUPxUVJSajo3RA+9aAUjN6J18RdihiDCn9yRsjXvu/D3Vkp/TDid3qjf7tfEC0hGydZ4nt6RJhEM5Fo4pVWgavJ1aaWyXMbXGKfxRWaGfdv6H+jfV4ad5aBsnPnZa0gNeVbDzJEhbzTyTPLG2aBkNHjCmng1Tu0IwLj+tMIVozr5LKj1RSnS46n/DWJhzJJ9k7Mu44Qbe/C/zS1DavEWWwCdiWkGfpSqWA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(136003)(396003)(346002)(36840700001)(46966006)(36906005)(8676002)(8936002)(186003)(36756003)(83380400001)(30864003)(316002)(6916009)(107886003)(1076003)(4326008)(54906003)(36860700001)(26005)(6666004)(82740400003)(6266002)(5660300002)(966005)(7636003)(478600001)(2906002)(2616005)(47076005)(426003)(70586007)(70206006)(42186006)(356005)(44832011)(336012)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 01:57:31.7201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa752c8-27fa-4721-305b-08d914e94e08
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4075
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Describe XRT driver architecture and provide basic overview of
Xilinx Alveo platform.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 Documentation/fpga/index.rst |   1 +
 Documentation/fpga/xrt.rst   | 869 +++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  11 +
 3 files changed, 881 insertions(+)
 create mode 100644 Documentation/fpga/xrt.rst

diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
index f80f95667ca2..30134357b70d 100644
--- a/Documentation/fpga/index.rst
+++ b/Documentation/fpga/index.rst
@@ -8,6 +8,7 @@ fpga
     :maxdepth: 1
 
     dfl
+    xrt
 
 .. only::  subproject and html
 
diff --git a/Documentation/fpga/xrt.rst b/Documentation/fpga/xrt.rst
new file mode 100644
index 000000000000..fd69b96a8f80
--- /dev/null
+++ b/Documentation/fpga/xrt.rst
@@ -0,0 +1,869 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+XRTV2 Linux Kernel Driver Overview
+==================================
+
+Authors:
+
+* Sonal Santan <sonal.santan@xilinx.com>
+* Max Zhen <max.zhen@xilinx.com>
+* Lizhi Hou <lizhi.hou@xilinx.com>
+
+XRTV2 drivers are second generation `XRT <https://github.com/Xilinx/XRT>`_
+drivers which support `Alveo <https://www.xilinx.com/products/boards-and-kits/alveo.html>`_
+PCIe platforms from Xilinx.
+
+XRTV2 drivers support *subsystem* style data driven platforms where driver's
+configuration and behavior are determined by metadata provided by the platform
+(in *device tree* format). Primary management physical function (MPF) driver
+is called **xrt-mgmt**. Primary user physical function (UPF) driver is called
+**xrt-user** and is under development. xrt_driver framework and HW subsystem
+drivers are packaged into a library module called **xrt-lib**, which is shared
+by **xrt-mgmt** and **xrt-user** (under development). The xrt_driver framework
+implements a ``bus_type`` called **xrt_bus_type** which is used to discover HW
+subsystems and facilitate inter HW subsystem interaction.
+
+Driver Modules
+==============
+
+xrt-lib.ko
+----------
+
+xrt-lib is the repository of all subsystem drivers and pure software modules that
+can potentially be shared between xrt-mgmt and xrt-user. All these drivers are
+structured as **xrt_driver** and are instantiated by xrt-mgmt (or xrt-user under
+development) based on the metadata associated with the hardware. The metadata is
+in the form of a device tree as mentioned before. Each xrt_driver statically
+defines a subsystem node array by using node name or a string in its ``.endpoints``
+property. And this array is eventually translated to IOMEM resources in the
+instantiated **xrt_device**.
+
+The xrt-lib infrastructure provides hooks to xrt_drivers for device node
+management, user file operations and ioctl callbacks. The core infrastructure also
+provides a bus functionality called **xrt_bus_type** for xrt_driver registration,
+discovery and inter xrt_driver calls. xrt-lib does not have any dependency on PCIe
+subsystem.
+
+.. note::
+   See code in ``include/xleaf.h`` and ``include/xdevice.h``
+
+
+xrt-mgmt.ko
+------------
+
+The xrt-mgmt driver is a PCIe device driver driving MPF found on Xilinx's Alveo
+PCIe device. It consists of one *root* driver, one or more *group* drivers
+and one or more *xleaf* drivers. The group and xleaf drivers are instantiations
+of xrt_driver but are called group and xleaf to symbolize the logical operation
+performed by them.
+
+The root driver manages the life cycle of multiple group drivers, which, in turn,
+manages multiple xleaf drivers. This flexibility allows xrt-mgmt.ko and xrt-lib.ko
+to support various HW subsystems exposed by different Alveo shells. The differences
+among these Alveo shells is handled in xleaf drivers. The root and group
+drivers make part of the infrastructure which provide common services to xleaf
+drivers found on various Alveo shells. See :ref:`alveo_platform_overview`.
+
+The instantiation of specific group driver or xleaf driver is completely data
+driven based on metadata (mostly in device tree format) found through VSEC
+capability and inside firmware files, such as platform xsabin or user xclbin file.
+
+
+Driver Object Model
+===================
+
+The driver object model looks like the following::
+
+                    +-----------+
+                    |   xroot   |
+                    +-----+-----+
+                          |
+              +-----------+-----------+
+              |                       |
+              v                       v
+        +-----------+          +-----------+
+        |   group   |    ...   |   group   |
+        +-----+-----+          +------+----+
+              |                       |
+              |                       |
+        +-----+----+            +-----+----+
+        |          |            |          |
+        v          v            v          v
+    +-------+  +-------+    +-------+  +-------+
+    | xleaf |..| xleaf |    | xleaf |..| xleaf |
+    +-------+  +-------+    +-------+  +-------+
+
+As an example, for Xilinx Alveo U50 before user xclbin download, the tree
+looks like the following::
+
+                                +-----------+
+                                |  xrt-mgmt |
+                                +-----+-----+
+                                      |
+            +-------------------------+--------------------+
+            |                         |                    |
+            v                         v                    v
+       +--------+                +--------+            +--------+
+       | group0 |                | group1 |            | group2 |
+       +----+---+                +----+---+            +---+----+
+            |                         |                    |
+            |                         |                    |
+      +-----+-----+        +----+-----+---+    +-----+-----+----+--------+
+      |           |        |    |         |    |     |          |        |
+      v           v        |    v         v    |     v          v        |
+ +------------+  +------+  | +------+ +------+ |  +------+ +-----------+ |
+ | xmgmt_main |  | VSEC |  | | GPIO | | QSPI | |  |  CMC | | AXI-GATE0 | |
+ +------------+  +------+  | +------+ +------+ |  +------+ +-----------+ |
+                           | +---------+       |  +------+ +-----------+ |
+                           +>| MAILBOX |       +->| ICAP | | AXI-GATE1 |<+
+                             +---------+       |  +------+ +-----------+
+                                               |  +-------+
+                                               +->| CALIB |
+                                                  +-------+
+
+After a xclbin is downloaded, group3 will be added and the tree looks like the
+following::
+
+                                +-----------+
+                                |  xrt-mgmt |
+                                +-----+-----+
+                                      |
+            +-------------------------+--------------------+-----------------+
+            |                         |                    |                 |
+            v                         v                    v                 |
+       +--------+                +--------+            +--------+            |
+       | group0 |                | group1 |            | group2 |            |
+       +----+---+                +----+---+            +---+----+            |
+            |                         |                    |                 |
+            |                         |                    |                 |
+      +-----+-----+       +-----+-----+---+    +-----+-----+----+--------+   |
+      |           |       |     |         |    |     |          |        |   |
+      v           v       |     v         v    |     v          v        |   |
+ +------------+  +------+ | +------+ +------+  |  +------+ +-----------+ |   |
+ | xmgmt_main |  | VSEC | | | GPIO | | QSPI |  |  |  CMC | | AXI-GATE0 | |   |
+ +------------+  +------+ | +------+ +------+  |  +------+ +-----------+ |   |
+                          | +---------+        |  +------+ +-----------+ |   |
+                          +>| MAILBOX |        +->| ICAP | | AXI-GATE1 |<+   |
+                            +---------+        |  +------+ +-----------+     |
+                                               |  +-------+                  |
+                                               +->| CALIB |                  |
+                                                  +-------+                  |
+                      +---+----+                                             |
+                      | group3 |<--------------------------------------------+
+                      +--------+
+                          |
+                          |
+     +-------+--------+---+--+--------+------+-------+
+     |       |        |      |        |      |       |
+     v       |        v      |        v      |       v
+ +--------+  |   +--------+  |   +--------+  |    +-----+
+ | CLOCK0 |  |   | CLOCK1 |  |   | CLOCK2 |  |    | UCS |
+ +--------+  v   +--------+  v   +--------+  v    +-----+
+ +-------------+ +-------------+ +-------------+
+ | CLOCK-FREQ0 | | CLOCK-FREQ1 | | CLOCK-FREQ2 |
+ +-------------+ +-------------+ +-------------+
+
+
+root
+----
+
+The root driver is a PCIe device driver attached to MPF. It's part of the
+infrastructure of the MPF driver and resides in xrt-mgmt.ko. This driver
+
+* manages one or more group drivers
+* provides access to functionalities that requires pci_dev, such as PCIE config
+  space access, to other xleaf drivers through root calls
+* facilities inter xleaf driver calls for other xleaf drivers
+* facilities event callbacks for other xleaf drivers
+
+When root driver starts, it will explicitly create an initial group instance,
+which contains xleaf drivers that will trigger the creation of other group
+instances. The root driver will wait for all group and xleaf drivers to be
+created before it returns from its probe routine and claim success of the
+initialization of the entire xrt-mgmt driver. If any xleaf fails to initialize
+the xrt-mgmt driver will still come online but with limited functionality.
+
+.. note::
+   See code in ``lib/xroot.c`` and ``mgmt/root.c``
+
+
+group
+-----
+
+The group driver represents a pseudo device whose life cycle is managed by
+root and does not have real IO mem or IRQ resources. It's part of the
+infrastructure of the MPF driver and resides in xrt-lib.ko. This driver
+
+* manages one or more xleaf drivers
+* provides access to root from xleaf drivers, so that root calls, event
+  notifications and inter xleaf calls can happen
+
+In xrt-mgmt, an initial group driver instance will be created by the root. This
+instance contains xleaf drivers that will trigger group instances to be created
+to manage groups of xleaf drivers found on different partitions on hardware,
+such as VSEC, Shell, and User.
+
+Every *fpga_region* has a group driver associated with it. The group driver is
+created when a xclbin image is loaded on the fpga_region. The existing group
+is destroyed when a new xclbin image is loaded. The fpga_region persists
+across xclbin downloads.
+
+.. note::
+   See code in ``lib/group.c``
+
+
+xleaf
+-----
+
+The xleaf driver is a xrt_driver whose life cycle is managed by
+a group driver and may or may not have real IO mem or IRQ resources. They
+are the real meat of xrt-mgmt and manage HW subsystems they are attached to.
+
+A xleaf driver without real hardware resources manages in-memory states for
+xrt-mgmt. These in-memory states could be shared by multiple other xleaf.
+
+Xleaf drivers assigned to specific hardware resources drive a specific subsystem
+in the device. To manipulate the subsystem or carry out a task, a xleaf driver
+may ask for help from the root via root calls and/or from other leaves via
+inter xleaf calls.
+
+A xleaf can also broadcast events through infrastructure code for other leaves
+to process. It can also receive event notification from infrastructure about
+certain events, such as post-creation or pre-exit of a particular xleaf.
+
+.. note::
+   See code in ``lib/xleaf/*.c``
+
+
+xrt_bus_type
+------------
+
+xrt_bus_type defines a virtual bus which handles xrt_driver probe, remove and match
+operations. All xrt_drivers register with xrt_bus_type as part of xrt-lib driver
+``module_init`` and un-register as part of xrt-lib driver ``module_exit``.
+
+.. note::
+   See code in ``lib/lib-drv.c``
+
+FPGA Manager Interaction
+========================
+
+fpga_manager
+------------
+
+An instance of fpga_manager is created by xmgmt_main and is used for xclbin
+image download. fpga_manager requires the full xclbin image before it can
+start programming the FPGA configuration engine via Internal Configuration
+Access Port (ICAP) xrt_driver.
+
+fpga_region
+-----------
+
+For every interface exposed by the currently loaded xclbin/xsabin in the
+*parent* fpga_region a new instance of fpga_region is created like a *child*
+fpga_region. The device tree of the *parent* fpga_region defines the
+resources for a new instance of fpga_bridge which isolates the parent from
+child fpga_region. This new instance of fpga_bridge will be used when a
+xclbin image is loaded on the child fpga_region. After the xclbin image is
+downloaded to the fpga_region, an instance of group is created for the
+fpga_region using the device tree obtained as part of the xclbin. If this
+device tree defines any child interfaces then it can trigger the creation of
+fpga_bridge and fpga_region for the next region in the chain.
+
+fpga_bridge
+-----------
+
+Like the fpga_region, matching fpga_bridge is also created by walking the
+device tree of the parent group.
+
+Driver Interfaces
+=================
+
+xrt-mgmt Driver Ioctls
+----------------------
+
+Ioctls exposed by xrt-mgmt driver to user space are enumerated in the following
+table:
+
+== ===================== ============================ ==========================
+#  Functionality         ioctl request code            data format
+== ===================== ============================ ==========================
+1  FPGA image download   XMGMT_IOCICAPDOWNLOAD_AXLF    xmgmt_ioc_bitstream_axlf
+== ===================== ============================ ==========================
+
+A user xclbin can be downloaded by using the xbmgmt tool from the XRT open source
+suite. See example usage below::
+
+  xbmgmt partition --program --path /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/test/verify.xclbin --force
+
+xrt-mgmt Driver Sysfs
+----------------------
+
+xrt-mgmt driver exposes a rich set of sysfs interfaces. Subsystem xrt
+drivers export sysfs node for every platform instance.
+
+Every partition also exports its UUIDs. See below for examples::
+
+  /sys/bus/pci/devices/0000:06:00.0/xmgmt_main.0/interface_uuids
+  /sys/bus/pci/devices/0000:06:00.0/xmgmt_main.0/logic_uuids
+
+
+hwmon
+-----
+
+The xrt-mgmt driver exposes standard hwmon interface to report voltage, current,
+temperature, power, etc. These can easily be viewed using *sensors* command line
+utility.
+
+.. _alveo_platform_overview:
+
+Alveo Platform Overview
+=======================
+
+Alveo platforms are architected as two physical FPGA partitions: *Shell* and
+*User*. The Shell provides basic infrastructure for the Alveo platform like
+PCIe connectivity, board management, Dynamic Function Exchange (DFX), sensors,
+clocking, reset, and security. The User partition contains the user compiled FPGA
+binary which is loaded by a procedure called DFX also known as partial
+reconfiguration.
+
+For DFX to work properly, physical partitions require strict HW compatibility
+with each other. Every physical partition has two interface UUIDs: *parent* UUID
+and *child* UUID. For simple single stage platforms, Shell → User forms parent
+child relationship.
+
+.. note::
+   Partition compatibility matching is a key design component of the Alveo platforms
+   and XRT. Partitions have child and parent relationship. A loaded partition
+   exposes child partition UUID to advertise its compatibility requirement. When
+   loading a child partition, the xrt-mgmt driver matches the parent
+   UUID of the child partition against the child UUID exported by the parent.
+   The parent and child partition UUIDs are stored in the *xclbin* (for the user)
+   and the *xsabin* (for the shell). Except for the root UUID exported by VSEC,
+   the hardware itself does not know about the UUIDs. The UUIDs are stored in
+   xsabin and xclbin. The image format has a special node called Partition UUIDs
+   which define the compatibility UUIDs. See :ref:`partition_uuids`.
+
+
+The physical partitions and their loading are illustrated below::
+
+           SHELL                               USER
+        +-----------+                  +-------------------+
+        |           |                  |                   |
+        | VSEC UUID | CHILD     PARENT |    LOGIC UUID     |
+        |           o------->|<--------o                   |
+        |           | UUID       UUID  |                   |
+        +-----+-----+                  +--------+----------+
+              |                                 |
+              .                                 .
+              |                                 |
+          +---+---+                      +------+--------+
+          |  POR  |                      | USER COMPILED |
+          | FLASH |                      |    XCLBIN     |
+          +-------+                      +---------------+
+
+
+Loading Sequence
+----------------
+
+The Shell partition is loaded from flash at system boot time. It establishes the
+PCIe link and exposes two physical functions to the BIOS. After the OS boots,
+xrt-mgmt driver attaches to the PCIe physical function 0 exposed by the Shell
+and then looks for VSEC in the PCIe extended configuration space. Using VSEC, it
+determines the logic UUID of Shell and uses the UUID to load matching *xsabin*
+file from Linux firmware directory. The xsabin file contains the metadata to
+discover the peripherals that are part of the Shell and firmware for any embedded
+soft processors in the Shell. The xsabin file also contains Partition UUIDs as
+described here :ref:`partition_uuids`.
+
+The Shell exports a child interface UUID which is used for the compatibility
+check when loading the user compiled xclbin over the User partition as part of DFX.
+When a user requests loading of a specific xclbin, the xrt-mgmt driver reads
+the parent interface UUID specified in the xclbin and matches it with the child
+interface UUID exported by the Shell to determine if the xclbin is compatible with
+the Shell. If the match fails loading of xclbin is denied.
+
+xclbin loading is requested using ICAP_DOWNLOAD_AXLF ioctl command. When loading
+a xclbin, xrt-mgmt driver performs the following *logical* operations:
+
+1. Copy xclbin from user to kernel memory
+2. Sanity check the xclbin contents
+3. Isolate the User partition
+4. Download the bitstream using the FPGA config engine (ICAP)
+5. De-isolate the User partition
+6. Program the clocks (ClockWiz) driving the User partition
+7. Wait for the memory controller (MIG) calibration
+8. Return the loading status back to the caller
+
+`Platform Loading Overview <https://xilinx.github.io/XRT/master/html/platforms_partitions.html>`_
+provides more detailed information on platform loading.
+
+
+xsabin
+------
+
+Each Alveo platform comes packaged with its own xsabin. The xsabin is a trusted
+component of the platform. For format details refer to :ref:`xsabin_xclbin_container_format`
+below. xsabin contains basic information like UUIDs, platform name and metadata in the
+form of device tree. See :ref:`device_tree_usage` below for details and example.
+
+xclbin
+------
+
+xclbin is compiled by end user using
+`Vitis <https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html>`_
+tool set from Xilinx. The xclbin contains sections describing user compiled
+acceleration engines/kernels, memory subsystems, clocking information etc. It also
+contains a FPGA bitstream for the user partition, UUIDs, platform name, etc.
+
+
+.. _xsabin_xclbin_container_format:
+
+xsabin/xclbin Container Format
+------------------------------
+
+xclbin/xsabin is ELF-like binary container format. It is structured as series of
+sections. There is a file header followed by several section headers which is
+followed by sections. A section header points to an actual section. There is an
+optional signature at the end. The format is defined by the header file ``xclbin.h``.
+The following figure illustrates a typical xclbin::
+
+
+           +---------------------+
+           |                     |
+           |       HEADER        |
+           +---------------------+
+           |   SECTION  HEADER   |
+           |                     |
+           +---------------------+
+           |         ...         |
+           |                     |
+           +---------------------+
+           |   SECTION  HEADER   |
+           |                     |
+           +---------------------+
+           |       SECTION       |
+           |                     |
+           +---------------------+
+           |         ...         |
+           |                     |
+           +---------------------+
+           |       SECTION       |
+           |                     |
+           +---------------------+
+           |      SIGNATURE      |
+           |      (OPTIONAL)     |
+           +---------------------+
+
+
+xclbin/xsabin files can be packaged, un-packaged and inspected using a XRT
+utility called **xclbinutil**. xclbinutil is part of the XRT open source
+software stack. The source code for xclbinutil can be found at
+https://github.com/Xilinx/XRT/tree/master/src/runtime_src/tools/xclbinutil
+
+For example to enumerate the contents of a xclbin/xsabin use the *--info* switch
+as shown below::
+
+
+  xclbinutil --info --input /opt/xilinx/firmware/u50/gen3x16-xdma/blp/test/bandwidth.xclbin
+  xclbinutil --info --input /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/partition.xsabin
+
+
+.. _device_tree_usage:
+
+Device Tree Usage
+-----------------
+
+As mentioned previously, the xsabin file stores metadata which advertise HW
+subsystems present in a partition. The metadata is stored in device tree format
+with a well defined schema. XRT management driver uses this information to bind
+*xrt_drivers* to the subsystem instantiations. The xrt_drivers are found in
+**xrt-lib.ko** kernel module defined earlier.
+
+Logic UUID
+^^^^^^^^^^
+A partition is identified uniquely through ``logic_uuid`` property::
+
+  /dts-v1/;
+  / {
+      logic_uuid = "0123456789abcdef0123456789abcdef";
+      ...
+    }
+
+Schema Version
+^^^^^^^^^^^^^^
+Schema version is defined through the ``schema_version`` node. It contains
+``major`` and ``minor`` properties as below::
+
+  /dts-v1/;
+  / {
+       schema_version {
+           major = <0x01>;
+           minor = <0x00>;
+       };
+       ...
+    }
+
+.. _partition_uuids:
+
+Partition UUIDs
+^^^^^^^^^^^^^^^
+As mentioned earlier, each partition may have parent and child UUIDs. These UUIDs are
+defined by ``interfaces`` node and ``interface_uuid`` property::
+
+  /dts-v1/;
+  / {
+       interfaces {
+           @0 {
+                  interface_uuid = "0123456789abcdef0123456789abcdef";
+           };
+           @1 {
+                  interface_uuid = "fedcba9876543210fedcba9876543210";
+           };
+           ...
+        };
+       ...
+    }
+
+
+Subsystem Instantiations
+^^^^^^^^^^^^^^^^^^^^^^^^
+Subsystem instantiations are captured as children of ``addressable_endpoints``
+node::
+
+  /dts-v1/;
+  / {
+       addressable_endpoints {
+           abc {
+               ...
+           };
+           def {
+               ...
+           };
+           ...
+       }
+  }
+
+Subnode 'abc' and 'def' are the name of subsystem nodes
+
+Subsystem Node
+^^^^^^^^^^^^^^
+Each subsystem node and its properties define a hardware instance::
+
+
+  addressable_endpoints {
+      abc {
+          reg = <0x00 0x1f05000 0x00 0x1000>>
+          pcie_physical_function = <0x0>;
+          pcie_bar_mapping = <0x2>;
+          compatible = "abc def";
+	  interrupts = <0x09 0x0c>;
+          firmware {
+              firmware_product_name = "abc"
+              firmware_branch_name = "def"
+              firmware_version_major = <1>
+              firmware_version_minor = <2>
+          };
+      }
+      ...
+  }
+
+:reg:
+ Property defines an address range. `<0x00 0x1f05000 0x00 0x1000>` indicates
+ *0x00 0x1f05000* as BAR offset and *0x00 0x1000* as address length.
+:pcie_physical_function:
+ Property specifies which PCIe physical function the subsystem node resides.
+ `<0x0>` implies physical function 0.
+:pcie_bar_mapping:
+ Property specifies which PCIe BAR the subsystem node resides. `<0x2>` implies
+ BAR 2. A value of 0 means the property is not defined.
+:compatible:
+ Property is a list of strings. The first string in the list specifies the exact
+ subsystem node. The following strings represent other devices that the device
+ is compatible with.
+:interrupts:
+ Property specifies start and end interrupts for this subsystem node.
+ `<0x09 0x0c>` implies interrupts 9 to 13 are used by this subsystem.
+:firmware:
+ Subnode defines the firmware required by this subsystem node.
+
+Alveo U50 Platform Example
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+::
+
+  /dts-v1/;
+
+  /{
+        logic_uuid = "f465b0a3ae8c64f619bc150384ace69b";
+
+        schema_version {
+                major = <0x01>;
+                minor = <0x00>;
+        };
+
+        interfaces {
+
+                @0 {
+                        interface_uuid = "862c7020a250293e32036f19956669e5";
+                };
+        };
+
+        addressable_endpoints {
+
+                ep_blp_rom_00 {
+                        reg = <0x00 0x1f04000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+                };
+
+                ep_card_flash_program_00 {
+                        reg = <0x00 0x1f06000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_quad_spi-1.0\0axi_quad_spi";
+                        interrupts = <0x03 0x03>;
+                };
+
+                ep_cmc_firmware_mem_00 {
+                        reg = <0x00 0x1e20000 0x00 0x20000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+
+                        firmware {
+                                firmware_product_name = "cmc";
+                                firmware_branch_name = "u50";
+                                firmware_version_major = <0x01>;
+                                firmware_version_minor = <0x00>;
+                        };
+                };
+
+                ep_cmc_intc_00 {
+                        reg = <0x00 0x1e03000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
+                        interrupts = <0x04 0x04>;
+                };
+
+                ep_cmc_mutex_00 {
+                        reg = <0x00 0x1e02000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_cmc_regmap_00 {
+                        reg = <0x00 0x1e08000 0x00 0x2000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+
+                        firmware {
+                                firmware_product_name = "sc-fw";
+                                firmware_branch_name = "u50";
+                                firmware_version_major = <0x05>;
+                        };
+                };
+
+                ep_cmc_reset_00 {
+                        reg = <0x00 0x1e01000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_ddr_mem_calib_00 {
+                        reg = <0x00 0x63000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_debug_bscan_mgmt_00 {
+                        reg = <0x00 0x1e90000 0x00 0x10000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-debug_bridge-1.0\0debug_bridge";
+                };
+
+                ep_ert_base_address_00 {
+                        reg = <0x00 0x21000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_ert_command_queue_mgmt_00 {
+                        reg = <0x00 0x40000 0x00 0x10000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
+                };
+
+                ep_ert_command_queue_user_00 {
+                        reg = <0x00 0x40000 0x00 0x10000>;
+                        pcie_physical_function = <0x01>;
+                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
+                };
+
+                ep_ert_firmware_mem_00 {
+                        reg = <0x00 0x30000 0x00 0x8000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+
+                        firmware {
+                                firmware_product_name = "ert";
+                                firmware_branch_name = "v20";
+                                firmware_version_major = <0x01>;
+                        };
+                };
+
+                ep_ert_intc_00 {
+                        reg = <0x00 0x23000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
+                        interrupts = <0x05 0x05>;
+                };
+
+                ep_ert_reset_00 {
+                        reg = <0x00 0x22000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_ert_sched_00 {
+                        reg = <0x00 0x50000 0x00 0x1000>;
+                        pcie_physical_function = <0x01>;
+                        compatible = "xilinx.com,reg_abs-ert_sched-1.0\0ert_sched";
+                        interrupts = <0x09 0x0c>;
+                };
+
+                ep_fpga_configuration_00 {
+                        reg = <0x00 0x1e88000 0x00 0x8000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_hwicap-1.0\0axi_hwicap";
+                        interrupts = <0x02 0x02>;
+                };
+
+                ep_icap_reset_00 {
+                        reg = <0x00 0x1f07000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_msix_00 {
+                        reg = <0x00 0x00 0x00 0x20000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-msix-1.0\0msix";
+                        pcie_bar_mapping = <0x02>;
+                };
+
+                ep_pcie_link_mon_00 {
+                        reg = <0x00 0x1f05000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_pr_isolate_plp_00 {
+                        reg = <0x00 0x1f01000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_pr_isolate_ulp_00 {
+                        reg = <0x00 0x1000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
+                };
+
+                ep_uuid_rom_00 {
+                        reg = <0x00 0x64000 0x00 0x1000>;
+                        pcie_physical_function = <0x00>;
+                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
+                };
+
+                ep_xdma_00 {
+                        reg = <0x00 0x00 0x00 0x10000>;
+                        pcie_physical_function = <0x01>;
+                        compatible = "xilinx.com,reg_abs-xdma-1.0\0xdma";
+                        pcie_bar_mapping = <0x02>;
+                };
+        };
+
+  }
+
+
+
+Deployment Models
+=================
+
+Baremetal
+---------
+
+In bare-metal deployments, both MPF and UPF are visible and accessible. xrt-mgmt
+driver binds to MPF. xrt-mgmt driver operations are privileged and available to
+system administrator. The full stack is illustrated below::
+
+                            HOST
+
+               [XRT-MGMT]         [XRT-USER]
+                    |                  |
+                    |                  |
+                 +-----+            +-----+
+                 | MPF |            | UPF |
+                 |     |            |     |
+                 | PF0 |            | PF1 |
+                 +--+--+            +--+--+
+          ......... ^................. ^..........
+                    |                  |
+                    |   PCIe DEVICE    |
+                    |                  |
+                 +--+------------------+--+
+                 |         SHELL          |
+                 |                        |
+                 +------------------------+
+                 |         USER           |
+                 |                        |
+                 |                        |
+                 |                        |
+                 |                        |
+                 +------------------------+
+
+
+
+Virtualized
+-----------
+
+In virtualized deployments, the privileged MPF is assigned to the host but the
+unprivileged UPF is assigned to a guest VM via PCIe pass-through. xrt-mgmt driver
+in host binds to MPF. xrt-mgmt driver operations are privileged and only accessible
+to the MPF. The full stack is illustrated below::
+
+
+                                 ..............
+                  HOST           .    VM      .
+                                 .            .
+               [XRT-MGMT]        . [XRT-USER] .
+                    |            .     |      .
+                    |            .     |      .
+                 +-----+         .  +-----+   .
+                 | MPF |         .  | UPF |   .
+                 |     |         .  |     |   .
+                 | PF0 |         .  | PF1 |   .
+                 +--+--+         .  +--+--+   .
+          ......... ^................. ^..........
+                    |                  |
+                    |   PCIe DEVICE    |
+                    |                  |
+                 +--+------------------+--+
+                 |         SHELL          |
+                 |                        |
+                 +------------------------+
+                 |         USER           |
+                 |                        |
+                 |                        |
+                 |                        |
+                 |                        |
+                 +------------------------+
+
+
+
+
+
+Platform Security Considerations
+================================
+
+`Security of Alveo Platform <https://xilinx.github.io/XRT/master/html/security.html>`_
+discusses the deployment options and security implications in great detail.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..89abe140041b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7016,6 +7016,17 @@ F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
 
+FPGA XRT DRIVERS
+M:	Lizhi Hou <lizhi.hou@xilinx.com>
+R:	Max Zhen <max.zhen@xilinx.com>
+R:	Sonal Santan <sonal.santan@xilinx.com>
+L:	linux-fpga@vger.kernel.org
+S:	Supported
+W:	https://github.com/Xilinx/XRT
+F:	Documentation/fpga/xrt.rst
+F:	drivers/fpga/xrt/
+F:	include/uapi/linux/xrt/
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
-- 
2.27.0

