Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149182B0B90
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Nov 2020 18:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgKLRre (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Nov 2020 12:47:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:5888 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgKLRr2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 12 Nov 2020 12:47:28 -0500
IronPort-SDR: gINq8hxpdzFW9nbS8rQ/yqsMlsVUfZYeJWE6GfOkxSZUUD8AWbullly3K06O+0NBun6WMpnCYt
 V4BimN+eTRKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158128468"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="158128468"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:47:27 -0800
IronPort-SDR: H+MfRLfGlEk0eMJS0l2rm9JZDz1wj3ha2SB0sWXO+ZggY1lZmE3ELNSoXl+t7rG4/eU80EvgX4
 Cxx2BLD4vMhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="328576378"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 12 Nov 2020 09:47:26 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 2/4] fpga: of-fpga-region: add authenticate-fpga-config property
Date:   Thu, 12 Nov 2020 12:06:41 -0600
Message-Id: <1605204403-6663-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add authenticate-fpga-config property to support FPGA bitstream
authentication.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/fpga/of-fpga-region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e405309..c7c6d1c 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -228,6 +228,9 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
 	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
 		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
 
+	if (of_property_read_bool(overlay, "authenticate-fpga-config"))
+		info->flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
+
 	if (!of_property_read_string(overlay, "firmware-name",
 				     &firmware_name)) {
 		info->firmware_name = devm_kstrdup(dev, firmware_name,
-- 
2.7.4

