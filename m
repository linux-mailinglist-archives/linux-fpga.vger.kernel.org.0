Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6D4895AE
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Aug 2019 05:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfHLDHt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Aug 2019 23:07:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:12631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfHLDHs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Aug 2019 23:07:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 20:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,375,1559545200"; 
   d="scan'208";a="199987460"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2019 20:07:46 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v5 1/9] fpga: dfl: make init callback optional
Date:   Mon, 12 Aug 2019 10:49:56 +0800
Message-Id: <1565578204-13969-2-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch makes init callback of sub features optional. With
this change, people don't need to prepare any empty init callback.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c0512af..96a2b82 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -271,11 +271,13 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
 				     struct dfl_feature *feature,
 				     struct dfl_feature_driver *drv)
 {
-	int ret;
+	int ret = 0;
 
-	ret = drv->ops->init(pdev, feature);
-	if (ret)
-		return ret;
+	if (drv->ops->init) {
+		ret = drv->ops->init(pdev, feature);
+		if (ret)
+			return ret;
+	}
 
 	feature->ops = drv->ops;
 
-- 
1.8.3.1

