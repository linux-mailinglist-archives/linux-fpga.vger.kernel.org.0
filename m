Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22465621728
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 15:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbiKHOpG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 09:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiKHOod (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 09:44:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA176400;
        Tue,  8 Nov 2022 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667918672; x=1699454672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R8VSM/9itvp5kxWxpXkIS/pD4UFexUu9PXtV9Kc9JTo=;
  b=ePYifdz8YpXoCwNXu19uNoFT8OccNRpSKvZvhmyXxxlorpE8JrdBMqtE
   yINc5Z1IzihiAWH3jU3TqOGEJdlCgntcnO6y7KIV3BnuYvXuMv/LHJu45
   9iSjzs+ziQ5kLpVoiSm5K194uvwpEA0nSSSHyix5zxQgySyHniXAz7bhf
   ROvgRrkaioIMjBGcIni1jEelxE+8uhDKsRfMSByI64uXrDQG1osJdt+GQ
   RH9JVUBnj0VVI7kUtA2gofl8Bcu1A/dEjY8hBg5Mu28Kb9pxJHhRarPeu
   9RL2gr02EBvh5+52QZ/nc8aQkePl0F/hEMVBW9S4on70yvR9U99Qt6Avw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312498021"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="312498021"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:44:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="638809931"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="638809931"
Received: from ppkrause-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:44:12 -0800
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
Subject: [PATCH 12/12] mfd: intel-m10-bmc: Change MODULE_LICENSE() to GPL
Date:   Tue,  8 Nov 2022 16:43:05 +0200
Message-Id: <20221108144305.45424-13-ilpo.jarvinen@linux.intel.com>
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
index 4a7a16d9f8d6..6a45b080a208 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -258,5 +258,5 @@ module_spi_driver(intel_m10bmc_spi_driver);
 
 MODULE_DESCRIPTION("Intel MAX 10 BMC SPI bus interface");
 MODULE_AUTHOR("Intel Corporation");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("spi:intel-m10-bmc");
-- 
2.30.2

