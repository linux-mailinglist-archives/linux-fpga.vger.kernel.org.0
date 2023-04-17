Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136D16E4379
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 11:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjDQJRB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjDQJQ7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 05:16:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833644B2;
        Mon, 17 Apr 2023 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681723009; x=1713259009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gSWgvhKHipiuGz7qDqL6C+EWFt45sA4BpV/ijn37ytQ=;
  b=iT4xAs7b3bOjSZpFjxShUhE4DbbEVVb9VOAJAKkB3x6SacPkwNHtkbJ6
   OfGHUN2dkBM9qyFmURUF4iBCBW1EOPnC7V8o+I0NYjPznEYWKMPiKuykm
   D8LXjR/PSNqNVr28j7cIwJ4BgIdOhwnxPjwZd6ZWr2PzdgxZ5fOQ+7NwU
   nyVKlcpMr3CPrBvfdSRkNuv5p7EonAeRNuf2z2OAmEd4lFZgx2nJnKuuz
   8XyipFwUhgkE8aQ70diZ5yDM4JH3YqygRbiH7xR1++McBBh0wf3hvQEvE
   TPUSp7HneZu+RLISRseoGKTmsLSkok8ihQf6CTm8WL7d38ROTAu4TFld8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="342338703"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="342338703"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="690595484"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="690595484"
Received: from anicosix-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.35.34])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:16:39 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/4] mfd: intel-m10-bmc: Move core symbols to own namespace
Date:   Mon, 17 Apr 2023 12:16:16 +0300
Message-Id: <20230417091619.14134-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230417091619.14134-1-ilpo.jarvinen@linux.intel.com>
References: <20230417091619.14134-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create INTEL_M10_BMC_CORE namespace for symbols exported by
intel-m10-bmc-core.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc-core.c | 4 ++--
 drivers/mfd/intel-m10-bmc-pmci.c | 1 +
 drivers/mfd/intel-m10-bmc-spi.c  | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index dac9cf7bcb4a..c0b8209fd842 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -98,7 +98,7 @@ const struct attribute_group *m10bmc_dev_groups[] = {
 	&m10bmc_group,
 	NULL,
 };
-EXPORT_SYMBOL_GPL(m10bmc_dev_groups);
+EXPORT_SYMBOL_NS_GPL(m10bmc_dev_groups, INTEL_M10_BMC_CORE);
 
 int m10bmc_dev_init(struct intel_m10bmc *m10bmc, const struct intel_m10bmc_platform_info *info)
 {
@@ -115,7 +115,7 @@ int m10bmc_dev_init(struct intel_m10bmc *m10bmc, const struct intel_m10bmc_platf
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(m10bmc_dev_init);
+EXPORT_SYMBOL_NS_GPL(m10bmc_dev_init, INTEL_M10_BMC_CORE);
 
 MODULE_DESCRIPTION("Intel MAX 10 BMC core driver");
 MODULE_AUTHOR("Intel Corporation");
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
index 8821f1876dd6..0392ef8b57d8 100644
--- a/drivers/mfd/intel-m10-bmc-pmci.c
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -453,3 +453,4 @@ module_dfl_driver(m10bmc_pmci_driver);
 MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index 957200e17fed..edd266557ab9 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -166,3 +166,4 @@ MODULE_DESCRIPTION("Intel MAX 10 BMC SPI bus interface");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("spi:intel-m10-bmc");
+MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);
-- 
2.30.2

