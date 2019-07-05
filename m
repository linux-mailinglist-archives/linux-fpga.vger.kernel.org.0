Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9AE5FF2E
	for <lists+linux-fpga@lfdr.de>; Fri,  5 Jul 2019 02:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfGEAmm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Jul 2019 20:42:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:40861 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbfGEAmN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jul 2019 20:42:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 17:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,453,1557212400"; 
   d="scan'208";a="185074803"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2019 17:42:10 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 07/11] fpga: dfl: afu: export __port_enable/disable function.
Date:   Fri,  5 Jul 2019 08:23:54 +0800
Message-Id: <1562286238-11413-8-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562286238-11413-1-git-send-email-hao.wu@intel.com>
References: <1562286238-11413-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

As these two functions are used by other private features. e.g.
in error reporting private feature, it requires to check port status
and reset port for error clearing.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: rebased.
---
 drivers/fpga/dfl-afu-main.c | 25 ++++++++++++++-----------
 drivers/fpga/dfl-afu.h      |  3 +++
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index fbd9553..22d294b 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -22,14 +22,16 @@
 #include "dfl-afu.h"
 
 /**
- * port_enable - enable a port
+ * __port_enable - enable a port
  * @pdev: port platform device.
  *
  * Enable Port by clear the port soft reset bit, which is set by default.
  * The AFU is unable to respond to any MMIO access while in reset.
- * port_enable function should only be used after port_disable function.
+ * __port_enable function should only be used after __port_disable function.
+ *
+ * The caller needs to hold lock for protection.
  */
-static void port_enable(struct platform_device *pdev)
+void __port_enable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -52,13 +54,14 @@ static void port_enable(struct platform_device *pdev)
 #define RST_POLL_TIMEOUT 1000 /* us */
 
 /**
- * port_disable - disable a port
+ * __port_disable - disable a port
  * @pdev: port platform device.
  *
- * Disable Port by setting the port soft reset bit, it puts the port into
- * reset.
+ * Disable Port by setting the port soft reset bit, it puts the port into reset.
+ *
+ * The caller needs to hold lock for protection.
  */
-static int port_disable(struct platform_device *pdev)
+int __port_disable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -104,9 +107,9 @@ static int __port_reset(struct platform_device *pdev)
 {
 	int ret;
 
-	ret = port_disable(pdev);
+	ret = __port_disable(pdev);
 	if (!ret)
-		port_enable(pdev);
+		__port_enable(pdev);
 
 	return ret;
 }
@@ -806,9 +809,9 @@ static int port_enable_set(struct platform_device *pdev, bool enable)
 
 	mutex_lock(&pdata->lock);
 	if (enable)
-		port_enable(pdev);
+		__port_enable(pdev);
 	else
-		ret = port_disable(pdev);
+		ret = __port_disable(pdev);
 	mutex_unlock(&pdata->lock);
 
 	return ret;
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 0c7630a..35e60c5 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -79,6 +79,9 @@ struct dfl_afu {
 	struct dfl_feature_platform_data *pdata;
 };
 
+void __port_enable(struct platform_device *pdev);
+int __port_disable(struct platform_device *pdev);
+
 void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
 int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 			u32 region_index, u64 region_size, u64 phys, u32 flags);
-- 
1.8.3.1

