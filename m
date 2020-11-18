Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227562B7F24
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 15:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKROJI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 09:09:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:44078 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgKROJF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 09:09:05 -0500
IronPort-SDR: vr4ylSyQPHSLUViLrZZI0DtmrGvoneRAMTRrXaLGstcNim0HrZNCE0UOXJQzYOO/DYr2yAWEr9
 YOMiFZcy4dCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158892819"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158892819"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 06:09:04 -0800
IronPort-SDR: 7+OMYNG4DOiHNS2BM/zUpkyQQrDJ9A7cmsPpLKbb7p2ajoLDRUgXUdtbsIkEJYhDS2cawelHRb
 cGcRVwNCDyig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="325596925"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2020 06:09:03 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv2 4/5] dt-bindings: fpga: add authenticate-fpga-config property
Date:   Wed, 18 Nov 2020 08:29:12 -0600
Message-Id: <1605709753-7800-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property for FPGA bitstream authentication,
which makes sure a signed bitstream has valid signatures.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: put authenticate-fpga-config above partial-fpga-config
    update commit messages
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index e811cf8..d0d3234 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -182,6 +182,7 @@ Optional properties:
 	This property is optional if the FPGA Manager handles the bridges.
         If the fpga-region is  the child of a fpga-bridge, the list should not
         contain the parent bridge.
+- authenticate-fpga-config : boolean, set if do bitstream authentication only.
 - partial-fpga-config : boolean, set if partial reconfiguration is to be done,
 	otherwise full reconfiguration is done.
 - external-fpga-config : boolean, set if the FPGA has already been configured
-- 
2.7.4

