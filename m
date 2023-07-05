Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43555747BA2
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 04:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGECzO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Jul 2023 22:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjGECzN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Jul 2023 22:55:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3351910F8;
        Tue,  4 Jul 2023 19:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688525712; x=1720061712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5WC8P8GcGa8BS4IN/OSHf+dk5rOPXZjdNP6PUxd+4rk=;
  b=d/EnqWuDgfLGnvnBAsx1N78FvmMVPmyGZS4L8ngFcJHFb1IJw5y9lpCQ
   IUAbN+7mycpurwKTYl1Ud2QTBjYzSEyy16VJoQchYwv2MSRE9JwcYleP0
   18ad0Jcl9+zrw5gK9H+Gn4M2bxstu1KRgc/YHqKHvOt50LObVOY6lrJdj
   PnvZrDF4g3m7wfbud05WiN2CvPaxIiFPLjZXdsVAv9hArI5ESGdpzyT0f
   H80JK71h28fpRAHEfiRNCoPFf9ysSzDsWARzlTtcYIqgUYvb2lhg4i5xm
   PqKZ+n4/hg5I5FGqqTJ4tMltU8DDuH4/e2JN5XnawLc71rsSeRa5X79q2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="343567176"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="343567176"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 19:55:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="754206077"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="754206077"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 19:55:11 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com, Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH 1/2] fpga: dfl: use sysfs_emit() to format sysfs values
Date:   Tue,  4 Jul 2023 22:54:50 -0400
Message-Id: <a80ad13ad82ff294e706bb87e5b62793c5d195f5.1687301688.git.peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1687301688.git.peter.colberg@intel.com>
References: <cover.1687301688.git.peter.colberg@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Use sysfs_emit() to format sysfs values, which wraps vscnprintf() for a
PAGE_SIZE buffer. Remove explicit casts in favour of using the printk()
format specifier corresponding to the type of the formatted value.

These changes are cosmetic only; no functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/fpga/dfl-afu-error.c |  7 +++----
 drivers/fpga/dfl-afu-main.c  | 17 ++++++++---------
 drivers/fpga/dfl-fme-error.c | 19 ++++++++-----------
 drivers/fpga/dfl-fme-main.c  | 26 ++++++++++----------------
 drivers/fpga/dfl-fme-perf.c  | 16 +++++++---------
 drivers/fpga/dfl.c           |  4 ++--
 drivers/fpga/fpga-bridge.c   |  2 +-
 drivers/fpga/fpga-mgr.c      |  4 ++--
 drivers/fpga/fpga-region.c   |  5 ++---
 9 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index ab7be6217368..6d113d606560 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -125,7 +125,7 @@ static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
 	error = readq(base + PORT_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
+	return sysfs_emit(buf, "0x%llx\n", error);
 }
 
 static ssize_t errors_store(struct device *dev, struct device_attribute *attr,
@@ -156,7 +156,7 @@ static ssize_t first_error_show(struct device *dev,
 	error = readq(base + PORT_FIRST_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
+	return sysfs_emit(buf, "0x%llx\n", error);
 }
 static DEVICE_ATTR_RO(first_error);
 
@@ -175,8 +175,7 @@ static ssize_t first_malformed_req_show(struct device *dev,
 	req1 = readq(base + PORT_MALFORMED_REQ1);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%016llx%016llx\n",
-		       (unsigned long long)req1, (unsigned long long)req0);
+	return sysfs_emit(buf, "0x%016llx%016llx\n", req1, req0);
 }
 static DEVICE_ATTR_RO(first_malformed_req);
 
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7f621e96d3b8..51fdbe8a2f26 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -155,7 +155,7 @@ id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int id = port_get_id(to_platform_device(dev));
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
+	return sysfs_emit(buf, "%d\n", id);
 }
 static DEVICE_ATTR_RO(id);
 
@@ -172,7 +172,7 @@ ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
 	v = readq(base + PORT_HDR_CTRL);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_CTRL_LATENCY, v));
+	return sysfs_emit(buf, "%llx\n", FIELD_GET(PORT_CTRL_LATENCY, v));
 }
 
 static ssize_t
@@ -213,7 +213,7 @@ ap1_event_show(struct device *dev, struct device_attribute *attr, char *buf)
 	v = readq(base + PORT_HDR_STS);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP1_EVT, v));
