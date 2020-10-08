Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40E4286C08
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Oct 2020 02:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgJHARQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Oct 2020 20:17:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:22302 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbgJHAQ6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Oct 2020 20:16:58 -0400
IronPort-SDR: 798Im+U0I4wWakwfT9Ep1buKFKze6Zvj0eY+xGt4UYZJIL6xZz6nVy0zAM6Hhv72vMGlNYAkuV
 jjlDThNll0tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="182629369"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="182629369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:16:55 -0700
IronPort-SDR: QWEKayX20vQy4HYpCnTEoVIWT/LrIW6IgZKg5WnPJlAVRWFHfE76H05ii+kfMtpXFN0aXckMUG
 yusKpwmMa4yA==
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="355169302"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.1.22])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:16:54 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 7/7] fpga: sec-mgr: expose hardware error info
Date:   Wed,  7 Oct 2020 17:16:41 -0700
Message-Id: <20201008001641.28305-8-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008001641.28305-1-russell.h.weight@intel.com>
References: <20201008001641.28305-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Security Manager class driver to include
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
v4:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
    and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
v3:
  - No change
v2:
  - Bumped documentation date and version
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 14 +++++++
 drivers/fpga/fpga-sec-mgr.c                   | 38 +++++++++++++++++++
 include/linux/fpga/fpga-sec-mgr.h             |  5 +++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index 814271aede05..5a2dad0d0941 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -127,3 +127,17 @@ Description:	Read-only. Returns a string describing the failure
 		idle state. If this file is read while a secure
 		update is in progress, then the read will fail with
 		EBUSY.
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/hw_errinfo
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
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index 40a526ff8fa4..75d0cf6d9fa0 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -152,10 +152,17 @@ static void set_error(struct fpga_sec_mgr *smgr, enum fpga_sec_err err_code)
 	smgr->err_code = err_code;
 }
 
+static void set_hw_errinfo(struct fpga_sec_mgr *smgr)
+{
+	if (smgr->sops->get_hw_errinfo)
+		smgr->hw_errinfo = smgr->sops->get_hw_errinfo(smgr);
+}
+
 static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 			       enum fpga_sec_err err_code)
 {
 	set_error(smgr, err_code);
+	set_hw_errinfo(smgr);
 	smgr->sops->cancel(smgr);
 }
 
@@ -371,6 +378,23 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(error);
 
+static ssize_t
+hw_errinfo_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+	int ret;
+
+	mutex_lock(&smgr->lock);
+	if (smgr->progress != FPGA_SEC_PROG_IDLE)
+		ret = -EBUSY;
+	else
+		ret = sprintf(buf, "0x%llx\n", smgr->hw_errinfo);
+	mutex_unlock(&smgr->lock);
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
 
 	smgr->err_code = FPGA_SEC_ERR_NONE;
+	smgr->hw_errinfo = 0;
 	smgr->request_cancel = false;
 	smgr->progress = FPGA_SEC_PROG_READING;
 	reinit_completion(&smgr->update_done);
@@ -436,18 +461,31 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(cancel);
 
+static umode_t
+sec_mgr_update_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(kobj_to_dev(kobj));
+
+	if (attr == &dev_attr_hw_errinfo.attr && !smgr->sops->get_hw_errinfo)
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
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
index 168ce9c26a08..1e83a1f7ce31 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -60,6 +60,9 @@ enum fpga_sec_err {
  *			    function and is called at the completion
  *			    of the update, whether success or failure,
  *			    if the prepare function succeeded.
+ * @get_hw_errinfo:	    Optional: Return u64 hw specific error info.
+ *			    The software err_code may used to determine
+ *			    whether the hw error info is applicable.
  */
 struct fpga_sec_mgr_ops {
 	int (*user_flash_count)(struct fpga_sec_mgr *smgr);
@@ -87,6 +90,7 @@ struct fpga_sec_mgr_ops {
 	enum fpga_sec_err (*poll_complete)(struct fpga_sec_mgr *smgr);
 	void (*cleanup)(struct fpga_sec_mgr *smgr);
 	enum fpga_sec_err (*cancel)(struct fpga_sec_mgr *smgr);
+	u64 (*get_hw_errinfo)(struct fpga_sec_mgr *smgr);
 };
 
 /* Update progress codes */
@@ -112,6 +116,7 @@ struct fpga_sec_mgr {
 	enum fpga_sec_prog progress;
 	enum fpga_sec_prog err_state;	/* progress state at time of failure */
 	enum fpga_sec_err err_code;	/* security manager error code */
+	u64 hw_errinfo;			/* 64 bits of HW specific error info */
 	bool request_cancel;
 	bool driver_unload;
 	void *priv;
-- 
2.17.1

