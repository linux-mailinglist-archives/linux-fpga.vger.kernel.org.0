Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E153470E0
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhCXFcu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:32:50 -0400
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:23777
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232940AbhCXFcl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:32:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPAuQyGgO0hzj582mPa+10WuamCUXhKIcFNJP5PtVrFeAkUFD4zOlYwPuwBjM7QRUjw+SClhqnPI9g89yb+l2ubeha2cOTZizlPHaunqAxzOmajzjRwNuj4YxrBr1ZVi7ucDN5bCVt3yQoYtIiodcfTih5+kSmDP45my8PJU2NGDTTT7TOCxuYuckiH5EHQimDPtNBXZy8OzqBV1BhPxZxySe0tzWqMFKm3WVNhsTwKGMDy+tszNrNXOadjK5E+gX40bGpRXB0jfPNtPjwAkKJ/Nd8oQfZgcErkirP6f5sdt9507NHU9XyTVikL/VR7NnT15dgeu2wIyX6PxAOnvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOal4i2vQS9Sb9KrQ0mOaE5vtC68zkPR0kIESi1vcGI=;
 b=l5rZdZ9gqmJCASAzXcNRCVImvGInolEOvDBfiMQp25wmxqm9FTM6NmJg2J3bE3q6w82sZ7+Za1vBTkKzjn4o7qBnk5qj0I3LD9og8uimyAnbN2FqOJ2tvbBM6K/j4a48DGcg2Yj9Y/IDWsMTWV2hvGWqxhPGyRvhxTSPUyEvmJk5KysxB4rEEvV1FabI3A3W56KEFA7vacMOcHOYCzXe5yEJdHfTALpTQIszdhEDsJqPkXF7BrlJtkQGTiLMzvASHmUvjJh+VardFIdyKsT0CSZQTzjFBURXrZ3imS8oGD4o3iZprWBxMIHSzSQLJE2c/2zyl+UjvuLV6ozYrLw88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOal4i2vQS9Sb9KrQ0mOaE5vtC68zkPR0kIESi1vcGI=;
 b=WRxN83Rq+iHL7r6AoUjXBA+heppTKc+ReeA4R1jcEx5+u3BN3d5pDDKr90N4bEd3Sx3/lNUO16ovhCKGLdZqPhF9GFocYhDuPuAWQPUoabGLiYQlNGV7DHolv/u7tGOLRjldw03zPmYzsvlOBUrSXwIGq4gN9WQzeigJnw87uCY=
Received: from SN6PR16CA0048.namprd16.prod.outlook.com (2603:10b6:805:ca::25)
 by BYAPR02MB4149.namprd02.prod.outlook.com (2603:10b6:a03::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Wed, 24 Mar 2021 05:32:39 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::e2) by SN6PR16CA0048.outlook.office365.com
 (2603:10b6:805:ca::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:32:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:32:33 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:32:33 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51022 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOw89-0004ME-Sa; Tue, 23 Mar 2021 22:32:33 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 9B2CE60011A; Tue, 23 Mar 2021 22:29:55 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 01/20] Documentation: fpga: Add a document describing XRT Alveo drivers
