Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69B15DB5C
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Feb 2020 16:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgBNPpr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Feb 2020 10:45:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:1170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbgBNPpq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Feb 2020 10:45:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 07:45:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="433053711"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2020 07:45:45 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 4/7] dt-bindings, firmware: add compatible value Intel Stratix10 service layer binding
Date:   Fri, 14 Feb 2020 10:00:49 -0600
Message-Id: <1581696052-11540-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

A a compatible property value to Intel Stratix10 service layer binding

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
index 1fa6606..6eff1af 100644
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
@@ -23,7 +23,7 @@ Required properties:
 The svc node has the following mandatory properties, must be located under
 the firmware node.
 
-- compatible: "intel,stratix10-svc"
+- compatible: "intel,stratix10-svc" or "intel,agilex-svc"
 - method: smc or hvc
         smc - Secure Monitor Call
         hvc - Hypervisor Call
-- 
2.7.4

