Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138A433977B
	for <lists+linux-fpga@lfdr.de>; Fri, 12 Mar 2021 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhCLTg5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 12 Mar 2021 14:36:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:44156 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhCLTg1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 12 Mar 2021 14:36:27 -0500
IronPort-SDR: kgt7yGRSVUV8srtjw1DU/DqpIDUIviONbtJw3625TEr9Ejrbcx/Mw1ZAh7vP7amxc6+Q34tEYo
 TkLCQVTPhexQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168796315"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="168796315"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 11:36:27 -0800
IronPort-SDR: MtPLN5Bd4l4YZ2kYAvuRMlyOwX+gRXEFnrj7d2RrdF5HHJkKWhbm7RhfyZXuvqkj261bM60Gsu
 EKqa8KUCYp1g==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="510426153"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.51.149])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 11:36:26 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v10 2/5] fpga: m10bmc-sec: expose max10 flash update count
Date:   Fri, 12 Mar 2021 11:36:20 -0800
Message-Id: <20210312193623.326306-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312193623.326306-1-russell.h.weight@intel.com>
References: <20210312193623.326306-1-russell.h.weight@intel.com>
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
v10:
  - Changed the path expression in the sysfs documentation to
    replace the n3000 reference with something more generic to
    accomodate other devices that use the same driver.
v9:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v8:
  - Previously patch 3/6, otherwise no change
v7:
  - Updated Date and KernelVersion in ABI documentation
v6:
  - Changed flash_count_show() parameter list to achieve
    reverse-christmas tree format.
  - Added WARN_ON() call for (FLASH_COUNT_SIZE / stride) to ensure
    that the proper count is passed to regmap_bulk_read().
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
 .../testing/sysfs-driver-intel-m10-bmc-secure |  8 ++++
 drivers/fpga/intel-m10-bmc-secure.c           | 37 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
index bd3ee9bc1a92..598db1116d34 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
@@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
 		"hash not programmed".  This file is only visible if the
 		underlying device supports it.
 		Format: "0x%x".
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/flash_count
+Date:		April 2021
+KernelVersion:  5.13
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns number of times the secure update
+		staging area has been flashed.
+		Format: "%u".
diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 5ac5f59b5731..ecd63c13cb2d 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 struct m10bmc_sec {
 	struct device *dev;
@@ -78,7 +79,43 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
 
+#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
+
+static ssize_t flash_count_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	unsigned int stride, num_bits;
+	u8 *flash_buf;
+	int cnt, ret;
+
+	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	num_bits = FLASH_COUNT_SIZE * 8;
+
+	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
+	if (!flash_buf)
+		return -ENOMEM;
+
+	WARN_ON(FLASH_COUNT_SIZE % stride);
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

