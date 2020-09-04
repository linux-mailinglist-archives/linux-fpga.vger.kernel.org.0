Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC625E451
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 01:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgIDXx3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 19:53:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:64701 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgIDXxZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Sep 2020 19:53:25 -0400
IronPort-SDR: vbKgI5QBrK1xcRb1Y1BrWCCxPObzmjGASKbkwEkrT+GMtIMjauRQ8PbqvYZ5hG5mEKtvg2WkAc
 jObqDbebUbCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219386217"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="219386217"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 16:53:20 -0700
IronPort-SDR: CJf/Vfunu4BGZuqI1xOJKfWDJCi/HxKZlKc0vg6+QswWanXRnNguakxc0AeYKVeS1FF1sueeCb
 aHuM6xll6O8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="284656540"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.151.80])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 16:53:19 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 11/12] fpga: expose hardware error info in sysfs
Date:   Fri,  4 Sep 2020 16:53:04 -0700
Message-Id: <20200904235305.6254-12-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
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
Reviewed-by: Wu Hao <hao.wu@intel.com>
---
 .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 14 +++++++
 drivers/fpga/ifpga-sec-mgr.c                  | 38 +++++++++++++++++++
 include/linux/fpga/ifpga-sec-mgr.h            |  5 +++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
index 762a7dee9453..20bde1abb5e4 100644
--- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
@@ -135,3 +135,17 @@ Description:	Read-only. Returns a string describing the failure
 		idle state. If this file is read while a secure
 		update is in progress, then the read will fail with
 		EBUSY.
+
+What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/hw_errinfo
+Date:		Sep 2020
+KernelVersion:  5.10
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
index afd97c135ebe..6944396eff80 100644
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
 
@@ -348,6 +355,23 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
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
@@ -382,6 +406,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 		imgr->filename[strlen(imgr->filename) - 1] = '\0';
 
 	imgr->err_code = IFPGA_SEC_ERR_NONE;
+	imgr->hw_errinfo = 0;
 	imgr->request_cancel = false;
 	imgr->progress = IFPGA_SEC_PROG_READ_FILE;
 	reinit_completion(&imgr->update_done);
@@ -416,18 +441,31 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
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
index f51ed663a723..3be8d8da078a 100644
--- a/include/linux/fpga/ifpga-sec-mgr.h
+++ b/include/linux/fpga/ifpga-sec-mgr.h
@@ -135,6 +135,9 @@ enum ifpga_sec_err {
  *			    function and is called at the completion
  *			    of the update, whether success or failure,
  *			    if the prepare function succeeded.
+ * @get_hw_errinfo:	    Optional: Return u64 hw specific error info.
+ *			    The software err_code may used to determine
+ *			    whether the hw error info is applicable.
  */
 struct ifpga_sec_mgr_ops {
 	sysfs_cnt_hndlr_t user_flash_count;
@@ -158,6 +161,7 @@ struct ifpga_sec_mgr_ops {
 	enum ifpga_sec_err (*poll_complete)(struct ifpga_sec_mgr *imgr);
 	void (*cleanup)(struct ifpga_sec_mgr *imgr);
 	enum ifpga_sec_err (*cancel)(struct ifpga_sec_mgr *imgr);
+	u64 (*get_hw_errinfo)(struct ifpga_sec_mgr *imgr);
 };
 
 /* Update progress codes */
@@ -183,6 +187,7 @@ struct ifpga_sec_mgr {
 	enum ifpga_sec_prog progress;
 	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
 	enum ifpga_sec_err err_code;	/* security manager error code */
+	u64 hw_errinfo;			/* 64 bits of HW specific error info */
 	bool request_cancel;
 	bool driver_unload;
 	void *priv;
-- 
2.17.1

