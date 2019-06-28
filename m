Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AC58F42
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2019 02:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfF1Au0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Jun 2019 20:50:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36392 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfF1Au0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Jun 2019 20:50:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so2068235pfl.3
        for <linux-fpga@vger.kernel.org>; Thu, 27 Jun 2019 17:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBydnfh+YN9Yc9HXPJwsYuVwytnWxGaymT7rRliU0P8=;
        b=L23Ebm5Pb1N+73/tEjJmUjKd6NtRkEQrPHAAtfPEkvhqzk9WsYM8Dtm9pLZJT3wCdc
         lXs0K5NheYYEG2eqFdww0ZLtn5ias3Hbjft09L3qwmcP1CCRZi7lNQu4SUvlr07rNaIT
         /c+xn8bRUlUi+oO1Ufddzn5yYBM0Pw1NwBY3Bt7uAFgY0e4FTPylKlBwt0o9S4VMN87v
         8gNNQEUe698yr349UiC//madRZuqVxGWW+xWVN0ks0FQTjIhnc7zXvxqzyD8ujOzFudf
         ZAj/NHOkcIVlOiCALSBxDm7krQKR7SRcO3m3N4vZO5v/G8fuSKpu1qDJnfGLRcWUNPfr
         hqjg==
X-Gm-Message-State: APjAAAXSi9oEHIsPLvUNQ5HEemozFbc5DzHK+PWaubnfMx4x3DOS4TS2
        f4oXcQi/5pZ27i8ik6P3swnknixutgQ=
X-Google-Smtp-Source: APXvYqyHSBholFGqsLCO5MmTamh+UAgVNLAphVT0dWY/UTJtq87LALCYHiYN7wiY2Eibi6w58Oh+Fg==
X-Received: by 2002:a63:52:: with SMTP id 79mr6431474pga.381.1561683024807;
        Thu, 27 Jun 2019 17:50:24 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id s22sm271542pfh.107.2019.06.27.17.50.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:23 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 05/15] Documentation: fpga: dfl: add descriptions for virtualization and new interfaces.
Date:   Thu, 27 Jun 2019 17:49:41 -0700
Message-Id: <20190628004951.6202-6-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

This patch adds virtualization support description for DFL based
FPGA devices (based on PCIe SRIOV), and introductions to new
interfaces added by new dfl private feature drivers.

[mdf@kernel.org: Fixed up to make it work with new reStructuredText docs]
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 Documentation/fpga/dfl.rst | 100 +++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 2f125abd777f..be9929dd7251 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -87,6 +87,8 @@ The following functions are exposed through ioctls:
 - Get driver API version (DFL_FPGA_GET_API_VERSION)
 - Check for extensions (DFL_FPGA_CHECK_EXTENSION)
 - Program bitstream (DFL_FPGA_FME_PORT_PR)
+- Assign port to PF (DFL_FPGA_FME_PORT_ASSIGN)
+- Release port from PF (DFL_FPGA_FME_PORT_RELEASE)
 
 More functions are exposed through sysfs
 (/sys/class/fpga_region/regionX/dfl-fme.n/):
@@ -143,6 +145,9 @@ More functions are exposed through sysfs:
  Read Accelerator GUID (afu_id)
      afu_id indicates which PR bitstream is programmed to this AFU.
 
+ Global error reporting management (errors/)
+     error reporting sysfs interfaces allow user to read errors detected by the
+     hardware, and clear the logged errors.
 
 DFL Framework Overview
 ======================
@@ -218,6 +223,101 @@ the compat_id exposed by the target FPGA region. This check is usually done by
 userspace before calling the reconfiguration IOCTL.
 
 
+FPGA virtualization - PCIe SRIOV
+================================
+This section describes the virtualization support on DFL based FPGA device to
+enable accessing an accelerator from applications running in a virtual machine
+(VM). This section only describes the PCIe based FPGA device with SRIOV support.
+
+Features supported by the particular FPGA device are exposed through Device
+Feature Lists, as illustrated below:
+
+::
+
+    +-------------------------------+  +-------------+
+    |              PF               |  |     VF      |
+    +-------------------------------+  +-------------+
+        ^            ^         ^              ^
+        |            |         |              |
+  +-----|------------|---------|--------------|-------+
+  |     |            |         |              |       |
+  |  +-----+     +-------+ +-------+      +-------+   |
+  |  | FME |     | Port0 | | Port1 |      | Port2 |   |
+  |  +-----+     +-------+ +-------+      +-------+   |
+  |                  ^         ^              ^       |
+  |                  |         |              |       |
+  |              +-------+ +------+       +-------+   |
+  |              |  AFU  | |  AFU |       |  AFU  |   |
+  |              +-------+ +------+       +-------+   |
+  |                                                   |
+  |            DFL based FPGA PCIe Device             |
+  +---------------------------------------------------+
+
+FME is always accessed through the physical function (PF).
+
+Ports (and related AFUs) are accessed via PF by default, but could be exposed
+through virtual function (VF) devices via PCIe SRIOV. Each VF only contains
+1 Port and 1 AFU for isolation. Users could assign individual VFs (accelerators)
+created via PCIe SRIOV interface, to virtual machines.
+
+The driver organization in virtualization case is illustrated below:
+::
+
+    +-------++------++------+             |
+    | FME   || FME  || FME  |             |
+    | FPGA  || FPGA || FPGA |             |
+    |Manager||Bridge||Region|             |
+    +-------++------++------+             |
+    +-----------------------+  +--------+ |             +--------+
+    |          FME          |  |  AFU   | |             |  AFU   |
+    |         Module        |  | Module | |             | Module |
+    +-----------------------+  +--------+ |             +--------+
+          +-----------------------+       |       +-----------------------+
+          | FPGA Container Device |       |       | FPGA Container Device |
+          |  (FPGA Base Region)   |       |       |  (FPGA Base Region)   |
+          +-----------------------+       |       +-----------------------+
+            +------------------+          |         +------------------+
+            | FPGA PCIE Module |          | Virtual | FPGA PCIE Module |
+            +------------------+   Host   | Machine +------------------+
+   -------------------------------------- | ------------------------------
+             +---------------+            |          +---------------+
+             | PCI PF Device |            |          | PCI VF Device |
+             +---------------+            |          +---------------+
+
+FPGA PCIe device driver is always loaded first once a FPGA PCIe PF or VF device
+is detected. It:
+
+* Finishes enumeration on both FPGA PCIe PF and VF device using common
+	   interfaces from DFL framework.
+* Supports SRIOV.
+
+The FME device driver plays a management role in this driver architecture, it
+provides ioctls to release Port from PF and assign Port to PF. After release
+a port from PF, then it's safe to expose this port through a VF via PCIe SRIOV
+sysfs interface.
+
+To enable accessing an accelerator from applications running in a VM, the
+respective AFU's port needs to be assigned to a VF using the following steps:
+
+#. The PF owns all AFU ports by default. Any port that needs to be
+   reassigned to a VF must first be released through the
+   DFL_FPGA_FME_PORT_RELEASE ioctl on the FME device.
+
+#. Once N ports are released from PF, then user can use command below
+   to enable SRIOV and VFs. Each VF owns only one Port with AFU.
+
+   ::
+
+      echo N > $PCI_DEVICE_PATH/sriov_numvfs
+
+#. Pass through the VFs to VMs
+
+#. The AFU under VF is accessible from applications in VM (using the
+   same driver inside the VF).
+
+Note that an FME can't be assigned to a VF, thus PR and other management
+functions are only available via the PF.
+
 Device enumeration
 ==================
 This section introduces how applications enumerate the fpga device from
-- 
2.22.0

