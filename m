Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE7E62171B
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiKHOnm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiKHOnh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 09:43:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6ED2D6;
        Tue,  8 Nov 2022 06:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667918610; x=1699454610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qivsivPDEJsUiYkYuhDs3R/Ifrl+68cqLkvnLoS0vU8=;
  b=nKO3VeL5gr4uOQcFvLbSRRWGWSHBqoQPh5D7IsV02ZXbGB0zQZDLSGFh
   f1dMmZQlWjnnPqZVmwusHtxUzcmWnVEDOwsh71fjO/SYoxUykqcRQq/qT
   EffObFOUnjCch9+bMpb018c4GwXjTSScOJwKjCk0EEwkq8/6drWJLs5D6
   LFBPSQ6bT7dRFaJH7GU6Z3liRbBWNwUPuKgDo9I33ksXRKILuzQe9ixT/
   A9XB1OmKZ+4QCc3f2ai2JN8Yhzgqdx/h57lo2uxfrUu3O+cTmxC3gIADQ
   10VCuLm1d2W2Qhm7EHrkdoTWRn0nFKown9c/zoVqMHRoilM8aHhIrCVEX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="374979568"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="374979568"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:43:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="638809735"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="638809735"
Received: from ppkrause-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:43:27 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/12] mfd: intel-m10-bmc: Rename the local variables
Date:   Tue,  8 Nov 2022 16:42:56 +0200
Message-Id: <20221108144305.45424-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Local variables directly interact with dev_get_drvdata/dev_set_drvdata
should be named ddata.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 762808906380..80487a2f0024 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -81,15 +81,15 @@ static DEVICE_ATTR_RO(bmcfw_version);
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
 
@@ -106,11 +106,11 @@ static DEVICE_ATTR_RO(mac_address);
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
2.30.2

