Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C13B4B4EEE
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352059AbiBNLjm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 06:39:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351967AbiBNLj3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 06:39:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFEEBF56;
        Mon, 14 Feb 2022 03:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644838177; x=1676374177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U2uuZbQHEdb5rmolpAMFUIlVMwjCd15kzHvEeAFLHvA=;
  b=G4KYOy9NrM95Ee3RpNcvvPPFrqDL/aNl1rpKP32CXjW/O1KqxYU/h1AT
   E3vwJdwS+wm1WWrpD7BzHw4uHC5Qx7AVf0Nfb85yLO7fuDtPBu0IADBkv
   YdWiDr8DnfYK3M/8dyzigF1bsOg4DPBwUq8rHv4YVov35SkAPGMgYY3By
   4mvveyjSq6S9QZxd0PNmxmBrQEnPL2HqroZigw9tg8/i+ZLznBfRY2Jfm
   23EN3qFgky8ETsWA9oClnXIbc99CW1NkZoHu/YvByxorg4dHD1D/YWtij
   MKDTh2rScgnIFsq4lIvkCBXv6Lh2COrJqo9MMfOKQGUMwOLuWu8KQnn6X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250276727"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250276727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587166967"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2022 03:29:35 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
Date:   Mon, 14 Feb 2022 06:26:13 -0500
Message-Id: <20220214112619.219761-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220214112619.219761-1-tianfei.zhang@intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei Zhang <tianfei.zhang@intel.com>

This patch adds description about IOFS support for DFL.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 Documentation/fpga/dfl.rst | 99 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ef9eec71f6f3..6f9eae1c1697 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -58,7 +58,10 @@ interface to FPGA, e.g. the FPGA Management Engine (FME) and Port (more
 descriptions on FME and Port in later sections).
 
 Accelerated Function Unit (AFU) represents an FPGA programmable region and
-always connects to a FIU (e.g. a Port) as its child as illustrated above.
+always connects to a FIU (e.g. a Port) as its child as illustrated above, but
+on IOFS design, it introducing Port Gasket which contains AFUs. For DFL perspective,
+the Next_AFU pointer on FIU feature header can point to NULL so the AFU is not
+connects to a FIU(more descriptions on IOFS in later section).
 
 Private Features represent sub features of the FIU and AFU. They could be
 various function blocks with different IDs, but all private features which
@@ -134,6 +137,9 @@ reconfigurable region containing an AFU. It controls the communication from SW
 to the accelerator and exposes features such as reset and debug. Each FPGA
 device may have more than one port, but always one AFU per port.
 
+On IOFS, it introducing a new hardware unit, Port Gasket, which contains all
+the PR specific modules and regions (more descriptions on IOFS in later section).
+
 
 AFU
 ===
@@ -143,6 +149,9 @@ used for accelerator-specific control registers.
 User-space applications can acquire exclusive access to an AFU attached to a
 port by using open() on the port device node and release it using close().
 
+On IOFS, the AFU is embedded in a Port Gasket. The AFU resource can expose via
+VFs with SRIOV support (more descriptions on IOFS in later section).
+
 The following functions are exposed through ioctls:
 
 - Get driver API version (DFL_FPGA_GET_API_VERSION)
@@ -284,7 +293,8 @@ FME is always accessed through the physical function (PF).
 
 Ports (and related AFUs) are accessed via PF by default, but could be exposed
 through virtual function (VF) devices via PCIe SRIOV. Each VF only contains
-1 Port and 1 AFU for isolation. Users could assign individual VFs (accelerators)
+1 Port (On IOFS design, the VF is designs without Port) and 1 AFU for isolation.
+Users could assign individual VFs (accelerators)
 created via PCIe SRIOV interface, to virtual machines.
 
 The driver organization in virtualization case is illustrated below:
@@ -389,6 +399,91 @@ The device nodes used for ioctl() or mmap() can be referenced through::
 	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/dev
 	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
 
+Intel Open FPGA stack
+=====================
+Intel Open FPGA stack aka IOFS, Intel's version of a common core set of
+RTL to allow customers to easily interface to logic and IP on the FPGA.
+IOFS leverage the DFL for the implementation of the FPGA RTL design.
+
+IOFS designs allow for the arrangement of software interfaces across multiple
+PCIe endpoints. Some of these interfaces may be PFs defined in the static region
+that connect to interfaces in an IP that is loaded via Partial Reconfiguration (PR).
+And some of these interfaces may be VFs defined in the PR region that can be
+reconfigured by the end-user. Furthermore, these PFs/VFs may also be arranged
+using a DFL such that features may be discovered and accessed in user space
+(with the aid of a generic kernel driver like vfio-pci). The diagram below depicts
+an example design with two PFs and two VFs. In this example, PF1 implements its
+MMIO space such that it is compatible with the VirtIO framework. The other functions,
+VF0 and VF1, leverage VFIO to export the MMIO space to an application or a hypervisor.
+
+     +-----------------+  +--------------+  +-------------+  +------------+
+     | FPGA Managerment|  |   VirtIO     |  |  User App   |  | Virtual    |
+     |      App        |  |     App      |  |             |  | Machine    |
+     +--------+--------+  +------+-------+  +------+------+  +-----+------+
+              |                  |                 |               |
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
+On IOFS, it introducing some enhancements compared with original DFL design.
+1. It introducing Port Gasket in PF0 which is responsible for FPGA management,
+like FME and Port management. The Port Gasket contains all the PR specific modules
+and logic, e.g., PR slot reset/freeze control, user clock, remote STP etc.
+Architecturally, a Port Gasket can have multiple PR slots where user workload can
+be programmed into.
+2. To expend the scalable of FPGA, it can support multiple FPs in static region
+which contain some static functions like VirtIO, diagnostic test, and access over
+VFIO or assigned to VMs easily. Those PFs will not have a Port Unit which without
+PR region (AFU) connected to those PFs, and the end-user cannot partial reconfigurate
+those PFs.
+3. In our previous DFL design, it can only create one VF based in an AFU. To raise
+the efficiency usage of AFU, it can create more than one VFs in an AFU via PCIe
+SRIOV, so those VFs share the PR region and resource.
+
+There is one reference architecture design for IOFS as illustrated below:
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
+    +-------+       +----------+    +--------+   | |
+    | Port  |            PF1            PF2      | |
+    +---+---+                                    | |
+        |                             +----------+ |
+        |                             |           ++
+        |                             |           |
+        |                             | PF0_VF0   | PF0_VF1
+        |           +-----------------+-----------+------------+
+        |           |           +-----+-----------+--------+   |
+        |           |           |     |           |        |   |
+        |           | +------+  |  +--+ -+     +--+---+    |   |
+        |           | | CSR  |  |  | DFH |     |  DFH |    |   |
+        +-----------+ +------+  |  +-----+     +------+    |   |
+                    |           |  | DEV |     |  DEV |    |   |
+                    |           |  +-----+     +------+    |   |
+                    |           |            PR Slot       |   |
+                    |           +--------------------------+   |
+                    | Port Gasket                              |
+                    +------------------------------------------+
+
+Here are the major changes about DFL structures on IOFS implementation design:
+1. The Port Gasket connects to FIU Port in DFL, but the Next_AFU pointer in
+FIU feature header can point to NULL so that it is no AFU connects to a FIU
+Port.
+2. The VF which include in PR region can start with AFU feature header without
+a FIU Port feature header.
 
 Performance Counters
 ====================
-- 
2.17.1

