Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293EE30AA79
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 16:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhBAPG4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 10:06:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:33905 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhBAPGK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Feb 2021 10:06:10 -0500
IronPort-SDR: hT1p50H6dFYeoxBfyQvqS1990ehXj8+iLezFHiSPAkUl0m5qinOCLtEdNVfCg7dfwQGdBMxc94
 R5cu2/qNJVBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242214682"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="242214682"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:02:32 -0800
IronPort-SDR: 3vXLgtQeRyuKoXukZd7xaTR2EL4ACw0mYIM4eZ0PtTG76DyRQA9xM1znI4Ki0QyoWFaDKX6PdZ
 PRYpqVZ9FkTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="369891577"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2021 07:02:31 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv4 4/6] fpga: of-fpga-region: add authenticate-fpga-config property
Date:   Mon,  1 Feb 2021 09:21:57 -0600
Message-Id: <1612192919-4069-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
References: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property to support FPGA bitstream
authentication, which makes sure a signed bitstream has valid signatures.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v4: add additional checks to make sure *only* authenticate
v3: no change
v2: changed in alphabetical order
---
 drivers/fpga/of-fpga-region.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e405309..5074479 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -218,15 +218,25 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
 
 	info->overlay = overlay;
 
-	/* Read FPGA region properties from the overlay */
-	if (of_property_read_bool(overlay, "partial-fpga-config"))
-		info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
+	/*
+	 * Read FPGA region properties from the overlay.
+	 *
+	 * First check the integrity of the bitstream. If the
+	 * authentication is passed, the user can perform other
+	 * operations.
+	 */
+	if (of_property_read_bool(overlay, "authenticate-fpga-config")) {
+		info->flags |= FPGA_MGR_BITSTREAM_AUTHENTICATE;
+	} else {
+		if (of_property_read_bool(overlay, "partial-fpga-config"))
+			info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
 
-	if (of_property_read_bool(overlay, "external-fpga-config"))
-		info->flags |= FPGA_MGR_EXTERNAL_CONFIG;
+		if (of_property_read_bool(overlay, "external-fpga-config"))
+			info->flags |= FPGA_MGR_EXTERNAL_CONFIG;
 
-	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
-		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
+		if (of_property_read_bool(overlay, "encrypted-fpga-config"))
+			info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
+	}
 
 	if (!of_property_read_string(overlay, "firmware-name",
 				     &firmware_name)) {
-- 
2.7.4

