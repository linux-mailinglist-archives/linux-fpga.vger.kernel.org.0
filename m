Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A04A37228F
	for <lists+linux-fpga@lfdr.de>; Mon,  3 May 2021 23:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhECVlm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 3 May 2021 17:41:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:49664 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhECVll (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 3 May 2021 17:41:41 -0400
IronPort-SDR: V8LJXc4PRXmOuj5q8Wy1LZp73thXXV9m0O8wY4F2ihioY6BohoLcvOsF12AEC4GS9Nweo+kMWC
 nc68HV0REwCg==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="194699854"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="194699854"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 14:40:45 -0700
IronPort-SDR: J9a0ZoABpTBSB8yeR0GnbmqzEXxk/X1/F4hXtsDujQfp8vtsGCNZdoSgvlO+CCu0YfhQn5g6KG
 EHg6UCSX18CQ==
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="538933099"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.218.202])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 14:40:45 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v12 1/5] fpga: m10bmc-sec: create max10 bmc secure update driver
Date:   Mon,  3 May 2021 14:40:38 -0700
Message-Id: <20210503214042.316836-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503214042.316836-1-russell.h.weight@intel.com>
References: <20210503214042.316836-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
provides sysfs files for displaying the current root entry hashes
for the FPGA static region, the FPGA PR region, and the MAX10
BMC.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v12:
  - Updated Date and KernelVersion fields in ABI documentation
v11:
  - Added Reviewed-by tag
v10:
  - Changed the path expressions in the sysfs documentation to
    replace the n3000 reference with something more generic to
    accomodate other devices that use the same driver.
v9:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v8:
  - Previously patch 2/6, otherwise no change
v7:
  - Updated Date and KernelVersion in ABI documentation
v6:
  - Added WARN_ON() call for (sha_num_bytes / stride) to assert
    that the proper count is passed to regmap_bulk_read().
v5:
  - No change
v4:
  - Moved sysfs files for displaying the root entry hashes (REH)
    from the FPGA Security Manager class driver to here. The
    m10bmc_reh() and m10bmc_reh_size() functions are removed and
    the functionality from these functions is moved into a
    show_root_entry_hash() function for displaying the REHs.
  - Added ABI documentation for the new sysfs entries:
    sysfs-driver-intel-m10-bmc-secure
  - Updated the MAINTAINERS file to add the new ABI documentation
    file: sysfs-driver-intel-m10-bmc-secure
  - Removed unnecessary ret variable from m10bmc_secure_probe()
  - Incorporated new devm_fpga_sec_mgr_register() function into
    m10bmc_secure_probe() and removed the m10bmc_secure_remove()
    function.
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
 .../testing/sysfs-driver-intel-m10-bmc-secure |  29 ++++
 MAINTAINERS                                   |   2 +
 drivers/fpga/Kconfig                          |  11 ++
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/intel-m10-bmc-secure.c           | 135 ++++++++++++++++++
 5 files changed, 180 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
 create mode 100644 drivers/fpga/intel-m10-bmc-secure.c

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
new file mode 100644
index 000000000000..9a0abb147b28
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
@@ -0,0 +1,29 @@
+What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/sr_root_entry_hash
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the root entry hash for the static
+		region if one is programmed, else it returns the
+		string: "hash not programmed".  This file is only
+		visible if the underlying device supports it.
+		Format: "0x%x".
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/pr_root_entry_hash
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the root entry hash for the partial
+		reconfiguration region if one is programmed, else it
+		returns the string: "hash not programmed".  This file
+		is only visible if the underlying device supports it.
+		Format: "0x%x".
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/bmc_root_entry_hash
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns the root entry hash for the BMC image
+		if one is programmed, else it returns the string:
+		"hash not programmed".  This file is only visible if the
+		underlying device supports it.
+		Format: "0x%x".
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b1dc0376b52..77fae7dbd95b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7151,8 +7151,10 @@ M:	Russ Weight <russell.h.weight@intel.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
 F:	Documentation/fpga/fpga-sec-mgr.rst
 F:	drivers/fpga/fpga-sec-mgr.c
+F:	drivers/fpga/intel-m10-bmc-secure.c
 F:	include/linux/fpga/fpga-sec-mgr.h
 
 FPU EMULATOR
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 09a8d915db26..0f3bbebd8b08 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -243,4 +243,15 @@ config FPGA_SEC_MGR
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
index 000000000000..5ac5f59b5731
--- /dev/null
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -0,0 +1,135 @@
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
+
+struct m10bmc_sec {
+	struct device *dev;
+	struct intel_m10bmc *m10bmc;
+};
+
+/* Root Entry Hash (REH) support */
+#define REH_SHA256_SIZE		32
+#define REH_SHA384_SIZE		48
+#define REH_MAGIC		GENMASK(15, 0)
+#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
+
+static ssize_t
+show_root_entry_hash(struct device *dev, u32 exp_magic,
+		     u32 prog_addr, u32 reh_addr, char *buf)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	int sha_num_bytes, i, cnt, ret;
+	u8 hash[REH_SHA384_SIZE];
+	u32 magic;
+
+	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "%s magic 0x%08x\n", __func__, magic);
+
+	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
+		return sysfs_emit(buf, "hash not programmed\n");
+
+	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
+	if (sha_num_bytes != REH_SHA256_SIZE &&
+	    sha_num_bytes != REH_SHA384_SIZE)   {
+		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
+			sha_num_bytes);
+		return -EINVAL;
+	}
+
+	WARN_ON(sha_num_bytes % stride);
+	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
+			       hash, sha_num_bytes / stride);
+	if (ret) {
+		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
+			reh_addr, sha_num_bytes / stride, ret);
+		return ret;
+	}
+
+	cnt = sprintf(buf, "0x");
+	for (i = 0; i < sha_num_bytes; i++)
+		cnt += sprintf(buf + cnt, "%02x", hash[i]);
+	cnt += sprintf(buf + cnt, "\n");
+
+	return cnt;
+}
+
+#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
+static ssize_t _name##_root_entry_hash_show(struct device *dev, \
+					    struct device_attribute *attr, \
+					    char *buf) \
+{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
+static DEVICE_ATTR_RO(_name##_root_entry_hash)
+
+DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
+DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
+DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
+
+static struct attribute *m10bmc_security_attrs[] = {
+	&dev_attr_bmc_root_entry_hash.attr,
+	&dev_attr_sr_root_entry_hash.attr,
+	&dev_attr_pr_root_entry_hash.attr,
+	NULL,
+};
+
+static struct attribute_group m10bmc_security_attr_group = {
+	.name = "security",
+	.attrs = m10bmc_security_attrs,
+};
+
+static const struct attribute_group *m10bmc_sec_attr_groups[] = {
+	&m10bmc_security_attr_group,
+	NULL,
+};
+
+static const struct fpga_sec_mgr_ops m10bmc_sops = { };
+
+static int m10bmc_secure_probe(struct platform_device *pdev)
+{
+	struct fpga_sec_mgr *smgr;
+	struct m10bmc_sec *sec;
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
+		dev_err(sec->dev, "Security manager failed to start\n");
+		return -ENOMEM;
+	}
+
+	return devm_fpga_sec_mgr_register(sec->dev, smgr);
+}
+
+static struct platform_driver intel_m10bmc_secure_driver = {
+	.probe = m10bmc_secure_probe,
+	.driver = {
+		.name = "n3000bmc-secure",
+		.dev_groups = m10bmc_sec_attr_groups,
+	},
+};
+module_platform_driver(intel_m10bmc_secure_driver);
+
+MODULE_ALIAS("platform:n3000bmc-secure");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

