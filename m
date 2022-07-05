Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38895664C9
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Jul 2022 10:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiGEIEk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Jul 2022 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGEIEj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Jul 2022 04:04:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556056333
        for <linux-fpga@vger.kernel.org>; Tue,  5 Jul 2022 01:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657008278; x=1688544278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=229hhrunAiPVA8D+jsEf+MoFO4/vbqwtX+J+v92oXTg=;
  b=CULmr0P3cn5O57lnZ7xF+l2gu0qA4b9C1cdxOjUDareD1fWgOSNMICG2
   HA4DfXoLlZMTxr4z1PnIzk9oaQ+zNXy4/b7e8ZChPQ8d7OuyQRIJ+rBJa
   gn5CFj+iBEJDnH4WFCKRbIPxQLMTFbNkYZMRQsDwpXwW21vE2Xi1wBrc/
   ZrkWnvzh8WZH4XD8IxClok1JWV3DwwGz+UaurBiNqV0kpK/CMRi7RFF6m
   IKZx9JOl8POduhRWj4ko9R/HZM4evymKQPp8fYFU4otp/p3ixKX9/dtRC
   OjVPfhvYmVf8K13sPtlZezTvUG+jBGAspIfx9eJJTw8VRNA/kf3mCt0ji
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369609029"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="369609029"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 01:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="919613425"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 01:04:36 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     mdf@kernel.org, yilun.xu@intel.com, lee.jones@linaro.org,
        russell.h.weight@intel.com
Cc:     hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 2/3] fpga: m10bmc-sec: add sysfs to load bmc images
Date:   Tue,  5 Jul 2022 04:00:57 -0400
Message-Id: <20220705080058.92532-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220705080058.92532-1-tianfei.zhang@intel.com>
References: <20220705080058.92532-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Add the available_images and image_load sysfs files. The available_images
file returns a space separated list of key words that may be written
into the image_load file. These keywords describe an FPGA, BMC, or
firmware image in FLASH or EEPROM storage that may be loaded.

The image_load sysfs file may be written with a key word to trigger a
reload of an FPGA, BMC, or firmware image from FLASH or EEPROM.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 .../sysfs-driver-intel-m10-bmc-sec-update     |  21 ++++
 drivers/fpga/intel-m10-bmc-sec-update.c       | 104 ++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
index 0a41afe0ab4c..8ded1a59d4db 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
@@ -59,3 +59,24 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
 Description:	Read only. Returns number of times the secure update
 		staging area has been flashed.
 		Format: "%u".
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../control/available_images
+Date:		July 2022
+KernelVersion:  5.20
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. This file returns a space separated list of
+		key words that may be written into the image_load file
+		described below. These keywords decribe an FPGA, BMC,
+		or firmware image in FLASH or EEPROM storage that may
+		be loaded.
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../control/image_load
+Date:		July 2022
+KernelVersion:  5.20
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Write-only. A key word may be written to this file to
+		trigger a reload of an FPGA, BMC, or firmware image from
+		FLASH or EEPROM. Refer to the available_images file for a
+		list of supported key words for the underlying device.
+		Writing an unsupported string to this file will result in
+		EINVAL being returned.
diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 72c677c910de..640690e6c131 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+struct image_load;
+
 struct m10bmc_sec {
 	struct device *dev;
 	struct intel_m10bmc *m10bmc;
@@ -21,6 +23,12 @@ struct m10bmc_sec {
 	char *fw_name;
 	u32 fw_name_id;
 	bool cancel_request;
+	struct image_load *image_load;	/* terminated with { } member */
+};
+
+struct image_load {
+	const char *name;
+	int (*load_image)(struct m10bmc_sec *sec);
 };
 
 static DEFINE_XARRAY_ALLOC(fw_upload_xa);
@@ -137,6 +145,54 @@ DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
 
 #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
 
+static ssize_t available_images_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	const struct image_load *hndlr;
+	ssize_t count = 0;
+
+	for (hndlr = sec->image_load; hndlr->name; hndlr++) {
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "%s ", hndlr->name);
+	}
+
+	buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(available_images);
+
+static ssize_t image_load_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	const struct image_load *hndlr;
+	int ret = -EINVAL;
+
+	for (hndlr = sec->image_load; hndlr->name; hndlr++) {
+		if (sysfs_streq(buf, hndlr->name)) {
+			ret = hndlr->load_image(sec);
+			break;
+		}
+	}
+
+	return ret ? : count;
+}
+static DEVICE_ATTR_WO(image_load);
+
+static struct attribute *m10bmc_control_attrs[] = {
+	&dev_attr_available_images.attr,
+	&dev_attr_image_load.attr,
+	NULL,
+};
+
+static struct attribute_group m10bmc_control_attr_group = {
+	.name = "control",
+	.attrs = m10bmc_control_attrs,
+};
+
 static ssize_t flash_count_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -195,6 +251,7 @@ static struct attribute_group m10bmc_security_attr_group = {
 
 static const struct attribute_group *m10bmc_sec_attr_groups[] = {
 	&m10bmc_security_attr_group,
+	&m10bmc_control_attr_group,
 	NULL,
 };
 
@@ -208,6 +265,52 @@ static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
 		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
 }
 
+static int m10bmc_sec_bmc_image_load(struct m10bmc_sec *sec,
+				     unsigned int val)
+{
+	u32 doorbell;
+	int ret;
+
+	if (val > 1) {
+		dev_err(sec->dev, "invalid reload val = %d\n", val);
+		return -EINVAL;
+	}
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return ret;
+
+	if (doorbell & DRBL_REBOOT_DISABLED)
+		return -EBUSY;
+
+	return m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL,
+				      DRBL_CONFIG_SEL | DRBL_REBOOT_REQ,
+				      FIELD_PREP(DRBL_CONFIG_SEL, val) |
+				      DRBL_REBOOT_REQ);
+}
+
+static int m10bmc_sec_bmc_image_load_0(struct m10bmc_sec *sec)
+{
+	return m10bmc_sec_bmc_image_load(sec, 0);
+}
+
+static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
+{
+	return m10bmc_sec_bmc_image_load(sec, 1);
+}
+
+static struct image_load m10bmc_image_load_hndlrs[] = {
+	{
+		.name = "bmc_factory",
+		.load_image = m10bmc_sec_bmc_image_load_1,
+	},
+	{
+		.name = "bmc_user",
+		.load_image = m10bmc_sec_bmc_image_load_0,
+	},
+	{}
+};
+
 static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
 {
 	u32 doorbell;
@@ -565,6 +668,7 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
 	sec->dev = &pdev->dev;
 	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
 	dev_set_drvdata(&pdev->dev, sec);
+	sec->image_load = m10bmc_image_load_hndlrs;
 
 	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
 		       xa_limit_32b, GFP_KERNEL);
-- 
2.26.2

