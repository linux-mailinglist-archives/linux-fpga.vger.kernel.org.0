Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED534564C0
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Nov 2021 22:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhKRVHE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 16:07:04 -0500
Received: from mail-mw2nam08on2043.outbound.protection.outlook.com ([40.107.101.43]:6190
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231787AbhKRVHE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 16:07:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed9e+xqr8ILEdb0vs+5SH2Mx6bEUvVPCZTcx/QC/vbgfp2NZ5917yF9WMEtBlKYUrfha+bIBvLsAe+f8LsGNvi+6jpFaGJrrUbx6VwhldQcbZ5SSQ/o1uJ7KSZ1wvHUtxahwvTgftPfwGw63sD5R4YlyDqMN0mx1y6x9jD+YcSfhUQgLCsJ/Tbb1Q3QXK2B1unZzDxzOmYBIyAJOLTe5Lzw5TCPW5g4tYViDwalz8uwfCXtfjsQ6zraID6sN0EHIBIgyDTgSXpbErC2j2mlHPR2p2W7EBv2IO9oasXy1DwTd+Udt5HRqpkXX/D7DikE1c126dncRBANBjT7/q7XkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n6r7W3TPGDH7Ay8PmUJGY+wlppbFthoFxtNRG2cJ2I=;
 b=dl7Sd7yKV6bMFpqjEc6NAa6ONv+eAwp+b+yGab/SacCQP2xHEaeWR5N8J6A/JyaybfHFC1GjEhMkA0+p/tyThEiSVjAPdKri1Qc/RdcK5CcbLPHnhVZ9xVbjtdus/lvwSOXwntpAt/dP+Kw5BPKmw85FV2s8WgM4D1XSkOnWrNSB0xM3EhlFBzfhiz8d8onpNnu7C3QYJh+EH8UF3R6McRZuUFlj9jZ4bVmPq9612lIElRMO9kJJ7Ln5ql4hVVY59hrfJLw33A4pde3c5FY/moCqm9U+izTrtoSsUjussI29cE9cEIAMUB2Km87lqSt5Y/pqME0fOmV8DYlSHPRg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n6r7W3TPGDH7Ay8PmUJGY+wlppbFthoFxtNRG2cJ2I=;
 b=BrbaDExPo++1lmK7qdpGD3mKTW82m3hUs/r/r3SCWOmS4hIkZsM5SF8OUeqvN2lQ3Ya1Lw8CrIFcaagllepwqkTDr7630Fc5Ai9jeW6xMk/Pijo9H/r410stwQUGBbmZ9YSCZw7ft4gr9oIlblGzhpeK3I6oPHg3mXiKbS56O3c=
Received: from SN4PR0501CA0100.namprd05.prod.outlook.com
 (2603:10b6:803:42::17) by SN4PR0201MB8774.namprd02.prod.outlook.com
 (2603:10b6:806:201::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Thu, 18 Nov
 2021 21:04:01 +0000
Received: from SN1NAM02FT0048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::20) by SN4PR0501CA0100.outlook.office365.com
 (2603:10b6:803:42::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.10 via Frontend
 Transport; Thu, 18 Nov 2021 21:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0048.mail.protection.outlook.com (10.97.4.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 21:04:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 13:03:48 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 13:03:48 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=37750 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mnoZQ-0007Ct-CP; Thu, 18 Nov 2021 13:03:48 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 9D40F60003F; Thu, 18 Nov 2021 13:03:36 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 XRT Alveo Infrastructure 1/9] Documentation: fpga: Add a document describing XRT Alveo driver infrastructure
Date:   Thu, 18 Nov 2021 13:03:15 -0800
Message-ID: <20211118210323.1070283-2-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
References: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d605610c-764f-4604-0156-08d9aad6f228
X-MS-TrafficTypeDiagnostic: SN4PR0201MB8774:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB877498D0E8766C4A97EA9311A19B9@SN4PR0201MB8774.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Y2QH5KxEhebPEkt+ANYliTm+9sOyIlTiaBCD42HkLFLVLI09meXzIkxnt0ZNeGLQB+RIzgq3hBLZaX5x/DlgwSaEpESl/uyUFcxzzFkgkZ3xmzmTeVoaAJ3RmBTzkvRqg90rL22AQ9CSCgVgoR5rhtzQDVyDo5cF2jYj1EJZ6vv2l8XiI/qabTYNh0sWZZdMpfedhSKBvOR7n5m6fJFRoVq+giLTXyE4kPI4sGW29l7qxOCXcFCSdcISeab1dNfkYQV9RcK5rCi9jUF7HrNJIme379bz2rmzDEPsOgNm+7pAe9X5e2VURSIbin3gAQo9Y/g1McCJ13gLY7CszgOJDqx3w5x3D/2DG/wWTX0TJN+OMd2m8XckApnndTzdauzX5brlMpPM7ce3w/ZGDGYfJ7diPoPTqfhjQCSggvsHszJsQcmTyoDWjsayzrPoI/1ve5mEJHZ1owtb6jw16sbQISPQ4VjKo49gMzlcVLHdkk8JdDo1SbFjD5ixJyr8jLAW+aTnyosFNIVeH4aaBzbXKk3amwmcOYiKh41ahXNYohZvK/ESUF7mpg7I2ITTrc3n4Rr1a+9pni4AazDaTldvse4gNk+XypNz/h6vCHKzDIApRIZd+DNtnb3+KYA9Afcfw6tUi2RmA6pyLVb95VYDQW9SD9lQnAjJ6WDZlrQg41JMJCcH+pucGhLMW4lRGkJY1ji3k4Qzu166zBwYg+bNYPVdsqkM8FT3P04ds3aRQP70zRxbzt/AXzd3KHreuTnawZdKeop4ROm5BJ4ceKrJQFVaXlklXYYD0RFX9j/NN/6buf/Fv0hmCl8QY0Wvu1BAYefhLfd8lnY02QmrIAN2g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(44832011)(30864003)(2906002)(186003)(336012)(5660300002)(36756003)(2616005)(356005)(6916009)(42186006)(508600001)(7636003)(83380400001)(4326008)(70206006)(6266002)(6666004)(70586007)(107886003)(26005)(82310400003)(36860700001)(1076003)(8936002)(966005)(8676002)(54906003)(426003)(36906005)(316002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:04:01.1267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d605610c-764f-4604-0156-08d9aad6f228
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8774
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
 Documentation/fpga/xrt.rst   | 510 +++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  10 +
 3 files changed, 521 insertions(+)
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
index 000000000000..323ded5c0f4a
--- /dev/null
+++ b/Documentation/fpga/xrt.rst
@@ -0,0 +1,510 @@
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
+**xrt-user** and is under development. xrt_driver framework and FPGA subsystem
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
+xrt-lib is the repository of xrt drivers and pure software modules that can
+potentially be shared between xrt-mgmt and xrt-user. All these drivers are
+structured as **xrt_driver** and are instantiated by xrt-mgmt (or xrt-user under
+development) based on the metadata associated with the hardware.  The metadata
+is in the form of a device tree as mentioned before.
+
+xrt-lib relies on OF kernel APIs to unflatten the metadata and overlay the
+unflattened device tree nodes to system device tree. In xrt-lib module initialization
+routine, "/xrt-bus" is created in system device tree, all XRT device
+tree nodes and properties will be under "/xrt-bus".
+
+The xrt-lib infrastructure provides hooks to xrt_drivers for device node
+management, user file operations and ioctl callbacks. The core infrastructure also
+provides a bus functionality called **xrt_bus_type** for xrt_driver registration,
+discovery and inter xrt_driver calls. xrt-lib does not have any dependency on PCIe
+subsystem.
+
+xrt-mgmt.ko
+------------
+
+The xrt-mgmt driver is a PCIe device driver driving MPF found on Xilinx's Alveo
+PCIe device. It creates one or more *group* device and one or more *xleaf* device.
+The group and xleaf drivers are in xrt-lib and instantiations of the xrt_driver but
+are called group and xleaf to symbolize the logical operation performed by them.
+
+The xrt-mgmt driver uses xrt-lib APIs to manages the life cycle of multiple group
+drivers, which, in turn, manages multiple xleaf drivers. This flexibility allows
+xrt-mgmt.ko and xrt-lib.ko to support various HW subsystems exposed by different
+Alveo shells. The differences among these Alveo shells is handled in xleaf drivers.
+The group driver is part of the infrastructure which provides common services to xleaf
+drivers found on various Alveo shells. See :ref:`alveo_platform_overview`.
+
+The instantiation of specific group driver or xleaf drivers is completely data
+driven based on metadata (mostly in device tree format) found through VSEC
+capability and inside the firmware files, such as platform xsabin or user xclbin
+file.
+
+
+Driver Object Model
+===================
+
+The driver object model looks like the following::
+
+                              +-----------+
+                              |  of root  |
+                              +-----+-----+
+                                    |
+                          +---------+---------+
+                          |                   |
+                    +-----------+        +----------+
+                    |  xrt-bus  |        |   ...    |
+                    +-----+-----+        +----------+
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
+                                |  xrt-bus  |
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
+                                |  xrt-bus  |
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
+group
+-----
+
+The group driver represents a pseudo device whose life cycle is managed by
+root and does not have real IO mem or IRQ resources. It's part of the
+infrastructure of the MPF driver and resides in xrt-lib.ko. This driver
+
+* manages one or more xleaf drivers
+* handle requests from xleaf drivers. For example event notifications and
+  inter xleaf calls.
+
+In xrt-mgmt, an initial group driver instance will be created by the PCIe driver.
+This instance contains xleaf drivers that will trigger group instances to be
+created to manage groups of xleaf drivers found on different partitions of
+hardware, such as VSEC, Shell, and User.
+
+xleaf
+-----
+
+The xleaf driver is a xrt_driver whose life cycle is managed by
+a group driver and may or may not have real IO mem or IRQ resources. They
+manage HW subsystems they are attached to.
+
+A xleaf driver without real hardware resources manages in-memory states for
+xrt-mgmt. These states are shareable by other xleaf drivers.
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
+xrt_bus_type
+------------
+
+xrt_bus_type defines a virtual bus which handles xrt_driver probe, remove and match
+operations. All xrt_drivers register with xrt_bus_type as part of xrt-lib driver
+``module_init`` and un-register as part of xrt-lib driver ``module_exit``.
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
+downloaded to the fpga_region, an instance of a group is created for the
+fpga_region using the device tree obtained as part of the xclbin. If this
+device tree defines any child interfaces, it can trigger the creation of
+fpga_bridge and fpga_region for the next region in the chain.
+
+fpga_bridge
+-----------
+
+Like the fpga_region, an fpga_bridge is created by walking the device tree
+of the parent group. The bridge is used for isolation between a parent and
+its child.
+
+Driver Interfaces
+=================
+
+xrt-mgmt Driver Ioctls
+----------------------
+
+Ioctls exposed by the xrt-mgmt driver to user space are enumerated in the
+following table:
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
+.. _alveo_platform_overview:
+
+Alveo Platform Overview
+=======================
+
+Alveo platforms are architected as two physical FPGA partitions: *Shell* and
+*User*. The Shell provides basic infrastructure for the Alveo platform like
+PCIe connectivity, board management, Dynamic Function Exchange (DFX), sensors,
+clocking, reset, and security. DFX, partial reconfiguration, is responsible for
+loading the user compiled FPGA binary.
+
+For DFX to work properly, physical partitions require strict HW compatibility
+with each other. Every physical partition has two interface UUIDs: the *parent*
+UUID and the *child* UUID. For simple single stage platforms, Shell → User forms
+the parent child relationship.
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
+   which define the compatibility UUIDs.
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
+the xrt-mgmt driver attaches to the PCIe physical function 0 exposed by the Shell
+and then looks for VSEC in the PCIe extended configuration space. Using VSEC, it
+determines the logic UUID of the Shell and uses the UUID to load matching *xsabin*
+file from Linux firmware directory. The xsabin file contains the metadata to
+discover the peripherals that are part of the Shell and the firmware for any
+embedded soft processors in the Shell. The xsabin file also contains Partition
+UUIDs.
+
+The Shell exports a child interface UUID which is used for the compatibility
+check when loading the user compiled xclbin over the User partition as part of DFX.
+When a user requests loading of a specific xclbin, the xrt-mgmt driver reads
+the parent interface UUID specified in the xclbin and matches it with the child
+interface UUID exported by the Shell to determine if the xclbin is compatible with
+the Shell. If the match fails, loading of xclbin is denied.
+
+xclbin loading is requested using the ICAP_DOWNLOAD_AXLF ioctl command. When loading
+a xclbin, the xrt-mgmt driver performs the following *logical* operations:
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
+contains an FPGA bitstream for the user partition, UUIDs, platform name, etc.
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
+xclbin/xsabin files can be packaged, un-packaged and inspected using an XRT
+utility called **xclbinutil**. xclbinutil is part of the XRT open source
+software stack. The source code for xclbinutil can be found at
+https://github.com/Xilinx/XRT/tree/master/src/runtime_src/tools/xclbinutil
+
+For example, to enumerate the contents of a xclbin/xsabin use the *--info* switch
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
+The xsabin file stores metadata which advertise HW subsystems present in a
+partition. The metadata is stored in device tree format with a well defined
+schema. XRT management driver uses this information to create *xrt_devices* and
+bind *xrt_drivers* to them. The xrt_drivers could be independent modules or
+found in **xrt-lib.ko** kernel module.
+
+Deployment Models
+=================
+
+Baremetal
+---------
+
+In bare-metal deployments, both MPF and UPF are visible and accessible. The
+xrt-mgmt driver binds to MPF. The xrt-mgmt driver operations are privileged and
+available to system administrator. The full stack is illustrated below::
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
+unprivileged UPF is assigned to a guest VM via PCIe pass-through. The xrt-mgmt
+driver in host binds to MPF. The xrt-mgmt driver operations are privileged and
+only accessible to the MPF. The full stack is illustrated below::
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
index 80eebc1d9ed5..fd7053bcfdb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7369,6 +7369,16 @@ F:	Documentation/fpga/
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
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
-- 
2.27.0

