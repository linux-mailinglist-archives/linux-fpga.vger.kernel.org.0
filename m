Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704632F4173
	for <lists+linux-fpga@lfdr.de>; Wed, 13 Jan 2021 03:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbhAMB76 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Jan 2021 20:59:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:20593 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbhAMB76 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 Jan 2021 20:59:58 -0500
IronPort-SDR: k+0wFNwN1Q90QwPFh9bSGl19Uxv8SoMgxx0YSUOH6PbDD6bRnIJMCP3h2olcMjHIUYSa+cIYO/
 Ce+Ic7AGjqhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="165222731"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="165222731"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 17:59:17 -0800
IronPort-SDR: 8V9yMjTis3wyTh7a1t9oICRlztM8UZ2GrXUQvYCKkjUtOqSIO3+FURT8rWqOSDTuUYSuBe7W9l
 96w7uxxZneVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="363726063"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2021 17:59:15 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v6 2/2] Documentation: fpga: dfl: Add description for DFL UIO support
Date:   Wed, 13 Jan 2021 09:54:08 +0800
Message-Id: <1610502848-30345-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
References: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
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
v6: improve the title of the userspace driver support section.
    some word improvement.
---
 Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 0404fe6..c33b6d0 100644
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
 
 
+Userspace driver support for DFL devices
+========================================
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
+This requires direct access to MMIO space and interrupt handling from
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

