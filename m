Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF82B0B8F
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Nov 2020 18:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgKLRrc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Nov 2020 12:47:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:5888 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKLRr3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 12 Nov 2020 12:47:29 -0500
IronPort-SDR: 44Cqq88NUqnawhIlZPlrr4dA3l84Gk8tkYLCXsO0lqQzzO6AhUN2uoIyBhF7e1uMyx/g+68tZL
 QqMgTCKsYLgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158128476"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="158128476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:47:29 -0800
IronPort-SDR: 0hhUeegefhlOfHD8NoUPRm8H0jDAx1Gg6Aho3utfqwmckB1aFGgDdGCm4HJiJxXZlTJtKvCpNS
 JEmOn7AxxQ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="328576387"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 12 Nov 2020 09:47:28 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config property
Date:   Thu, 12 Nov 2020 12:06:42 -0600
Message-Id: <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property for FPGA bitstream authentication.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index e811cf8..7a512bc 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -187,6 +187,7 @@ Optional properties:
 - external-fpga-config : boolean, set if the FPGA has already been configured
 	prior to OS boot up.
 - encrypted-fpga-config : boolean, set if the bitstream is encrypted
+- authenticate-fpga-config : boolean, set if do bitstream authentication
 - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
 	bridges to successfully become enabled after the region has been
 	programmed.
-- 
2.7.4

