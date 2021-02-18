Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7531E66D
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 07:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhBRGqp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 01:46:45 -0500
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:16278
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231136AbhBRGoG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 01:44:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsbNc89rEDUyYuAlD2o3XymitzaIWWc3FrYivRalWU9Tj4f2vu4ozNep4yadlOPVrpmy5uPb7z/NMl69OsRRG/IQJALNQ1GlPI9VWlMORH22z8Z5208MGSV/2kPyzIH+5znaiUO/s+njm4Tj70hkIDl4swUCGKPjoskgdy3/oyiy8YGlZubguv3BPOp/wC+k7WQvdiPOF7lRitQV9RVpe++Ofr3GgKfNV/xA/YSb9Cw/wTdbnxJA8QM5DpzfRYcJE8rdpT8flecfLlmc2CAU6PES4fmgdjul6dv0R3KlOsgUcxm+y8n+kFuM6s8Jmqd1n/FnV50cqpkwYAfPk4ngXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBi7gm8oR6B3ORFbxjHg5TaTtX2aQF5hXGV3lzpTQ08=;
 b=G9Kxn+VpB4eWzASFyJzpZ9vuYuSE848HxMKdfneRWUeSUZ3TkO4OxuWxwzwCvPx3eEiSkpOyu+2jcPXn3rMTm33HDOgD/jtZ+Zd88V4rKBb8xUNknj7zUtkdUVmLVEiw+ejdFGLF50KDzWQL9zvfF5KY353YR/JlDxYqYOpEeC4oqurIWdikfk/RG8Zl2Kb4ycR3HiOU4uJTXJsVa5nD0g12HztWqoYVepFH1XospwEUXNKj1F/aZIHS0HjeaSV+HuwAYHilB5QohsbLYpCSEGV2REyxvEEQu2g2yPs4Hxy8ahorUjZBMrhAe2hGjzSVK5ijFQFrQTvrTahzo3jWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBi7gm8oR6B3ORFbxjHg5TaTtX2aQF5hXGV3lzpTQ08=;
 b=gxIG1MVXyV3VykorIumdv6zVs3ngW3ROgy0jl0dyUE7ubwCpq6Dp1O61Lc69kp4AyCd5HJaom91+EYwPxMOZ5vsGIt4i0Cmh/kVm9y8TiaILrosfUPHkYHlxEVOa0FMIXt+Am2mp5MYDKVLjc7YrMbn24h1uVHyfrAs406Dn09Y=
