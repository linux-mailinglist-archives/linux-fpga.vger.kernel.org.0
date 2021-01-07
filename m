Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9A2EC970
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jan 2021 05:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbhAGEjI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Jan 2021 23:39:08 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:42106 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbhAGEjI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jan 2021 23:39:08 -0500
Received: by mail-pl1-f179.google.com with SMTP id s15so2840396plr.9;
        Wed, 06 Jan 2021 20:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GR5ExBzuWIYoAA/XH65FzpS/TmI5axXrOYOLHsZSJbc=;
        b=XDW3CWpp3OPM1EsnzmVQs0IB5EKySGwgTwBBgKb3HDffx51hQR/wo0m1BWWPPMfCZE
         FKnptzDazXOHBDHl2Kx42WG0uQNw0QC8LWJs0CGqMxoBcKpuATrzAiaNr66D1jQt3WIr
         +dwhY6Wk3uzY6Fe4DHK8U2EqeXd1r+tT4TTUM5CucUei7XtC+XJ9y7bUGj1bQc2maP94
         1tS8kO9TUpU+Vfw1wu+GB6pC2gMSWzSdRn8eQUMO7CcGoutWf7l1h77OT8QCKpXgOWKI
         q9lxCMDRuolL1kkmOuwh7K27/CtHX67FPhryyW9N8RFgvrie8f+rRCdOWPvyrEE06RBG
         xG/Q==
X-Gm-Message-State: AOAM530LiHeSPhKT+6EVDLIgMSt9ciObLHjxC7GrqChZy1tH7AbpLhVG
        yKabhrh6bPjwZJIphElOWzQ=
X-Google-Smtp-Source: ABdhPJxwaHLEDl7ksobiWhzPD+qQZ/eMR0u5VzqYQzRvPj2dAdPJm9HUPVLt1MugDZs8WBOZuTUFXg==
X-Received: by 2002:a17:90a:d58c:: with SMTP id v12mr7548380pju.37.1609994307323;
        Wed, 06 Jan 2021 20:38:27 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a22sm3945343pfa.215.2021.01.06.20.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 20:38:26 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 4/8] fpga: dfl: move dfl_device_id to mod_devicetable.h
Date:   Wed,  6 Jan 2021 20:37:10 -0800
Message-Id: <20210107043714.991646-5-mdf@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107043714.991646-1-mdf@kernel.org>
References: <20210107043714.991646-1-mdf@kernel.org>
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
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
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
index c425290b21e2..b8dae34eca10 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -846,4 +846,28 @@ struct auxiliary_device_id {
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
2.30.0

