Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C7D513F21
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Apr 2022 01:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiD1XlF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Apr 2022 19:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353316AbiD1XlD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Apr 2022 19:41:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1641B7B6;
        Thu, 28 Apr 2022 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651189066; x=1682725066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=22oF7Vi4x/uM0pZxtaPE/8tw5/ohe7Aw2augStssZnk=;
  b=XE4+5Dtj2IjY6uVC5oc70Qa2ejkEuzvMo5BK9xSVF52dgzHTjK88JX7U
   n73p2mu7QCKsGay+g/R5SEvvxfE9gqhcjHT3Cr1de6zFTf/Sk6CQvJtKX
   wHH84awQQdKL4aflo9i5smLMRSMrUeAC+S1bfXsmGSpiUrW06KMtQsjd0
   djkPDYJoFbknLDBHb7p24CroBTmK+AwEqTsy87KsZ7n0Y5m9935Q+hu1X
   R+KGxqeNWk6m8EwgVBiVbPyO2ZOu/hk0J5xGbxcPGlgbx9Gxt8nsF+hsy
   SAfCd+TudX8hOf6R6MuqZFJfblWAPVVZFPleyc6Xm+bDz2cOzdo2HsD9t
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265987671"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="265987671"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:37:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="731766378"
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
Subject: [PATCH v17 4/5] fpga: cardbmc-sec: expose canceled keys in sysfs
Date:   Thu, 28 Apr 2022 16:37:31 -0700
Message-Id: <20220428233732.189425-5-russell.h.weight@intel.com>
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

Extend the FPGA Card BMC Secure Update driver to provide sysfs files to
expose the canceled code signing key (CSK) bit vectors. These use the
standard bitmap list format (e.g. 1,2-6,9).

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
  - No changes
v13:
  - Updated ABI documentation date and kernel version
v12:
  - Updated Date and KernelVersion fields in ABI documentation
v11:
  - No change
v10:
  - Changed the path expressions in the sysfs documentation to
    replace the n3000 reference with something more generic to
    accomodate other devices that use the same driver.
v9:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v8:
  - Previously patch 4/6, otherwise no change
v7:
  - Updated Date and KernelVersion in ABI documentation
v6:
  - Added WARN_ON() call for (size / stride) to ensure
    that the proper count is passed to regmap_bulk_read().
v5:
  - No change
v4:
  - Moved sysfs files for displaying the code-signing-key (CSK)
    cancellation vectors from the FPGA Security Manger class driver
    to here. The m10bmc_csk_vector() and m10bmc_csk_cancel_nbits()
    functions are removed and the functionality from these functions
    is moved into a show_canceled_csk() function for for displaying
    the CSK vectors.
  - Added ABI documentation for new sysfs entries
v3:
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
    driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
  - Renamed get_csk_vector() to m10bmc_csk_vector()
v2:
  - Replaced small function-creation macros for explicit function
    declarations.
  - Fixed get_csk_vector() function to properly apply the stride
    variable in calls to m10bmc_raw_bulk_read()
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
---
 .../sysfs-driver-intel-cardbmc-sec-update     | 24 ++++++++++
 drivers/fpga/intel-cardbmc-sec-update.c       | 48 +++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
index 80279a3e36a5..7fe0d03c3175 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
+++ b/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
@@ -28,6 +28,30 @@ Description:	Read only. Returns the root entry hash for the BMC image
 		underlying device supports it.
 		Format: "0x%x".
 
+What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/sr_canceled_csks
+Date:		Jul 2022
+KernelVersion:	5.19
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns a list of indices for canceled code
+		signing keys for the static region. The standard bitmap
+		list format is used (e.g. "1,2-6,9").
+
+What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/pr_canceled_csks
+Date:		Jul 2022
+KernelVersion:	5.19
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns a list of indices for canceled code
+		signing keys for the partial reconfiguration region. The
+		standard bitmap list format is used (e.g. "1,2-6,9").
+
+What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/bmc_canceled_csks
+Date:		Jul 2022
+KernelVersion:	5.19
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns a list of indices for canceled code
+		signing keys for the BMC.  The standard bitmap list format
+		is used (e.g. "1,2-6,9").
+
 What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/flash_count
 Date:		Jul 2022
 KernelVersion:	5.19
diff --git a/drivers/fpga/intel-cardbmc-sec-update.c b/drivers/fpga/intel-cardbmc-sec-update.c
index 12c8ebdf4c14..0b268d925e0a 100644
--- a/drivers/fpga/intel-cardbmc-sec-update.c
+++ b/drivers/fpga/intel-cardbmc-sec-update.c
@@ -84,6 +84,51 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
 
+#define CSK_BIT_LEN		128U
+#define CSK_32ARRAY_SIZE	DIV_ROUND_UP(CSK_BIT_LEN, 32)
+
+static ssize_t
+show_canceled_csk(struct device *dev, u32 addr, char *buf)
+{
+	unsigned int i, stride, size = CSK_32ARRAY_SIZE * sizeof(u32);
+	struct bmc_sec *sec = dev_get_drvdata(dev);
+	DECLARE_BITMAP(csk_map, CSK_BIT_LEN);
+	__le32 csk_le32[CSK_32ARRAY_SIZE];
+	u32 csk32[CSK_32ARRAY_SIZE];
+	int ret;
+
+	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+
+	WARN_ON(size % stride);
+	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk_le32,
+			       size / stride);
+	if (ret) {
+		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
+			addr, size / stride, ret);
+		return ret;
+	}
+
+	for (i = 0; i < CSK_32ARRAY_SIZE; i++)
+		csk32[i] = le32_to_cpu(((csk_le32[i])));
+
+	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
+	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
+	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
+}
+
+#define DEVICE_ATTR_SEC_CSK_RO(_name, _addr) \
+static ssize_t _name##_canceled_csks_show(struct device *dev, \
+					  struct device_attribute *attr, \
+					  char *buf) \
+{ return show_canceled_csk(dev, _addr, buf); } \
+static DEVICE_ATTR_RO(_name##_canceled_csks)
+
+#define CSK_VEC_OFFSET 0x34
+
+DEVICE_ATTR_SEC_CSK_RO(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET);
+DEVICE_ATTR_SEC_CSK_RO(sr, SR_PROG_ADDR + CSK_VEC_OFFSET);
+DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
+
 #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
 
 static ssize_t flash_count_show(struct device *dev,
@@ -124,6 +169,9 @@ static struct attribute *bmc_security_attrs[] = {
 	&dev_attr_bmc_root_entry_hash.attr,
 	&dev_attr_sr_root_entry_hash.attr,
 	&dev_attr_pr_root_entry_hash.attr,
+	&dev_attr_sr_canceled_csks.attr,
+	&dev_attr_pr_canceled_csks.attr,
+	&dev_attr_bmc_canceled_csks.attr,
 	NULL,
 };
 
-- 
2.25.1

