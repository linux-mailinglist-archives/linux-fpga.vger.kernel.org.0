Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B919B62171C
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiKHOnh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 09:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiKHOne (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 09:43:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6162616;
        Tue,  8 Nov 2022 06:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667918606; x=1699454606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g58/NBfybf+Ooyq7bad7n2jpBnL5AIXlfiOhy2MhRp0=;
  b=KFi0UzjjMHMW0h3GSrdcYBqtGaGOjCPxcPUe9RYYpVKF2k0ltHVNpcKC
   8IoiO2DKvMUuk1f9ZsdW+yGuVZqV0EnGlJRFZbd0DpKUE+aVZFBUdzoc+
   F1orSLo/bJ3gm9FfVknPMWPB7ZcUUJGtO7k6JHVlyO21mfHTwFaWygYr2
   4hmJ7w0JjuIk9c2Q/o6/uh7sUvvwuGyPFOEszsoDNUQ5Rwfya612uhizb
   c8UIPcor2QTEitaU0LGCKurd5ZKv6p1UENGZ4AKryDazV2kT0jl8Nft4k
   DfwX8B9ZLY2KJlJbWx/Gi/aysxokevxEZ00eqVm4haPkADRx0Ye8wDh5u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="374979553"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208,146";a="374979553"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:43:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="638809711"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208,146";a="638809711"
Received: from ppkrause-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:43:22 -0800
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
Subject: [PATCH 02/12] mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
Date:   Tue,  8 Nov 2022 16:42:55 +0200
Message-Id: <20221108144305.45424-3-ilpo.jarvinen@linux.intel.com>
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

BMC type specific info is currently set by a switch/case block. The
size of this info is expected to grow as more dev types and features
are added which would have made the switch block bloaty.

Store type specific info into struct and place them into .driver_data
instead because it makes things a bit cleaner.

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc.c       | 50 +++++++++++++++++--------------
 include/linux/mfd/intel-m10-bmc.h | 14 +++++++++
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index ee167c5dcd29..762808906380 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -156,15 +156,17 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
 static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct intel_m10bmc_platform_info *info;
 	struct device *dev = &spi->dev;
-	struct mfd_cell *cells;
 	struct intel_m10bmc *ddata;
-	int ret, n_cell;
+	int ret;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
+	info = (struct intel_m10bmc_platform_info *)id->driver_data;
+	ddata->info = info;
 	ddata->dev = dev;
 
 	ddata->regmap =
@@ -183,24 +185,8 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	switch (id->driver_data) {
-	case M10_N3000:
-		cells = m10bmc_pacn3000_subdevs;
-		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
-		break;
-	case M10_D5005:
-		cells = m10bmc_d5005_subdevs;
-		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
-		break;
-	case M10_N5010:
-		cells = m10bmc_n5010_subdevs;
-		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+				   info->cells, info->n_cells,
 				   NULL, 0, NULL);
 	if (ret)
 		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
@@ -208,10 +194,28 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
+static const struct intel_m10bmc_platform_info m10bmc_m10_n3000 = {
+	.type = M10_N3000,
+	.cells = m10bmc_pacn3000_subdevs,
+	.n_cells = ARRAY_SIZE(m10bmc_pacn3000_subdevs),
+};
+
+static const struct intel_m10bmc_platform_info m10bmc_m10_d5005 = {
+	.type = M10_D5005,
+	.cells = m10bmc_d5005_subdevs,
+	.n_cells = ARRAY_SIZE(m10bmc_d5005_subdevs),
+};
+
+static const struct intel_m10bmc_platform_info m10bmc_m10_n5010 = {
+	.type = M10_N5010,
+	.cells = m10bmc_n5010_subdevs,
+	.n_cells = ARRAY_SIZE(m10bmc_n5010_subdevs),
+};
+
 static const struct spi_device_id m10bmc_spi_id[] = {
-	{ "m10-n3000", M10_N3000 },
-	{ "m10-d5005", M10_D5005 },
-	{ "m10-n5010", M10_N5010 },
+	{ "m10-n3000", (kernel_ulong_t)&m10bmc_m10_n3000 },
+	{ "m10-d5005", (kernel_ulong_t)&m10bmc_m10_d5005 },
+	{ "m10-n5010", (kernel_ulong_t)&m10bmc_m10_n5010 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index d77383a8a410..e58115f514b9 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -124,14 +124,28 @@ enum m10bmc_type {
 /* Address of 4KB inverted bit vector containing staging area FLASH count */
 #define STAGING_FLASH_COUNT	0x17ffb000
 
+/**
+ * struct intel_m10bmc_platform_info - Intel MAX 10 BMC platform specific information
+ * @type: the type of MAX10 BMC
+ * @cells: MFD cells
+ * @n_cells: MFD cells ARRAY_SIZE()
+ */
+struct intel_m10bmc_platform_info {
+	enum m10bmc_type type;
+	struct mfd_cell *cells;
+	int n_cells;
+};
+
 /**
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
  * @regmap: the regmap used to access registers by m10bmc itself
+ * @info: the platform information for MAX10 BMC
  */
 struct intel_m10bmc {
 	struct device *dev;
 	struct regmap *regmap;
+	const struct intel_m10bmc_platform_info *info;
 };
 
 /*
-- 
2.30.2

