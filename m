Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA476D762E
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Apr 2023 10:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbjDEICT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 04:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbjDEICS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 04:02:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA83C32;
        Wed,  5 Apr 2023 01:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680681737; x=1712217737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BbQrm2hVJXugEoU9akTq2r86Vq3neTtzZG3wnmgyjIk=;
  b=kJ4zBewqi/LvgzEXndVxR4IjtlgOsd9R9PPjRyCkMHimVkCEIJsQg0Er
   1uLG8hkIatGrKrdzyaZJhJ+UpFaAaR7WXlQJl6+tAKQZC1LAC2RVUP5Gg
   MOr7izPHjwh8G6uozC7IrtUS7US4KsAO9yKgDew4BW14NGBjBvv2xw9S7
   cf5sikeAarVlhXpOh5eHnenrRygfJXqtRqnU1U/WQzWLpA5xjWEbu77t7
   HnUJhaG9I4BVDwhn9Wj79Mbsea2NeRqz1Oop5gzWwBfc1iF4yUWaR0j5w
   L9KGw86UVIDG+GMgVe0wZc9BySgnyPZNOmtO0LfuMvTA0MNVTsD9yxxhZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428680216"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428680216"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775959622"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="775959622"
Received: from wtedesch-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.53.134])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:02:04 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/4] mfd: intel-m10-bmc: Move core symbols to own namespace
Date:   Wed,  5 Apr 2023 11:01:49 +0300
Message-Id: <20230405080152.6732-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create INTEL_M10_BMC_CORE namespace for symbols exported by
intel-m10-bmc-core.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc-core.c | 2 +-
 drivers/mfd/intel-m10-bmc-pmci.c | 1 +
 drivers/mfd/intel-m10-bmc-spi.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index dac9cf7bcb4a..b94412813887 100644
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

