Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE34D74DE
	for <lists+linux-fpga@lfdr.de>; Sun, 13 Mar 2022 12:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiCMK7l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Mar 2022 06:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiCMK6c (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Mar 2022 06:58:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E817925A;
        Sun, 13 Mar 2022 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647169042; x=1678705042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ycxS6hXjlOl0lJYRTULrmUeJPYeloRwhDspTCAgJ33U=;
  b=CXo+PN71PgEG/1+4Rt7csFtQucFtDtWshmheFvaa/LSKuGfyFBymMGqa
   yUPhWKqm+5X1TYEUVYOJ7DCutKLiz16AbP54cXtRuDaIhMyo2lbC+4RcB
   ckZ6EcO3xOV+qoaaeY170CUKpnv6dXEFLNh/5cTZRxTxJlvc9Tsyn6hQV
   /xGiclnASa9P5scsshPjG2fxF8qD0PaUh3A59RfCHZseKbCwR5sSM08PA
   vMtgCVKxeFGlPolf7QeEoDBGGJgJMYCsAlpTeumZEzlR6PkfBwNI8pVUW
   wz9G3rfDftG6edQUBlZynW8tLPbJUHK9QMoYkPeodQ0xEBZ57KhCTfdgR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="319086341"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="319086341"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 03:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713380345"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 03:56:15 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v5 6/6] Documentation: fpga: dfl: add description of OFS
Date:   Sun, 13 Mar 2022 06:52:42 -0400
Message-Id: <20220313105242.1567774-7-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220313105242.1567774-1-tianfei.zhang@intel.com>
References: <20220313105242.1567774-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

This patch adds description about OFS support for DFL.

---
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
index ef9eec71f6f3..4c1f9cb82ccb 100644
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
+   With legacy model FPGA cards like Intel PAC N3000 or N5000,there is
+   a notion that the boundary between the AFU and the shell is also the unit of
+   PR for those FPGA platforms. This model can only able to handle a
+   single context, because it only has one PR engine, and one PR region which
+   has an associated Port device.
+2. Multiple VFs per PR slot.
+   In this model, available AFU resources may allow instantiation of many of VFs
+   which has a dedicated PCIe function with their own dedicated MMIO space, or
+   partition a region of MMIO space on a single PCIe function. Intel PAC N6000
+   card has implemented this model.
+   In this model, the AFU/PR slot was not connected to port device. For DFL's view,
+   the Next_AFU pointer in FIU feature header of port device points to NULL in this
+   model, so in AFU driver perspective, there are no AFU MMIO region managed by
+   AFU driver. On the other hand, each VF can start with an AFU feature header without
+   connected to a FIU Port feature header.
+
+In multiple VFs per PR slot model, the port device can still be accessed using
+ioctls API which expose by /dev/dfl-port.n device node, like port reset, get
+port info, whose APIs were mentioned in AFU section in this documentation. But
+it cannot access the AFU MMIO space via AFU ioctl APIs like DFL_FPGA_PORT_DMA_MAP
+because no AFU MMIO space managed in AFU driver. Users can access the AFU resource
+by creating VF devices via PCIe SRIOV interface, and then access the VF via VFIO
+driver or assign the VF to VM.
+
+In multiple VFs per PR slot model, the steps enable VFs are compatible with
+legacy mode which mentioned in "FPGA virtualization - PCIe SRIOV" section
+in this documentation.
+
+OFS provides the diversity for access the AFU resource to RTL developer.
+An IP designer may choose to add more than one PF for interfacing with IP
+on the FPGA and choose different model to access the AFU resource.
+
+There is one reference architecture design using the "Multiple VFs per PR slot"
+model for OFS as illustrated below. In this reference design, it exports the
+FPGA management functions via PF0. PF1 will bind with virtio-net driver
+presenting itself as a network interface to the OS. PF2 will bound to the
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

