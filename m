Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14BA62DA55
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Nov 2022 13:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbiKQMJX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Nov 2022 07:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbiKQMHv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Nov 2022 07:07:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8000570187;
        Thu, 17 Nov 2022 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668686870; x=1700222870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khLVRLYXYH/ezhU5wlbHnIyoJyTr5yi1lolOdkUJ53A=;
  b=VhY+pBaZ8BGtS111x070qJ02QMgefxpjVaf0sFQ16OxzdWAgVqgg+xHr
   wIpp4cjibtW7z7ghZpENkd9KYORKolA4Z3F/B9poO0ddT+jimCjSMpMnq
   mJ8pTEDnxQIGYDwHYeQKajF2jgnaT03tiwsAuiCA8uxSqHMDBCL8SXBYu
   sKnTDBTUypOEnIlukhHP6e+E38j4YyPT+9al/SYPhi95Tdkzi52rFFued
   G/g1xw1qWXc4fZedBgAxOk8XtYIsz7UvbyUhjHK2oBn60riDQgQ0dQCsu
   8ldWlOukd6josC0MU4APU0pfCwDIk4z7ghT/mcD1QBvWqwRgmoHl8EDVo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314648936"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314648936"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968855971"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968855971"
Received: from kvehmane-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.61.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:44 -0800
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
Subject: [PATCH v2 11/11] mfd: intel-m10-bmc: Change MODULE_LICENSE() to GPL
Date:   Thu, 17 Nov 2022 14:05:15 +0200
Message-Id: <20221117120515.37807-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
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

"GPL v2" should not be used as MODULE_LICENSE(). "GPL" is enough, see
commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL
v2" bogosity") for more details.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc-core.c | 2 +-
 drivers/mfd/intel-m10-bmc-spi.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index 50a4ec758bdb..3b9e866b2bcf 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -130,4 +130,4 @@ EXPORT_SYMBOL_GPL(m10bmc_dev_init);
 
 MODULE_DESCRIPTION("Intel MAX 10 BMC core MFD driver");
 MODULE_AUTHOR("Intel Corporation");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index a17a0b50f352..1173f35cfcaa 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -266,5 +266,5 @@ module_spi_driver(intel_m10bmc_spi_driver);
 
 MODULE_DESCRIPTION("Intel MAX 10 BMC SPI bus interface");
 MODULE_AUTHOR("Intel Corporation");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("spi:intel-m10-bmc");
-- 
2.30.2

