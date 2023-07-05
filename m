Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC93747BDB
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 05:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjGEDgT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Jul 2023 23:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGEDgR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Jul 2023 23:36:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE96310D5;
        Tue,  4 Jul 2023 20:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688528176; x=1720064176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=41pwSXKy2GbjS/fl5NCKHCzIRlKAfNX3B77kR9+h2ZM=;
  b=Zc5RwB/kIhmSuxU2Fq6c76IVajhHk0NXndBE5UJpA0uLrYChWsuBUyoj
   pUxAYNr/Iz+CuUtjbBgQWAtwXxoEn+x4RkXLL8JaTxgmugEWEvVdOUDAn
   dbztbZI88lArUgGXudrWkz/lmae1/DWVVR3OcKCoPxlLzsOtalHVdi0HO
   lSsKbRVyxCFPIn0CPfvGdGnZ8yGmxZoWWFMQGREwRMe+UnLQi4wh9Uv5+
   +7+JaFDIP4ZnoMIrxoxvDRmBn6CRYC1pMXofwhklz5fWLoLDxQry/fxO+
   GPUuoFava/oiO7254ruI/gH4sRjkw8KNtThsmdR0It9sfoR3GW/Mksmw2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="366723065"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="366723065"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 20:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="809098517"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="809098517"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 20:36:15 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com, Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH] fpga: dfl: fme: use SI unit prefix macros
Date:   Tue,  4 Jul 2023 23:35:48 -0400
Message-Id: <20230705033548.10737-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Substitute SI prefixes MILLI for temperature and MICRO for power, which
are exported via the hwmon sysfs interface in m°C and ųW, respectively.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/fpga/dfl-fme-main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index bcb5d34b3b82..3dcf990bd261 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
+#include <linux/units.h>
 #include <linux/fpga-dfl.h>
 
 #include "dfl.h"
@@ -231,19 +232,19 @@ static int thermal_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_temp_input:
 		v = readq(feature->ioaddr + FME_THERM_RDSENSOR_FMT1);
-		*val = (long)(FIELD_GET(FPGA_TEMPERATURE, v) * 1000);
+		*val = (long)(FIELD_GET(FPGA_TEMPERATURE, v) * MILLI);
 		break;
 	case hwmon_temp_max:
 		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
-		*val = (long)(FIELD_GET(TEMP_THRESHOLD1, v) * 1000);
+		*val = (long)(FIELD_GET(TEMP_THRESHOLD1, v) * MILLI);
 		break;
 	case hwmon_temp_crit:
 		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
-		*val = (long)(FIELD_GET(TEMP_THRESHOLD2, v) * 1000);
+		*val = (long)(FIELD_GET(TEMP_THRESHOLD2, v) * MILLI);
 		break;
 	case hwmon_temp_emergency:
 		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
-		*val = (long)(FIELD_GET(TRIP_THRESHOLD, v) * 1000);
+		*val = (long)(FIELD_GET(TRIP_THRESHOLD, v) * MILLI);
 		break;
 	case hwmon_temp_max_alarm:
 		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
@@ -382,15 +383,15 @@ static int power_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (attr) {
 	case hwmon_power_input:
 		v = readq(feature->ioaddr + FME_PWR_STATUS);
-		*val = (long)(FIELD_GET(PWR_CONSUMED, v) * 1000000);
+		*val = (long)(FIELD_GET(PWR_CONSUMED, v) * MICRO);
 		break;
 	case hwmon_power_max:
 		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
-		*val = (long)(FIELD_GET(PWR_THRESHOLD1, v) * 1000000);
+		*val = (long)(FIELD_GET(PWR_THRESHOLD1, v) * MICRO);
 		break;
 	case hwmon_power_crit:
 		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
-		*val = (long)(FIELD_GET(PWR_THRESHOLD2, v) * 1000000);
+		*val = (long)(FIELD_GET(PWR_THRESHOLD2, v) * MICRO);
 		break;
 	case hwmon_power_max_alarm:
 		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
@@ -415,7 +416,7 @@ static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 	int ret = 0;
 	u64 v;
 
-	val = clamp_val(val / 1000000, 0, PWR_THRESHOLD_MAX);
+	val = clamp_val(val / MICRO, 0, PWR_THRESHOLD_MAX);
 
 	mutex_lock(&pdata->lock);
 
-- 
2.28.0