Date:   Tue, 23 Mar 2021 22:29:28 -0700
Message-ID: <20210324052947.27889-2-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69d2fe96-9e90-4881-eaf3-08d8ee863d1b
X-MS-TrafficTypeDiagnostic: BYAPR02MB4149:
X-Microsoft-Antispam-PRVS: <BYAPR02MB41494B4CD964CFDF6F58B940A1639@BYAPR02MB4149.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJyjvULLi68Ag+6h1IPudYFhPpnAW1v/dLTYxqnSZ5amDbXr3UdqAfwY0ye9VU5KeFpuco49vsI4RhHfWQsJg8p2IeUq6vdnDfxZxEC8ESjIfOOmA92f1W+DhrCfw/atT8+78B7vq553ECtqaqt3TLdzqR9XWhfBoxoFRpDjTfMuZG6niHeeuozoA1NP//px3/dUVqQ7U6k77N2UmhCUwi7VY+Ae5zcFSnFi8pTzsbybo4rUn6JV80KbG9L9tHsvsmm/DxODwPK9dsVTDhYTXkb8kOL/N7V/fe2Tv6pZjKaygQlOWgEIXUpZ0uFA1ROzUy/5HJ+r/BVzApJg4bSA193+RiKpy8rO7q8P4WGyYZx8/SVvwbz1OEgfiJXfe4Ej/lcbvDvfai555cd/WCE97ZG4t7MPdOLxOYfdK/E+CTJMa40phc5ZiEjTAgnJDh5IPdewj4AQMOnJgyWi5q7+GfVxN8eip/XPXurxFt9/8MySHP8jz7LCwr/nk9+OSUk1gMospSC4zLPSd4ZjUBqNnWgdpLIbf8tP6JuhU1u0EHFvYcxlqGrSO8+hvbukhrm3UIbL1q1JAkL6+zCPfpJ2hGk0h4SlYztHqRyQb6qwI2K0WzHNRMbQkrJFdauluj/Eh2v+zIQj/AxfcPmyB7RR9xCZI7bTliZl5WPjN8ZqICpHlVEb+8A+lqz46q+Va9FsFn60cY/9G2OdWdRlhCySEPvzYKjg6tl/UJRliSInO4A=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(396003)(136003)(36840700001)(46966006)(7636003)(83380400001)(82310400003)(82740400003)(36906005)(2906002)(26005)(6666004)(42186006)(356005)(186003)(8936002)(478600001)(4326008)(2616005)(1076003)(336012)(8676002)(316002)(36860700001)(107886003)(70206006)(44832011)(426003)(36756003)(5660300002)(30864003)(70586007)(54906003)(47076005)(6266002)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:32:39.0383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d2fe96-9e90-4881-eaf3-08d8ee863d1b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4149
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
 Documentation/fpga/xrt.rst   | 844 +++++++++++++++++++++++++++++++++++
 2 files changed, 845 insertions(+)
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
index 000000000000..0f7977464270
--- /dev/null
+++ b/Documentation/fpga/xrt.rst
@@ -0,0 +1,844 @@
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
+on meta data associated with the hardware. The metadata is in the form of a device
+tree as mentioned before. Each platform driver statically defines a subsystem node
+array by using node name or a string in its ``compatible`` property. And this
+array is eventually translated to IOMEM resources of the platform device.
+
+The xrt-lib core infrastructure provides hooks to platform drivers for device node
+management, user file operations and ioctl callbacks. The core infrastructure also
+provides pseudo-bus functionality for platform driver registration, discovery and
+inter platform driver ioctl calls.
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
+The root driver manages the life cycle of multiple group drivers, which, in turn,
+manages multiple xleaf drivers. This allows a single set of drivers to support
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
+* facilities event callbacks for other xleaf drivers
+* facilities inter-leaf driver calls for other xleaf drivers
+
+When root driver starts, it will explicitly create an initial group instance,
+which contains xleaf drivers that will trigger the creation of other group
+instances. The root driver will wait for all group and leaves to be created
+before it returns from it's probe routine and claim success of the
+initialization of the entire xmgmt driver. If any leaf fails to initialize the
+xmgmt driver will still come online but with limited functionality.
+
+.. note::
+   See code in ``lib/xroot.c`` and ``mgmt/root.c``
+
+
+group
+^^^^^
+
+The group driver represents a pseudo device whose life cycle is managed by
+root and does not have real IO mem or IRQ resources. It's part of the
+infrastructure of the MPF driver and resides in xrt-lib.ko. This driver
+
+* manages one or more xleaf drivers
+* provides access to root from leaves, so that root calls, event notifications
+  and inter-leaf calls can happen
+
+In xmgmt, an initial group driver instance will be created by the root. This
+instance contains leaves that will trigger group instances to be created to
+manage groups of leaves found on different partitions on hardware, such as
+VSEC, Shell, and User.
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
+start programming the FPGA configuration engine via Internal Configuration
+Access Port (ICAP) platform driver.
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
+A user xclbin can be downloaded by using the xbmgmt tool from the XRT open source
+suite. See example usage below::
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
+For DFX to work properly physical partitions require strict HW compatibility
+with each other. Every physical partition has two interface UUIDs: *parent* UUID
+and *child* UUID. For simple single stage platforms, Shell → User forms parent
+child relationship.
+
+.. note::
+   Partition compatibility matching is key design component of Alveo platforms
+   and XRT. Partitions have child and parent relationship. A loaded partition
+   exposes child partition UUID to advertise its compatibility requirement.When
+   loading a child partition the xmgmt management driver matches parent UUID of
+   the child partition against child UUID exported by the parent. Parent and
+   child partition UUIDs are stored in the *xclbin* (for user) or *xsabin* (for
+   shell). Except for root UUID exported by VSEC, hardware itself does not know
+   about UUIDs. UUIDs are stored in xsabin and xclbin. The image format has a
+   special node called Partition UUIDs which define the compatibility UUIDs. See
+   :ref:`partition_uuids`.
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
+PCIe link and exposes two physical functions to the BIOS. After the OS boots, xmgmt
+driver attaches to the PCIe physical function 0 exposed by the Shell and then looks
+for VSEC in PCIe extended configuration space. Using VSEC it determines the logic
+UUID of Shell and uses the UUID to load matching *xsabin* file from Linux firmware
+directory. The xsabin file contains metadata to discover peripherals that are part
+of Shell and firmware(s) for any embedded soft processors in Shell. The xsabin file
+also contains Partition UUIDs as described here :ref:`partition_uuids`.
+
+The Shell exports a child interface UUID which is used for the compatibility check
+when loading user compiled xclbin over the User partition as part of DFX. When a user
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
+contains FPGA bitstream for the user partition, UUIDs, platform name, etc.
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
+in a partition. The metadata is stored in device tree format with a well defined schema.
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
+In bare-metal deployments, both MPF and UPF are visible and accessible. xmgmt
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
+In virtualized deployments, privileged MPF is assigned to host but unprivileged
+UPF is assigned to guest VM via PCIe pass-through. xmgmt driver in host binds
+to MPF. xmgmt driver operations are privileged and only accessible to the MPF.
+The full stack is illustrated below::
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
2.27.0

