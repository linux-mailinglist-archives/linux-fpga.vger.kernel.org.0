Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93E92B7F1F
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 15:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKROJF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 09:09:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:44063 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgKROJD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 09:09:03 -0500
IronPort-SDR: 3qMAYDVavMqhB0i4fbq04ncevTUdLdCucjkKeHlqZ3z+/yL0cEalEFW6IlBLx+Es4mtg+pPakk
 aoQWudk/m5ZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158892815"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158892815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 06:09:02 -0800
IronPort-SDR: g91f9M9sTZQ1rAMbTLTHR7LaKCSrbyLbvXkY71SghjPqQOc9S3bSMrdnz2cQ63rNvkCnDNgPeS
 P9xuzVTYSgmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="325596908"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2020 06:09:02 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv2 3/5] fpga: of-fpga-region: add authenticate-fpga-config property
Date:   Wed, 18 Nov 2020 08:29:11 -0600
Message-Id: <1605709753-7800-4-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property to support FPGA bitstream
authentication, which makes sure a signed bitstream has valid signatures.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: changed in alphabetical order
---
 drivers/fpga/of-fpga-region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e405309..3840883 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -219,6 +219,9 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
 	info->overlay = overlay;
 
 	/* Read FPGA region properties from the overlay */
+	if (of_property_read_bool(overlay, "authenticate-fpga-config"))
+		info->flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
+
 	if (of_property_read_bool(overlay, "partial-fpga-config"))
 		info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
 
-- 
2.7.4

