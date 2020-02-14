Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7DD15DB43
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Feb 2020 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgBNPor (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Feb 2020 10:44:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:8617 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgBNPoq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Feb 2020 10:44:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 07:44:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="433053205"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2020 07:44:45 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 1/7] dt-bindings: fpga: add compatible value to Stratix10 SoC FPGA manager binding
Date:   Fri, 14 Feb 2020 10:00:46 -0600
Message-Id: <1581696052-11540-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add a compatible property value to Stratix10 SoC FPGA manager binding file

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
index 6e03f79..0f87413 100644
--- a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
+++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
@@ -4,7 +4,8 @@ Required properties:
 The fpga_mgr node has the following mandatory property, must be located under
 firmware/svc node.
 
-- compatible : should contain "intel,stratix10-soc-fpga-mgr"
+- compatible : should contain "intel,stratix10-soc-fpga-mgr" or
+	       "intel,agilex-soc-fpga-mgr"
 
 Example:
 
-- 
2.7.4

