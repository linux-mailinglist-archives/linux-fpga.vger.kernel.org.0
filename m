Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E56302CC0
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Jan 2021 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbhAYUkO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 15:40:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:37458 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732402AbhAYUkF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 15:40:05 -0500
IronPort-SDR: 1ZY6C/QmVuOdpJeM/T/ldEfe+pGDcfXmdi08zmzMmMxo0tLCOmxHtez6XaWlmKmLjR4bQvgL90
 5IybOCHUkL5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177227342"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="177227342"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 12:36:47 -0800
IronPort-SDR: gmJAmLl88Tb59RyS4x4J9pqOS3mb05lsdzyT4bclu3kRQGPCItmmSY3H3O25BpHp3r31mya+Q3
 RLDRj+mJUyOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="504283195"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2021 12:36:46 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv3 5/6] dt-bindings: fpga: add authenticate-fpga-config property
Date:   Mon, 25 Jan 2021 14:56:27 -0600
Message-Id: <1611608188-25621-6-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property for FPGA bitstream authentication,
which makes sure a signed bitstream has valid signatures.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v3: no change
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

