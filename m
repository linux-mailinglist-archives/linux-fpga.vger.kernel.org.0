Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20453F48D
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jun 2022 05:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiFGDcI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 6 Jun 2022 23:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFGDcG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 6 Jun 2022 23:32:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5151445782;
        Mon,  6 Jun 2022 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654572725; x=1686108725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nphOBXs/+SI9u+eGqjgatvTTn0XBshiwzlb3vatLVc0=;
  b=F+z/Vt0JlYEkLLZPyOzvANMh2JdToFOz1Mv/Hi2q2L86FP6cFTth+H7w
   7H4zjlXgoR0UuMbLlL0AWtWCyaxfWv4VdS5rf6psp7okmEjJ5F7A9bcyA
   W4DYDWIXHktgelLROG7Vjfs6WYchdYLUkJEpZGxWl1/FlXddfSuNqlpvE
   tNJUrECkL3O2eUH4NNlne+vMa0/kSjbdjBVSVuZEb8cpdetRda7pQlQlr
   PVZPpRiNAwrYfqSptmDrUbL/HUYem0XIBkpQxoqj+OycegHoTBqDpCwgL
   D1R21y9R4z7E+xpNUtMtM1oRn9yGG1eVV+MdYOrIcu/cN+WXXd54ptPtL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="337908379"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="337908379"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 20:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="826161222"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2022 20:32:02 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 1/4] mfd: intel-m10-bmc: rename the local variables
Date:   Mon,  6 Jun 2022 23:28:30 -0400
Message-Id: <20220607032833.3482-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220607032833.3482-1-tianfei.zhang@intel.com>
References: <20220607032833.3482-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

