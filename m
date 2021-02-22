Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC513321EC7
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Feb 2021 19:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBVSGF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Feb 2021 13:06:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:60709 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhBVSGF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 22 Feb 2021 13:06:05 -0500
IronPort-SDR: oMJ3VzAzryy/LVTuHzmSLX9YJuqzfLDpfcWvcjwU0z9cYBpIDoaSRU+ISJ2YkFWERcEhIbMbi9
 QP3u41Nkb96w==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="203940546"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="203940546"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 10:04:23 -0800
IronPort-SDR: 6b4L1Xf6+UC0yIplK4IpGCEBwv4Frqqy0A0y5iXumm6sxuyh9+vCLfwdfTAtqmdarbcarPJCHt
 QdptNSVFJjDw==
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="389950448"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.104.72])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 10:04:22 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v6 1/1] fpga: dfl: afu: harden port enable logic
Date:   Mon, 22 Feb 2021 10:04:14 -0800
Message-Id: <20210222180414.116014-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Port enable is not complete until ACK = 0. Change
__afu_port_enable() to guarantee that the enable process
is complete by polling for ACK == 0.

Reviewed-by: Tom Rix <trix@redhat.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v6:
  - Fixed the dev_warn statement, which had "__func__" embedded in the
    string instead of treated as a parameter to the format string.
v5:
  - Added Reviewed-by tag to commit message
v4:
  - Added a dev_warn() call for the -EINVAL case of afu_port_err_clear()
  - Modified dev_err() message in __afu_port_disable() to say "disable"
    instead of "reset"
v3:
  - afu_port_err_clear() changed to prioritize port_enable failure over
    other a detected mismatch in port errors.
  - reorganized code in port_reset() to be more readable.
v2:
  - Fixed typo in commit message
---
 drivers/fpga/dfl-afu-error.c | 10 ++++++----
 drivers/fpga/dfl-afu-main.c  | 33 +++++++++++++++++++++++----------
 drivers/fpga/dfl-afu.h       |  2 +-
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index c4691187cca9..ab7be6217368 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -52,7 +52,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	struct platform_device *pdev = to_platform_device(dev);
 	void __iomem *base_err, *base_hdr;
-	int ret = -EBUSY;
+	int enable_ret = 0, ret = -EBUSY;
 	u64 v;
 
 	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
@@ -96,18 +96,20 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 		v = readq(base_err + PORT_FIRST_ERROR);
 		writeq(v, base_err + PORT_FIRST_ERROR);
 	} else {
+		dev_warn(dev, "%s: received 0x%llx, expected 0x%llx\n",
+			 __func__, v, err);
 		ret = -EINVAL;
 	}
 
 	/* Clear mask */
 	__afu_port_err_mask(dev, false);
 
-	/* Enable the Port by clear the reset */
-	__afu_port_enable(pdev);
+	/* Enable the Port by clearing the reset */
+	enable_ret = __afu_port_enable(pdev);
 
 done:
 	mutex_unlock(&pdata->lock);
-	return ret;
+	return enable_ret ? enable_ret : ret;
 }
 
 static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 753cda4b2568..77dadaae5b8f 100644
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
@@ -86,7 +99,7 @@ int __afu_port_disable(struct platform_device *pdev)
 	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
 			       v & PORT_CTRL_SFTRST_ACK,
 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
-		dev_err(&pdev->dev, "timeout, fail to reset device\n");
+		dev_err(&pdev->dev, "timeout, failure to disable device\n");
 		return -ETIMEDOUT;
 	}
 
@@ -111,9 +124,9 @@ static int __port_reset(struct platform_device *pdev)
 
 	ret = __afu_port_disable(pdev);
 	if (!ret)
-		__afu_port_enable(pdev);
+		return ret;
 
-	return ret;
+	return __afu_port_enable(pdev);
 }
 
 static int port_reset(struct platform_device *pdev)
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
2.25.1

