Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D59895A1
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Aug 2019 05:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHLDIT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Aug 2019 23:08:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:12631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfHLDH4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Aug 2019 23:07:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 20:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,375,1559545200"; 
   d="scan'208";a="199987489"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2019 20:07:54 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v5 5/9] fpga: dfl: afu: expose __afu_port_enable/disable function.
Date:   Mon, 12 Aug 2019 10:50:00 +0800
Message-Id: <1565578204-13969-6-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

As these two functions are used by other private features within the
same driver module but different driver files. e.g. in error reporting
private feature, it requires to clear errors when port is in reset.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: rebased
v5: add afu prefix to __port_enable/disable function to keep
    alignment with other func exposed across different afu files.
---
 drivers/fpga/dfl-afu-main.c | 26 +++++++++++++++-----------
 drivers/fpga/dfl-afu.h      |  4 ++++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index f0b45f2..449185c 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -22,14 +22,17 @@
 #include "dfl-afu.h"
 
 /**
- * port_enable - enable a port
+ * __afu_port_enable - enable a port by clear reset
  * @pdev: port platform device.
  *
  * Enable Port by clear the port soft reset bit, which is set by default.
  * The AFU is unable to respond to any MMIO access while in reset.
- * port_enable function should only be used after port_disable function.
+ * __afu_port_enable function should only be used after __afu_port_disable
+ * function.
+ *
+ * The caller needs to hold lock for protection.
  */
-static void port_enable(struct platform_device *pdev)
+void __afu_port_enable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -52,13 +55,14 @@ static void port_enable(struct platform_device *pdev)
 #define RST_POLL_TIMEOUT 1000 /* us */
 
 /**
- * port_disable - disable a port
+ * __afu_port_disable - disable a port by hold reset
  * @pdev: port platform device.
  *
- * Disable Port by setting the port soft reset bit, it puts the port into
- * reset.
+ * Disable Port by setting the port soft reset bit, it puts the port into reset.
+ *
+ * The caller needs to hold lock for protection.
  */
-static int port_disable(struct platform_device *pdev)
+int __afu_port_disable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -104,9 +108,9 @@ static int __port_reset(struct platform_device *pdev)
 {
 	int ret;
 
-	ret = port_disable(pdev);
+	ret = __afu_port_disable(pdev);
 	if (!ret)
-		port_enable(pdev);
+		__afu_port_enable(pdev);
 
 	return ret;
 }
@@ -799,9 +803,9 @@ static int port_enable_set(struct platform_device *pdev, bool enable)
 
 	mutex_lock(&pdata->lock);
 	if (enable)
-		port_enable(pdev);
+		__afu_port_enable(pdev);
 	else
-		ret = port_disable(pdev);
+		ret = __afu_port_disable(pdev);
 	mutex_unlock(&pdata->lock);
 
 	return ret;
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 0c7630a..83683f2 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -79,6 +79,10 @@ struct dfl_afu {
 	struct dfl_feature_platform_data *pdata;
 };
 
+/* hold pdata->lock when call __afu_port_enable/disable */
+void __afu_port_enable(struct platform_device *pdev);
+int __afu_port_disable(struct platform_device *pdev);
+
 void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
 int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 			u32 region_index, u64 region_size, u64 phys, u32 flags);
-- 
1.8.3.1

