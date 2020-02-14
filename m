Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87A415DB5F
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Feb 2020 16:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgBNPpw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Feb 2020 10:45:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:42705 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgBNPpv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Feb 2020 10:45:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 07:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="433053747"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2020 07:45:50 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 5/7] arm64: dts: agilex: correct service layer driver's compatible value
Date:   Fri, 14 Feb 2020 10:00:50 -0600
Message-Id: <1581696052-11540-6-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Correct the compatible property value for Intel Service Layer driver
on Intel Agilex SoC platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 8c29853..d48218c 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -539,7 +539,7 @@
 
 		firmware {
 			svc {
-				compatible = "intel,stratix10-svc";
+				compatible = "intel,agilex-svc";
 				method = "smc";
 				memory-region = <&service_reserved>;
 
-- 
2.7.4

