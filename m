Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6831529CCF
	for <lists+linux-fpga@lfdr.de>; Tue, 17 May 2022 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbiEQIlc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 May 2022 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243845AbiEQIl3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 May 2022 04:41:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD52AE1;
        Tue, 17 May 2022 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652776888; x=1684312888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UQpWUmGLp4Oj7CWq7C8ttsNpIWRrZDf0YaCaJl29o50=;
  b=Ad/ng89cSCo5i62a9AIRvL2lZRUJYqAtRGSP4YvoIJ9XOxnnZpNRj3Hf
   ym+qsQJ7YccWcIuZbcjk8N7rHCRAfvbzewyC9I5NgiYjfNRnR4kd/3xAC
   E0uajdU9B71jCMJ1jTpRhcfb8sZyUdXAvEHChq00/otmO2O0rTM9YXrWv
   yYLu4qhVt9KA3SsRmEP3eVrJAUSX4DUggABk9CfkF7hNNJxwHjJXEza7M
   uvbaRU3UwHaxcTvkOBYVsciVwSsPXyMixz/rrzywJRORswxN7WJQBeq+/
   CJ7EA14cSlBluFOozAzTkCbhTQZ9ecUDNnGuQdwQJy9exxAaHGQbmLoeC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="296388698"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="296388698"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 01:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="555677538"
Received: from pglc1026.png.intel.com ([172.30.19.132])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2022 01:41:24 -0700
From:   adrian.ho.yin.ng@intel.com
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>,
        Alan Tull <atull@opensource.altera.com>
Subject: [PATCH 1/3] fpga: Implement DebugFS for FPGA Manager Framework
Date:   Tue, 17 May 2022 16:41:22 +0800
Message-Id: <20220517084122.2605-1-adrian.ho.yin.ng@intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>

Implement DebugFS for the FPGA Manager Framework.

Each FPGA gets its own directory such as
 <debugfs>/fpga_manager/fpga0 and three files:

 * [RW] flags          = flags as defined in fpga-mgr.h
 * [RW] firmware_name  = write/read back name of FPGA image
                         firmware file to program
 * [WO] image          = write-only file for directly writing
                         fpga image w/o firmware layer

Enabled by CONFIG_FPGA_MGR_DEBUG_FS

Signed-off-by: Alan Tull <atull@opensource.altera.com>
Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
---
 drivers/fpga/Kconfig            |   7 ++
 drivers/fpga/Makefile           |   1 +
 drivers/fpga/fpga-mgr-debugfs.c | 183 ++++++++++++++++++++++++++++++++
 drivers/fpga/fpga-mgr-debugfs.h |  32 ++++++
 drivers/fpga/fpga-mgr.c         |   8 ++
 include/linux/fpga/fpga-mgr.h   |   3 +
 6 files changed, 234 insertions(+)
 create mode 100644 drivers/fpga/fpga-mgr-debugfs.c
 create mode 100644 drivers/fpga/fpga-mgr-debugfs.h

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 991b3f361ec9..dd6bf04dadc2 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -10,6 +10,13 @@ menuconfig FPGA
 	  kernel.  The FPGA framework adds an FPGA manager class and FPGA
 	  manager drivers.
 
+config FPGA_MGR_DEBUG_FS
+	bool "FPGA Manager DebugFS"
+	depends on FPGA && DEBUG_FS
+	help
+	  Say Y here if you want to expose a DebugFS interface for the
+	  FPGA Manager Framework.
+
 if FPGA
 
 config FPGA_MGR_SOCFPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 0bff783d1b61..e896554010da 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -5,6 +5,7 @@
 
 # Core FPGA Manager Framework
 obj-$(CONFIG_FPGA)			+= fpga-mgr.o
+obj-$(CONFIG_FPGA_MGR_DEBUG_FS)		+= fpga-mgr-debugfs.o
 
 # FPGA Manager Drivers
 obj-$(CONFIG_FPGA_MGR_ALTERA_CVP)	+= altera-cvp.o
