Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3B28200C
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Oct 2020 03:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgJCBYa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Oct 2020 21:24:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:5544 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgJCBYV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Oct 2020 21:24:21 -0400
IronPort-SDR: sifS9rmrYX4YOaghodXxdytGwhjsSx4XqWcQjuuhDjdHdOgahuK+ZhvmdC7r05KBTnO7YeMhEr
 X8JYulL4TWrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="162363107"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="162363107"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:19 -0700
IronPort-SDR: /ezDqut3ZkjlURL6Rco6ynAJNaQkZbaPWrh8zZ63V3sadFJOK1OXgcccMbFW+DnYICJrpf4+SI
 U4fmeQw3usLQ==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="516097856"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.5.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:18 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 2/6] fpga: m10bmc-sec: create max10 bmc security engine
Date:   Fri,  2 Oct 2020 18:24:08 -0700
Message-Id: <20201003012412.16831-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201003012412.16831-1-russell.h.weight@intel.com>
References: <20201003012412.16831-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create a platform driver that can be invoked as a sub
driver for the Intel MAX10 BMC in order to support
secure updates. This sub-driver will invoke an
instance of the Intel FPGA Security Manager class driver
in order to expose sysfs interfaces for managing and
monitoring secure updates to FPGA and BMC images.

This patch creates the MAX10 BMC Security Engine driver and
provides support for displaying the current root entry hashes
for the FPGA static region, the FPGA PR region, and the MAX10
BMC.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
  - Switched to GENMASK(31, 16) for a couple of mask definitions.
  - Moved MAX10 BMC address and function definitions to a separate
    patch.
  - Replaced small function-creation macros with explicit function
    declarations.
  - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
  - Adapted to changes in the Intel FPGA Security Manager by splitting
    the single call to ifpga_sec_mgr_register() into two function
    calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
---
 MAINTAINERS                         |   1 +
 drivers/fpga/Kconfig                |  11 ++
 drivers/fpga/Makefile               |   3 +
 drivers/fpga/intel-m10-bmc-secure.c | 165 ++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+)
 create mode 100644 drivers/fpga/intel-m10-bmc-secure.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bb5ef309dec..c359d0214980 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6898,6 +6898,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
 F:	Documentation/fpga/ifpga-sec-mgr.rst
 F:	drivers/fpga/ifpga-sec-mgr.c
+F:	drivers/fpga/intel-m10-bmc-secure.c
 F:	include/linux/fpga/ifpga-sec-mgr.h
 
 FPU EMULATOR
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index c534cc80f398..2380d36b08c7 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -235,4 +235,15 @@ config IFPGA_SEC_MGR
 	  region and for the BMC. Select this option to enable
 	  updates for secure FPGA devices.
 
+config IFPGA_M10_BMC_SECURE
+        tristate "Intel MAX10 BMC security engine"
+	depends on MFD_INTEL_M10_BMC && IFPGA_SEC_MGR
+        help
+          Secure update support for the Intel MAX10 board management
+	  controller.
+
+	  This is a subdriver of the Intel MAX10 board management controller
+	  (BMC) and provides support for secure updates for the BMC image,
+	  the FPGA image, the Root Entry Hashes, etc.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 6f706590e209..8e702689cdda 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -24,6 +24,9 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 # Intel FPGA Security Manager Framework
 obj-$(CONFIG_IFPGA_SEC_MGR)		+= ifpga-sec-mgr.o
 
