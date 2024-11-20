Return-Path: <linux-fpga+bounces-956-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A239D31B4
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58631F23750
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB0413B2BB;
	Wed, 20 Nov 2024 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiF3e33Q"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130F6F305;
	Wed, 20 Nov 2024 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065104; cv=none; b=ZiB7/QRBPsFu2x9zvkLTv/1Zx+K1AFl6kE2TbM9tsiJNEI3dSq+x9i4+8JV/v66UEgyCpdhexn2xFbbPqWf5GczoiaK6Xjw/nmmKApjCqGU59WX50PwzszYsHT5TZ4x287n7xEVJUHeAS6BxLXDv9BiazPn5k1lS6oOYod46dp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065104; c=relaxed/simple;
	bh=O8yvJHoy7gPJYXwQ9NUGw4oMA1x9U1vJMizyd0U9DLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgC76dkIM9DMnl7EwKs5EhMUs8Bey8DDaQrXYFuHCyhDpBaGsbyGfS/LzBuL5QYTTUcwJA3AxUApIGs4XyQ8kMNE4rmnEHIKZo4xuLUFmfqdfqarCo+XHHblw+Au08KRn62lsXJehHzMiFx6qUopJSHJBkmaJAYXS4nw5hV0K6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiF3e33Q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065102; x=1763601102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8yvJHoy7gPJYXwQ9NUGw4oMA1x9U1vJMizyd0U9DLg=;
  b=kiF3e33QCqP5obl6NhVH4JPH+wMgCUEHNk8QTwvnNl3MPgQO8P7pWJ3C
   r5ofqC2a9qc26XfiZS9SHhlDGTRTrULnuNU8ARvev0CIwtWvim5eW2RgF
   z7iN7tg2HWhaeN0J6g3rqGlW38HbB/t2cXYxaJ3AWZqrHEY3mf3EoFOXW
   OF7Go5ozAooyTpbgTVEwf26A4DdZV/fgz78/qE4rEz9aKAAQwxjYRxUGC
   v/A8cd2HNjmUb9Sw77z1YKHI6ekPd99olgaIZVdSOTUdf85YlusG2cQgF
   en8stDeTImwLvB9cQl4lUCFbzB50+HYPENhdm1RYKY+5g3SeEoJkNhkdy
   g==;
X-CSE-ConnectionGUID: tEu3Z/DjTN2PXTf/APS+ng==
X-CSE-MsgGUID: PS2MW/r/TrmGsGW0Myx0Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42612983"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42612983"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:40 -0800
X-CSE-ConnectionGUID: xjOc8X3hRd+6BuAyzJ9CPw==
X-CSE-MsgGUID: EdtCQEdATs+U/xkqUuI3KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813578"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:39 -0800
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v5 05/18] fpga: dfl: pass feature platform data instead of device as argument
Date: Tue, 19 Nov 2024 20:10:21 -0500
Message-ID: <20241120011035.230574-6-peter.colberg@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120011035.230574-1-peter.colberg@intel.com>
References: <20241120011035.230574-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For functions which use the feature platform data, instead of invoking
dev_get_platdata() on the device, directly pass the data as an argument.

This patch is part of a refactoring of the internal DFL APIs to move
the feature device data into a new struct dfl_feature_dev_data which
lifetime is independent of the corresponding platform device.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

Changes since v3:
- Extend description to mention the reason for the refactoring.

Changes since v2:
- New patch extracted from monolithic v1 patch.
---
 drivers/fpga/dfl-afu-error.c | 29 +++++++-------
 drivers/fpga/dfl-afu-main.c  | 76 +++++++++++++++++++-----------------
 drivers/fpga/dfl-afu.h       |  4 +-
 drivers/fpga/dfl-fme-br.c    | 26 ++++++------
 drivers/fpga/dfl-fme-error.c | 32 ++++++++-------
 drivers/fpga/dfl-fme-main.c  | 18 ++++++---
 drivers/fpga/dfl-fme-pr.c    |  6 +--
 drivers/fpga/dfl.c           | 71 ++++++++++++++-------------------
 drivers/fpga/dfl.h           | 35 +++++++++--------
 9 files changed, 150 insertions(+), 147 deletions(-)

diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index ab7be6217368..ad6ea19faaa0 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -28,11 +28,11 @@
 #define ERROR_MASK		GENMASK_ULL(63, 0)
 
 /* mask or unmask port errors by the error mask register. */
-static void __afu_port_err_mask(struct device *dev, bool mask)
+static void __afu_port_err_mask(struct dfl_feature_platform_data *pdata, bool mask)
 {
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
 
 	writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
 }
@@ -42,7 +42,7 @@ static void afu_port_err_mask(struct device *dev, bool mask)
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 
 	mutex_lock(&pdata->lock);
-	__afu_port_err_mask(dev, mask);
+	__afu_port_err_mask(pdata, mask);
 	mutex_unlock(&pdata->lock);
 }
 
@@ -50,13 +50,12 @@ static void afu_port_err_mask(struct device *dev, bool mask)
 static int afu_port_err_clear(struct device *dev, u64 err)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
-	struct platform_device *pdev = to_platform_device(dev);
 	void __iomem *base_err, *base_hdr;
 	int enable_ret = 0, ret = -EBUSY;
 	u64 v;
 
-	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
-	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base_err = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
+	base_hdr = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 
@@ -80,12 +79,12 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	}
 
 	/* Halt Port by keeping Port in reset */
-	ret = __afu_port_disable(pdev);
+	ret = __afu_port_disable(pdata);
 	if (ret)
 		goto done;
 
 	/* Mask all errors */
-	__afu_port_err_mask(dev, true);
+	__afu_port_err_mask(pdata, true);
 
 	/* Clear errors if err input matches with current port errors.*/
 	v = readq(base_err + PORT_ERROR);
@@ -102,10 +101,10 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	}
 
 	/* Clear mask */
-	__afu_port_err_mask(dev, false);
+	__afu_port_err_mask(pdata, false);
 
 	/* Enable the Port by clearing the reset */
-	enable_ret = __afu_port_enable(pdev);
+	enable_ret = __afu_port_enable(pdata);
 
 done:
 	mutex_unlock(&pdata->lock);
@@ -119,7 +118,7 @@ static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
 	void __iomem *base;
 	u64 error;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
 
 	mutex_lock(&pdata->lock);
 	error = readq(base + PORT_ERROR);
