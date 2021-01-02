Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C172E8637
	for <lists+linux-fpga@lfdr.de>; Sat,  2 Jan 2021 04:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbhABDS5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 1 Jan 2021 22:18:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:61870 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbhABDS5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 1 Jan 2021 22:18:57 -0500
IronPort-SDR: O2YgumPmjJ2Vb4qkXHiovgQTl9s3ftzjlnp5tfTWWaThdu4sD9TJENZdq8TEaQ7BDdT5T7LLeQ
 fqRKE7mqYMrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="176026815"
X-IronPort-AV: E=Sophos;i="5.78,469,1599548400"; 
   d="scan'208";a="176026815"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2021 19:17:51 -0800
IronPort-SDR: +V6gPm97kcYBHH1v/MzMSPYsID6tQC3aB/LPUyJApk+nDsuRT6cHcHH/5/xatCVzklW1OeSMja
 gJScGCPb1H5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,469,1599548400"; 
   d="scan'208";a="349085244"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jan 2021 19:17:50 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v5 2/2] Documentation: fpga: dfl: Add description for DFL UIO support
Date:   Sat,  2 Jan 2021 11:13:02 +0800
Message-Id: <1609557182-20787-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds description for UIO support for dfl devices on DFL
bus.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v2: no doc in v1, add it for v2.
v3: some documentation fixes.
v4: documentation change since the driver matching is changed.
v5: no change.
---
 Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 0404fe6..b8497f3 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -7,6 +7,7 @@ Authors:
 - Enno Luebbers <enno.luebbers@intel.com>
 - Xiao Guangrong <guangrong.xiao@linux.intel.com>
 - Wu Hao <hao.wu@intel.com>
+- Xu Yilun <yilun.xu@intel.com>
 
 The Device Feature List (DFL) FPGA framework (and drivers according to
 this framework) hides the very details of low layer hardwares and provides
@@ -502,6 +503,29 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
 
+UIO support for DFL devices
+===========================
+The purpose of an FPGA is to be reprogrammed with newly developed hardware
+components. New hardware can instantiate a new private feature in the DFL, and
+then get a DFL device in their system. In some cases users may need a userspace
+driver for the DFL device:
+
+* Users may need to run some diagnostic test for their hardwares.
+* Users may prototype the kernel driver in user space.
+* Some hardware is designed for specific purposes and does not fit into one of
+  the standard kernel subsystems.
+
+This requires the direct access to the MMIO space and interrupt handling in
+userspace. The dfl-uio-pdev module exposes the UIO device interfaces for this
+purpose. It adds the uio_pdrv_genirq platform device with the resources of
+the DFL feature, and lets the generic UIO platform device driver provide UIO
+support to userspace.
+
+FPGA_DFL_UIO_PDEV should be selected to enable the dfl-uio-pdev module driver.
+To support a new DFL feature been directly accessed via UIO, its feature id
+should be added to the driver's id_table.
+
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.7.4