+	return sysfs_emit(buf, "%llx\n", FIELD_GET(PORT_STS_AP1_EVT, v));
 }
 
 static ssize_t
@@ -251,7 +251,7 @@ ap2_event_show(struct device *dev, struct device_attribute *attr,
 	v = readq(base + PORT_HDR_STS);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP2_EVT, v));
+	return sysfs_emit(buf, "%llx\n", FIELD_GET(PORT_STS_AP2_EVT, v));
 }
 
 static ssize_t
@@ -288,7 +288,7 @@ power_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 	v = readq(base + PORT_HDR_STS);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%x\n", (u8)FIELD_GET(PORT_STS_PWR_STATE, v));
+	return sysfs_emit(buf, "0x%llx\n", FIELD_GET(PORT_STS_PWR_STATE, v));
 }
 static DEVICE_ATTR_RO(power_state);
 
@@ -348,7 +348,7 @@ userclk_freqsts_show(struct device *dev, struct device_attribute *attr,
 	userclk_freqsts = readq(base + PORT_HDR_USRCLK_STS0);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)userclk_freqsts);
+	return sysfs_emit(buf, "0x%llx\n", userclk_freqsts);
 }
 static DEVICE_ATTR_RO(userclk_freqsts);
 
@@ -366,8 +366,7 @@ userclk_freqcntrsts_show(struct device *dev, struct device_attribute *attr,
 	userclk_freqcntrsts = readq(base + PORT_HDR_USRCLK_STS1);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n",
-		       (unsigned long long)userclk_freqcntrsts);
+	return sysfs_emit(buf, "0x%llx\n", userclk_freqcntrsts);
 }
 static DEVICE_ATTR_RO(userclk_freqcntrsts);
 
@@ -472,7 +471,7 @@ afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 	guidh = readq(base + GUID_H);
 	mutex_unlock(&pdata->lock);
 
-	return scnprintf(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
+	return sysfs_emit(buf, "%016llx%016llx\n", guidh, guidl);
 }
 static DEVICE_ATTR_RO(afu_id);
 
diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
index 51c2892ec06d..a570f294ad82 100644
--- a/drivers/fpga/dfl-fme-error.c
+++ b/drivers/fpga/dfl-fme-error.c
@@ -52,7 +52,7 @@ static ssize_t pcie0_errors_show(struct device *dev,
 	value = readq(base + PCIE0_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+	return sysfs_emit(buf, "0x%llx\n", value);
 }
 
 static ssize_t pcie0_errors_store(struct device *dev,
@@ -97,7 +97,7 @@ static ssize_t pcie1_errors_show(struct device *dev,
 	value = readq(base + PCIE1_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+	return sysfs_emit(buf, "0x%llx\n", value);
 }
 
 static ssize_t pcie1_errors_store(struct device *dev,
@@ -136,8 +136,7 @@ static ssize_t nonfatal_errors_show(struct device *dev,
 
 	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
 
-	return sprintf(buf, "0x%llx\n",
-		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
+	return sysfs_emit(buf, "0x%llx\n", readq(base + RAS_NONFAT_ERROR));
 }
 static DEVICE_ATTR_RO(nonfatal_errors);
 
@@ -148,8 +147,7 @@ static ssize_t catfatal_errors_show(struct device *dev,
 
 	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
 
-	return sprintf(buf, "0x%llx\n",
-		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
+	return sysfs_emit(buf, "0x%llx\n", readq(base + RAS_CATFAT_ERROR));
 }
 static DEVICE_ATTR_RO(catfatal_errors);
 
@@ -166,8 +164,7 @@ static ssize_t inject_errors_show(struct device *dev,
 	v = readq(base + RAS_ERROR_INJECT);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n",
-		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
+	return sysfs_emit(buf, "0x%llx\n", FIELD_GET(INJECT_ERROR_MASK, v));
 }
 
 static ssize_t inject_errors_store(struct device *dev,
@@ -211,7 +208,7 @@ static ssize_t fme_errors_show(struct device *dev,
 	value = readq(base + FME_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+	return sysfs_emit(buf, "0x%llx\n", value);
 }
 
 static ssize_t fme_errors_store(struct device *dev,
@@ -258,7 +255,7 @@ static ssize_t first_error_show(struct device *dev,
 	value = readq(base + FME_FIRST_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+	return sysfs_emit(buf, "0x%llx\n", value);
 }
 static DEVICE_ATTR_RO(first_error);
 
@@ -275,7 +272,7 @@ static ssize_t next_error_show(struct device *dev,
 	value = readq(base + FME_NEXT_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+	return sysfs_emit(buf, "0x%llx\n", value);
 }
 static DEVICE_ATTR_RO(next_error);
 
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index bcb5d34b3b82..3b2ad31edf87 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -34,8 +34,7 @@ static ssize_t ports_num_show(struct device *dev,
 
 	v = readq(base + FME_HDR_CAP);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 (unsigned int)FIELD_GET(FME_CAP_NUM_PORTS, v));
+	return sysfs_emit(buf, "%llu\n", FIELD_GET(FME_CAP_NUM_PORTS, v));
 }
 static DEVICE_ATTR_RO(ports_num);
 
@@ -53,7 +52,7 @@ static ssize_t bitstream_id_show(struct device *dev,
 
 	v = readq(base + FME_HDR_BITSTREAM_ID);
 
-	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+	return sysfs_emit(buf, "0x%llx\n", v);
 }
 static DEVICE_ATTR_RO(bitstream_id);
 
@@ -71,7 +70,7 @@ static ssize_t bitstream_metadata_show(struct device *dev,
 
 	v = readq(base + FME_HDR_BITSTREAM_MD);
 
-	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+	return sysfs_emit(buf, "0x%llx\n", v);
 }
 static DEVICE_ATTR_RO(bitstream_metadata);
 
@@ -85,8 +84,7 @@ static ssize_t cache_size_show(struct device *dev,
 
 	v = readq(base + FME_HDR_CAP);
 
-	return sprintf(buf, "%u\n",
-		       (unsigned int)FIELD_GET(FME_CAP_CACHE_SIZE, v));
+	return sysfs_emit(buf, "%llu\n", FIELD_GET(FME_CAP_CACHE_SIZE, v));
 }
 static DEVICE_ATTR_RO(cache_size);
 
@@ -100,8 +98,7 @@ static ssize_t fabric_version_show(struct device *dev,
 
 	v = readq(base + FME_HDR_CAP);
 
-	return sprintf(buf, "%u\n",
-		       (unsigned int)FIELD_GET(FME_CAP_FABRIC_VERID, v));
+	return sysfs_emit(buf, "%llu\n", FIELD_GET(FME_CAP_FABRIC_VERID, v));
 }
 static DEVICE_ATTR_RO(fabric_version);
 
@@ -115,8 +112,7 @@ static ssize_t socket_id_show(struct device *dev,
 
 	v = readq(base + FME_HDR_CAP);
 
-	return sprintf(buf, "%u\n",
-		       (unsigned int)FIELD_GET(FME_CAP_SOCKET_ID, v));
+	return sysfs_emit(buf, "%llu\n", FIELD_GET(FME_CAP_SOCKET_ID, v));
 }
 static DEVICE_ATTR_RO(socket_id);
 
@@ -285,8 +281,7 @@ static ssize_t temp1_max_policy_show(struct device *dev,
 
 	v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
 
-	return sprintf(buf, "%u\n",
-		       (unsigned int)FIELD_GET(TEMP_THRESHOLD1_POLICY, v));
+	return sysfs_emit(buf, "%llu\n", FIELD_GET(TEMP_THRESHOLD1_POLICY, v));
 }
 
 static DEVICE_ATTR_RO(temp1_max_policy);
@@ -489,7 +484,7 @@ static ssize_t power1_xeon_limit_show(struct device *dev,
 	if (FIELD_GET(XEON_PWR_EN, v))
 		xeon_limit = FIELD_GET(XEON_PWR_LIMIT, v);
 
-	return sprintf(buf, "%u\n", xeon_limit * 100000);
+	return sysfs_emit(buf, "%u\n", xeon_limit * 100000);
 }
 
 static ssize_t power1_fpga_limit_show(struct device *dev,
@@ -504,7 +499,7 @@ static ssize_t power1_fpga_limit_show(struct device *dev,
 	if (FIELD_GET(FPGA_PWR_EN, v))
 		fpga_limit = FIELD_GET(FPGA_PWR_LIMIT, v);
 
-	return sprintf(buf, "%u\n", fpga_limit * 100000);
+	return sysfs_emit(buf, "%u\n", fpga_limit * 100000);
 }
 
 static ssize_t power1_ltr_show(struct device *dev,
@@ -515,8 +510,7 @@ static ssize_t power1_ltr_show(struct device *dev,
 
 	v = readq(feature->ioaddr + FME_PWR_STATUS);
 
-	return sprintf(buf, "%u\n",
-		       (unsigned int)FIELD_GET(FME_LATENCY_TOLERANCE, v));
+	return sysfs_emit(buf, "%llu\n", FIELD_GET(FME_LATENCY_TOLERANCE, v));
 }
 
 static DEVICE_ATTR_RO(power1_xeon_limit);
diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6f37..1b072416069b 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -524,20 +524,18 @@ static ssize_t fme_perf_event_show(struct device *dev,
 {
 	struct dev_ext_attribute *eattr;
 	unsigned long config;
-	char *ptr = buf;
 
 	eattr = container_of(attr, struct dev_ext_attribute, attr);
 	config = (unsigned long)eattr->var;
 
-	ptr += sprintf(ptr, "event=0x%02x", (unsigned int)get_event(config));
-	ptr += sprintf(ptr, ",evtype=0x%02x", (unsigned int)get_evtype(config));
+	if (!is_portid_root(get_portid(config)))
+		return sysfs_emit(buf,
+				  "event=0x%02llx,evtype=0x%02llx,portid=?\n",
+				  get_event(config), get_evtype(config));
 
-	if (is_portid_root(get_portid(config)))
-		ptr += sprintf(ptr, ",portid=0x%02x\n", FME_PORTID_ROOT);
-	else
-		ptr += sprintf(ptr, ",portid=?\n");
-
-	return (ssize_t)(ptr - buf);
+	return sysfs_emit(buf, "event=0x%02llx,evtype=0x%02llx,portid=0x%02x\n",
+			  get_event(config), get_evtype(config),
+			  FME_PORTID_ROOT);
 }
 
 #define FME_EVENT_ATTR(_name) \
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index dd7a783d53b5..db8141b68f79 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -307,7 +307,7 @@ type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dfl_device *ddev = to_dfl_dev(dev);
 
-	return sprintf(buf, "0x%x\n", ddev->type);
+	return sysfs_emit(buf, "0x%x\n", ddev->type);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -316,7 +316,7 @@ feature_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dfl_device *ddev = to_dfl_dev(dev);
 
-	return sprintf(buf, "0x%x\n", ddev->feature_id);
+	return sysfs_emit(buf, "0x%x\n", ddev->feature_id);
 }
 static DEVICE_ATTR_RO(feature_id);
 
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a6c25dee9cc1..9b88c18cc126 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -286,7 +286,7 @@ static ssize_t name_show(struct device *dev,
 {
 	struct fpga_bridge *bridge = to_fpga_bridge(dev);
 
-	return sprintf(buf, "%s\n", bridge->name);
+	return sysfs_emit(buf, "%s\n", bridge->name);
 }
 
 static ssize_t state_show(struct device *dev,
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index eb583f86a0b9..b3991f921312 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -618,7 +618,7 @@ static ssize_t name_show(struct device *dev,
 {
 	struct fpga_manager *mgr = to_fpga_manager(dev);
 
-	return sprintf(buf, "%s\n", mgr->name);
+	return sysfs_emit(buf, "%s\n", mgr->name);
 }
 
 static ssize_t state_show(struct device *dev,
@@ -626,7 +626,7 @@ static ssize_t state_show(struct device *dev,
 {
 	struct fpga_manager *mgr = to_fpga_manager(dev);
 
-	return sprintf(buf, "%s\n", state_str[mgr->state]);
+	return sysfs_emit(buf, "%s\n", state_str[mgr->state]);
 }
 
 static ssize_t status_show(struct device *dev,
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index ccf6fdab1360..7a3572b78f50 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -166,9 +166,8 @@ static ssize_t compat_id_show(struct device *dev,
 	if (!region->compat_id)
 		return -ENOENT;
 
-	return sprintf(buf, "%016llx%016llx\n",
-		       (unsigned long long)region->compat_id->id_h,
-		       (unsigned long long)region->compat_id->id_l);
+	return sysfs_emit(buf, "%016llx%016llx\n", region->compat_id->id_h,
+			  region->compat_id->id_l);
 }
 
 static DEVICE_ATTR_RO(compat_id);
-- 
2.28.0

