Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF12260A5D
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Sep 2020 07:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgIHFxP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Sep 2020 01:53:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:17184 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgIHFxO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 8 Sep 2020 01:53:14 -0400
IronPort-SDR: SjLQXLSRjh+Ct/S8j6wY4YOmaDKJ4S5Ncjczd5qMwO3TnYP8tRyDWoKaxB+3JybYix2mmAJfh1
 CW07qNlWLErw==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="138124882"
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="138124882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 22:53:14 -0700
IronPort-SDR: EPRfI1Rg/d5lvXgNfvE/JbdSrnF/EzkAp76ndX952xC1Y/yMyA49IeJiTkTXSIZMmogWZ542dB
 5j8XKHsTBOnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="504934381"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2020 22:53:12 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 1/3] fpga: dfl: move dfl_device_id to mod_devicetable.h
Date:   Tue,  8 Sep 2020 13:48:47 +0800
Message-Id: <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
patch moves struct dfl_device_id to mod_devicetable.h

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/fpga/dfl.h              | 13 +------------
 include/linux/mod_devicetable.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 5dc758f..d5b0760 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/uuid.h>
 #include <linux/fpga/fpga-region.h>
+#include <linux/mod_devicetable.h>
 
 /* maximum supported number of ports */
 #define MAX_DFL_FPGA_PORT_NUM 4
@@ -526,18 +527,6 @@ enum dfl_id_type {
 };
 
 /**
- * struct dfl_device_id -  dfl device identifier
- * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
- * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
- * @driver_data: driver specific data.
- */
-struct dfl_device_id {
-	u8 type;
-	u16 feature_id;
-	unsigned long driver_data;
-};
-
-/**
  * struct dfl_device - represent an dfl device on dfl bus
  *
  * @dev: generic device interface.
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5b08a47..407d8dc 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -838,4 +838,16 @@ struct mhi_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/**
+ * struct dfl_device_id -  dfl device identifier
+ * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
+ * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
+ * @driver_data: driver specific data.
+ */
+struct dfl_device_id {
+	__u8 type;
+	__u16 feature_id;
+	kernel_ulong_t driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
2.7.4

