Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE657640431
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Dec 2022 11:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiLBKJB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Dec 2022 05:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiLBKI5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Dec 2022 05:08:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAFBCCECF;
        Fri,  2 Dec 2022 02:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669975736; x=1701511736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i+se1vuA+3GG0eId+7rBECuN3TLOkAv1bHjo/nViMo4=;
  b=cD0NnRf5O7OVkU86uB5Ic1J6TBpeBR8uz5yoaU/lTpvpeAw4/8PUJ67N
   d9suy1mcupnmUQnQ9ygezk9ntNB0f4+/ZgsseVhCcA2w+Aw+Gx/4PmTOn
   fJjErMs/YfL9t7Tj8Y6tIZ1R5fR0EQka6FwEkX1qzuKip9yWZCUON4S2T
   myqIEs9rzBBU9zQOgn83QVBOEs3C0rxOi68JMaU0AnTnZ84m4ZKG8vPsY
   UVKRkWatylFpfU66znzGqoAZybb6y1+1zdIVXdCMqa4Uj6xAQoYytIBAa
   7vp5f6ZW/RcQmEe6F4JL1DTPAB2s4Lnj6nNvHMFdj00uicNGvghRKhGvX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342859653"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208,146";a="342859653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 02:08:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="622649470"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208,146";a="622649470"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 02:08:52 -0800
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
Subject: [PATCH v3 1/9] mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
Date:   Fri,  2 Dec 2022 12:08:33 +0200
Message-Id: <20221202100841.4741-2-ilpo.jarvinen@linux.intel.com>
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

BMC type specific info is currently set by a switch/case block. The
size of this info is expected to grow as more dev types and features
are added which would have made the switch block bloaty.

Store type specific info into struct and place them into .driver_data
instead because it makes things a bit cleaner.

The m10bmc_type enum can be dropped as the differentiation is now
fully handled by the platform info.

The info member of struct intel_m10bmc that is added here is not used
yet in this change but its addition logically still belongs to this
change. The CSR map change that comes after this change needs to have
the info member.

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-m10-bmc.c       | 53 ++++++++++++++-----------------
 include/linux/mfd/intel-m10-bmc.h | 12 +++++++
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 7e3319e5b22f..12c522c16d83 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -13,12 +13,6 @@
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
-enum m10bmc_type {
-	M10_N3000,
-	M10_D5005,
-	M10_N5010,
-};
-
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
 	{ .name = "d5005bmc-hwmon" },
 	{ .name = "d5005bmc-sec-update" }
@@ -162,15 +156,17 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
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
@@ -189,24 +185,8 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
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
@@ -214,10 +194,25 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
+static const struct intel_m10bmc_platform_info m10bmc_spi_n3000 = {
+	.cells = m10bmc_pacn3000_subdevs,
+	.n_cells = ARRAY_SIZE(m10bmc_pacn3000_subdevs),
+};
+
+static const struct intel_m10bmc_platform_info m10bmc_spi_d5005 = {
+	.cells = m10bmc_d5005_subdevs,
+	.n_cells = ARRAY_SIZE(m10bmc_d5005_subdevs),
+};
+
+static const struct intel_m10bmc_platform_info m10bmc_spi_n5010 = {
+	.cells = m10bmc_n5010_subdevs,
+	.n_cells = ARRAY_SIZE(m10bmc_n5010_subdevs),
+};
+
 static const struct spi_device_id m10bmc_spi_id[] = {
-	{ "m10-n3000", M10_N3000 },
-	{ "m10-d5005", M10_D5005 },
-	{ "m10-n5010", M10_N5010 },
+	{ "m10-n3000", (kernel_ulong_t)&m10bmc_spi_n3000 },
+	{ "m10-d5005", (kernel_ulong_t)&m10bmc_spi_d5005 },
+	{ "m10-n5010", (kernel_ulong_t)&m10bmc_spi_n5010 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index f0044b14136e..725b51ea4aee 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -118,14 +118,26 @@
 /* Address of 4KB inverted bit vector containing staging area FLASH count */
 #define STAGING_FLASH_COUNT	0x17ffb000
 
+/**
+ * struct intel_m10bmc_platform_info - Intel MAX 10 BMC platform specific information
+ * @cells: MFD cells
+ * @n_cells: MFD cells ARRAY_SIZE()
+ */
+struct intel_m10bmc_platform_info {
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

