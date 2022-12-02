Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C08640437
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Dec 2022 11:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiLBKJP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Dec 2022 05:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiLBKJH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Dec 2022 05:09:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A06CCEEB;
        Fri,  2 Dec 2022 02:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669975746; x=1701511746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F6zWASVpJF1rSsxD/df+vQjBNXxQMazvDrkx5nubrOo=;
  b=P0AOLM+l0wveB4kj5jCzU8PBN7edHvYFSgy+JQOQ5dWH3/BET7Cvu5kP
   Ar4QkVbHBDf3l23YHpH3sDXRwJLZ20B4mRLhdYOxKNLJe6KfFuxbAItkV
   3KB31xp70fqnaduAIDaSrKKXWiATiaui3neBJPjEXYTkdPVlrZKAXX/bf
   XHZD0YoinGplTj6O0+fuBok0x+7i7CUrTea9r73bDVA9jQtbu1bYgybol
   ncmqnsdzBocZq2A3URqjCp1KEfUaFjDZWUTCGGJ7hjk2p4PJW+f42D5SP
   ArRFiMjPFNVES9M4WJjnoLvxDTnKf5GmoXwIYHq0UrRNMlRoFwy2wdWtn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342859663"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="342859663"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 02:09:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="622649482"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="622649482"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 02:08:57 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/9] mfd: intel-m10-bmc: Rename the local variables
Date:   Fri,  2 Dec 2022 12:08:34 +0200
Message-Id: <20221202100841.4741-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

