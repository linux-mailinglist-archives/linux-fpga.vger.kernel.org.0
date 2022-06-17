Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1BB54EF22
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jun 2022 04:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379688AbiFQCIP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Jun 2022 22:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379689AbiFQCIM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 16 Jun 2022 22:08:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB727CD7;
        Thu, 16 Jun 2022 19:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655431682; x=1686967682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3/pGXYtwBNUoL/U8pvjgYsSt+Nl1CqQfA5RoTzhAlOw=;
  b=fB2wUv3zx0zWXP2w82PO4C3kWx14XXQPya/OT5MTJpsqaD0flznl6+GV
   TX0cl/skMQEAXVZhYrJXh8ATyjbDO7RpcGtBDAf2RMLCXFeuHrPSgtez+
   yCX79fOZb7tAqLqW3KBWdHX3AjRwIxkJ0nLkb9T0iWS27IrdEJVunJlmp
   dtOzXSBmVVwr6G5bUqqCJoKW4P/7MqXS/BAQYFvIbJSSagepARCKlZ4Ps
   CmROKHs5dS4l+MSyGpNuTUuODaBeJFVL1Ymm4NIv6QniYJi4vosbkfrV+
   rxfPlL2+3uW8A6tlfOAMOGYT1tyH9lASDsVUyryBvOKcASzPKkreh43oM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365750337"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365750337"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 19:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831831735"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 19:07:49 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2 4/4] mfd: intel-m10-bmc: support multiple register layouts
Date:   Thu, 16 Jun 2022 22:04:05 -0400
Message-Id: <20220617020405.128352-5-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220617020405.128352-1-tianfei.zhang@intel.com>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
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

There are different base addresses for the MAX10 CSR register.
Introducing a new data structure m10bmc_csr for the register
definition of MAX10 CSR. Embedded m10bmc_csr into struct
intel_m10bmc to support multiple register layouts.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/mfd/intel-m10-bmc-core.c  | 30 +++++++++++++++++++++++++-----
 include/linux/mfd/intel-m10-bmc.h | 20 +++++++++++++++++++-
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index c6a1a4c28357..f85f8e2aa9a1 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -10,6 +10,22 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 
+static const struct m10bmc_csr m10bmc_pmci_csr = {
+	.base = M10BMC_PMCI_SYS_BASE,
+	.build_version = M10BMC_PMCI_BUILD_VER,
+	.fw_version = NIOS2_PMCI_FW_VERSION,
+	.mac_low = M10BMC_PMCI_MAC_LOW,
+	.mac_high = M10BMC_PMCI_MAC_HIGH,
+};
+
+static const struct m10bmc_csr m10bmc_spi_csr = {
+	.base = M10BMC_SYS_BASE,
+	.build_version = M10BMC_BUILD_VER,
+	.fw_version = NIOS2_FW_VERSION,
+	.mac_low = M10BMC_MAC_LOW,
+	.mac_high = M10BMC_MAC_HIGH,
+};
+
 static struct mfd_cell m10bmc_n6000_bmc_subdevs[] = {
 	{ .name = "n6000bmc-hwmon" },
 	{ .name = "n6000bmc-sec-update" }
@@ -36,7 +52,7 @@ static ssize_t bmc_version_show(struct device *dev,
 	unsigned int val;
 	int ret;
 
-	ret = m10bmc_sys_read(ddata, M10BMC_BUILD_VER, &val);
+	ret = m10bmc_sys_read(ddata, ddata->csr->build_version, &val);
 	if (ret)
 		return ret;
 
@@ -51,7 +67,7 @@ static ssize_t bmcfw_version_show(struct device *dev,
 	unsigned int val;
 	int ret;
 
-	ret = m10bmc_sys_read(ddata, NIOS2_FW_VERSION, &val);
+	ret = m10bmc_sys_read(ddata, ddata->csr->fw_version, &val);
 	if (ret)
 		return ret;
 
@@ -66,11 +82,11 @@ static ssize_t mac_address_show(struct device *dev,
 	unsigned int macaddr_low, macaddr_high;
 	int ret;
 
-	ret = m10bmc_sys_read(ddata, M10BMC_MAC_LOW, &macaddr_low);
+	ret = m10bmc_sys_read(ddata, ddata->csr->mac_low, &macaddr_low);
 	if (ret)
 		return ret;
 
-	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
+	ret = m10bmc_sys_read(ddata, ddata->csr->mac_high, &macaddr_high);
 	if (ret)
 		return ret;
 
@@ -91,7 +107,7 @@ static ssize_t mac_count_show(struct device *dev,
 	unsigned int macaddr_high;
 	int ret;
 
-	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
+	ret = m10bmc_sys_read(ddata, ddata->csr->mac_high, &macaddr_high);
 	if (ret)
 		return ret;
 
@@ -163,18 +179,22 @@ int m10bmc_dev_init(struct intel_m10bmc *m10bmc)
 	case M10_N3000:
 		cells = m10bmc_pacn3000_subdevs;
 		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
+		m10bmc->csr = &m10bmc_spi_csr;
 		break;
 	case M10_D5005:
 		cells = m10bmc_d5005_subdevs;
 		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
+		m10bmc->csr = &m10bmc_spi_csr;
 		break;
 	case M10_N5010:
 		cells = m10bmc_n5010_subdevs;
 		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
+		m10bmc->csr = &m10bmc_spi_csr;
 		break;
 	case M10_N6000:
 		cells = m10bmc_n6000_bmc_subdevs;
 		n_cell = ARRAY_SIZE(m10bmc_n6000_bmc_subdevs);
+		m10bmc->csr = &m10bmc_pmci_csr;
 		break;
 	default:
 		return -ENODEV;
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 83c4d3993dcb..3a4fdab2acbd 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -125,6 +125,11 @@
 #define M10BMC_PMCI_TELEM_START		0x400
 #define M10BMC_PMCI_TELEM_END		0x78c
 
+#define M10BMC_PMCI_BUILD_VER   0x0
+#define NIOS2_PMCI_FW_VERSION   0x4
+#define M10BMC_PMCI_MAC_LOW    0x20
+#define M10BMC_PMCI_MAC_HIGH    0x24
+
 /* Supported MAX10 BMC types */
 enum m10bmc_type {
 	M10_N3000,
@@ -133,16 +138,29 @@ enum m10bmc_type {
 	M10_N6000
 };
 
+/**
+ * struct m10bmc_csr - Intel MAX 10 BMC CSR register
+ */
+struct m10bmc_csr {
+	unsigned int base;
+	unsigned int build_version;
+	unsigned int fw_version;
+	unsigned int mac_low;
+	unsigned int mac_high;
+};
+
 /**
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
  * @regmap: the regmap used to access registers by m10bmc itself
  * @type: the type of MAX10 BMC
+ * @csr: the register definition of MAX10 BMC
  */
 struct intel_m10bmc {
 	struct device *dev;
 	struct regmap *regmap;
 	enum m10bmc_type type;
+	const struct m10bmc_csr *csr;
 };
 
 /*
@@ -174,7 +192,7 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
  * M10BMC_SYS_BASE accordingly.
  */
 #define m10bmc_sys_read(m10bmc, offset, val) \
-	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
+	m10bmc_raw_read(m10bmc, m10bmc->csr->base + (offset), val)
 
 /*
  * MAX10 BMC Core support
-- 
2.26.2

