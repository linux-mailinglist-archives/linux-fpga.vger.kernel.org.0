Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76F52D9214
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 04:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgLNDl4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Dec 2020 22:41:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:41628 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438375AbgLNDlt (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 13 Dec 2020 22:41:49 -0500
IronPort-SDR: r7dvl32y3z8JBWnJ7iRu9/QQUeTiEIAsAxjwnFQ8wLtcMYG/sdWlK6A02ecrGiv3s/k+kM+IlC
 SOgwveZMGMdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="174762712"
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="174762712"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 19:41:03 -0800
IronPort-SDR: z1wgAxhEXN3lValOlrPUkmvwVUfLqMmYoC2bZZ0uMSYkVeLED80F2zrriBXUMxP/b96adHc3ks
 y7aql/dNs09A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="331726438"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2020 19:41:01 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v2 2/2] Documentation: fpga: dfl: Add description for DFL UIO support
Date:   Mon, 14 Dec 2020 11:36:21 +0800
Message-Id: <1607916981-14782-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
References: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds description for UIO support for dfl devices on DFL
bus.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v2: no doc in v1, add it for v2.
---
 Documentation/fpga/dfl.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 0404fe6..a15e81e 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -502,6 +502,29 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
 
+UIO support for DFL devices
+===========================
+The FPGA is open for users to be reprogramed with newly developed hardware
+components. They could instantiate a new private feature in the DFL, and then
+get a DFL device in their system. In some cases users may need a userspace
+driver for the DFL device:
+
+* Users may need to run some diagnostic test for their hardwares.
+* Some hardware is designed for specific purposes and does not fit into one of
+  the standard kernel subsystems.
+
+This requires the direct access to the MMIO space and interrupt handling in
+userspace. We implemented a dfl-uio-pdev module which exposes the UIO device
+interfaces. It adds the uio_pdrv_genirq platform device with the resources of
+the DFL device, and let the generic UIO platform device driver provide UIO
+support to userspace.
+
+The DFL UIO driver has a special matching algorithem. It will match any DFL
+device which could not be handled by other DFL drivers. In this way, it will
+not impact the functionality of the features which are already supported by the
+system.
+
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.7.4

