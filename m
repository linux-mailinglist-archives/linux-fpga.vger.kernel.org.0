Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610C71FD852
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Jun 2020 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgFQWFT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Jun 2020 18:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgFQWFT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 17 Jun 2020 18:05:19 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32CF206F7;
        Wed, 17 Jun 2020 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592431519;
        bh=cvtMTkB4hmn7ysFCDP83MIFxOHZl/oXXu23w2BuLqh4=;
        h=Date:From:To:Cc:Subject:From;
        b=IGma0ImoEm26f9+Bxg+i9NvHEA81DYTAje110vZX2rDU1u0AsyoPZnR2hGfNjpNKo
         5+jySRj2JtrrddUpcyGVUbbuSSdGv1IRRSZBkn/R5E22r/NMEK0n4lG4D5n/sXSe0Q
         nD0bcNrzuWzZ7GUjQKyWUdS18XVdwMeyUNnC4Oeo=
Date:   Wed, 17 Jun 2020 17:10:39 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] fpga: dfl: Use struct_size() in kzalloc()
Message-ID: <20200617221039.GA21877@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
function dfl_feature_platform_data_size().

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/fpga/dfl.c | 3 +--
 drivers/fpga/dfl.h | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 990994874bf1..2dd13e036d45 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -487,8 +487,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	 * it will be automatically freed by device's release() callback,
 	 * platform_device_release().
 	 */
-	pdata = kzalloc(dfl_feature_platform_data_size(binfo->feature_num),
-			GFP_KERNEL);
+	pdata = kzalloc(struct_size(pdata, features, binfo->feature_num), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2f5d3052e36e..044b0e88e5a8 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -299,12 +299,6 @@ struct dfl_feature_ops {
 #define DFL_FPGA_FEATURE_DEV_FME		"dfl-fme"
 #define DFL_FPGA_FEATURE_DEV_PORT		"dfl-port"
 
-static inline int dfl_feature_platform_data_size(const int num)
-{
-	return sizeof(struct dfl_feature_platform_data) +
-		num * sizeof(struct dfl_feature);
-}
-
 void dfl_fpga_dev_feature_uinit(struct platform_device *pdev);
 int dfl_fpga_dev_feature_init(struct platform_device *pdev,
 			      struct dfl_feature_driver *feature_drvs);
-- 
2.27.0

