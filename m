Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE67289EE0
	for <lists+linux-fpga@lfdr.de>; Sat, 10 Oct 2020 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgJJHPe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 10 Oct 2020 03:15:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:37913 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbgJJHPE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 10 Oct 2020 03:15:04 -0400
IronPort-SDR: j+Q4TfG43EKS0pzZGtcDCXmk60BmbPMTx13VKt0bzX76HP8X9+/yClaSXiFvLh6zNsXL6MRBWi
 UNIH4MS+sDuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="165679724"
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="165679724"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 00:15:01 -0700
IronPort-SDR: 9/07aPq/+HcPQvnm7W5iz1iB83xObfD9qmhV6JU6bX95E8OdVdyRzSlHIH7bZ9DAk/ayYOS4vX
 zmCU/igyeE7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="317287995"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 10 Oct 2020 00:14:59 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v9 2/6] fpga: dfl: move dfl_device_id to mod_devicetable.h
Date:   Sat, 10 Oct 2020 15:09:49 +0800
Message-Id: <1602313793-21421-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
patch moves struct dfl_device_id to mod_devicetable.h

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: fix the order for the header file
v3: rebase the patch for dfl bus name change
v9: rebase the patch for dfl bus name changes back to "dfl"
---
 drivers/fpga/dfl.h              | 13 +------------
 include/linux/mod_devicetable.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index ac373b1..549c790 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
@@ -526,18 +527,6 @@ enum dfl_id_type {
 };
 
 /**
- * struct dfl_device_id -  dfl device identifier
- * @type: DFL FIU type of the device. See enum dfl_id_type.
- * @feature_id: feature identifier local to its DFL FIU type.
- * @driver_data: driver specific data.
- */
-struct dfl_device_id {
-	u16 type;
-	u16 feature_id;
-	unsigned long driver_data;
-};
-
-/**
  * struct dfl_device - represent an dfl device on dfl bus
  *
  * @dev: generic device interface.
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5b08a47..66e1405 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -838,4 +838,16 @@ struct mhi_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/**
+ * struct dfl_device_id -  dfl device identifier
+ * @type: DFL FIU type of the device. See enum dfl_id_type.
+ * @feature_id: feature identifier local to its DFL FIU type.
+ * @driver_data: driver specific data.
+ */
+struct dfl_device_id {
+	__u16 type;
+	__u16 feature_id;
+	unsigned long driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
2.7.4

