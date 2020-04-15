Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD73F1A9A1A
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Apr 2020 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896305AbgDOKLj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Apr 2020 06:11:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:60792 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896300AbgDOKLi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Apr 2020 06:11:38 -0400
IronPort-SDR: qsBTHdaAPCyvsuoeCvISygRkRQAlcKEqKpyNPlfcwi4YKHnZZ075j354YrmLBbMYyVfJ0MiOLe
 uqCTvBhZ77Gw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 03:11:37 -0700
IronPort-SDR: i9IDSbBaHPzIj3hFf5CVpxlDGRv0opyNYzjbqRgTqg09fwyP5fiqUGEmEy92pzcW4adyiqw6Sh
 +ci/B1NBczWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="253483294"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 03:11:35 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v4 7/7] Documentation: fpga: dfl: add descriptions for interrupt related interfaces.
Date:   Wed, 15 Apr 2020 18:07:35 +0800
Message-Id: <1586945255-30823-8-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
References: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds introductions of interrupt related interfaces for FME
error reporting, port error reporting and AFU user interrupts features.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
----
v2: Update Documents cause change of irq ioctl interfaces.
v3: No change
v4: Update interrupt support part.
---
 Documentation/fpga/dfl.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 094fc8a..702bf62 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -89,6 +89,8 @@ The following functions are exposed through ioctls:
 - Program bitstream (DFL_FPGA_FME_PORT_PR)
 - Assign port to PF (DFL_FPGA_FME_PORT_ASSIGN)
 - Release port from PF (DFL_FPGA_FME_PORT_RELEASE)
+- Get number of irqs of FME global error (DFL_FPGA_FME_ERR_GET_IRQ_NUM)
+- Set interrupt trigger for FME error (DFL_FPGA_FME_ERR_SET_IRQ)
 
 More functions are exposed through sysfs
 (/sys/class/fpga_region/regionX/dfl-fme.n/):
@@ -144,6 +146,10 @@ The following functions are exposed through ioctls:
 - Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
 - Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
 - Reset AFU (DFL_FPGA_PORT_RESET)
+- Get number of irqs of port error (DFL_FPGA_PORT_ERR_GET_IRQ_NUM)
+- Set interrupt trigger for port error (DFL_FPGA_PORT_ERR_SET_IRQ)
+- Get number of irqs of UINT (DFL_FPGA_PORT_UINT_GET_IRQ_NUM)
+- Set interrupt trigger for UINT (DFL_FPGA_PORT_UINT_SET_IRQ)
 
 DFL_FPGA_PORT_RESET:
   reset the FPGA Port and its AFU. Userspace can do Port
@@ -378,6 +384,19 @@ The device nodes used for ioctl() or mmap() can be referenced through::
 	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
 
 
+Interrupt support
+=================
+Some FME and AFU private features are able to generate interrupts. As mentioned
+above, users could call ioctl (DFL_FPGA_*_GET_IRQ_NUM) to know whether or how
+many interrupts are supported for this private feature. Drivers also implement
+an eventfd based interrupt handling mechanism for users to get notified when
+interrupt happens. Users could set eventfds to driver via
+ioctl (DFL_FPGA_*_SET_IRQ), and then poll/select on these eventfds waiting for
+notification.
+In Current DFL, 3 sub features (Port error, FME global error and AFU interrupt)
+support interrupts.
+
+
 Add new FIUs support
 ====================
 It's possible that developers made some new function blocks (FIUs) under this
-- 
2.7.4

