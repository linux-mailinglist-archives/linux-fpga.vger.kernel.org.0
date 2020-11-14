Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9142B2A3A
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Nov 2020 01:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKNA4U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 Nov 2020 19:56:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:6577 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgKNA4U (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 13 Nov 2020 19:56:20 -0500
IronPort-SDR: Q3en36ej1fnQKy5xle868BmEXnJGsOpkMJ86GWF5B6h5G8PVaZPY+dO3JEDRRXQQxwqlksfsaf
 53seTRfWrH9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="188575980"
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="188575980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 16:56:14 -0800
IronPort-SDR: HezR9p8JRKuPTvAJUwkli6V0Wln0kP7lbX8eMsGru9qlAO6r4ws+Dy36j7clk7x5FZThaip2Zx
 NWqYZ5i08gWA==
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="399904240"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.134.21])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 16:56:12 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v5 3/6] fpga: m10bmc-sec: expose max10 flash update count
Date:   Fri, 13 Nov 2020 16:55:56 -0800
Message-Id: <20201114005559.90860-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201114005559.90860-1-russell.h.weight@intel.com>
References: <20201114005559.90860-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Secure Update driver to provide a
sysfs file to expose the flash update count for the FPGA
user image.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v5:
  - Renamed sysfs node user_flash_count to flash_count and updated the
    sysfs documentation accordingly.
v4:
  - Moved the sysfs file for displaying the flash count from the
    FPGA Security Manager class driver to here. The
    m10bmc_user_flash_count() function is removed and the
    functionality is moved into a user_flash_count_show()
    function.
  - Added ABI documentation for the new sysfs entry
v3:
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
    driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
v2:
  - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
  - Minor code cleanup per review comments
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
---
 .../testing/sysfs-driver-intel-m10-bmc-secure |  8 +++++
 drivers/fpga/intel-m10-bmc-secure.c           | 34 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
index 2992488b717a..73a3aba750e8 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
@@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
 		"hash not programmed".  This file is only visible if the
 		underlying device supports it.
 		Format: "0x%x".
+
+What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/flash_count
+Date:		Oct 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns number of times the secure update
+		staging area has been flashed.
+		Format: "%u".
diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 198bc8273d6b..6ad897001086 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 struct m10bmc_sec {
 	struct device *dev;
@@ -77,7 +78,40 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
 
+#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
+
+static ssize_t flash_count_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	unsigned int num_bits = FLASH_COUNT_SIZE * 8;
+	u8 *flash_buf;
+	int cnt, ret;
+
+	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
+	if (!flash_buf)
+		return -ENOMEM;
+
+	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
+			       flash_buf, FLASH_COUNT_SIZE / stride);
+	if (ret) {
+		dev_err(sec->dev,
+			"failed to read flash count: %x cnt %x: %d\n",
+			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
+		goto exit_free;
+	}
+	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
+
+exit_free:
+	kfree(flash_buf);
+
+	return ret ? : sysfs_emit(buf, "%u\n", cnt);
+}
+static DEVICE_ATTR_RO(flash_count);
+
 static struct attribute *m10bmc_security_attrs[] = {
+	&dev_attr_flash_count.attr,
 	&dev_attr_bmc_root_entry_hash.attr,
 	&dev_attr_sr_root_entry_hash.attr,
 	&dev_attr_pr_root_entry_hash.attr,
-- 
2.25.1

