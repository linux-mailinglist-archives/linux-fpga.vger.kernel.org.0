Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29494DABA3
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Mar 2022 08:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351110AbiCPHNN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 03:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354281AbiCPHNI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 03:13:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415555DE54;
        Wed, 16 Mar 2022 00:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647414714; x=1678950714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l15JadKf9Nz32702pJxV1seWJTMzNF6fJsTjk92xnng=;
  b=cJ6vvZ5SwaC2rb2qK5T5e02fDovibkzkqKUxuet3IT5R0WATh2eSUW48
   PjvpSqTKOhixrJLJZCOHfrburGjKrJ8B9XdvPsbLpqGKa0Nr1QOJjAi6F
   3iIb8RsWNOWlXZ01fXYlqTDDAVHaDCZ2GV4RNf/8lrPnpxT1HydTc4JFT
   yYJLUsYKDrpTiQzvUVdUSxa7VejxuBbd+0YXGYzFZM/J2rCHUKQvJUdg8
   WlwLjOwYWQm8w4Im4nWAMKANQYpeqebkZ0D4+752Hsq2l/bTR8FcwPI65
   xQ0wmR6L1gExY+sEwIzEGRSZ3SbHs9LiGQI4/RchlPlZ5bFujPSCB6Hxk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281289067"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281289067"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646538406"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 00:11:51 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v6 6/6] Documentation: fpga: dfl: add description of OFS
Date:   Wed, 16 Mar 2022 03:08:14 -0400
Message-Id: <20220316070814.1916017-7-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220316070814.1916017-1-tianfei.zhang@intel.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

This patch adds description about OFS support for DFL.

---
v6:
fix documentation with Randy's comment.
v5:
fix documentation with Matthew and Randy's comment.
v4:
add description about access the AFU on "multiple VFs per PR slot" model.
v3:
change IOFS to OFS in documentation.
v2:
* Fixs some typos.
* Adds more detail description about the models of AFU access which supported in OFS.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
 Documentation/fpga/dfl.rst | 114 +++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ef9eec71f6f3..93f262fe7b8c 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -556,6 +556,120 @@ new DFL feature via UIO direct access, its feature id should be added to the
 driver's id_table.
 
 
