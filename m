Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D04CE80A90
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Aug 2019 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfHDKiE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Aug 2019 06:38:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:31912 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfHDKiD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 4 Aug 2019 06:38:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2019 03:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,345,1559545200"; 
   d="scan'208";a="167678978"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2019 03:38:01 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v4 08/12] fpga: dfl: make uinit callback optional
Date:   Sun,  4 Aug 2019 18:20:18 +0800
Message-Id: <1564914022-3710-9-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch makes uinit callback of sub features optional. With
this change, people don't need to prepare any empty uinit callback.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 87eaef6..c0512af 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -259,7 +259,8 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
 
 	dfl_fpga_dev_for_each_feature(pdata, feature)
 		if (feature->ops) {
-			feature->ops->uinit(pdev, feature);
+			if (feature->ops->uinit)
+				feature->ops->uinit(pdev, feature);
 			feature->ops = NULL;
 		}
 }
-- 
1.8.3.1

