Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495DC326D9B
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Feb 2021 16:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhB0Pcr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Feb 2021 10:32:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:8563 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhB0Pcp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 27 Feb 2021 10:32:45 -0500
IronPort-SDR: HGkaA1H4eQ45j8MM8IDToiG5PhXervIaAgi17COaCTNNxdFhzWpNE7FXWFNQSkpICQz8no7F4x
 5ltQ22td7fUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="165990422"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="165990422"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 07:32:03 -0800
IronPort-SDR: 1kP4BRrJddmnlp0L33r5HeIjT2JjLhfZGUo0TTtGNK+pGLR55HqKtBr75/yChJw0WUSeuq28rX
 0Q0QEFuHkC0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="382370770"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2021 07:32:01 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [RESEND PATCH v11 2/2] Documentation: fpga: dfl: Add description for DFL UIO support
Date:   Sat, 27 Feb 2021 23:27:04 +0800
Message-Id: <1614439624-3946-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614439624-3946-1-git-send-email-yilun.xu@intel.com>
References: <1614439624-3946-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds description for UIO support for dfl devices on DFL
bus.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Reviewed-by: Wu Hao <hao.wu@intel.com>
---
v2: no doc in v1, add it for v2.
v3: some documentation fixes.
v4: documentation change since the driver matching is changed.
v5: no change.
v6: improve the title of the userspace driver support section.
    some word improvement.
v7: rebased to next-20210119
v8: some doc fixes.
v9: some doc change since we switch to the driver in drivers/uio.
v10: no change.
v11: add description that interrupt support is not implemented yet.
---
 Documentation/fpga/dfl.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index c41ac76..f3a1223 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -7,6 +7,7 @@ Authors:
 - Enno Luebbers <enno.luebbers@intel.com>
 - Xiao Guangrong <guangrong.xiao@linux.intel.com>
 - Wu Hao <hao.wu@intel.com>
+- Xu Yilun <yilun.xu@intel.com>
 
 The Device Feature List (DFL) FPGA framework (and drivers according to
 this framework) hides the very details of low layer hardwares and provides
@@ -530,6 +531,31 @@ Being able to specify more than one DFL per BAR has been considered, but it
 was determined the use case did not provide value.  Specifying a single DFL
 per BAR simplifies the implementation and allows for extra error checking.
 
+
+Userspace driver support for DFL devices
+========================================
+The purpose of an FPGA is to be reprogrammed with newly developed hardware
+components. New hardware can instantiate a new private feature in the DFL, and
+then present a DFL device in the system. In some cases users may need a
+userspace driver for the DFL device:
+
+* Users may need to run some diagnostic test for their hardware.
+* Users may prototype the kernel driver in user space.
+* Some hardware is designed for specific purposes and does not fit into one of
+  the standard kernel subsystems.
+
+This requires direct access to MMIO space and interrupt handling from
+userspace. The uio_dfl module exposes the UIO device interfaces for this
+purpose.
+
+Currently the uio_dfl driver only supports the Ether Group sub feature, which
+has no irq in hardware. So the interrupt handling is not added in this driver.
+
+UIO_DFL should be selected to enable the uio_dfl module driver. To support a
+new DFL feature via UIO direct access, its feature id should be added to the
+driver's id_table.
+
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.7.4

