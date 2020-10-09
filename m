Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B94E287FDE
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Oct 2020 03:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgJIBOg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Oct 2020 21:14:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:13068 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730138AbgJIBOa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Oct 2020 21:14:30 -0400
IronPort-SDR: CXF43DZXCWw58ptDEVnvykICSpLrG5FvuSV5zrKmcB3PEXKANQFdZoG0Pz7sqNAaiUv+E8G/1j
 g7/ybJl5fOtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="145294135"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="145294135"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 18:14:29 -0700
IronPort-SDR: 56dY2VuXgFAleF4Scp1mVFgXjkN/zlWwjymbtx7HF2uuGf0tCiUqV7poGYzfjgQgpLoGG+1b2p
 QV3fPNNrkm+w==
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="462002348"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.33.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 18:14:28 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 2/6] fpga: m10bmc-sec: create max10 bmc secure update driver
Date:   Thu,  8 Oct 2020 18:14:19 -0700
Message-Id: <20201009011423.22741-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009011423.22741-1-russell.h.weight@intel.com>
References: <20201009011423.22741-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create a platform driver that can be invoked as a sub
driver for the Intel MAX10 BMC in order to support
secure updates. This sub-driver will invoke an
instance of the FPGA Security Manager class driver
in order to expose sysfs interfaces for managing and
monitoring secure updates to FPGA and BMC images.

This patch creates the MAX10 BMC Secure Update driver and
provides support for displaying the current root entry hashes
for the FPGA static region, the FPGA PR region, and the MAX10
BMC.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v3:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
    Update driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
  - Changed "_root_entry_hash" to "_reh", with a comment explaining
    what reh is.
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
 drivers/fpga/intel-m10-bmc-secure.c | 166 ++++++++++++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 drivers/fpga/intel-m10-bmc-secure.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fbe29616ed0a..743959bdeaab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6908,6 +6908,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
 F:	Documentation/fpga/fpga-sec-mgr.rst
 F:	drivers/fpga/fpga-sec-mgr.c
+F:	drivers/fpga/intel-m10-bmc-secure.c
 F:	include/linux/fpga/fpga-sec-mgr.h
 
 FPU EMULATOR
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7204199e0e20..ecd3b7f19265 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -235,4 +235,15 @@ config FPGA_SEC_MGR
 	  region and for the BMC. Select this option to enable
 	  updates for secure FPGA devices.
 
+config IFPGA_M10_BMC_SECURE
+	tristate "Intel MAX10 BMC Secure Update driver"
+	depends on MFD_INTEL_M10_BMC && FPGA_SEC_MGR
+	help
+	  Secure update support for the Intel MAX10 board management
+	  controller.
+
+	  This is a subdriver of the Intel MAX10 board management controller
+	  (BMC) and provides support for secure updates for the BMC image,
+	  the FPGA image, the Root Entry Hashes, etc.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 22576d1a3996..7259f1ab2531 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -24,6 +24,9 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 # FPGA Security Manager Framework
 obj-$(CONFIG_FPGA_SEC_MGR)		+= fpga-sec-mgr.o
 
+# FPGA Secure Update Drivers
+obj-$(CONFIG_IFPGA_M10_BMC_SECURE)	+= intel-m10-bmc-secure.o
+
 # FPGA Bridge Drivers
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
new file mode 100644
index 000000000000..433af08a9507
--- /dev/null
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Max10 Board Management Controller Secure Update Driver
+ *
+ * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/fpga/fpga-sec-mgr.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/vmalloc.h>
+
+struct m10bmc_sec {
+	struct device *dev;
+	struct intel_m10bmc *m10bmc;
+	struct fpga_sec_mgr *smgr;
+};
+
+/* Root Entry Hash (REH) support */
+#define REH_SHA256_SIZE		32
+#define REH_SHA384_SIZE		48
+#define REH_MAGIC		GENMASK(15, 0)
+#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
+
+static int m10bmc_reh_size(struct fpga_sec_mgr *smgr,
+			   u32 exp_magic, u32 prog_addr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
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
+	 * If no magic number, then no Root Entry Hash (REH) is programmed,
+	 * so the REH size is zero.
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
+static int m10bmc_bmc_reh_size(struct fpga_sec_mgr *smgr)
+{
+	return m10bmc_reh_size(smgr, BMC_PROG_MAGIC, BMC_PROG_ADDR);
+}
+
+static int m10bmc_sr_reh_size(struct fpga_sec_mgr *smgr)
+{
+	return m10bmc_reh_size(smgr, SR_PROG_MAGIC, SR_PROG_ADDR);
+}
+
+static int m10bmc_pr_reh_size(struct fpga_sec_mgr *smgr)
+{
+	return m10bmc_reh_size(smgr, PR_PROG_MAGIC, PR_PROG_ADDR);
+}
+
+static int m10bmc_reh(struct fpga_sec_mgr *smgr, u32 hash_addr,
+		      u8 *hash, unsigned int size)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	int ret;
+
+	ret = regmap_bulk_read(sec->m10bmc->regmap, hash_addr,
+			       hash, size / stride);
+	if (ret)
+		dev_err(sec->m10bmc->dev,
+			"failed to read root entry hash: %x cnt %x: %d\n",
+			hash_addr, size / stride, ret);
+
+	return ret;
+}
+
+static int m10bmc_bmc_reh(struct fpga_sec_mgr *smgr, u8 *hash,
+			  unsigned int size)
+{
+	return m10bmc_reh(smgr, BMC_REH_ADDR, hash, size);
+}
+
+static int m10bmc_sr_reh(struct fpga_sec_mgr *smgr, u8 *hash,
+			 unsigned int size)
+{
+	return m10bmc_reh(smgr, SR_REH_ADDR, hash, size);
+}
+
+static int m10bmc_pr_reh(struct fpga_sec_mgr *smgr, u8 *hash,
+			 unsigned int size)
+{
+	return m10bmc_reh(smgr, PR_REH_ADDR, hash, size);
+}
+
+static const struct fpga_sec_mgr_ops m10bmc_sops = {
+	.bmc_root_entry_hash = m10bmc_bmc_reh,
+	.sr_root_entry_hash = m10bmc_sr_reh,
+	.pr_root_entry_hash = m10bmc_pr_reh,
+	.bmc_reh_size = m10bmc_bmc_reh_size,
+	.sr_reh_size = m10bmc_sr_reh_size,
+	.pr_reh_size = m10bmc_pr_reh_size,
+};
+
+static int m10bmc_secure_probe(struct platform_device *pdev)
+{
+	struct fpga_sec_mgr *smgr;
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
+	smgr = devm_fpga_sec_mgr_create(sec->dev, "Max10 BMC Secure Update",
+					&m10bmc_sops, sec);
+	if (!smgr) {
+		dev_err(sec->dev,
+			"Security manager failed to start: %d\n", ret);
+		return -ENOMEM;
+	}
+
+	sec->smgr = smgr;
+
+	return fpga_sec_mgr_register(smgr);
+}
+
+static int m10bmc_secure_remove(struct platform_device *pdev)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
+
+	fpga_sec_mgr_unregister(sec->smgr);
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
+MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

