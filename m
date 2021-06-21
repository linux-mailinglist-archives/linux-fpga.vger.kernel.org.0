Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2153AE3BF
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 09:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFUHIw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 03:08:52 -0400
Received: from first.geanix.com ([116.203.34.67]:54102 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhFUHIs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 03:08:48 -0400
Received: from 185.17.218.86 (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id DD7B34C3BB7;
        Mon, 21 Jun 2021 07:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=silicom.dk; s=first;
        t=1624259192; bh=EvJBXmKpD9XzIULYTA8pUFWOTf4A6/iiDUj0U5hdSvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a4r9ikf51N/FMGhXyLfg7J0FfBqo+3CMlW6iDiIN/fAshKci3ArsTgT9y/Qd3PXm7
         V/dfn6TTtmDz2B3k/hgvHtPuzD+Df6JyDuYZ521ki/QlGLzKaovoSK47Bd+NNIjqtr
         G3/bKFlmtA4izfChXzQjAxKIlOs8tmP7GK1EWifItkLrXs4y7VaAcH+wwSpKQo4nT/
         DPWx7yI6UdMX0dkILu/M0tfMXJNrvQJxIaLcoKoDYUbs1rdfkiDRTghHzNObOiKJZr
         ua7416nnJYNCQ6aUI21EbUmdJr1T7SaqWlwfVNMIfW9QhXvrYr8YfDeS7FEoAlc+zk
         1mBerE5LRxKwg==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        Debarati Biswas <debaratix.biswas@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
Subject: [PATCH 2/4] fpga: dfl: Move DFH header register macros to linux/dfl.h
Date:   Mon, 21 Jun 2021 09:06:19 +0200
Message-Id: <20210621070621.431482-3-mhu@silicom.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210621070621.431482-1-mhu@silicom.dk>
References: <20210621070621.431482-1-mhu@silicom.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,TVD_RCVD_IP,TVD_RCVD_IP4,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Debarati Biswas <debaratix.biswas@intel.com>

Device Feature List (DFL) drivers may be defined in subdirectories other
than drivers/fpga, and each DFL driver should have access to the Device
Feature Header (DFH) register, which contains revision and type
information. This change moves the macros specific to the DFH register
from drivers/fpga/dfl.h to include/linux/dfl.h.

Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---
 drivers/fpga/dfl.h  | 48 +----------------------------------------
 include/linux/dfl.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2b82c96ba56c..6ed0353e9a99 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/cdev.h>
 #include <linux/delay.h>
+#include <linux/dfl.h>
 #include <linux/eventfd.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
@@ -53,32 +54,6 @@
 #define PORT_FEATURE_ID_UINT		0x12
 #define PORT_FEATURE_ID_STP		0x13
 
-/*
- * Device Feature Header Register Set
- *
- * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
- * For AFUs, they have DFH + GUID as common header registers.
- * For private features, they only have DFH register as common header.
- */
-#define DFH			0x0
-#define GUID_L			0x8
-#define GUID_H			0x10
-#define NEXT_AFU		0x18
-
-#define DFH_SIZE		0x8
-
-/* Device Feature Header Register Bitfield */
-#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
-#define DFH_ID_FIU_FME		0
-#define DFH_ID_FIU_PORT		1
-#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
-#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
-#define DFH_EOL			BIT_ULL(40)		/* End of list */
-#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
-#define DFH_TYPE_AFU		1
-#define DFH_TYPE_PRIVATE	3
-#define DFH_TYPE_FIU		4
-
 /* Next AFU Register Bitfield */
 #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
 
@@ -403,27 +378,6 @@ struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
 	return pdata->dev->dev.parent->parent;
 }
 
-static inline bool dfl_feature_is_fme(void __iomem *base)
-{
-	u64 v = readq(base + DFH);
-
-	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
-		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_FME);
-}
-
-static inline bool dfl_feature_is_port(void __iomem *base)
-{
-	u64 v = readq(base + DFH);
-
-	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
-		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
-}
-
-static inline u8 dfl_feature_revision(void __iomem *base)
-{
-	return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
-}
-
 /**
  * struct dfl_fpga_enum_info - DFL FPGA enumeration information
  *
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 6cc10982351a..1cd86b2e7cb1 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -8,7 +8,9 @@
 #ifndef __LINUX_DFL_H
 #define __LINUX_DFL_H
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/mod_devicetable.h>
 
 /**
@@ -83,4 +85,54 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
 	module_driver(__dfl_driver, dfl_driver_register, \
 		      dfl_driver_unregister)
 
+/*
+ * Device Feature Header Register Set
+ *
+ * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
+ * For AFUs, they have DFH + GUID as common header registers.
+ * For private features, they only have DFH register as common header.
+ */
+#define DFH                     0x0
+#define GUID_L                  0x8
+#define GUID_H                  0x10
+#define NEXT_AFU                0x18
+
+#define DFH_SIZE                0x8
+
+/* Device Feature Header Register Bitfield */
+#define DFH_ID                  GENMASK_ULL(11, 0)      /* Feature ID */
+#define DFH_ID_FIU_FME          0
+#define DFH_ID_FIU_PORT         1
+#define DFH_REVISION            GENMASK_ULL(15, 12)
+#define DFH_NEXT_HDR_OFST       GENMASK_ULL(39, 16)     /* Offset to next DFH */
+#define DFH_EOL                 BIT_ULL(40)             /* End of list */
+#define DFH_TYPE                GENMASK_ULL(63, 60)     /* Feature type */
+#define DFH_TYPE_AFU            1
+#define DFH_TYPE_PRIVATE        3
+#define DFH_TYPE_FIU            4
+
+/* Function to read from DFH and check if the Feature type is FME */
+static inline bool dfl_feature_is_fme(void __iomem *base)
+{
+	u64 v = readq(base + DFH);
+
+	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
+		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_FME);
+}
+
+/* Function to read from DFH and check if the Feature type is port*/
+static inline bool dfl_feature_is_port(void __iomem *base)
+{
+	u64 v = readq(base + DFH);
+
+	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
+		 (FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
+}
+
+/* Function to read feature revision from DFH */
+static inline u8 dfl_feature_revision(void __iomem *base)
+{
+	return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
+}
+
 #endif /* __LINUX_DFL_H */
-- 
2.31.0

