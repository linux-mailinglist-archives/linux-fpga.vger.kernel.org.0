Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC8A15DB67
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Feb 2020 16:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgBNPqE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Feb 2020 10:46:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:47493 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgBNPqE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Feb 2020 10:46:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 07:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="433053824"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2020 07:46:03 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 7/7] firmware: intel_stratix10_service: add depend on agilex
Date:   Fri, 14 Feb 2020 10:00:52 -0600
Message-Id: <1581696052-11540-8-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add depend on Agilex for Intel Agilex SoC platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index ea869ad..8007d4a 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -206,7 +206,7 @@ config FW_CFG_SYSFS_CMDLINE
 
 config INTEL_STRATIX10_SERVICE
 	tristate "Intel Stratix10 Service Layer"
-	depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
+	depends on (ARCH_STRATIX10 || ARCH_AGILEX) && HAVE_ARM_SMCCC
 	default n
 	help
 	  Intel Stratix10 service layer runs at privileged exception level,
-- 
2.7.4