+Open FPGA Stack
+=====================
+
+Open FPGA Stack (OFS) is a collection of RTL and open source software providing
+interfaces to access the instantiated RTL easily in an FPGA. OFS leverages the
+DFL for the implementation of the FPGA RTL design.
+
+OFS designs allow for the arrangement of software interfaces across multiple
+PCIe endpoints. Some of these interfaces may be PFs defined in the static region
+that connect to interfaces in an IP that is loaded via Partial Reconfiguration (PR).
+And some of these interfaces may be VFs defined in the PR region that can be
+reconfigured by the end-user. Furthermore, these PFs/VFs may use DFLs such that
+features may be discovered and accessed in user space (with the aid of a generic
+kernel driver like vfio-pci). The diagram below depicts an example design with two
+PFs and two VFs. In this example, it will export the management functions via PF0,
+PF1 will bind with virtio-net driver presenting itself as a network interface to
+the OS. The other functions, VF0 and VF1, leverage VFIO to export the MMIO space
+to an application or assign to a VM.
+::
+
+     +-----------------+  +--------------+  +-------------+  +------------+
+     | FPGA Management |  |   VirtIO     |  |  User App   |  | Virtual    |
+     |      App        |  |     App      |  |             |  | Machine    |
+     +--------+--------+  +------+-------+  +------+------+  +-----+------+
+              |                  |                 |               |
+     +--------+--------+  +------+-------+  +------+------+        |
+     |     DFL Driver  |  |VirtIO driver |  |    VFIO     |        |
+     +--------+--------+  +------+-------+  +------+------+        |
+              |                  |                 |               |
+              |                  |                 |               |
+     +--------+--------+  +------+-------+  +------+------+   +----+------+
+     |     PF0         |  |     PF1      |  |   PF0_VF0   |   |  PF0_VF1  |
+     +-----------------+  +--------------+  +-------------+   +-----------+
+
+As accelerators are specialized hardware, they are typically limited in the
+number installed in a given system. Many use cases require them to be shared
+across multiple software contexts or threads of software execution, either
+through partitioning of individual dedicated resources, or virtualization of
+shared resources. OFS provides several models to share the AFU resources via
+PR mechanism and hardware-based virtualization schemes.
+
+1. Legacy model.
+   With legacy model FPGA cards like Intel PAC N3000 or N5000, there is
+   a notion that the boundary between the AFU and the shell is also the unit of
+   PR for those FPGA platforms. This model is only able to handle a
+   single context, because it only has one PR engine, and one PR region which
+   has an associated Port device.
+2. Multiple VFs per PR slot.
+   In this model, available AFU resources may allow instantiation of many VFs
+   which have a dedicated PCIe function with their own dedicated MMIO space, or
+   partition a region of MMIO space on a single PCIe function. Intel PAC N6000
+   card has implemented this model.
+   In this model, the AFU/PR slot was not connected to port device. For DFL's view,
+   the Next_AFU pointer in FIU feature header of port device points to NULL in this
+   model, so in AFU driver perspective, there is no AFU MMIO region managed by
+   AFU driver. On the other hand, each VF can start with an AFU feature header without
+   being connected to a FIU Port feature header.
+
+In multiple VFs per PR slot model, the port device can still be accessed using
+ioctls API which expose /dev/dfl-port.h device nodes, like port reset, get
+port info, whose APIs were mentioned in AFU section in this documentation. But
+it cannot access the AFU MMIO space via AFU ioctl APIs like DFL_FPGA_PORT_DMA_MAP
+because there is no AFU MMIO space managed in the AFU driver. Users can access
+the AFU resource by creating VF devices via PCIe SRIOV interface, and then access
+the VF via VFIO driver or assign the VF to VM.
+
+In multiple VFs per PR slot model, the steps to enable VFs are compatible with
+legacy mode which are mentioned in "FPGA virtualization - PCIe SRIOV" section
+in this documentation.
+
+OFS provides the diversity for accessing the AFU resource to RTL developer.
+An IP designer may choose to add more than one PF for interfacing with IP
+on the FPGA and choose different model to access the AFU resource.
+
+There is one reference architecture design using the "Multiple VFs per PR slot"
+model for OFS as illustrated below. In this reference design, it exports the
+FPGA management functions via PF0. PF1 will bind with virtio-net driver
+presenting itself as a network interface to the OS. PF2 will bind to the
+vfio-pci driver allowing the user space software to discover and interface
+with the specific workload like diagnostic test. To access the AFU resource,
+it uses SR-IOV to partition workload interfaces across various VFs.
+::
+
+                              +----------------------+
+                              |   PF/VF mux/demux    |
+                              +--+--+-----+------+-+-+
+                                 |  |     |      | |
+        +------------------------+  |     |      | |
+  PF0   |                 +---------+   +-+      | |
+    +---+---+             |         +---+----+   | |
+    |  DFH  |             |         |   DFH  |   | |
+    +-------+       +-----+----+    +--------+   | |
+    |  FME  |       |  VirtIO  |    |  Test  |   | |
+    +---+---+       +----------+    +--------+   | |
+        |                PF1            PF2      | |
+        |                                        | |
+        |                             +----------+ |
+        |                             |           ++
+        |                             |           |
+        |                             | PF0_VF0   | PF0_VF1
+        |           +-----------------+-----------+------------+
+        |           |           +-----+-----------+--------+   |
+        |           |           |     |           |        |   |
+        |           | +------+  |  +--+ -+     +--+---+    |   |
+        |           | | Port |  |  | DFH |     |  DFH |    |   |
+        +-----------+ +------+  |  +-----+     +------+    |   |
+                    |           |  | DEV |     |  DEV |    |   |
+                    |           |  +-----+     +------+    |   |
+                    |           |            PR Slot       |   |
+                    |           +--------------------------+   |
+                    | Port Gasket                              |
+                    +------------------------------------------+
+
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.26.2