@@ -150,7 +149,7 @@ static ssize_t first_error_show(struct device *dev,
 	void __iomem *base;
 	u64 error;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
 
 	mutex_lock(&pdata->lock);
 	error = readq(base + PORT_FIRST_ERROR);
@@ -168,7 +167,7 @@ static ssize_t first_malformed_req_show(struct device *dev,
 	void __iomem *base;
 	u64 req0, req1;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
 
 	mutex_lock(&pdata->lock);
 	req0 = readq(base + PORT_MALFORMED_REQ0);
@@ -190,13 +189,15 @@ static struct attribute *port_err_attrs[] = {
 static umode_t port_err_attrs_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
+	struct dfl_feature_platform_data *pdata;
 	struct device *dev = kobj_to_dev(kobj);
 
+	pdata = dev_get_platdata(dev);
 	/*
 	 * sysfs entries are visible only if related private feature is
 	 * enumerated.
 	 */
-	if (!dfl_get_feature_by_id(dev, PORT_FEATURE_ID_ERROR))
+	if (!dfl_get_feature_by_id(pdata, PORT_FEATURE_ID_ERROR))
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index c0f2db72b5b9..c86d01f49633 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -26,7 +26,7 @@
 
 /**
  * __afu_port_enable - enable a port by clear reset
- * @pdev: port platform device.
+ * @pdata: feature device platform data
  *
  * Enable Port by clear the port soft reset bit, which is set by default.
  * The AFU is unable to respond to any MMIO access while in reset.
@@ -35,9 +35,8 @@
  *
  * The caller needs to hold lock for protection.
  */
-int __afu_port_enable(struct platform_device *pdev)
+int __afu_port_enable(struct dfl_feature_platform_data *pdata)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
 	u64 v;
 
@@ -46,7 +45,7 @@ int __afu_port_enable(struct platform_device *pdev)
 	if (--pdata->disable_count != 0)
 		return 0;
 
-	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	/* Clear port soft reset */
 	v = readq(base + PORT_HDR_CTRL);
@@ -70,22 +69,21 @@ int __afu_port_enable(struct platform_device *pdev)
 
 /**
  * __afu_port_disable - disable a port by hold reset
- * @pdev: port platform device.
+ * @pdata: feature device platform data
  *
  * Disable Port by setting the port soft reset bit, it puts the port into reset.
  *
  * The caller needs to hold lock for protection.
  */
-int __afu_port_disable(struct platform_device *pdev)
+int __afu_port_disable(struct dfl_feature_platform_data *pdata)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
 	u64 v;
 
 	if (pdata->disable_count++ != 0)
 		return 0;
 
-	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	/* Set port soft reset */
 	v = readq(base + PORT_HDR_CTRL);
@@ -120,15 +118,15 @@ int __afu_port_disable(struct platform_device *pdev)
  * (disabled). Any attempts on MMIO access to AFU while in reset, will
  * result errors reported via port error reporting sub feature (if present).
  */
-static int __port_reset(struct platform_device *pdev)
+static int __port_reset(struct dfl_feature_platform_data *pdata)
 {
 	int ret;
 
-	ret = __afu_port_disable(pdev);
+	ret = __afu_port_disable(pdata);
 	if (ret)
 		return ret;
 
-	return __afu_port_enable(pdev);
+	return __afu_port_enable(pdata);
 }
 
 static int port_reset(struct platform_device *pdev)
@@ -137,17 +135,17 @@ static int port_reset(struct platform_device *pdev)
 	int ret;
 
 	mutex_lock(&pdata->lock);
-	ret = __port_reset(pdev);
+	ret = __port_reset(pdata);
 	mutex_unlock(&pdata->lock);
 
 	return ret;
 }
 
-static int port_get_id(struct platform_device *pdev)
+static int port_get_id(struct dfl_feature_platform_data *pdata)
 {
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	return FIELD_GET(PORT_CAP_PORT_NUM, readq(base + PORT_HDR_CAP));
 }
@@ -155,7 +153,8 @@ static int port_get_id(struct platform_device *pdev)
 static ssize_t
 id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	int id = port_get_id(to_platform_device(dev));
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	int id = port_get_id(pdata);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
 }
@@ -168,7 +167,7 @@ ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	v = readq(base + PORT_HDR_CTRL);
@@ -189,7 +188,7 @@ ltr_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtobool(buf, &ltr))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	v = readq(base + PORT_HDR_CTRL);
@@ -209,7 +208,7 @@ ap1_event_show(struct device *dev, struct device_attribute *attr, char *buf)
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	v = readq(base + PORT_HDR_STS);
@@ -229,7 +228,7 @@ ap1_event_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtobool(buf, &clear) || !clear)
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	writeq(PORT_STS_AP1_EVT, base + PORT_HDR_STS);
@@ -247,7 +246,7 @@ ap2_event_show(struct device *dev, struct device_attribute *attr,
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	v = readq(base + PORT_HDR_STS);
@@ -267,7 +266,7 @@ ap2_event_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtobool(buf, &clear) || !clear)
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	writeq(PORT_STS_AP2_EVT, base + PORT_HDR_STS);
@@ -284,7 +283,7 @@ power_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	v = readq(base + PORT_HDR_STS);
@@ -305,7 +304,7 @@ userclk_freqcmd_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtou64(buf, 0, &userclk_freq_cmd))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	writeq(userclk_freq_cmd, base + PORT_HDR_USRCLK_CMD0);
@@ -326,7 +325,7 @@ userclk_freqcntrcmd_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtou64(buf, 0, &userclk_freqcntr_cmd))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	writeq(userclk_freqcntr_cmd, base + PORT_HDR_USRCLK_CMD1);
@@ -344,7 +343,7 @@ userclk_freqsts_show(struct device *dev, struct device_attribute *attr,
 	u64 userclk_freqsts;
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	userclk_freqsts = readq(base + PORT_HDR_USRCLK_STS0);
@@ -362,7 +361,7 @@ userclk_freqcntrsts_show(struct device *dev, struct device_attribute *attr,
 	u64 userclk_freqcntrsts;
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	userclk_freqcntrsts = readq(base + PORT_HDR_USRCLK_STS1);
@@ -389,11 +388,13 @@ static struct attribute *port_hdr_attrs[] = {
 static umode_t port_hdr_attrs_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
+	struct dfl_feature_platform_data *pdata;
 	struct device *dev = kobj_to_dev(kobj);
 	umode_t mode = attr->mode;
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	pdata = dev_get_platdata(dev);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
 
 	if (dfl_feature_revision(base) > 0) {
 		/*
@@ -462,7 +463,7 @@ afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 	void __iomem *base;
 	u64 guidl, guidh;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_AFU);
+	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_AFU);
 
 	mutex_lock(&pdata->lock);
 	if (pdata->disable_count) {
@@ -486,13 +487,15 @@ static struct attribute *port_afu_attrs[] = {
 static umode_t port_afu_attrs_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
+	struct dfl_feature_platform_data *pdata;
 	struct device *dev = kobj_to_dev(kobj);
 
+	pdata = dev_get_platdata(dev);
 	/*
 	 * sysfs entries are visible only if related private feature is
 	 * enumerated.
 	 */
-	if (!dfl_get_feature_by_id(dev, PORT_FEATURE_ID_AFU))
+	if (!dfl_get_feature_by_id(pdata, PORT_FEATURE_ID_AFU))
 		return 0;
 
 	return attr->mode;
@@ -506,9 +509,10 @@ static const struct attribute_group port_afu_group = {
 static int port_afu_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct resource *res = &pdev->resource[feature->resource_index];
 
-	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
+	return afu_mmio_region_add(pdata,
 				   DFL_PORT_REGION_INDEX_AFU,
 				   resource_size(res), res->start,
 				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
@@ -527,9 +531,10 @@ static const struct dfl_feature_ops port_afu_ops = {
 static int port_stp_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct resource *res = &pdev->resource[feature->resource_index];
 
-	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
+	return afu_mmio_region_add(pdata,
 				   DFL_PORT_REGION_INDEX_STP,
 				   resource_size(res), res->start,
 				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
@@ -630,7 +635,7 @@ static int afu_release(struct inode *inode, struct file *filp)
 		dfl_fpga_dev_for_each_feature(pdata, feature)
 			dfl_fpga_set_irq_triggers(feature, 0,
 						  feature->nr_irqs, NULL);
-		__port_reset(pdev);
+		__port_reset(pdata);
 		afu_dma_region_destroy(pdata);
 	}
 	mutex_unlock(&pdata->lock);
@@ -878,16 +883,15 @@ static int afu_dev_destroy(struct platform_device *pdev)
 	return 0;
 }
 
-static int port_enable_set(struct platform_device *pdev, bool enable)
+static int port_enable_set(struct dfl_feature_platform_data *pdata, bool enable)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int ret;
 
 	mutex_lock(&pdata->lock);
 	if (enable)
-		ret = __afu_port_enable(pdev);
+		ret = __afu_port_enable(pdata);
 	else
-		ret = __afu_port_disable(pdev);
+		ret = __afu_port_disable(pdata);
 	mutex_unlock(&pdata->lock);
 
 	return ret;
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 7bef3e300aa2..6d1e79240c70 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -77,8 +77,8 @@ struct dfl_afu {
 };
 
 /* hold pdata->lock when call __afu_port_enable/disable */
-int __afu_port_enable(struct platform_device *pdev);
-int __afu_port_disable(struct platform_device *pdev);
+int __afu_port_enable(struct dfl_feature_platform_data *pdata);
+int __afu_port_disable(struct dfl_feature_platform_data *pdata);
 
 void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
 int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index 0b01b3895277..c19ddb02a161 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -22,34 +22,34 @@
 struct fme_br_priv {
 	struct dfl_fme_br_pdata *pdata;
 	struct dfl_fpga_port_ops *port_ops;
-	struct platform_device *port_pdev;
+	struct dfl_feature_platform_data *port_pdata;
 };
 
 static int fme_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
 {
+	struct dfl_feature_platform_data *port_pdata;
 	struct fme_br_priv *priv = bridge->priv;
-	struct platform_device *port_pdev;
 	struct dfl_fpga_port_ops *ops;
 
-	if (!priv->port_pdev) {
-		port_pdev = dfl_fpga_cdev_find_port(priv->pdata->cdev,
-						    &priv->pdata->port_id,
-						    dfl_fpga_check_port_id);
-		if (!port_pdev)
+	if (!priv->port_pdata) {
+		port_pdata = dfl_fpga_cdev_find_port_data(priv->pdata->cdev,
+							  &priv->pdata->port_id,
+							  dfl_fpga_check_port_id);
+		if (!port_pdata)
 			return -ENODEV;
 
-		priv->port_pdev = port_pdev;
+		priv->port_pdata = port_pdata;
 	}
 
-	if (priv->port_pdev && !priv->port_ops) {
-		ops = dfl_fpga_port_ops_get(priv->port_pdev);
+	if (priv->port_pdata && !priv->port_ops) {
+		ops = dfl_fpga_port_ops_get(priv->port_pdata);
 		if (!ops || !ops->enable_set)
 			return -ENOENT;
 
 		priv->port_ops = ops;
 	}
 
-	return priv->port_ops->enable_set(priv->port_pdev, enable);
+	return priv->port_ops->enable_set(priv->port_pdata, enable);
 }
 
 static const struct fpga_bridge_ops fme_bridge_ops = {
@@ -85,8 +85,8 @@ static void fme_br_remove(struct platform_device *pdev)
 
 	fpga_bridge_unregister(br);
 
-	if (priv->port_pdev)
-		put_device(&priv->port_pdev->dev);
+	if (priv->port_pdata)
+		put_device(&priv->port_pdata->dev->dev);
 	if (priv->port_ops)
 		dfl_fpga_port_ops_put(priv->port_ops);
 }
diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
index 51c2892ec06d..39b8e3b450d7 100644
--- a/drivers/fpga/dfl-fme-error.c
+++ b/drivers/fpga/dfl-fme-error.c
@@ -46,7 +46,7 @@ static ssize_t pcie0_errors_show(struct device *dev,
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	value = readq(base + PCIE0_ERROR);
@@ -67,7 +67,7 @@ static ssize_t pcie0_errors_store(struct device *dev,
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	writeq(GENMASK_ULL(63, 0), base + PCIE0_ERROR_MASK);
@@ -91,7 +91,7 @@ static ssize_t pcie1_errors_show(struct device *dev,
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	value = readq(base + PCIE1_ERROR);
@@ -112,7 +112,7 @@ static ssize_t pcie1_errors_store(struct device *dev,
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	writeq(GENMASK_ULL(63, 0), base + PCIE1_ERROR_MASK);
@@ -132,9 +132,10 @@ static DEVICE_ATTR_RW(pcie1_errors);
 static ssize_t nonfatal_errors_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
@@ -144,9 +145,10 @@ static DEVICE_ATTR_RO(nonfatal_errors);
 static ssize_t catfatal_errors_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
@@ -160,7 +162,7 @@ static ssize_t inject_errors_show(struct device *dev,
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	v = readq(base + RAS_ERROR_INJECT);
@@ -185,7 +187,7 @@ static ssize_t inject_errors_store(struct device *dev,
 	if (inject_error & ~INJECT_ERROR_MASK)
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	v = readq(base + RAS_ERROR_INJECT);
@@ -205,7 +207,7 @@ static ssize_t fme_errors_show(struct device *dev,
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	value = readq(base + FME_ERROR);
@@ -226,7 +228,7 @@ static ssize_t fme_errors_store(struct device *dev,
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	writeq(GENMASK_ULL(63, 0), base + FME_ERROR_MASK);
@@ -252,7 +254,7 @@ static ssize_t first_error_show(struct device *dev,
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	value = readq(base + FME_FIRST_ERROR);
@@ -269,7 +271,7 @@ static ssize_t next_error_show(struct device *dev,
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 	value = readq(base + FME_NEXT_ERROR);
@@ -294,13 +296,15 @@ static struct attribute *fme_global_err_attrs[] = {
 static umode_t fme_global_err_attrs_visible(struct kobject *kobj,
 					    struct attribute *attr, int n)
 {
+	struct dfl_feature_platform_data *pdata;
 	struct device *dev = kobj_to_dev(kobj);
 
+	pdata = dev_get_platdata(dev);
 	/*
 	 * sysfs entries are visible only if related private feature is
 	 * enumerated.
 	 */
-	if (!dfl_get_feature_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR))
+	if (!dfl_get_feature_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR))
 		return 0;
 
 	return attr->mode;
@@ -317,7 +321,7 @@ static void fme_err_mask(struct device *dev, bool mask)
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
 
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 480a187289bb..4964e15e910b 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -28,10 +28,11 @@
 static ssize_t ports_num_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -47,10 +48,11 @@ static DEVICE_ATTR_RO(ports_num);
 static ssize_t bitstream_id_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_BITSTREAM_ID);
 
@@ -65,10 +67,11 @@ static DEVICE_ATTR_RO(bitstream_id);
 static ssize_t bitstream_metadata_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_BITSTREAM_MD);
 
@@ -79,10 +82,11 @@ static DEVICE_ATTR_RO(bitstream_metadata);
 static ssize_t cache_size_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -94,10 +98,11 @@ static DEVICE_ATTR_RO(cache_size);
 static ssize_t fabric_version_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -109,10 +114,11 @@ static DEVICE_ATTR_RO(fabric_version);
 static ssize_t socket_id_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index cdcf6dea4cc9..97fc0e402edf 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -87,8 +87,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 		return -EINVAL;
 
 	/* get fme header region */
-	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
-					       FME_FEATURE_ID_HEADER);
+	fme_hdr = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
 
 	/* check port id */
 	v = readq(fme_hdr + FME_HDR_CAP);
@@ -378,8 +377,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
 	int ret = -ENODEV, i = 0;
 	u64 fme_cap, port_offset;
 
-	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
-					       FME_FEATURE_ID_HEADER);
+	fme_hdr = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
 
 	mutex_lock(&pdata->lock);
 	priv = dfl_fpga_pdata_get_private(pdata);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 8512a1da6570..4c79d433d216 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -161,7 +161,7 @@ static LIST_HEAD(dfl_port_ops_list);
  *
  * Please note that must dfl_fpga_port_ops_put after use the port_ops.
  */
-struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device *pdev)
+struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_platform_data *pdata)
 {
 	struct dfl_fpga_port_ops *ops = NULL;
 
@@ -171,7 +171,7 @@ struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device *pdev)
 
 	list_for_each_entry(ops, &dfl_port_ops_list, node) {
 		/* match port_ops using the name of platform device */
-		if (!strcmp(pdev->name, ops->name)) {
+		if (!strcmp(pdata->dev->name, ops->name)) {
 			if (!try_module_get(ops->owner))
 				ops = NULL;
 			goto done;
@@ -227,19 +227,18 @@ EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_del);
  *
  * Return: 1 if port device matches with given port id, otherwise 0.
  */
-int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
+int dfl_fpga_check_port_id(struct dfl_feature_platform_data *pdata, void *pport_id)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct dfl_fpga_port_ops *port_ops;
 
 	if (pdata->id != FEATURE_DEV_ID_UNUSED)
 		return pdata->id == *(int *)pport_id;
 
-	port_ops = dfl_fpga_port_ops_get(pdev);
+	port_ops = dfl_fpga_port_ops_get(pdata);
 	if (!port_ops || !port_ops->get_id)
 		return 0;
 
-	pdata->id = port_ops->get_id(pdev);
+	pdata->id = port_ops->get_id(pdata);
 	dfl_fpga_port_ops_put(port_ops);
 
 	return pdata->id == *(int *)pport_id;
@@ -741,11 +740,9 @@ struct dfl_feature_info {
 	u64 params[];
 };
 
-static void dfl_fpga_cdev_add_port_dev(struct dfl_fpga_cdev *cdev,
-				       struct platform_device *port)
+static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
+					struct dfl_feature_platform_data *pdata)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&port->dev);
-
 	mutex_lock(&cdev->lock);
 	list_add(&pdata->node, &cdev->port_dev_list);
 	get_device(&pdata->dev->dev);
@@ -865,8 +862,8 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	ret = platform_device_add(binfo->feature_dev);
 	if (!ret) {
 		if (type == PORT_ID)
-			dfl_fpga_cdev_add_port_dev(binfo->cdev,
-						   binfo->feature_dev);
+			dfl_fpga_cdev_add_port_data(binfo->cdev,
+						    pdata);
 		else
 			binfo->cdev->fme_dev =
 					get_device(&binfo->feature_dev->dev);
@@ -1641,7 +1638,7 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_remove);
 
 /**
- * __dfl_fpga_cdev_find_port - find a port under given container device
+ * __dfl_fpga_cdev_find_port_data - find a port under given container device
  *
  * @cdev: container device
  * @data: data passed to match function
@@ -1654,23 +1651,20 @@ EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_remove);
  *
  * NOTE: you will need to drop the device reference with put_device() after use.
  */
-struct platform_device *
-__dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
-			  int (*match)(struct platform_device *, void *))
+struct dfl_feature_platform_data *
+__dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
+			       int (*match)(struct dfl_feature_platform_data *, void *))
 {
 	struct dfl_feature_platform_data *pdata;
-	struct platform_device *port_dev;
 
 	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
-		port_dev = pdata->dev;
-
-		if (match(port_dev, data) && get_device(&port_dev->dev))
-			return port_dev;
+		if (match(pdata, data) && get_device(&pdata->dev->dev))
+			return pdata;
 	}
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_find_port);
+EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_find_port_data);
 
 static int __init dfl_fpga_init(void)
 {
@@ -1705,32 +1699,29 @@ static int __init dfl_fpga_init(void)
 int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 {
 	struct dfl_feature_platform_data *pdata;
-	struct platform_device *port_pdev;
 	int ret = -ENODEV;
 
 	mutex_lock(&cdev->lock);
-	port_pdev = __dfl_fpga_cdev_find_port(cdev, &port_id,
-					      dfl_fpga_check_port_id);
-	if (!port_pdev)
+	pdata = __dfl_fpga_cdev_find_port_data(cdev, &port_id,
+					       dfl_fpga_check_port_id);
+	if (!pdata)
 		goto unlock_exit;
 
-	if (!device_is_registered(&port_pdev->dev)) {
+	if (!device_is_registered(&pdata->dev->dev)) {
 		ret = -EBUSY;
 		goto put_dev_exit;
 	}
 
-	pdata = dev_get_platdata(&port_pdev->dev);
-
 	mutex_lock(&pdata->lock);
 	ret = dfl_feature_dev_use_begin(pdata, true);
 	mutex_unlock(&pdata->lock);
 	if (ret)
 		goto put_dev_exit;
 
-	platform_device_del(port_pdev);
+	platform_device_del(pdata->dev);
 	cdev->released_port_num++;
 put_dev_exit:
-	put_device(&port_pdev->dev);
+	put_device(&pdata->dev->dev);
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
@@ -1751,33 +1742,30 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_release_port);
 int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
 {
 	struct dfl_feature_platform_data *pdata;
-	struct platform_device *port_pdev;
 	int ret = -ENODEV;
 
 	mutex_lock(&cdev->lock);
-	port_pdev = __dfl_fpga_cdev_find_port(cdev, &port_id,
-					      dfl_fpga_check_port_id);
-	if (!port_pdev)
+	pdata = __dfl_fpga_cdev_find_port_data(cdev, &port_id,
+					       dfl_fpga_check_port_id);
+	if (!pdata)
 		goto unlock_exit;
 
-	if (device_is_registered(&port_pdev->dev)) {
+	if (device_is_registered(&pdata->dev->dev)) {
 		ret = -EBUSY;
 		goto put_dev_exit;
 	}
 
-	ret = platform_device_add(port_pdev);
+	ret = platform_device_add(pdata->dev);
 	if (ret)
 		goto put_dev_exit;
 
-	pdata = dev_get_platdata(&port_pdev->dev);
-
 	mutex_lock(&pdata->lock);
 	dfl_feature_dev_use_end(pdata);
 	mutex_unlock(&pdata->lock);
 
 	cdev->released_port_num--;
 put_dev_exit:
-	put_device(&port_pdev->dev);
+	put_device(&pdata->dev->dev);
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
@@ -1787,10 +1775,11 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_assign_port);
 static void config_port_access_mode(struct device *fme_dev, int port_id,
 				    bool is_vf)
 {
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(fme_dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(fme_dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_PORT_OFST(port_id));
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2285215f444e..8ef9f33e22c1 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -206,6 +206,8 @@
 #define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts num */
 #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
 
+struct dfl_feature_platform_data;
+
 /**
  * struct dfl_fpga_port_ops - port ops
  *
@@ -219,15 +221,15 @@ struct dfl_fpga_port_ops {
 	const char *name;
 	struct module *owner;
 	struct list_head node;
-	int (*get_id)(struct platform_device *pdev);
-	int (*enable_set)(struct platform_device *pdev, bool enable);
+	int (*get_id)(struct dfl_feature_platform_data *pdata);
+	int (*enable_set)(struct dfl_feature_platform_data *pdata, bool enable);
 };
 
 void dfl_fpga_port_ops_add(struct dfl_fpga_port_ops *ops);
 void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops);
-struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device *pdev);
+struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_platform_data *pdata);
 void dfl_fpga_port_ops_put(struct dfl_fpga_port_ops *ops);
-int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
+int dfl_fpga_check_port_id(struct dfl_feature_platform_data *pdata, void *pport_id);
 
 /**
  * struct dfl_feature_id - dfl private feature id
@@ -413,9 +415,8 @@ dfl_fpga_inode_to_feature_dev_data(struct inode *inode)
 	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
 
 static inline
-struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
+struct dfl_feature *dfl_get_feature_by_id(struct dfl_feature_platform_data *pdata, u16 id)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	struct dfl_feature *feature;
 
 	dfl_fpga_dev_for_each_feature(pdata, feature)
@@ -426,9 +427,9 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
 }
 
 static inline
-void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
+void __iomem *dfl_get_feature_ioaddr_by_id(struct dfl_feature_platform_data *pdata, u16 id)
 {
-	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
+	struct dfl_feature *feature = dfl_get_feature_by_id(pdata, id);
 
 	if (feature && feature->ioaddr)
 		return feature->ioaddr;
@@ -527,21 +528,21 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev);
  * device returned by __dfl_fpga_cdev_find_port and dfl_fpga_cdev_find_port
  * functions.
  */
-struct platform_device *
-__dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
-			  int (*match)(struct platform_device *, void *));
+struct dfl_feature_platform_data *
+__dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
+			       int (*match)(struct dfl_feature_platform_data *, void *));
 
-static inline struct platform_device *
-dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
-			int (*match)(struct platform_device *, void *))
+static inline struct dfl_feature_platform_data *
+dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
+			     int (*match)(struct dfl_feature_platform_data *, void *))
 {
-	struct platform_device *pdev;
+	struct dfl_feature_platform_data *pdata;
 
 	mutex_lock(&cdev->lock);
-	pdev = __dfl_fpga_cdev_find_port(cdev, data, match);
+	pdata = __dfl_fpga_cdev_find_port_data(cdev, data, match);
 	mutex_unlock(&cdev->lock);
 
-	return pdev;
+	return pdata;
 }
 
 int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id);
-- 
2.47.0


