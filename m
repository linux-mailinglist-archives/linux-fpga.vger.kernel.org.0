Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0F4341F2
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 01:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhJSXSp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Oct 2021 19:18:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:7453 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhJSXSo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Oct 2021 19:18:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="209445777"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="209445777"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 16:15:52 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="567152177"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.183.7])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 16:15:50 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 1/2] fpga: dfl: afu: Clear port errors in afu init
Date:   Tue, 19 Oct 2021 16:15:44 -0700
Message-Id: <20211019231545.47118-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019231545.47118-1-russell.h.weight@intel.com>
References: <20211019231545.47118-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

When the AFU driver initializes, log any pre-existing errors and clear them.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/fpga/dfl-afu-error.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index ab7be6217368..0dc60bf49902 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -47,13 +47,13 @@ static void afu_port_err_mask(struct device *dev, bool mask)
 }
 
 /* clear port errors. */
-static int afu_port_err_clear(struct device *dev, u64 err)
+static int afu_port_err_clear(struct device *dev, u64 err, bool clear_all)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	struct platform_device *pdev = to_platform_device(dev);
+	u64 v, port_error, port_first_error;
 	void __iomem *base_err, *base_hdr;
 	int enable_ret = 0, ret = -EBUSY;
-	u64 v;
 
 	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
 	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
@@ -88,16 +88,21 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	__afu_port_err_mask(dev, true);
 
 	/* Clear errors if err input matches with current port errors.*/
-	v = readq(base_err + PORT_ERROR);
+	port_error = readq(base_err + PORT_ERROR);
 
-	if (v == err) {
-		writeq(v, base_err + PORT_ERROR);
+	if (clear_all || port_error == err) {
+		port_first_error = readq(base_err + PORT_FIRST_ERROR);
 
-		v = readq(base_err + PORT_FIRST_ERROR);
-		writeq(v, base_err + PORT_FIRST_ERROR);
+		if (clear_all && (port_error || port_first_error))
+			dev_warn(dev,
+				 "Port Error: 0x%llx, First Error 0x%llx\n",
+				 port_error, port_first_error);
+
+		writeq(port_error, base_err + PORT_ERROR);
+		writeq(port_first_error, base_err + PORT_FIRST_ERROR);
 	} else {
 		dev_warn(dev, "%s: received 0x%llx, expected 0x%llx\n",
-			 __func__, v, err);
+			 __func__, port_error, err);
 		ret = -EINVAL;
 	}
 
@@ -137,7 +142,7 @@ static ssize_t errors_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtou64(buff, 0, &value))
 		return -EINVAL;
 
-	ret = afu_port_err_clear(dev, value);
+	ret = afu_port_err_clear(dev, value, false);
 
 	return ret ? ret : count;
 }
@@ -211,7 +216,8 @@ const struct attribute_group port_err_group = {
 static int port_err_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
-	afu_port_err_mask(&pdev->dev, false);
+	if (afu_port_err_clear(&pdev->dev, 0, true))
+		afu_port_err_mask(&pdev->dev, false);
 
 	return 0;
 }
-- 
2.25.1

