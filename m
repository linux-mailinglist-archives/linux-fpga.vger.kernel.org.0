Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2A365646C
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLZR7k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 12:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiLZR7T (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 12:59:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900772643;
        Mon, 26 Dec 2022 09:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672077558; x=1703613558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mFSOsqgSNZDii9PY6hZvi9x/Lr8KAur/Xx++8sMCiWY=;
  b=VLlZMdq8rymgjYT7tTGs8jDkve7OVyI0DvFCrlx7Vk7YT1Y4mVTtQkdM
   SrxPgpPP5a5N/gqy6l+4i35A+GYcxAf9O201/LWOicnbSTPHqGj1Eqd3P
   zGx+shkNpumjgPyM6VqhUYsiYcJM9WYx9Jw1KAsIDhUxMc8IwF4Eik/N6
   Kvm3mnIHeZ06zPqKMFLe18yjZFbCMdhCbdgM5TshTiga1RsAn6WCtz48C
   DPfSEFm/fcS2CaoWB/rFY6O9EA1ABKbcwGhcnZTce9G1JnaB/jxqN9/Bv
   Z+zyInjL0BhpBE5Z7MF+3VynQ84fzk0p480WJ/sl0uiVKO87SMyZ1vl1+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322570971"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="322570971"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:59:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="654810064"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="654810064"
Received: from ptelkov-mobl2.ccr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:59:13 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 02/10] mfd: intel-m10-bmc: Rename the local variables
Date:   Mon, 26 Dec 2022 19:58:41 +0200
Message-Id: <20221226175849.13056-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 12c522c16d83..2c26203c4799 100644
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

