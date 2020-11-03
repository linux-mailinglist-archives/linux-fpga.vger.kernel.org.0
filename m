Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD7A2A3D79
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgKCHVW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:21:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32957 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCHVV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:21:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id b19so8163784pld.0
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inYJkkmj+hglF0hl9VW5FqoaH1VFBfk/UnPb1jfM00w=;
        b=opK2XSvGgQI76saXXf0mUUPBqzq9IYDBj5WUiZO1w3GtjtisX4qNNqyFFTlYb3XAfd
         o8hU+GDHYeq6qZAnph9YFS4WWAhJwMqX9zejlgrUaacKyfAfqzTwK/XwtCaxxjdFljAc
         l4dkY38xXeaAK9ADzXMn7Rz0WTZA7N9gzSZ9z7r843QYsa035EemeICpqUlLqEKa1CF4
         bxg/t0yfbLR4/ztXNQ/s0M7DVbRiAduAukYFJRE8w9dd6LFyNQKOfoLv9SHV2zdCdayu
         CgsAQVbTj5+frdTgGCqbu6iICnf2/s1zCrlzSY05WLJ9eoOqbPrWwXV2+//O7GkldlBa
         lrHA==
X-Gm-Message-State: AOAM531urkkxdiOakDbLTMnyUHVAvwEQQx5us+ZM7HHG4FTOeQYrtUI2
        pNwxJGpXhofbC0CuCvMeQNc=
X-Google-Smtp-Source: ABdhPJyeJDwuQU3x3wBQVaPke9Zx+QggAIRDzLh89uDPfWIZ/+rj9EVYQoKkeNVz2hUW9Xc3FjSo/A==
X-Received: by 2002:a17:902:e788:b029:d6:dc69:80a8 with SMTP id cp8-20020a170902e788b02900d6dc6980a8mr4190254plb.59.1604388081055;
        Mon, 02 Nov 2020 23:21:21 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id cv4sm1961092pjb.1.2020.11.02.23.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:21:20 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/4] fpga: dfl: move dfl_device_id to mod_devicetable.h
Date:   Mon,  2 Nov 2020 23:21:02 -0800
Message-Id: <20201103072104.12361-3-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103072104.12361-1-mdf@kernel.org>
References: <20201103072104.12361-1-mdf@kernel.org>
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
index 5b08a473cdba..e4870e5d3ea8 100644
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
+	unsigned long driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
2.29.2

