Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6EF315957
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Feb 2021 23:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhBIWVt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Feb 2021 17:21:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:21286 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233860AbhBIWJA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Feb 2021 17:09:00 -0500
IronPort-SDR: YXYBG1uAtILW3lXdhyMcX7ybpk6PGVy1pdJuKEPdJ6ygFWyASi8LQw1eG2N17rucQCMKwIJeVI
 1soRlI5IRAGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="201058922"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="201058922"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:02:11 -0800
IronPort-SDR: pt5sIP/qzXvCKkqpXKwTVzob2sXr5JNAGnQCMp00GryNKfNyi5mY6HzcvXfVC8rWpGEgJtqi9Z
 8XQPLl2wbkxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361959976"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 14:02:10 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv5 5/7] fpga: of-fpga-region: add authenticate-fpga-config property
Date:   Tue,  9 Feb 2021 16:20:31 -0600
Message-Id: <1612909233-13867-6-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property to support FPGA bitstream
authentication, which makes sure a signed bitstream has valid signatures.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v5: no change
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

