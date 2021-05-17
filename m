Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B053822C9
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEQCeM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:12 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:34588 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhEQCeM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:12 -0400
Received: by mail-pl1-f169.google.com with SMTP id h7so2315947plt.1
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSSYdCtIQxbcyAXdS71tqSOcp2D/L0mRXKz8gwWCGqg=;
        b=GvmU0wwhquo05QrVBD9WpA5FvGDYedKmQvoGZ0AVWQyG8fJ2RZw3tBkSeb5YSNmOJk
         BOdORsJ0AL+ofbG9Ev+Nw0GaGhmXFUn6hcrTQlcV9RIWgI23jhoClsSi7WoN6/x/o/0z
         VbS1XptPZKCs+958K0UAeezvBKONhGxDye6DiYeQWcxjJd8swXWNCK2LVRFfVbCE7oOl
         87HTbgY8FekNYmYtjs6tZfEQtQzgX5z5ot8Hvc7UPZuAzozeNE2mIdKnJkbGVI8ND6Au
         /tRS5zPRCJW0/G/hMrwTdt4Z4Y5ASlrkZqhFLN7HGuvFjDG3Sl2Sc7X3S/xkdELiuYf7
         9GCw==
X-Gm-Message-State: AOAM530AcsSmufH4L+spcyFOltIB2UbnlosDPiqB1Os6R19MpBwsKMaq
        YgvtD45EgkwQeUncPlq48xM=
X-Google-Smtp-Source: ABdhPJw5cfDe7LbztmX8Gzl0ryHcZBaDO079W7Un492Qn6ifkFv+MwClbeRCjwpHXzkgKg/P5zvE5A==
X-Received: by 2002:a17:902:ea0c:b029:f0:af3d:c5d6 with SMTP id s12-20020a170902ea0cb02900f0af3dc5d6mr12742855plg.45.1621218775814;
        Sun, 16 May 2021 19:32:55 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o3sm9039109pgh.22.2021.05.16.19.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:32:55 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 07/12] fpga: sec-mgr: expose hardware error info
Date:   Sun, 16 May 2021 19:31:55 -0700
Message-Id: <20210517023200.52707-8-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517023200.52707-1-mdf@kernel.org>
References: <20210517023200.52707-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

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
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 14 +++++++
 drivers/fpga/fpga-sec-mgr.c                   | 38 +++++++++++++++++++
 include/linux/fpga/fpga-sec-mgr.h             |  5 +++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index 749f2d4c78d3..f1881ce39c63 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -65,3 +65,17 @@ Description:	Read-only. Returns a string describing the failure
 		idle state. If this file is read while a secure
 		update is in progress, then the read will fail with
 		EBUSY.
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/hw_errinfo
+Date:		June 2021
+KernelVersion:	5.14
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
index 48950843c2b4..cefe9182c3c3 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -36,10 +36,17 @@ static void fpga_sec_set_error(struct fpga_sec_mgr *smgr, enum fpga_sec_err err_
 	smgr->err_code = err_code;
 }
 
+static void fpga_sec_set_hw_errinfo(struct fpga_sec_mgr *smgr)
+{
+	if (smgr->sops->get_hw_errinfo)
+		smgr->hw_errinfo = smgr->sops->get_hw_errinfo(smgr);
+}
+
 static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 			       enum fpga_sec_err err_code)
 {
 	fpga_sec_set_error(smgr, err_code);
+	fpga_sec_set_hw_errinfo(smgr);
 	smgr->sops->cancel(smgr);
 }
 
@@ -221,6 +228,23 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
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
+		ret = sysfs_emit(buf, "0x%llx\n", smgr->hw_errinfo);
+	mutex_unlock(&smgr->lock);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(hw_errinfo);
+
 static ssize_t remaining_size_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -252,6 +276,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	smgr->err_code = FPGA_SEC_ERR_NONE;
+	smgr->hw_errinfo = 0;
 	smgr->request_cancel = false;
 	smgr->progress = FPGA_SEC_PROG_READING;
 	reinit_completion(&smgr->update_done);
@@ -286,18 +311,31 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
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
index 0e1f50434024..a99bfd28f38c 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -40,6 +40,9 @@ enum fpga_sec_err {
  *			    function and is called at the completion
  *			    of the update, whether success or failure,
  *			    if the prepare function succeeded.
+ * @get_hw_errinfo:	    Optional: Return u64 hw specific error info.
+ *			    The software err_code may used to determine
+ *			    whether the hw error info is applicable.
  */
 struct fpga_sec_mgr_ops {
 	enum fpga_sec_err (*prepare)(struct fpga_sec_mgr *smgr);
@@ -47,6 +50,7 @@ struct fpga_sec_mgr_ops {
 	enum fpga_sec_err (*poll_complete)(struct fpga_sec_mgr *smgr);
 	enum fpga_sec_err (*cancel)(struct fpga_sec_mgr *smgr);
 	void (*cleanup)(struct fpga_sec_mgr *smgr);
+	u64 (*get_hw_errinfo)(struct fpga_sec_mgr *smgr);
 };
 
 /* Update progress codes */
@@ -72,6 +76,7 @@ struct fpga_sec_mgr {
 	enum fpga_sec_prog progress;
 	enum fpga_sec_prog err_state;	/* progress state at time of failure */
 	enum fpga_sec_err err_code;	/* security manager error code */
+	u64 hw_errinfo;			/* 64 bits of HW specific error info */
 	bool request_cancel;
 	bool driver_unload;
 	void *priv;
-- 
2.31.1

