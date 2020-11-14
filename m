Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0372B2A37
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Nov 2020 01:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgKNA4a (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 Nov 2020 19:56:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:6577 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgKNA4U (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 13 Nov 2020 19:56:20 -0500
IronPort-SDR: InIbBZ/RQR0VW0I0S+XijJ/VHxw7WbaTXtXE1wrOMPPFDG3wN7SJrzvPTZARuEd5GgPmm7wy95
 xLV6V7t1dQKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="188575986"
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="188575986"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 16:56:14 -0800
IronPort-SDR: A16wsDyT8y6iiW/rFNLQIqD77TRcHlh321eI6qHtb6r6l0tZv8gqWcs/8O/iTRslScETj6GkEl
 Uv29KLnxVCeA==
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="399904245"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.134.21])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 16:56:13 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v5 4/6] fpga: m10bmc-sec: expose max10 canceled keys in sysfs
Date:   Fri, 13 Nov 2020 16:55:57 -0800
Message-Id: <20201114005559.90860-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201114005559.90860-1-russell.h.weight@intel.com>
References: <20201114005559.90860-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Secure Update driver to provide sysfs
files to expose the canceled code signing key (CSK) bit
vectors. These use the standard bitmap list format
(e.g. 1,2-6,9).

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
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
 .../testing/sysfs-driver-intel-m10-bmc-secure | 24 ++++++++++
 drivers/fpga/intel-m10-bmc-secure.c           | 46 +++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
index 73a3aba750e8..610f19569b5f 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
@@ -28,6 +28,30 @@ Description:	Read only. Returns the root entry hash for the BMC image
 		underlying device supports it.
 		Format: "0x%x".
 
+What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/sr_canceled_csks
+Date:		Oct 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns a list of indices for canceled code
+		signing keys for the static region. The standard bitmap
+		list format is used (e.g. "1,2-6,9").
+
+What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/pr_canceled_csks
+Date:		Oct 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns a list of indices for canceled code
+		signing keys for the partial reconfiguration region. The
+		standard bitmap list format is used (e.g. "1,2-6,9").
+
+What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/bmc_canceled_csks
+Date:		Oct 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns a list of indices for canceled code
+		signing keys for the BMC.  The standard bitmap list format
+		is used (e.g. "1,2-6,9").
+
 What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/flash_count
 Date:		Oct 2020
 KernelVersion:  5.11
diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 6ad897001086..689da5bc6461 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -78,6 +78,49 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
 
+#define CSK_BIT_LEN		128U
+#define CSK_32ARRAY_SIZE	DIV_ROUND_UP(CSK_BIT_LEN, 32)
+
+static ssize_t
+show_canceled_csk(struct device *dev, u32 addr, char *buf)
+{
+	unsigned int i, stride, size = CSK_32ARRAY_SIZE * sizeof(u32);
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	DECLARE_BITMAP(csk_map, CSK_BIT_LEN);
+	__le32 csk_le32[CSK_32ARRAY_SIZE];
+	u32 csk32[CSK_32ARRAY_SIZE];
+	int ret;
+
+	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+
+	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk_le32, size / stride);
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
@@ -115,6 +158,9 @@ static struct attribute *m10bmc_security_attrs[] = {
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

