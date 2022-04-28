Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9E5513F20
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Apr 2022 01:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353319AbiD1XlD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Apr 2022 19:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbiD1XlC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Apr 2022 19:41:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1418618E1D;
        Thu, 28 Apr 2022 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651189066; x=1682725066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xk10lKH497OijrGSWsK7Yu2qBbB87ryHpf3sEO+W2X4=;
  b=V2ZCBfkwqP36N7RKuCQVJ9Y6/37kcVw80j3B8afHIdobpEc3QV5s2EJj
   OWPwCbz0ZqqGLYxwvifYJqhFpdA9aCJ+/XSfX44ihSHLm6gGxwMA/Zv3u
   tdSRGHGwomLUno9xnUlCOOC+NNhMtBbG0QbFHWpKD5Ph2/mX6utWpKZ5x
   gD3s+pjZn6aXRuq2XufsoMe70ji0W73TlVmy9lYMae+T8YuLcMv7/b1uo
   qiRwDV1VLojTXf5RHmsNTajPloOrfx+t+hgzucVQAfN148E/L5d8sKW8D
   z5jybF3pCCBmLThLyeJYdVlUNY1Enfigekx6r0lISfT+7ElO2B6Ursoyx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265987666"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="265987666"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:37:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="731766373"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.153.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:37:44 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v17 3/5] fpga: cardbmc-sec: expose flash update count
Date:   Thu, 28 Apr 2022 16:37:30 -0700
Message-Id: <20220428233732.189425-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428233732.189425-1-russell.h.weight@intel.com>
References: <20220428233732.189425-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Card BMC Secure Update driver to provide a sysfs file to
expose the flash update count.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v17:
  - Update the Date and KernelVersion for the ABI documentation to Jul 2022
    and 5.19 respectively.
  - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
    future devices will not necessarily use the MAX10.
v16:
  - No Change
v15:
  - Updated the Dates and KernelVersions in the ABI documentation
v14:
  - No change
v13:
  - Updated ABI documentation date and kernel version
v12:
  - Updated Date and KernelVersion fields in ABI documentation
v11:
  - No change
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
 .../sysfs-driver-intel-cardbmc-sec-update     |  8 +++++
 drivers/fpga/intel-cardbmc-sec-update.c       | 36 +++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
index c032fbe59614..80279a3e36a5 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
+++ b/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
@@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
 		"hash not programmed".  This file is only visible if the
 		underlying device supports it.
 		Format: "0x%x".
+
+What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/flash_count
+Date:		Jul 2022
+KernelVersion:	5.19
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns number of times the secure update
+		staging area has been flashed.
+		Format: "%u".
diff --git a/drivers/fpga/intel-cardbmc-sec-update.c b/drivers/fpga/intel-cardbmc-sec-update.c
index ba3559f3335d..12c8ebdf4c14 100644
--- a/drivers/fpga/intel-cardbmc-sec-update.c
+++ b/drivers/fpga/intel-cardbmc-sec-update.c
@@ -84,7 +84,43 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
 
+#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
+
+static ssize_t flash_count_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct bmc_sec *sec = dev_get_drvdata(dev);
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
 static struct attribute *bmc_security_attrs[] = {
+	&dev_attr_flash_count.attr,
 	&dev_attr_bmc_root_entry_hash.attr,
 	&dev_attr_sr_root_entry_hash.attr,
 	&dev_attr_pr_root_entry_hash.attr,
-- 
2.25.1

