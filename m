Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551CC4D003C
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Mar 2022 14:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiCGNil (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Mar 2022 08:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242893AbiCGNhK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Mar 2022 08:37:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792577D028;
        Mon,  7 Mar 2022 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646660176; x=1678196176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i7gwv5O4GkNL6rgs1vkOvdH5VNk7zaVgX2afxTaLEy4=;
  b=MoDAPU9H3GPgaxamESCCMILqA7Rxwpnema6lIoPThO568+4Qgd5xqgZ9
   Xs9rGGEa6O2JvBfEsrhwccGknUJTnYNRDYyc0oySHXzQkplNaaF+/srax
   ViA5Q+2UJeCK3XfQeOuqSKRjTuleU96iTIZd9LCg2jq+getkMGnKpM2Em
   HhsJcKBYyJ2DNNN2dgF5pBG77iXlHXTdtDZCYBaF9T162vjmnyex22aIW
   Nzqjw5njwk7TiEUfJZnzwEgHFcbXUk9JmZz6Z8nSFh++f4J9OmAfrZVpv
   y3uyKu4eRIbsvXykzuFBiloACLapiI8DPPSp3DQbTza/1vFLgH7pRVjw4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254579377"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254579377"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:36:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643247030"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 05:36:13 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4 6/6] Documentation: fpga: dfl: add description of OFS
Date:   Mon,  7 Mar 2022 08:32:43 -0500
Message-Id: <20220307133243.1426300-7-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220307133243.1426300-1-tianfei.zhang@intel.com>
References: <20220307133243.1426300-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds description about OFS support for DFL.

---
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
index ef9eec71f6f3..4dcd5cc101c4 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -556,6 +556,120 @@ new DFL feature via UIO direct access, its feature id should be added to the
 driver's id_table.
 
 
+Open FPGA stack
+=====================
+
+Open FPGA stack aka OFS, a collection of RTL and open software providing interface
+to access the instantiated RTL easily in FPGA. OFS leverages the DFL for the
+implementation of the FPGA RTL design.
+
+OFS designs allow for the arrangement of software interfaces across multiple
+PCIe endpoints. Some of these interfaces may be PFs defined in the static region
+that connect to interfaces in an IP that is loaded via Partial Reconfiguration (PR).
+And some of these interfaces may be VFs defined in the PR region that can be
+reconfigured by the end-user. Furthermore, these PFs/VFs may also be arranged
+using a DFL such that features may be discovered and accessed in user space
+(with the aid of a generic kernel driver like vfio-pci). The diagram below depicts
+an example design with two PFs and two VFs. In this example, it will export the
+management functions via PF0, PF1 will bind with virtio-net driver presenting itself
+as a network interface to the OS. The other functions, VF0 and VF1, leverage VFIO
+to export the MMIO space to an application or assign to a VM.
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
+shared resources. On OFS, it provides several models to share the AFU
+resources via PR mechanism and hardware-based virtualization schemes.
+
+1. Legacy model.
+   In legacy FPGA card platforms (like Intel PAC N3000 or N5000 Card),there is
+   a notion that the boundary between the AFU and the shell is also the unit of
+   PR for those FPGA platforms. In this model, it can only able to handle a
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
+In multiple VFs per PR slot model, it still can access the port device using
+ioctls API which expose by /dev/dfl-port.n device node, like port reset, get
+port info, whose APIs were mentioned in AFU section in this documentation. But
+it cannot access the AFU MMIO space via AFU ioctl APIs like DFL_FPGA_PORT_DMA_MAP
+because no AFU MMIO space managed in AFU driver. Users can access the AFU resource
+by create VF devices via PCIe SRIOV interface, and then access the VF via VFIO
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

