Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2954EF1E
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jun 2022 04:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379605AbiFQCHq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Jun 2022 22:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiFQCHp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 16 Jun 2022 22:07:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A121A393;
        Thu, 16 Jun 2022 19:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655431664; x=1686967664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nphOBXs/+SI9u+eGqjgatvTTn0XBshiwzlb3vatLVc0=;
  b=jUo2M3nzw3QhXp9yf5h64Bf+jj/JkfSUJmpnvo02NlrxjQ3npYPUIvdP
   GGZkawpLs75qIaoWHkmhilOmt2v9R1iRrRbQfSNc/gMmjia1Tqj9QMKn8
   1vRgAZV1UJRro7iqIbuQU/FZsD1NPLNQV1b2J13iYmydc2kNsZU5UcfRM
   AcCksEgPBZNUu/RiqU12cVG7hNZybFpI0MbSwCGrllAMM4vaEvZyOiXt4
   ndsfQ/sDYX9pJWS0RZxPR8i6O79ygEzcVE7I/HDKUyutACFeLTegDgNms
   DQ9jwN+ELAorFm1Y/LuulGQBfE9nz3LGJnqT/+Xywq+QjVl54T/Bjy7Wi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365750322"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365750322"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 19:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831831711"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 19:07:41 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2 1/4] mfd: intel-m10-bmc: rename the local variables
Date:   Thu, 16 Jun 2022 22:04:02 -0400
Message-Id: <20220617020405.128352-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220617020405.128352-1-tianfei.zhang@intel.com>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

It had better use ddata for local variables which
directly interacts with dev_get_drvdata()/dev_set_drvdata().

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/mfd/intel-m10-bmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 8db3bcf5fccc..7e521df29c72 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -86,15 +86,15 @@ static DEVICE_ATTR_RO(bmcfw_version);
 static ssize_t mac_address_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
 	unsigned int macaddr_low, macaddr_high;
 	int ret;
 
-	ret = m10bmc_sys_read(max10, M10BMC_MAC_LOW, &macaddr_low);
+	ret = m10bmc_sys_read(ddata, M10BMC_MAC_LOW, &macaddr_low);
 	if (ret)
 		return ret;
 
-	ret = m10bmc_sys_read(max10, M10BMC_MAC_HIGH, &macaddr_high);
+	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
 	if (ret)
 		return ret;
 
@@ -111,11 +111,11 @@ static DEVICE_ATTR_RO(mac_address);
 static ssize_t mac_count_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
 	unsigned int macaddr_high;
 	int ret;
 
-	ret = m10bmc_sys_read(max10, M10BMC_MAC_HIGH, &macaddr_high);
+	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
 	if (ret)
 		return ret;
 
-- 
2.26.2

