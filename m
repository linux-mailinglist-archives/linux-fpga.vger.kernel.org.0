Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F362D99C5
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 15:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgLNOWv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 09:22:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:1154 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgLNOWo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 09:22:44 -0500
IronPort-SDR: Ty3NwGdCMTz0q/IV/7XmdHEqH0kVIVq0bv4kcJIRfkZDVeTowlDzJ4GMB9hlNfnNod7ilZc/Nu
 STnVNd0PBbzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="173941501"
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="173941501"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 06:19:10 -0800
IronPort-SDR: OAR0q16NbdW5qHAEGWS48EcuhcAysV1x45B8emAw+bcRmLGQvDe1nZSeLJJUzvLpBMGB4il7hR
 cwmmtuSCxmuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="333456258"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2020 06:18:47 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv2 3/5] fpga: of-fpga-region: add authenticate-fpga-config property
Date:   Mon, 14 Dec 2020 08:39:58 -0600
Message-Id: <1607956800-28476-4-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
References: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
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