+# Intel Security Manager Drivers
+obj-$(CONFIG_IFPGA_M10_BMC_SECURE)	+= intel-m10-bmc-secure.o
+
 # FPGA Bridge Drivers
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
new file mode 100644
index 000000000000..df8ebda9a9cb
--- /dev/null
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Max10 Board Management Controller Security Engine Driver
+ *
+ * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/fpga/ifpga-sec-mgr.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/vmalloc.h>
+
+struct m10bmc_sec {
+	struct device *dev;
+	struct intel_m10bmc *m10bmc;
+	struct ifpga_sec_mgr *imgr;
+};
+
+#define REH_SHA256_SIZE		32
+#define REH_SHA384_SIZE		48
+#define REH_MAGIC		GENMASK(15, 0)
+#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
+
+static int m10bmc_reh_size(struct ifpga_sec_mgr *imgr,
+			   u32 exp_magic, u32 prog_addr)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	int sha_num_bytes, ret;
+	u32 magic;
+
+	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
+	if (ret)
+		return ret;
+
+	dev_dbg(sec->dev, "%s magic 0x%08x\n", __func__, magic);
+
+	/*
+	 * If no magic number, then no REH is programmed, so
+	 * the REH size is zero.
+	 */
+	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
+		return 0;
+
+	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
+	if (sha_num_bytes != REH_SHA256_SIZE &&
+	    sha_num_bytes != REH_SHA384_SIZE)   {
+		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
+			sha_num_bytes);
+		return -EINVAL;
+	}
+
+	return sha_num_bytes;
+}
+
+static int m10bmc_bmc_reh_size(struct ifpga_sec_mgr *imgr)
+{
+	return m10bmc_reh_size(imgr, BMC_PROG_MAGIC, BMC_PROG_ADDR);
+}
+
+static int m10bmc_sr_reh_size(struct ifpga_sec_mgr *imgr)
+{
+	return m10bmc_reh_size(imgr, SR_PROG_MAGIC, SR_PROG_ADDR);
+}
+
+static int m10bmc_pr_reh_size(struct ifpga_sec_mgr *imgr)
+{
+	return m10bmc_reh_size(imgr, PR_PROG_MAGIC, PR_PROG_ADDR);
+}
+
+static int m10bmc_root_entry_hash(struct ifpga_sec_mgr *imgr,
+				  u32 hash_addr, u8 *hash,
+				  unsigned int size)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	int ret;
+
+	ret = m10bmc_raw_bulk_read(sec->m10bmc, hash_addr,
+				   hash, size / stride);
+	if (ret)
+		dev_err(sec->dev, "bulk_read of 0x%x failed %d",
+			hash_addr, ret);
+
+	return ret;
+}
+
+static int m10bmc_bmc_root_entry_hash(struct ifpga_sec_mgr *imgr,
+				      u8 *hash, unsigned int size)
+{
+	return m10bmc_root_entry_hash(imgr, BMC_REH_ADDR, hash, size);
+}
+
+static int m10bmc_sr_root_entry_hash(struct ifpga_sec_mgr *imgr,
+				     u8 *hash, unsigned int size)
+{
+	return m10bmc_root_entry_hash(imgr, SR_REH_ADDR, hash, size);
+}
+
+static int m10bmc_pr_root_entry_hash(struct ifpga_sec_mgr *imgr,
+				     u8 *hash, unsigned int size)
+{
+	return m10bmc_root_entry_hash(imgr, PR_REH_ADDR, hash, size);
+}
+
+static const struct ifpga_sec_mgr_ops m10bmc_iops = {
+	.bmc_root_entry_hash = m10bmc_bmc_root_entry_hash,
+	.sr_root_entry_hash = m10bmc_sr_root_entry_hash,
+	.pr_root_entry_hash = m10bmc_pr_root_entry_hash,
+	.bmc_reh_size = m10bmc_bmc_reh_size,
+	.sr_reh_size = m10bmc_sr_reh_size,
+	.pr_reh_size = m10bmc_pr_reh_size,
+};
+
+static int m10bmc_secure_probe(struct platform_device *pdev)
+{
+	struct ifpga_sec_mgr *imgr;
+	struct m10bmc_sec *sec;
+	int ret;
+
+	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
+	if (!sec)
+		return -ENOMEM;
+
+	sec->dev = &pdev->dev;
+	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
+	dev_set_drvdata(&pdev->dev, sec);
+
+	imgr = devm_ifpga_sec_mgr_create(sec->dev, "Max10 BMC Security Manager",
+					 &m10bmc_iops, sec);
+	if (!imgr) {
+		dev_err(sec->dev,
+			"Security manager failed to start: %d\n", ret);
+		return -ENOMEM;
+	}
+
+	sec->imgr = imgr;
+
+	return ifpga_sec_mgr_register(imgr);
+}
+
+static int m10bmc_secure_remove(struct platform_device *pdev)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
+
+	ifpga_sec_mgr_unregister(sec->imgr);
+
+	return 0;
+}
+
+static struct platform_driver intel_m10bmc_secure_driver = {
+	.probe = m10bmc_secure_probe,
+	.remove = m10bmc_secure_remove,
+	.driver = {
+		.name = "n3000bmc-secure",
+	},
+};
+module_platform_driver(intel_m10bmc_secure_driver);
+
+MODULE_ALIAS("platform:n3000bmc-secure");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel MAX10 BMC secure engine");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

