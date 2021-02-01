Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A126C30AA86
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 16:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhBAPGo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 10:06:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:33931 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhBAPGK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Feb 2021 10:06:10 -0500
IronPort-SDR: ADi6PMLT1KjDh7N4qkspEeQShaMMLBAAHebCCljW2HldSNOk7geNgJ3Ku2Tb1RB1VbCOcN+iXh
 jSP5RlUSUuBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242214687"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="242214687"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:02:32 -0800
IronPort-SDR: LY2JnlmMixwS3/SkzphMnCYhTbiRUHt8M0luCyNzR5k8v2fPsvrAEUjfWzwnQWib5ryNurluD1
 Hu8xg4lm/v/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="369891580"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2021 07:02:32 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv4 5/6] dt-bindings: fpga: add authenticate-fpga-config property
Date:   Mon,  1 Feb 2021 09:21:58 -0600
Message-Id: <1612192919-4069-6-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
References: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property for FPGA bitstream authentication,
which makes sure a signed bitstream has valid signatures.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v4: explain authenticate-fpga-config flag further
v3: no change
v2: put authenticate-fpga-config above partial-fpga-config
    update commit messages
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index e811cf8..e2740b6 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -182,6 +182,10 @@ Optional properties:
 	This property is optional if the FPGA Manager handles the bridges.
         If the fpga-region is  the child of a fpga-bridge, the list should not
         contain the parent bridge.
+- authenticate-fpga-config : boolean, set if do bitstream authentication only.
+	flag authenticate-fpga-config is used to first check the integrity of
+	the bitstream. If the authentication is passed, the user can perform
+	other operations.
 - partial-fpga-config : boolean, set if partial reconfiguration is to be done,
 	otherwise full reconfiguration is done.
 - external-fpga-config : boolean, set if the FPGA has already been configured
-- 
2.7.4