Received: from BL1PR13CA0263.namprd13.prod.outlook.com (2603:10b6:208:2ba::28)
 by CH2PR02MB6375.namprd02.prod.outlook.com (2603:10b6:610:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 18 Feb
 2021 06:43:04 +0000
Received: from BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2ba:cafe::fe) by BL1PR13CA0263.outlook.office365.com
 (2603:10b6:208:2ba::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend
 Transport; Thu, 18 Feb 2021 06:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT045.mail.protection.outlook.com (10.152.77.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:43:03 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:43:03 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:43:03 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=40160 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd1j-0001kN-Gc; Wed, 17 Feb 2021 22:43:03 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 933CF6000CF; Wed, 17 Feb 2021 22:41:05 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 01/18] Documentation: fpga: Add a document describing XRT Alveo drivers
Date:   Wed, 17 Feb 2021 22:40:02 -0800
Message-ID: <20210218064019.29189-2-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d6af07e-eadb-405b-a23b-08d8d3d87154
X-MS-TrafficTypeDiagnostic: CH2PR02MB6375:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6375FCD045856F9BEFE514C0A1859@CH2PR02MB6375.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9/KhTRPIuGcx1UEsjSf/aVR675j0oRCaAspzmFSiZ3HdtGAG9ek5TTJOYbVmi8kUSu/fB9Grh18z96+4sESsdGURa+6XT2orwxtFgqzzfPumHKhcB+EUZfWQaNicPU0Rkd59m+2D67RUZvdohfUgEi2hSy9whaC0IAcIrCCA5Eh5kzp6raqXt8KSa2+GvIHJrIhgrCwaZib5U9KSad+OkQRRG20ypil0S1T5VzgUq1BkyYz1HUH97/707G3DRoUmXoyfe8Ul5KBsMO+v15zBm9Va7VAM0uP9FkVoFB+uTgJ3r3g8rjzfgAFVhxPTvpLifxDiAsTkCuoOk8kpvpXv3rjWnDYZ6FNsa1wSH7Y8cU6GnoPkcihn/BkmLrdT6RJz1spSfHNmcM6d/J1wtgKz+JsPV5t5K1qAwH8b44pWSZcH7edJhdEEUCGT8hdjQ4UVZBtSNM0a9mE8015hlckKz8DssKvZLn2OsHKNNAHa1LEHHNk55M9nnOCW2vZhNXmQhfrweDT+Sq1m91i2zNySXwzqnO9fje/0VHG9+W24luThM856sE5/O1qKVjbcrrlLsjbMaPHtBVlkdISrHDSYofS5cYqDStlt1gQjbRqvIGFXA7MO+5Pts1EVv8Q1vRGaO0fjtPPco+M0FOXDcEE+c4EPcDGh8e6BfxUQAkM2gHNiZ7sORfXo7Vlo6M66W8bH7Gyd9WXrZ4F3MuZ8SEHlj7b8tgsgrYqg9Fi4o9tu80=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(5660300002)(336012)(4326008)(426003)(2616005)(82310400003)(82740400003)(6266002)(7636003)(6666004)(36860700001)(356005)(30864003)(186003)(107886003)(70206006)(83380400001)(44832011)(70586007)(36756003)(36906005)(6916009)(1076003)(26005)(478600001)(8936002)(2906002)(54906003)(47076005)(8676002)(316002)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:43:03.9274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6af07e-eadb-405b-a23b-08d8d3d87154
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6375
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Describe XRT driver architecture and provide basic overview of
Xilinx Alveo platform.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 Documentation/fpga/index.rst |   1 +
 Documentation/fpga/xrt.rst   | 842 +++++++++++++++++++++++++++++++++++
 2 files changed, 843 insertions(+)
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
index 000000000000..9bc2d2785cb9
--- /dev/null
+++ b/Documentation/fpga/xrt.rst
@@ -0,0 +1,842 @@
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
+configuration and behavior is determined by meta data provided by the platform
+(in *device tree* format). Primary management physical function (MPF) driver
+is called **xmgmt**. Primary user physical function (UPF) driver is called
+**xuser** and is under development. xrt driver framework and HW subsystem
+drivers are packaged into a library module called **xrt-lib**, which is
+shared by **xmgmt** and **xuser** (under development). The xrt driver framework
+implements a pseudo-bus which is used to discover HW subsystems and facilitate
+inter HW subsystem interaction.
+
+Driver Modules
+==============
+
+xrt-lib.ko
+----------
+
+Repository of all subsystem drivers and pure software modules that can potentially
+be shared between xmgmt and xuser. All these drivers are structured as Linux
+*platform driver* and are instantiated by xmgmt (or xuser under development) based
+on meta data associated with hardware. The metadata is in the form of device tree
+as mentioned before. Each platform driver statically defines a subsystem node
+array by using node name or a string in its ``compatible`` property. And this
+array is eventually translated to IOMEM resources of the platform device.
+
+The xrt-lib core infrastructure provides hooks to platform drivers for device node
+management, user file operations and ioctl callbacks. The core also provides pseudo-bus
+functionality for platform driver registration, discovery and inter platform driver
+ioctl calls.
+
+.. note::
+   See code in ``include/xleaf.h``
+
+
+xmgmt.ko
+--------
+
+The xmgmt driver is a PCIe device driver driving MPF found on Xilinx's Alveo
+PCIE device. It consists of one *root* driver, one or more *group* drivers
+and one or more *xleaf* drivers. The root and MPF specific xleaf drivers are
+in xmgmt.ko. The group driver and other xleaf drivers are in xrt-lib.ko.
+
+The instantiation of specific group driver or xleaf driver is completely data
+driven based on meta data (mostly in device tree format) found through VSEC
+capability and inside firmware files, such as platform xsabin or user xclbin file.
+The root driver manages life cycle of multiple group drivers, which, in turn,
+manages multiple xleaf drivers. This allows a single set of driver code to support
+all kinds of subsystems exposed by different shells. The difference among all
+these subsystems will be handled in xleaf drivers with root and group drivers
+being part of the infrastructure and provide common services for all leaves
+found on all platforms.
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
+As an example for Xilinx Alveo U50 before user xclbin download, the tree
+looks like the following::
+
+                                +-----------+
+                                |   xmgmt   |
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
+After an xclbin is download, group3 will be added and the tree looks like the
+following::
+
+                                +-----------+
+                                |   xmgmt   |
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
+xmgmt-root
+^^^^^^^^^^
+
+The xmgmt-root driver is a PCIe device driver attached to MPF. It's part of the
+infrastructure of the MPF driver and resides in xmgmt.ko. This driver
+
+* manages one or more group drivers
+* provides access to functionalities that requires pci_dev, such as PCIE config
+  space access, to other xleaf drivers through root calls
+* together with group driver, facilities event callbacks for other xleaf drivers
+* together with group driver, facilities inter-leaf driver calls for other xleaf
+  drivers
+
+When root driver starts, it will explicitly create an initial group instance,
+which contains xleaf drivers that will trigger the creation of other group
+instances. The root driver will wait for all group and leaves to be created
+before it returns from it's probe routine and claim success of the
+initialization of the entire xmgmt driver.
+
+.. note::
+   See code in ``lib/xroot.c`` and ``mgmt/root.c``
+
+
+group
+^^^^^
+
+The group driver is a platform device driver whose life cycle is managed by
+root and does not have real IO mem or IRQ resources. It's part of the
+infrastructure of the MPF driver and resides in xrt-lib.ko. This driver
+
+* manages one or more xleaf drivers so that multiple leaves can be managed as a
+  group
+* provides access to root from leaves, so that root calls, event notifications
+  and inter-leaf calls can happen
+
+In xmgmt, an initial group driver instance will be created by root, which
+contains leaves that will trigger group instances to be created to manage
+groups of leaves found on different partitions on hardware, such as VSEC, Shell,
+and User.
+
+Every *fpga_region* has a group object associated with it. The group is
+created when xclbin image is loaded on the fpga_region. The existing group
+is destroyed when a new xclbin image is loaded. The fpga_region persists
+across xclbin downloads.
+
+.. note::
+   See code in ``lib/group.c``
+
+
+xleaf
+^^^^^
+
+The xleaf driver is a platform device driver whose life cycle is managed by
+a group driver and may or may not have real IO mem or IRQ resources. They
+are the real meat of xmgmt and contains platform specific code to Shell and
+User found on a MPF.
+
+A xleaf driver may not have real hardware resources when it merely acts as a
+driver that manages certain in-memory states for xmgmt. These in-memory states
+could be shared by multiple other leaves.
+
+Leaf drivers assigned to specific hardware resources drive specific subsystem in
+the device. To manipulate the subsystem or carry out a task, a xleaf driver may
+ask help from root via root calls and/or from other leaves via inter-leaf calls.
+
+A xleaf can also broadcast events through infrastructure code for other leaves
+to process. It can also receive event notification from infrastructure about
+certain events, such as post-creation or pre-exit of a particular xleaf.
+
+.. note::
+   See code in ``lib/xleaf/*.c``
+
+
+FPGA Manager Interaction
+========================
+
+fpga_manager
+------------
+
+An instance of fpga_manager is created by xmgmt_main and is used for xclbin
+image download. fpga_manager requires the full xclbin image before it can
+start programming the FPGA configuration engine via ICAP platform driver.
+
+fpga_region
+-----------
+
+For every interface exposed by currently loaded xclbin/xsabin in the *parent*
+fpga_region a new instance of fpga_region is created like a *child* region.
+The device tree of the *parent* fpga_region defines the
+resources for a new instance of fpga_bridge which isolates the parent from
+child fpga_region. This new instance of fpga_bridge will be used when a
+xclbin image is loaded on the child fpga_region. After the xclbin image is
+downloaded to the fpga_region, an instance of group is created for the
+fpga_region using the device tree obtained as part of xclbin. If this device
+tree defines any child interfaces then it can trigger the creation of
+fpga_bridge and fpga_region for the next region in the chain.
+
+fpga_bridge
+-----------
+
+Like fpga_region, matching fpga_bridge is also created by walking the device
+tree of the parent group.
+
+Driver Interfaces
+=================
+
+xmgmt Driver Ioctls
+-------------------
+
+Ioctls exposed by xmgmt driver to user space are enumerated in the following
+table:
+
+== ===================== ============================ ==========================
+#  Functionality         ioctl request code            data format
+== ===================== ============================ ==========================
+1  FPGA image download   XMGMT_IOCICAPDOWNLOAD_AXLF    xmgmt_ioc_bitstream_axlf
+== ===================== ============================ ==========================
+
+User xclbin can be downloaded by using xbmgmt tool from XRT open source suite. See
+example usage below::
+
+  xbmgmt partition --program --path /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/test/verify.xclbin --force
+
+xmgmt Driver Sysfs
+------------------
+
+xmgmt driver exposes a rich set of sysfs interfaces. Subsystem platform
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
+xmgmt driver exposes standard hwmon interface to report voltage, current,
+temperature, power, etc. These can easily be viewed using *sensors* command
+line utility.
+
+Alveo Platform Overview
+=======================
+
+Alveo platforms are architected as two physical FPGA partitions: *Shell* and
+*User*. The Shell provides basic infrastructure for the Alveo platform like
+PCIe connectivity, board management, Dynamic Function Exchange (DFX), sensors,
+clocking, reset, and security. User partition contains user compiled FPGA
+binary which is loaded by a process called DFX also known as partial
+reconfiguration.
+
+Physical partitions require strict HW compatibility with each other for DFX to
+work properly. Every physical partition has two interface UUIDs: *parent* UUID
+and *child* UUID. For simple single stage platforms, Shell → User forms parent
+child relationship. For complex two stage platforms, Base → Shell → User forms
+the parent child relationship chain.
+
+.. note::
+   Partition compatibility matching is key design component of Alveo platforms
+   and XRT. Partitions have child and parent relationship. A loaded partition
+   exposes child partition UUID to advertise its compatibility requirement for
+   child partition. When loading a child partition the xmgmt management driver
+   matches parent UUID of the child partition against child UUID exported by
+   the parent. Parent and child partition UUIDs are stored in the *xclbin*
+   (for user) or *xsabin* (for base and shell). Except for root UUID, VSEC,
+   hardware itself does not know about UUIDs. UUIDs are stored in xsabin and
+   xclbin.
+
+
+The physical partitions and their loading is illustrated below::
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
+PCIe link and exposes two physical functions to the BIOS. After OS boot, xmgmt
+driver attaches to PCIe physical function 0 exposed by the Shell and then looks
+for VSEC in PCIe extended configuration space. Using VSEC it determines the logic
+UUID of Shell and uses the UUID to load matching *xsabin* file from Linux firmware
+directory. The xsabin file contains metadata to discover peripherals that are part
+of Shell and firmware(s) for any embedded soft processors in Shell.
+
+The Shell exports child interface UUID which is used for compatibility check when
+loading user compiled xclbin over the User partition as part of DFX. When a user
+requests loading of a specific xclbin the xmgmt management driver reads the parent
+interface UUID specified in the xclbin and matches it with child interface UUID
+exported by Shell to determine if xclbin is compatible with the Shell. If match
+fails loading of xclbin is denied.
+
+xclbin loading is requested using ICAP_DOWNLOAD_AXLF ioctl command. When loading
+xclbin, xmgmt driver performs the following *logical* operations:
+
+1. Copy xclbin from user to kernel memory
+2. Sanity check the xclbin contents
+3. Isolate the User partition
+4. Download the bitstream using the FPGA config engine (ICAP)
+5. De-isolate the User partition
+6. Program the clocks (ClockWiz) driving the User partition
+7. Wait for memory controller (MIG) calibration
+8. Return the loading status back to the caller
+
+`Platform Loading Overview <https://xilinx.github.io/XRT/master/html/platforms_partitions.html>`_
+provides more detailed information on platform loading.
+
+
+xsabin
+------
+
+Each Alveo platform comes packaged with its own xsabin. The xsabin is trusted
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
+contains bitstream for the user partition, UUIDs, platform name, etc. xclbin uses
+the same container format as xsabin which is described below.
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
+optional signature at the end. The format is defined by header file ``xclbin.h``.
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
+xclbin/xsabin files can be packaged, un-packaged and inspected using XRT utility
+called **xclbinutil**. xclbinutil is part of XRT open source software stack. The
+source code for xclbinutil can be found at
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
+As mentioned previously xsabin stores metadata which advertise HW subsystems present
+in a partition. The metadata is stored in device tree format with well defined schema.
+XRT management driver uses this information to bind *platform drivers* to the subsystem
+instantiations. The platform drivers are found in **xrt-lib.ko** kernel module defined
+later.
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
+Schema version is defined through ``schema_version`` node. And it contains ``major``
+and ``minor`` properties as below::
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
+Partition UUIDs
+^^^^^^^^^^^^^^^
+As said earlier, each partition may have parent and child UUIDs. These UUIDs are
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
+          reg = <0xa 0xb>
+          pcie_physical_function = <0x0>;
+          pcie_bar_mapping = <0x2>;
+          compatible = "abc def";
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
+ Property defines address range. '<0xa 0xb>' is BAR offset and length pair, both
+ are 64-bit integer.
+:pcie_physical_function:
+ Property specifies which PCIe physical function the subsystem node resides.
+:pcie_bar_mapping:
+ Property specifies which PCIe BAR the subsystem node resides. '<0x2>' is BAR
+ index and it is 0 if this property is not defined.
+:compatible:
+ Property is a list of strings. The first string in the list specifies the exact
+ subsystem node. The following strings represent other devices that the device
+ is compatible with.
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
+In bare-metal deployments both MPF and UPF are visible and accessible. xmgmt
+driver binds to MPF. xmgmt driver operations are privileged and available to
+system administrator. The full stack is illustrated below::
+
+                            HOST
+
+                 [XMGMT]            [XUSER]
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
+In virtualized deployments privileged MPF is assigned to host but unprivileged
+UPF is assigned to guest VM via PCIe pass-through. xmgmt driver in host binds
+to MPF. xmgmt driver operations are privileged and only accessible by hosting
+service provider. The full stack is illustrated below::
+
+
+                                 .............
+                  HOST           .    VM     .
+                                 .           .
+                 [XMGMT]         .  [XUSER]  .
+                    |            .     |     .
+                    |            .     |     .
+                 +-----+         .  +-----+  .
+                 | MPF |         .  | UPF |  .
+                 |     |         .  |     |  .
+                 | PF0 |         .  | PF1 |  .
+                 +--+--+         .  +--+--+  .
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
-- 
2.18.4

