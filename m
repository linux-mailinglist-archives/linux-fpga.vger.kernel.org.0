Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB0DEF3
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Apr 2019 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfD2JNC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Apr 2019 05:13:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:32630 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfD2JM7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 29 Apr 2019 05:12:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 02:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="165988292"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2019 02:12:57 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 13/18] fpga: dfl: afu: add STP (SignalTap) support
Date:   Mon, 29 Apr 2019 16:55:46 +0800
Message-Id: <1556528151-17221-14-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

STP (SignalTap) is one of the private features under the port for
debugging. This patch adds private feature driver support for it
to allow userspace applications to mmap related mmio region and
provide STP service.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl-afu-main.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 754729e..14970a4 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -518,6 +518,36 @@ static void port_afu_uinit(struct platform_device *pdev,
 	.uinit = port_afu_uinit,
 };
 
+static int port_stp_init(struct platform_device *pdev,
+			 struct dfl_feature *feature)
+{
+	struct resource *res = &pdev->resource[feature->resource_index];
+
+	dev_dbg(&pdev->dev, "PORT STP Init.\n");
+
+	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
+				   DFL_PORT_REGION_INDEX_STP,
+				   resource_size(res), res->start,
+				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
+				   DFL_PORT_REGION_WRITE);
+}
+
+static void port_stp_uinit(struct platform_device *pdev,
+			   struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "PORT STP UInit.\n");
+}
+
+static const struct dfl_feature_id port_stp_id_table[] = {
+	{.id = PORT_FEATURE_ID_STP,},
+	{0,}
+};
+
+static const struct dfl_feature_ops port_stp_ops = {
+	.init = port_stp_init,
+	.uinit = port_stp_uinit,
+};
+
 static struct dfl_feature_driver port_feature_drvs[] = {
 	{
 		.id_table = port_hdr_id_table,
@@ -532,6 +562,10 @@ static void port_afu_uinit(struct platform_device *pdev,
 		.ops = &port_err_ops,
 	},
 	{
+		.id_table = port_stp_id_table,
+		.ops = &port_stp_ops,
+	},
+	{
 		.ops = NULL,
 	}
 };
-- 
1.8.3.1

