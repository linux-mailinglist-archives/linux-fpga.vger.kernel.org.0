Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82975895AA
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Aug 2019 05:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHLDHw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Aug 2019 23:07:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:12631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfHLDHu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Aug 2019 23:07:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 20:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,375,1559545200"; 
   d="scan'208";a="199987467"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2019 20:07:48 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v5 2/9] fpga: dfl: fme: convert platform_driver to use dev_groups
Date:   Mon, 12 Aug 2019 10:49:57 +0800
Message-Id: <1565578204-13969-3-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch takes advantage of driver core which helps to create
and remove sysfs attribute files, so there is no need to register
sysfs entries manually in dfl-fme platform river code.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-fme-main.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index f033f1c..bf8114d 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -129,30 +129,6 @@ static ssize_t socket_id_show(struct device *dev,
 };
 ATTRIBUTE_GROUPS(fme_hdr);
 
-static int fme_hdr_init(struct platform_device *pdev,
-			struct dfl_feature *feature)
-{
-	void __iomem *base = feature->ioaddr;
-	int ret;
-
-	dev_dbg(&pdev->dev, "FME HDR Init.\n");
-	dev_dbg(&pdev->dev, "FME cap %llx.\n",
-		(unsigned long long)readq(base + FME_HDR_CAP));
-
-	ret = device_add_groups(&pdev->dev, fme_hdr_groups);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static void fme_hdr_uinit(struct platform_device *pdev,
-			  struct dfl_feature *feature)
-{
-	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
-	device_remove_groups(&pdev->dev, fme_hdr_groups);
-}
-
 static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
 				       unsigned long arg)
 {
@@ -199,8 +175,6 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
 };
 
 static const struct dfl_feature_ops fme_hdr_ops = {
-	.init = fme_hdr_init,
-	.uinit = fme_hdr_uinit,
 	.ioctl = fme_hdr_ioctl,
 };
 
@@ -361,7 +335,8 @@ static int fme_remove(struct platform_device *pdev)
 
 static struct platform_driver fme_driver = {
 	.driver	= {
-		.name    = DFL_FPGA_FEATURE_DEV_FME,
+		.name       = DFL_FPGA_FEATURE_DEV_FME,
+		.dev_groups = fme_hdr_groups,
 	},
 	.probe   = fme_probe,
 	.remove  = fme_remove,
-- 
1.8.3.1

