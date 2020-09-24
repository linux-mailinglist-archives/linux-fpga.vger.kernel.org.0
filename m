Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C12A277773
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgIXRH2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 13:07:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:17534 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgIXRH1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Sep 2020 13:07:27 -0400
IronPort-SDR: IcAq4YF0EfChAftKdxfXtIfqjLvk/pjOpg4kv3ErDvN9Kpc8E47mAOGUTwIbwGnxaZbgkMZlrj
 4UMi/fW2E4Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="222866243"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="222866243"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 10:04:56 -0700
IronPort-SDR: QEhXEq69vUQkkY+ZNoWXk/TZ8ChoQ5D47WuUPBYz6ut9nxRxWq35gU2sp18/opAWRO6bBnf5ig
 eeFKWY71B+1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="511697159"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2020 10:04:54 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 3/5] fpga: dfl: move fpga_dfl_device_id to mod_devicetable.h
Date:   Fri, 25 Sep 2020 00:59:59 +0800
Message-Id: <1600966801-30586-4-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
References: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
patch moves struct fpga_dfl_device_id to mod_devicetable.h

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
---
 drivers/fpga/dfl.h              | 13 +------------
 include/linux/mod_devicetable.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 78f7c6f..4a42d26 100644
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
@@ -526,18 +527,6 @@ enum fpga_dfl_id_type {
 };
 
 /**
- * struct fpga_dfl_device_id - fpga dfl device identifier
- * @type: FPGA DFL FIU type of the device, see enum fpga_dfl_id_type.
- * @feature_id: feature identifier local to its FPGA DFL FIU type.
- * @driver_data: driver specific data.
- */
-struct fpga_dfl_device_id {
-	u16 type;
-	u16 feature_id;
-	unsigned long driver_data;
-};
-
-/**
  * struct fpga_dfl_device - represent an fpga dfl device on fpga dfl bus
  *
  * @dev: generic device interface.
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5b08a47..ca24a4b 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -838,4 +838,16 @@ struct mhi_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/**
+ * struct fpga_dfl_device_id - fpga dfl device identifier
+ * @type: FPGA DFL FIU type of the device, see enum fpga_dfl_id_type.
+ * @feature_id: feature identifier local to its FPGA DFL FIU type.
+ * @driver_data: driver specific data.
+ */
+struct fpga_dfl_device_id {
+	__u16 type;
+	__u16 feature_id;
+	unsigned long driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
2.7.4

