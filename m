Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E34C8403
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 07:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiCAGZ4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 01:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiCAGZr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 01:25:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E20B76E27;
        Mon, 28 Feb 2022 22:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646115895; x=1677651895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5R3EskLi5TaBVZdnQEcrYdrqfXC1QZeIvpwUfEsGKl0=;
  b=VifAcRl4DNOETVugxUOZeIr24EMDke/yRv4ZXb37AvKlZgdf6zP7wiLe
   papDnEnVA2njM5peDR2Ls2+13/CnvBMuNtXjG7pwwcEN5n+0Em7+BjUE5
   NZb5Fi+eYAsfABoHjvbBbok4KeHyqSkwahVySQpezHkINZUi4R6mLjqE2
   9P3jrmp/mZuPWIa0F9CtEnNn0N6VpYrgP1RY7fhhERgJEe1LQQyvwxv62
   VvX7IWNIMwwqLxoJAdedIwuN17nb7dPIyGIHxz0TaqIeZdnWFCMRxAgxW
   bzs9fBI86lywFGn9j2oTl+tCjbfTE9B5fE8X6xIp5leWb9dXak95ZsmtX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251900336"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="251900336"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:24:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="708941808"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 22:24:48 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3 5/5] Documentation: fpga: dfl: add description of OFS
Date:   Tue,  1 Mar 2022 01:21:23 -0500
Message-Id: <20220301062123.818687-6-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220301062123.818687-1-tianfei.zhang@intel.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds description about OFS support for DFL.

---
v3:
change IOFS to OFS in documentation.

v2:
* Fixs some typos.
* Adds more detail description about the models of AFU access which supported in OFS.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
 Documentation/fpga/dfl.rst | 113 +++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ef9eec71f6f3..753507e7b162 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -556,6 +556,119 @@ new DFL feature via UIO direct access, its feature id should be added to the
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
+     +--------+--------+--+------+-------+  +------+------+        |
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
+   partition a region of MMIO space on a single PCIe function.
+   In this model, the Port device would not connected to AFU/PR slot, so we don't
+   need to release the Port device before creating the VFs. For DFL's view, the AFU
+   will not connect to Port device, so the Next_AFU pointer in FIU feature header
+   of port device points to NULL in this model. On the other hand, each VF can start
+   with an AFU feature header without connected to a FIU Port feature header.
+3. Micro-Personas in AFU.
+   OFS introducing a new concept to extend the FPGA usage, Micro-Personas in
+   AFU. It finds some downsides of the legacy model to be unacceptable, because
+   this may be desirable by a customer who intends to switch out one accelerator
+   for another accelerator without having to reconfigure the entire FPGA.
+   Micro-Personas allow the developer to designate their own AFU-defined PR
+   regions. In this model the unit of PR is not the entire AFU, instead
+   the unit of PR can be any size block or blocks inside the AFU.
+   In this model, it has PR capability includes one PR engine and multiple PR regions,
+   and each PR region has an associated port gasket. A PR region may also be
+   referred to as a PR slot. Port gasket is similar with port device in legacy
+   model which include the port control, port user clock control and port errors.
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

