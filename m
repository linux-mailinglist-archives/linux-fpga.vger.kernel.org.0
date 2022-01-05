Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD6A485BD8
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jan 2022 23:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiAEWvN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jan 2022 17:51:13 -0500
Received: from mail-dm3nam07on2077.outbound.protection.outlook.com ([40.107.95.77]:16481
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245183AbiAEWux (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Jan 2022 17:50:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCsELgIXkkCrgzytXOoANGDy1brOTLIXwgtqdpWi1tlw4yzwuz7VH65+9mCO2C5QzqWJcjVxFEAhVg5IKkCZA54ua+qCW187DeUkKVI2IKSrHkdihAzFP82h0+y93Fpxx0MOQnvevIKTD1ASt/HoUeTjLWqdcCfM12Y0fRk0XcgEkh/4l/sE7/Z1eIkIOuYi0BaniPpODoe3dY1++ybxeBm9Q/9OAyq0IuzcZ4qwdJpuc4eTFtLl4qcir7zCwH2Ox8eSvSF9QQ0NCwKDtZTNBiM8HttAvxmEKX5S+0NRHjITBocT4R/Xh5S5xiPmQm8Nlmdw+A8afUlLDwphB2eWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zthWXI8MK9B0dRqUNdnfgk2KukXyZu2rdCcwxGx2AUQ=;
 b=IYF/KEjVGciO4hMwelx/ydpyDjGT/KUoO3zvugdw00KjJAz32oj1DygEV2nilFfPyn7idaZZcHYUEMkU30MaV8NSjTMZZraBzZeQ+VLvrxj4U/g4oYYOCHlnZMd6f6TTaBVAn7fQOKJd2ABh0EtRMrddjh/adLyiSdQ9Y1tQZsB2r+u/XrD+w8PWm8aLJHDrtD7enrBnVvmk/dGXbDdf6ud6k/AQ2rcu5TZGEoUV5FNn27S2knsofo7nKrwxx8wlm2cEmi/+hBB+jItyhPFxgPIawWWtMpVMoC8HpGFnLD5MjRHsDOImeQNimkLMm1Yy/Gp85vJHba1qj988W03H0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zthWXI8MK9B0dRqUNdnfgk2KukXyZu2rdCcwxGx2AUQ=;
 b=pLWHvkkK+dHZQhp9Fn6Fzwrl/HqGxA6hGbY0PIQbkOh4/Z+Qh5bW26WanGiLFT9bAOVh8HAE5Akw78ceRu1jVu5nNasNxrrU0WOd+DQae4j3Fdq2VXF4Dsv0WNPU72UpiousMp5OYvXMSMoAqSNY8qRflZB4i1+U2DQYKDczQMA=
Received: from DS7PR03CA0235.namprd03.prod.outlook.com (2603:10b6:5:3ba::30)
 by BYAPR02MB4774.namprd02.prod.outlook.com (2603:10b6:a03:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 22:50:49 +0000
Received: from DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::95) by DS7PR03CA0235.outlook.office365.com
 (2603:10b6:5:3ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Wed, 5 Jan 2022 22:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT058.mail.protection.outlook.com (10.13.5.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Wed, 5 Jan 2022 22:50:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 5 Jan 2022 14:50:48 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 5 Jan 2022 14:50:48 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=56778 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1n5F7G-000ApI-4l; Wed, 05 Jan 2022 14:50:48 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id CB02F600AD1; Wed,  5 Jan 2022 14:50:22 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo Infrastructure 1/5] Documentation: fpga: Add a document describing XRT Alveo driver infrastructure
Date:   Wed, 5 Jan 2022 14:50:09 -0800
Message-ID: <20220105225013.1567871-2-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e8d663-a023-4b5a-eea2-08d9d09dd15d
X-MS-TrafficTypeDiagnostic: BYAPR02MB4774:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB4774BBA286A79342B880C1B8A14B9@BYAPR02MB4774.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQjySq0fFp6YzUxbro6G6EqASUeb0ZFWKo6K8ynerIHqv3o2pGxKfQZEtPWI7ZBQkySveGliFZP+ioRPBitLq9Txn+mLzyhLcGN+z8Z7p1fiR1inFxPZ+AxqcvKjYFM0GtGEw+nIXspLRguH4/Lh5tD+1fZZ8ilBCax080swn2iHXRuXpYZCg7LsfVt3S3mObuGRcL7xurYZftSHV/THUjiVtwq6ZY05hRPAhdJ05eLbF4RtjzgTatgridc26rCPGcphhcm3VBvm6Uhl6mMt7VCh/ttiBb95iak57LoI2rPDVb1ph9uroYIu/17Z/MOGtATnjHTHUkYG9PC5O46XG7RnRXS2YuiCXmijPIwugdbw9mlDsFTpJD/bgisC/zH0n92Oi2Fj+VsikEKAZwJLfSYaYvy/fOzI+Pp/uSxOOZi+08U7pMQhlnU+0dDVsTTKH47wWdcEF8n5YX67Ih4rCIlJ6M1Rpo6y/Bn2byKyy5GOFPcWCWFwddDT3ApPHu+sSNzm4TcxGxBls+Crf+En8PkPliuCz263OnKtidf+IEMtA3SSlg+eX/b58oDBetnqN9nNLZiXiNkbIvTdcmZbCmDOaX55zbB3hyX0IZZEjG+9Qt0j0715IxWDKIdpJajOJNpi2tHcVz83QvqyHJurbv+MMYeSl1gZMAb8teAOgE+RHiJ//D2U5QVuujM4SKfQWV46Ju3OkkW6ioeElStJAl5Svl6jKSNJGj2/68qwwyksEhS4bNixh5oXsML+GrQv4xGdX6/LbcSF26ChNN79N6PeYut1Td4djdDi4cy7r3VsAvioSr59lvAO1MK6DJZi4ZJedu4Lqm6bUKj3STdyQg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6916009)(36756003)(5660300002)(54906003)(4326008)(107886003)(44832011)(36860700001)(2906002)(508600001)(82310400004)(316002)(42186006)(966005)(30864003)(83380400001)(70206006)(8936002)(26005)(336012)(70586007)(1076003)(47076005)(186003)(6266002)(2616005)(8676002)(6666004)(356005)(7636003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:50:48.9735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e8d663-a023-4b5a-eea2-08d9d09dd15d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4774
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
 Documentation/fpga/xrt.rst   | 337 +++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  10 ++
 3 files changed, 348 insertions(+)
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
index 000000000000..45d6f2e18af0
--- /dev/null
+++ b/Documentation/fpga/xrt.rst
@@ -0,0 +1,337 @@
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
+XRTV2 drivers support *subsystem* style data driven platforms where the driver's
+configuration and behavior are determined by the metadata provided by the
+platform (in *device tree* format). Primary management physical function (MPF)
+driver is called **xrt-mgmt**. Primary user physical function (UPF) driver is
+called **xrt-user** and is under development. xrt_driver common APIs are packaged
+into a library module called **xrt-lib**, which is shared by **xrt-mgmt** and
+**xrt-user** (under development).
+
+Driver Modules
+==============
+
+xrt-lib.ko
+----------
+
+xrt-lib is the repository of functions that can potentially be shared between
+xrt-mgmt and xrt-user.
+
+Alveo platform consists of one or more FPGA partitions. Each partition has
+multiple HW peripherals (also referred to as endpoints) and metadata to describe
+the endpoints. This metadata is in flat device tree format. xrt-lib relies on OF
+kernel APIs to un-flatten the metadata and overlay the un-flattened device tree
+nodes to the system base device tree.
+
+xrt-mgmt.ko
+------------
+
+The xrt-mgmt driver is a PCIe device driver driving MPF found on Xilinx's Alveo
+PCIe device. It reads Alveo platform partition metadata and creates one or more
+partitions based on the hardware design. xrt-lib APIs are called to overlay the
+endpoint nodes to the system base tree. Eventually, platform devices are
+generated for each endpoint defined in the partition metadata.
+
+The xrt-mgmt driver uses xrt-lib APIs to manage the life cycle of partitions,
+which, in turn, manages multiple endpoints (platform devices) generated during
+partition creation. This flexibility allows xrt-mgmt.ko and xrt-lib.ko to support
+various HW subsystems exposed by different Alveo shells. The differences among
+these Alveo shells is handled in the endpoint (platform device) drivers.
+See :ref:`alveo_platform_overview`.
+
+The instantiation of a specific endpoint driver is completely data driven based
+on the metadata (in the device tree format). The flattened device tree is stored
+in a xsabin file which is discovered through the PCIe VSEC capability.
+
+
+Driver Object Model
+===================
+
+The system device tree after overlaying Alveo partitions looks like the
+following::
+
+                            +-----------+
+                            |  of root  |
+                            +-----------+
+                                  |
+              +-------------------+-------------------+
+              |                   |                   |
+              v                   v                   v
+      +-------------+      +------------+        +---------+
+      | xrt-part0   |      | xrt-partN  |        |         |
+      |(simple-bus) |  ... |(simple-bus)|        |   ...   |
+      +-------------+      +------------+        +---------+
+              |                   |
+              |                   |
+        +-----+--------+          |
+        |              |          |
+        v              v          v
+  +-----------+  +-----------+  +------------+
+  |ep_foo@123 |..|ep_bar@456 |  | ep_foo@789 |
+  +-----------+  +-----------+  +------------+
+
+partition node
+--------------
+
+The partition node is created and added to the system device tree when the driver
+creates a new partition. It is compatible with ``simple-bus`` which is a
+transparent bus node defined by Linux kernel. The partition node is used for
+translating the address of underneath endpoint to CPU address.
+
+endpoint node
+-------------
+
+During the partition creation, xrt driver un-flattens the partition metadata and
+adds all the endpoint nodes under the partition node to the system device tree.
+Eventually, all the endpoint nodes will be populated by the existing platform
+device and OF infrastructure. This means a platform device will be created for
+each endpoint node. The platform driver will be bound based on the ``compatible``
+property defined in the endpoint node.
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
+form of flat device tree.
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

