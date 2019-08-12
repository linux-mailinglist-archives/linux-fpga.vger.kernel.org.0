Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F87F89595
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Aug 2019 05:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfHLDIA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Aug 2019 23:08:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:12631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfHLDIA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Aug 2019 23:08:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 20:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,375,1559545200"; 
   d="scan'208";a="199987499"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2019 20:07:58 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v5 7/9] fpga: dfl: afu: add STP (SignalTap) support
Date:   Mon, 12 Aug 2019 10:50:02 +0800
Message-Id: <1565578204-13969-8-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
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
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v4: remove uinit callback which does nothing.
    remove dev_dbg in init callback function.
---
 drivers/fpga/dfl-afu-main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index e11352a..e4a34dc 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -508,6 +508,27 @@ static int port_afu_init(struct platform_device *pdev,
 	.init = port_afu_init,
 };
 
+static int port_stp_init(struct platform_device *pdev,
+			 struct dfl_feature *feature)
+{
+	struct resource *res = &pdev->resource[feature->resource_index];
+
+	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
+				   DFL_PORT_REGION_INDEX_STP,
+				   resource_size(res), res->start,
+				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
+				   DFL_PORT_REGION_WRITE);
+}
+
+static const struct dfl_feature_id port_stp_id_table[] = {
+	{.id = PORT_FEATURE_ID_STP,},
+	{0,}
+};
+
+static const struct dfl_feature_ops port_stp_ops = {
+	.init = port_stp_init,
+};
+
 static struct dfl_feature_driver port_feature_drvs[] = {
 	{
 		.id_table = port_hdr_id_table,
@@ -522,6 +543,10 @@ static int port_afu_init(struct platform_device *pdev,
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

