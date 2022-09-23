Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6B5E7AA7
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiIWMWp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 08:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiIWMV6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 08:21:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25108135047;
        Fri, 23 Sep 2022 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663935451; x=1695471451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3/jDHfEgmt1mU16f2cag46kqaswEiQqco0ejWollM4=;
  b=VYXetGqXpU9SMfAdQIVeDkI86yECh6mGv77EkcCLk2j5vddFZ+IE8o1C
   jTlxdcfeOJ7bqzychE8XFgI541V5vO/aLdRuBGTfmavZC3wzHcqVGARlh
   IVHNAPpeemXaibAAb7o6o1w9sXAB933Z5vCDYhWbmSgNceKfwH69iT/4l
   vdVZmj3GlnwSlUxlHHUG3Yu9BYlluXlUPRaSxxQUREu5AJT49BASvkwbd
   +mhnmboiJNnMbdwV1j89qj0Q6cJcdEX2vSHZEtOfDiy2clyB63ZFSGf29
   JgJ1755WJELHl7EwB24ECOGYyrF+VzubQwpNqoArDB+In2ovmMK6NWsQI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364595273"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="364595273"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:17:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="762597732"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:17:30 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Cc:     Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 2/6] fpga: dfl: Move the DFH definitions
Date:   Fri, 23 Sep 2022 05:17:41 -0700
Message-Id: <20220923121745.129167-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>

Moving the DFH register offset and register definitions from
drivers/fpga/dfl.h to include/linux/dfl.h. These definitions
need to be accessed by dfl drivers that are outside of
drivers/fpga.

Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v2: remove extra space in commit
    use uniform number of digits in constants
    don't change copyright date because of removed content
---
 drivers/fpga/dfl-afu-main.c |  4 ++--
 drivers/fpga/dfl.c          |  2 +-
 drivers/fpga/dfl.h          | 20 +-------------------
 include/linux/dfl.h         | 33 ++++++++++++++++++++++++++++++++-
 4 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7f621e96d3b8..c26961ee33db 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -468,8 +468,8 @@ afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 		return -EBUSY;
 	}
 
-	guidl = readq(base + GUID_L);
-	guidh = readq(base + GUID_H);
+	guidl = readq(base + DFH_GUID_L);
+	guidh = readq(base + DFH_GUID_H);
 	mutex_unlock(&pdata->lock);
 
 	return scnprintf(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b9aae85ba930..1132f3c10440 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1163,7 +1163,7 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 	 * find and parse FIU's child AFU via its NEXT_AFU register.
 	 * please note that only Port has valid NEXT_AFU pointer per spec.
 	 */
-	v = readq(binfo->ioaddr + NEXT_AFU);
+	v = readq(binfo->ioaddr + DFH_NEXT_AFU);
 
 	offset = FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
 	if (offset)
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 06cfcd5e84bb..e620fcb02b5a 100644
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
@@ -53,28 +54,9 @@
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
 /* Device Feature Header Register Bitfield */
-#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
 #define DFH_ID_FIU_FME		0
 #define DFH_ID_FIU_PORT		1
-#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
-#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
-#define DFH_EOL			BIT_ULL(40)		/* End of list */
-#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
 #define DFH_TYPE_AFU		1
 #define DFH_TYPE_PRIVATE	3
 #define DFH_TYPE_FIU		4
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 431636a0dc78..33d167c53b09 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -2,7 +2,7 @@
 /*
  * Header file for DFL driver and device API
  *
- * Copyright (C) 2020 Intel Corporation, Inc.
+ * Copyright (C) 2020-2022 Intel Corporation, Inc.
  */
 
 #ifndef __LINUX_DFL_H
@@ -11,6 +11,37 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 
+/*
+ * Device Feature Header Register Set
+ *
+ * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
+ * For AFUs, they have DFH + GUID as common header registers.
+ * For private features, they only have DFH register as common header.
+ */
+#define DFH			0x00
+#define DFH_GUID_L		0x08
+#define DFH_GUID_H		0x10
+#define DFH_NEXT_AFU		0x18
+
+/*
+ * DFHv1 Register Offset definitons
+ * In DHFv1, DFH + GUID + CSR_START + CSR_SIZE_GROUP + PARAM_HDR + PARAM_DATA
+ * as common header registers
+ */
+#define DFHv1_CSR_ADDR		0x18  /* CSR Register start address */
+#define DFHv1_CSR_SIZE_GRP	0x20  /* Size of Reg Block and Group/tag */
+#define DFHv1_PARAM_HDR		0x28  /* Optional First Param header */
+#define DFHv1_PARAM_DATA	0x08  /* Offset of Param data from Param header */
+
+#define DFH_SIZE		0x08
+
+/* Device Feature Header Register Bitfield */
+#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
+#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
+#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
+#define DFH_EOL			BIT_ULL(40)		/* End of list */
+#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
+
 /**
  * enum dfl_id_type - define the DFL FIU types
  */
-- 
2.25.1