diff --git a/drivers/fpga/fpga-mgr-debugfs.c b/drivers/fpga/fpga-mgr-debugfs.c
new file mode 100644
index 000000000000..30af59b92bf3
--- /dev/null
+++ b/drivers/fpga/fpga-mgr-debugfs.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Manager DebugFS
+ *
+ *  Copyright (C) 2016 Intel Corporation.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/debugfs.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+static struct dentry *fpga_mgr_debugfs_root;
+
+struct fpga_mgr_debugfs {
+	struct dentry *debugfs_dir;
+	char *firmware_name;
+	struct fpga_image_info info;
+};
+
+static ssize_t fpga_mgr_firmware_write_file(struct file *file,
+					    const char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	struct fpga_manager *mgr = file->private_data;
+	struct fpga_mgr_debugfs *debugfs = mgr->debugfs;
+	char *buf;
+	int ret;
+
+	buf = kzalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	buf[count] = 0;
+	if (buf[count - 1] == '\n')
+		buf[count - 1] = 0;
+
+	kfree(debugfs->firmware_name);
+	debugfs->firmware_name = buf;
+
+	ret = fpga_mgr_firmware_load(mgr, &debugfs->info, buf);
+	if (ret)
+		dev_err(&mgr->dev,
+			"fpga_mgr_firmware_load returned with value %d\n", ret);
+
+	return count;
+}
+
+static ssize_t fpga_mgr_firmware_read_file(struct file *file,
+					   char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct fpga_manager *mgr = file->private_data;
+	struct fpga_mgr_debugfs *debugfs = mgr->debugfs;
+	char *buf;
+	int ret;
+
+	if (debugfs->firmware_name == NULL)
+		return 0;
+
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = snprintf(buf, PAGE_SIZE, "%s\n", debugfs->firmware_name);
+	if (ret < 0) {
+		kfree(buf);
+		return ret;
+	}
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations fpga_mgr_firmware_fops = {
+	.open = simple_open,
+	.read = fpga_mgr_firmware_read_file,
+	.write = fpga_mgr_firmware_write_file,
+	.llseek = default_llseek,
+};
+
+static ssize_t fpga_mgr_image_write_file(struct file *file,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct fpga_manager *mgr = file->private_data;
+	struct fpga_mgr_debugfs *debugfs = mgr->debugfs;
+	char *buf;
+	int ret;
+
+	dev_info(&mgr->dev, "writing %d bytes to %s\n", count, mgr->name);
+
+	buf = kzalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	/* If firmware interface was previously used, forget it. */
+	kfree(debugfs->firmware_name);
+	debugfs->firmware_name = NULL;
+
+	ret = fpga_mgr_buf_load(mgr, &debugfs->info, buf, count);
+	if (ret)
+		dev_err(&mgr->dev,
+		       "fpga_mgr_buf_load returned with value %d\n", ret);
+
+	return count;
+}
+
+static const struct file_operations fpga_mgr_image_fops = {
+	.open = simple_open,
+	.write = fpga_mgr_image_write_file,
+	.llseek = default_llseek,
+};
+
+void fpga_mgr_debugfs_add(struct fpga_manager *mgr)
+{
+	struct fpga_mgr_debugfs *debugfs;
+	struct fpga_image_info *info;
+
+	if (!fpga_mgr_debugfs_root)
+		return;
+
+	debugfs = kzalloc(sizeof(*debugfs), GFP_KERNEL);
+	if (!debugfs)
+		return;
+
+	debugfs->debugfs_dir = debugfs_create_dir(dev_name(&mgr->dev),
+						  fpga_mgr_debugfs_root);
+
+	debugfs_create_file("firmware_name", 0600, debugfs->debugfs_dir, mgr,
+			    &fpga_mgr_firmware_fops);
+
+	debugfs_create_file("image", 0200, debugfs->debugfs_dir, mgr,
+			    &fpga_mgr_image_fops);
+
+	info = &debugfs->info;
+	debugfs_create_u32("flags", 0600, debugfs->debugfs_dir, &info->flags);
+
+	mgr->debugfs = debugfs;
+}
+
+void fpga_mgr_debugfs_remove(struct fpga_manager *mgr)
+{
+	struct fpga_mgr_debugfs *debugfs = mgr->debugfs;
+
+	if (!fpga_mgr_debugfs_root)
+		return;
+
+	debugfs_remove_recursive(debugfs->debugfs_dir);
+	kfree(debugfs->firmware_name);
+	kfree(debugfs);
+}
+
+void fpga_mgr_debugfs_init(void)
+{
+	fpga_mgr_debugfs_root = debugfs_create_dir("fpga_manager", NULL);
+	if (!fpga_mgr_debugfs_root)
+		pr_warn("fpga_mgr: Failed to create debugfs root\n");
+}
+
+void fpga_mgr_debugfs_uninit(void)
+{
+	debugfs_remove_recursive(fpga_mgr_debugfs_root);
+}
diff --git a/drivers/fpga/fpga-mgr-debugfs.h b/drivers/fpga/fpga-mgr-debugfs.h
new file mode 100644
index 000000000000..394da0c62237
--- /dev/null
+++ b/drivers/fpga/fpga-mgr-debugfs.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * FPGA Manager DebugFS
+ *
+ *  Copyright (C) 2016 Intel Corporation.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+
+void fpga_mgr_debugfs_add(struct fpga_manager *mgr);
+void fpga_mgr_debugfs_remove(struct fpga_manager *mgr);
+void fpga_mgr_debugfs_init(void);
+void fpga_mgr_debugfs_uninit(void);
+
+#else
+
+void fpga_mgr_debugfs_add(struct fpga_manager *mgr) {}
+void fpga_mgr_debugfs_remove(struct fpga_manager *mgr) {}
+void fpga_mgr_debugfs_init(void) {}
+void fpga_mgr_debugfs_uninit(void) {}
+
+#endif /* CONFIG_FPGA_MGR_DEBUG_FS */
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d49a9ce34568..9e9c1f2ebf2b 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/highmem.h>
+#include "fpga-mgr-debugfs.h"
 
 static DEFINE_IDA(fpga_mgr_ida);
 static struct class *fpga_mgr_class;
@@ -658,6 +659,8 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 		return ERR_PTR(ret);
 	}
 
+	fpga_mgr_debugfs_add(mgr);
+
 	return mgr;
 
 error_device:
@@ -708,6 +711,8 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 {
 	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
 
+	fpga_mgr_debugfs_remove(mgr);
+
 	/*
 	 * If the low level driver provides a method for putting fpga into
 	 * a desired state upon unregister, do it.
@@ -800,11 +805,14 @@ static int __init fpga_mgr_class_init(void)
 	fpga_mgr_class->dev_groups = fpga_mgr_groups;
 	fpga_mgr_class->dev_release = fpga_mgr_dev_release;
 
+	fpga_mgr_debugfs_init();
+
 	return 0;
 }
 
 static void __exit fpga_mgr_class_exit(void)
 {
+	fpga_mgr_debugfs_uninit();
 	class_destroy(fpga_mgr_class);
 	ida_destroy(&fpga_mgr_ida);
 }
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0f9468771bb9..ef7a4fa1448c 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -191,6 +191,9 @@ struct fpga_manager {
 	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
 	void *priv;
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	void *debugfs;
+#endif
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
-- 
2.26.2

