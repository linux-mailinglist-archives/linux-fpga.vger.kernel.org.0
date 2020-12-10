Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9545B2D62C4
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Dec 2020 17:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392373AbgLJQ7T (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Dec 2020 11:59:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40148 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392369AbgLJQ7F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Dec 2020 11:59:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id t7so4655495pfh.7
        for <linux-fpga@vger.kernel.org>; Thu, 10 Dec 2020 08:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2GZ+ePoFiu9QiVFXfkzqTqbUH2vMpi+ch5sofOIR7Q=;
        b=dzplKMQTvDRzZz/ldQGN9+0wHPRPVUmDG81sbJ8OqUsFlQZf03/unwVWl3TojR7j1n
         Tv/xTpMUynvd/BtUDcvgejPBCd926X6J8luyMz6UXirDLMlCrWGVEI0QSsClj2IwperI
         CQ2+pS6jGa+Zqc6axZGAGssl0xQkPqyUzEzu9sA9FspKx2vGOGXSgU0X4p7oQ6Lxt8zc
         P6teUUTechDJFp34rS0CbvaN+EAtDC2Om698BA6XK356bTcaqqoJgokR/YJI/tYG59OW
         5B7e9eJLgWTJTjYOgPmJZWjf1+QKAYgMyUh+6OjVts935621XdfSv9ctmOQIUDsPbDFX
         8bGg==
X-Gm-Message-State: AOAM5305yjKpmVacPFs6gTY6GWSwnJsz6fJt3cD7fSpRdj2SaQY/pY/z
        A1yXV5YDLqG510kCTu/9/8M=
X-Google-Smtp-Source: ABdhPJxYn72jlzshOuLIRhMdbvr/rsQ2gyHpHPcLykN9hYEGAxbP2oGzr58b7EGoXj3hZHIdKMRbdg==
X-Received: by 2002:a62:7b86:0:b029:19d:f996:44f3 with SMTP id w128-20020a627b860000b029019df99644f3mr7591086pfc.65.1607619505042;
        Thu, 10 Dec 2020 08:58:25 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id k14sm6842070pfp.132.2020.12.10.08.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:58:24 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 4/8] fpga: dfl: move dfl_device_id to mod_devicetable.h
Date:   Thu, 10 Dec 2020 08:58:00 -0800
Message-Id: <20201210165804.44234-5-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210165804.44234-1-mdf@kernel.org>
References: <20201210165804.44234-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>

In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
patch moves struct dfl_device_id to mod_devicetable.h

Some brief description for DFL (Device Feature List) is added to make
the DFL known to the whole kernel.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl.h              | 13 +------------
 include/linux/mod_devicetable.h | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index ac373b1fcff9..549c7900dcfd 100644
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
@@ -525,18 +526,6 @@ enum dfl_id_type {
 	DFL_ID_MAX,
 };
 
-/**
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
 /**
  * struct dfl_device - represent an dfl device on dfl bus
  *
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5b08a473cdba..7d36c8c0fdc2 100644
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
2.29.2

