Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A632E6D62
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Dec 2020 03:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgL2Cva (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Dec 2020 21:51:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:24910 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgL2Cv3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Dec 2020 21:51:29 -0500
IronPort-SDR: 0QSSQnmWbkpYBc/V4fddn4wb1blFKntGlCkftUAUDpM9yTiTqmH5vxFkqvSpYumK1SosDv+2iQ
 0/oQnxk9/Gjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="163512633"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="163512633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 18:50:49 -0800
IronPort-SDR: rxAa0KDg3w/YMIH2heaIxIeL9Z6LLi96E36OKw8mROmPusIpLpUM5UTKobaTOzF34DTGcAxukU
 hrxOAIM4/DOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="343926535"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2020 18:50:47 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v4 2/2] Documentation: fpga: dfl: Add description for DFL UIO support
Date:   Tue, 29 Dec 2020 10:42:56 +0800
Message-Id: <1609209776-7296-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609209776-7296-1-git-send-email-yilun.xu@intel.com>
References: <1609209776-7296-1-git-send-email-yilun.xu@intel.com>
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

