Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572E9285536
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Oct 2020 02:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgJGAKu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 20:10:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:3655 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgJGAKg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Oct 2020 20:10:36 -0400
IronPort-SDR: RjnwJJYZNIQxzA71e22N3IMshLqgABXt6u1BQ3OLMIAf46rtTgPhi7ffG1mtPn02w/dBm6VGyz
 e7YxunhxuLhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="162139590"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="162139590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:35 -0700
IronPort-SDR: Y1itfisCdUvGkgr1g9A/ITdSsc6bPwBWEi63vny5UwNUcsJEg8wyPSeuULX9TkjSushlRuc04D
 oaNFbuL/uyDg==
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="297380482"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.2.223])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:35 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 7/7] fpga: sec-mgr: expose hardware error info
Date:   Tue,  6 Oct 2020 17:10:04 -0700
Message-Id: <20201007001004.23790-8-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007001004.23790-1-russell.h.weight@intel.com>
References: <20201007001004.23790-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the Intel Security Manager class driver to include
an optional update/hw_errinfo sysfs node that can be used
to retrieve 64 bits of device specific error information
following a secure update failure.

The underlying driver must provide a get_hw_errinfo() callback
function to enable this feature. This data is treated as
opaque by the class driver. It is left to user-space software
or support personnel to interpret this data.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3:
  - No change
v2:
  - Bumped documentation date and version
---
 .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 14 +++++++
 drivers/fpga/ifpga-sec-mgr.c                  | 38 +++++++++++++++++++
 include/linux/fpga/ifpga-sec-mgr.h            |  5 +++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
index caafe7eb7670..37a335ff4936 100644
--- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
@@ -127,3 +127,17 @@ Description:	Read-only. Returns a string describing the failure
 		idle state. If this file is read while a secure
 		update is in progress, then the read will fail with
 		EBUSY.
+
+What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/hw_errinfo
+Date:		Oct 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a 64 bit error value providing
+		hardware specific information that may be useful in
+		debugging errors that occur during FPGA image updates.
+		This file is only visible if the underlying device
+		supports it. The hw_errinfo value is only accessible
+		when the secure update engine is in the idle state.
+		If this file is read while a secure update is in
+		progress, then the read will fail with EBUSY.
+		Format: "0x%llx".
diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
index 23914ef87f2d..0fd621f984dc 100644
--- a/drivers/fpga/ifpga-sec-mgr.c
+++ b/drivers/fpga/ifpga-sec-mgr.c
@@ -152,10 +152,17 @@ static void set_error(struct ifpga_sec_mgr *imgr, enum ifpga_sec_err err_code)
 	imgr->err_code = err_code;
 }
 
+static void set_hw_errinfo(struct ifpga_sec_mgr *imgr)
+{
+	if (imgr->iops->get_hw_errinfo)
+		imgr->hw_errinfo = imgr->iops->get_hw_errinfo(imgr);
+}
+
 static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
 				enum ifpga_sec_err err_code)
 {
 	set_error(imgr, err_code);
+	set_hw_errinfo(imgr);
 	imgr->iops->cancel(imgr);
 }
 
@@ -371,6 +378,23 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(error);
 
+static ssize_t
+hw_errinfo_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
+	int ret;
+
+	mutex_lock(&imgr->lock);
+	if (imgr->progress != IFPGA_SEC_PROG_IDLE)
+		ret = -EBUSY;
+	else
+		ret = sprintf(buf, "0x%llx\n", imgr->hw_errinfo);
+	mutex_unlock(&imgr->lock);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(hw_errinfo);
+
 static ssize_t remaining_size_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -402,6 +426,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	imgr->err_code = IFPGA_SEC_ERR_NONE;
+	imgr->hw_errinfo = 0;
 	imgr->request_cancel = false;
 	imgr->progress = IFPGA_SEC_PROG_READING;
 	reinit_completion(&imgr->update_done);
@@ -436,18 +461,31 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(cancel);
 
+static umode_t
+sec_mgr_update_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(kobj_to_dev(kobj));
+
+	if (attr == &dev_attr_hw_errinfo.attr && !imgr->iops->get_hw_errinfo)
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_cancel.attr,
 	&dev_attr_status.attr,
 	&dev_attr_error.attr,
 	&dev_attr_remaining_size.attr,
+	&dev_attr_hw_errinfo.attr,
 	NULL,
 };
 
 static struct attribute_group sec_mgr_update_attr_group = {
 	.name = "update",
 	.attrs = sec_mgr_update_attrs,
+	.is_visible = sec_mgr_update_visible,
 };
 
 static ssize_t name_show(struct device *dev,
diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
index 890be0800b05..baf4fe876164 100644
--- a/include/linux/fpga/ifpga-sec-mgr.h
+++ b/include/linux/fpga/ifpga-sec-mgr.h
@@ -60,6 +60,9 @@ enum ifpga_sec_err {
  *			    function and is called at the completion
  *			    of the update, whether success or failure,
  *			    if the prepare function succeeded.
+ * @get_hw_errinfo:	    Optional: Return u64 hw specific error info.
+ *			    The software err_code may used to determine
+ *			    whether the hw error info is applicable.
  */
 struct ifpga_sec_mgr_ops {
 	int (*user_flash_count)(struct ifpga_sec_mgr *imgr);
@@ -87,6 +90,7 @@ struct ifpga_sec_mgr_ops {
 	enum ifpga_sec_err (*poll_complete)(struct ifpga_sec_mgr *imgr);
 	void (*cleanup)(struct ifpga_sec_mgr *imgr);
 	enum ifpga_sec_err (*cancel)(struct ifpga_sec_mgr *imgr);
+	u64 (*get_hw_errinfo)(struct ifpga_sec_mgr *imgr);
 };
 
 /* Update progress codes */
@@ -112,6 +116,7 @@ struct ifpga_sec_mgr {
 	enum ifpga_sec_prog progress;
 	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
 	enum ifpga_sec_err err_code;	/* security manager error code */
+	u64 hw_errinfo;			/* 64 bits of HW specific error info */
 	bool request_cancel;
 	bool driver_unload;
 	void *priv;
-- 
2.17.1

