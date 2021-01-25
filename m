Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4736302CBF
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Jan 2021 21:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbhAYUkK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 15:40:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:37447 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732398AbhAYUkC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 15:40:02 -0500
IronPort-SDR: K4rDd15j/Ct6bo/zcS8HEQq9B9bjWvN1W4kIYdg49DWIVZwx4RFCSV0IzSQK1Lxh587gS+n0KW
 uH2GmV97pW4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177227338"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="177227338"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 12:36:46 -0800
IronPort-SDR: j1HM3iGLs+zvwfJH2yjR7azAsRocXpH/VRu+E48Vt1Jve73RWTAKaxoFOYfjpPxtT2Lk+2H8kV
 tYddRI6XzVuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="504283183"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2021 12:36:46 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv3 4/6] fpga: of-fpga-region: add authenticate-fpga-config property
Date:   Mon, 25 Jan 2021 14:56:26 -0600
Message-Id: <1611608188-25621-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property to support FPGA bitstream
authentication, which makes sure a signed bitstream has valid signatures.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v3: no change
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

