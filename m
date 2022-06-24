Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53DC559693
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jun 2022 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiFXJ0Z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Jun 2022 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiFXJ0X (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Jun 2022 05:26:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3261377044;
        Fri, 24 Jun 2022 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656062779; x=1687598779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v5bfWTJCoo5BBPZT3CLaQHxq1vNHu4D3VcxL1e2EOtI=;
  b=XyABwVWu1TKzL7CjEQsr3vq6eZToWopctbXyD7A3IuIQ/sk78TUN1TyY
   4IWWGmDXXlag1/BUXNHnC5MlCqiG9BT7Rb8ext54WtDslqw0yrZAxArUX
   /xBY5uEhJQa1v3vuBTRchFzlKZThieuIHcyq8vjmE62OZJp25DeA53TuW
   WFjPo8tGNVx9NJHwkcWlzCv00D7hBB0SrPw78m+7x1xsf7FGG5erqtwyM
   DPkSwNkAbLt72HvOz32tG8k55Uy3w9PRMEhqKkZrV89YRsYVVnj5toKgp
   PD9kmGt6Pw5IM1BoeP1Hi5ap8ymBW1rneAeBJQkzePGpsXZyRNMtdFmDJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261389200"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="261389200"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 02:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="691454982"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2022 02:26:16 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3 3/3] mfd: intel-m10-bmc: support different BMC base register address
Date:   Fri, 24 Jun 2022 05:22:29 -0400
Message-Id: <20220624092229.45854-4-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220624092229.45854-1-tianfei.zhang@intel.com>
References: <20220624092229.45854-1-tianfei.zhang@intel.com>
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

There are different base addresses for the MAX10 CSR registers.
Introducing a new member "base" in intel_m10bmc data structure
to support different BMC base register addresses.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
v3:
 - use a new member "base" instead of m10bmc_csr data structure.
---
 drivers/mfd/intel-m10-bmc-pmci.c  | 1 +
 drivers/mfd/intel-m10-bmc.c       | 1 +
 include/linux/mfd/intel-m10-bmc.h | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
index 93eca4483ac7..26eeda9720dc 100644
--- a/drivers/mfd/intel-m10-bmc-pmci.c
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -221,6 +221,7 @@ static int pmci_probe(struct dfl_device *ddev)
 		return -ENOMEM;
 
 	pmci->m10bmc.dev = dev;
+	pmci->m10bmc.base = M10BMC_PMCI_SYS_BASE;
 	pmci->dev = dev;
 
 	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 7e521df29c72..f4cb67629404 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -171,6 +171,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	ddata->dev = dev;
+	ddata->base = M10BMC_SYS_BASE;
 
 	ddata->regmap =
 		devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 7b58af207b72..0c81dbcdc3dc 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -130,10 +130,12 @@
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
  * @regmap: the regmap used to access registers by m10bmc itself
+ * @base: the base address of MAX10 BMC registers
  */
 struct intel_m10bmc {
 	struct device *dev;
 	struct regmap *regmap;
+	unsigned int base;
 };
 
 /*
@@ -165,6 +167,6 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
  * M10BMC_SYS_BASE accordingly.
  */
 #define m10bmc_sys_read(m10bmc, offset, val) \
-	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
+	m10bmc_raw_read(m10bmc, (m10bmc)->base + (offset), val)
 
 #endif /* __MFD_INTEL_M10_BMC_H */
-- 
2.26.2

