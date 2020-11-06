Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACE72A8F4D
	for <lists+linux-fpga@lfdr.de>; Fri,  6 Nov 2020 07:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKFGPV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 6 Nov 2020 01:15:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:36328 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgKFGPU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 6 Nov 2020 01:15:20 -0500
IronPort-SDR: 7ZFdBC9g43b/mQUvJ9hpDKXtwLV9tA+PFSqvUGKjXaH0Q9a21c/YkJF63XT+WSMlBaaEzQYWlf
 F8U97u7Bjjnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="233673818"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="233673818"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 22:15:19 -0800
IronPort-SDR: wZVNnmHCTPCsKM3O1p9O4KRhbaOr1gPTNqz/fqv6GnDn92lqFQ9n52csoPHHdngpJRSq/nzv1j
 uQ8fH/r8Q7RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="529700055"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2020 22:15:16 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v12 2/6] fpga: dfl: move dfl_device_id to mod_devicetable.h
Date:   Fri,  6 Nov 2020 14:09:30 +0800
Message-Id: <1604642974-9541-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604642974-9541-1-git-send-email-yilun.xu@intel.com>
References: <1604642974-9541-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
patch moves struct dfl_device_id to mod_devicetable.h

Some brief description for DFL (Device Feature List) is added to make
the DFL known to the whole kernel.

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
v10: add some comments to describe what is DFL
v11: no change
v12: fix the type of driver_data from unsigned long to kernel_ulong_t
---
 drivers/fpga/dfl.h              | 13 +------------
 include/linux/mod_devicetable.h | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

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
index 5b08a47..7d36c8c 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -838,4 +838,28 @@ struct mhi_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/*
+ * DFL (Device Feature List)
+ *
+ * DFL defines a linked list of feature headers within the device MMIO space to
+ * provide an extensible way of adding features. Software can walk through these
+ * predefined data structures to enumerate features. It is now used in the FPGA.
+ * See Documentation/fpga/dfl.rst for more information.
+ *
+ * The dfl bus type is introduced to match the individual feature devices (dfl
+ * devices) for specific dfl drivers.
+ */
+
+/**
+ * struct dfl_device_id -  dfl device identifier
+ * @type: DFL FIU type of the device. See enum dfl_id_type.
+ * @feature_id: feature identifier local to its DFL FIU type.
+ * @driver_data: driver specific data.
+ */
+struct dfl_device_id {
+	__u16 type;
+	__u16 feature_id;
+	kernel_ulong_t driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
2.7.4

