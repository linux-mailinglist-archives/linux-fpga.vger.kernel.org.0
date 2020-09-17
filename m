Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D106E26E3B5
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Sep 2020 20:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIQSem (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Sep 2020 14:34:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:48063 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgIQSdf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Sep 2020 14:33:35 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 14:33:19 EDT
IronPort-SDR: 1T0qoYjdEwUQSs2nTKZnO7D29FpHSCbozdDbA8lF0SLG2efHyAIsgbY3f7CX6vitxw0XbQs2mX
 sJZCSCwLFUkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="159075370"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="159075370"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 11:25:48 -0700
IronPort-SDR: N9BazKDdduRVcRT5MP4sYPA66mLeTpWQiF2tVqdVqHPMZ/xqe2+tPzyqIkYm3RYLWMdJUEpRfV
 9MWzmKfn/c7w==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="287679792"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.91.84])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 11:25:48 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 1/1] fpga: dfl: afu: harden port enable logic
Date:   Thu, 17 Sep 2020 11:25:45 -0700
Message-Id: <20200917182546.1788-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Port enable is not complete until ACK = 0. Change
__afu_port_enable() guarantee that the enable process
is complete by polling for ACK == 0.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/fpga/dfl-afu-error.c |  2 +-
 drivers/fpga/dfl-afu-main.c  | 29 +++++++++++++++++++++--------
 drivers/fpga/dfl-afu.h       |  2 +-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index c4691187cca9..0806532a3e9f 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -103,7 +103,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	__afu_port_err_mask(dev, false);
 
 	/* Enable the Port by clear the reset */
-	__afu_port_enable(pdev);
+	ret = __afu_port_enable(pdev);
 
 done:
 	mutex_unlock(&pdata->lock);
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 753cda4b2568..f73b06cdf13c 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -21,6 +21,9 @@
 
 #include "dfl-afu.h"
 
+#define RST_POLL_INVL 10 /* us */
+#define RST_POLL_TIMEOUT 1000 /* us */
+
 /**
  * __afu_port_enable - enable a port by clear reset
  * @pdev: port platform device.
@@ -32,7 +35,7 @@
  *
  * The caller needs to hold lock for protection.
  */
-void __afu_port_enable(struct platform_device *pdev)
+int __afu_port_enable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
 	WARN_ON(!pdata->disable_count);
 
 	if (--pdata->disable_count != 0)
-		return;
+		return 0;
 
 	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
 
@@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device *pdev)
 	v = readq(base + PORT_HDR_CTRL);
 	v &= ~PORT_CTRL_SFTRST;
 	writeq(v, base + PORT_HDR_CTRL);
-}
 
-#define RST_POLL_INVL 10 /* us */
-#define RST_POLL_TIMEOUT 1000 /* us */
+	/*
+	 * HW clears the ack bit to indicate that the port is fully out
+	 * of reset.
+	 */
+	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
+			       !(v & PORT_CTRL_SFTRST_ACK),
+			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
+		dev_err(&pdev->dev, "timeout, failure to enable device\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
 
 /**
  * __afu_port_disable - disable a port by hold reset
@@ -111,7 +124,7 @@ static int __port_reset(struct platform_device *pdev)
 
 	ret = __afu_port_disable(pdev);
 	if (!ret)
-		__afu_port_enable(pdev);
+		ret = __afu_port_enable(pdev);
 
 	return ret;
 }
@@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device *pdev)
 static int port_enable_set(struct platform_device *pdev, bool enable)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&pdata->lock);
 	if (enable)
-		__afu_port_enable(pdev);
+		ret = __afu_port_enable(pdev);
 	else
 		ret = __afu_port_disable(pdev);
 	mutex_unlock(&pdata->lock);
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 576e94960086..e5020e2b1f3d 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -80,7 +80,7 @@ struct dfl_afu {
 };
 
 /* hold pdata->lock when call __afu_port_enable/disable */
-void __afu_port_enable(struct platform_device *pdev);
+int __afu_port_enable(struct platform_device *pdev);
 int __afu_port_disable(struct platform_device *pdev);
 
 void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
-- 
2.17.1

