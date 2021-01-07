Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6B62EC975
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jan 2021 05:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbhAGEjH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Jan 2021 23:39:07 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:44188 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbhAGEjG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jan 2021 23:39:06 -0500
Received: by mail-pl1-f179.google.com with SMTP id r4so2838351pls.11;
        Wed, 06 Jan 2021 20:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYbrm0ZiujLK1nLan2rBPbUudD/EAiQPvy8ngGQPV/c=;
        b=lGTZCP9WhIffsTlS9VVbxqAGfjvirwVP5SmtPDp9BdFLGpw+voei8Ls1V9Mum2w2fU
         9aVuTqZoPRTwIi3sXE2DZP9sjES0mFK2TBdKgCF7dUO7CbwMb7d4ZqNU+NfpJq19C2O4
         syUgngqcUaTni6LAn8urUbIFeuLLxz0YBqqWwGp689uMHmcXmZ+5GTBJ8bzau4yfYCi2
         mxHdMkXuUJ/OWyLezra3KIKwbM26+39Ru8eiuy8ZrbIQqZtC0qlSqGCHjv1f374FV+xC
         oYayOvVXte81CYRahRsYYN8gDfIzbiiLpH/mV597pjI2ZUS3Oy+HTSXDpocSceV19bg8
         VjPg==
X-Gm-Message-State: AOAM531UcBLVvon1mBT2qmZ/w/KjvDSLRq7Azqv3HJyAhN2YZ3QKHlje
        Actu+DOPqUfSSKE4C/ZDyvY=
X-Google-Smtp-Source: ABdhPJwGKTIiRGR+vS6+8fIe2rfVtan4sezwHKxAHFYQe+CxUDexE32n8PiV39pCbg7rPoXMM+StqA==
X-Received: by 2002:a17:90a:df0d:: with SMTP id gp13mr7372759pjb.151.1609994305593;
        Wed, 06 Jan 2021 20:38:25 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u12sm3871764pfn.88.2021.01.06.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 20:38:24 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 3/8] fpga: dfl: fix the definitions of type & feature_id for dfl devices
Date:   Wed,  6 Jan 2021 20:37:09 -0800
Message-Id: <20210107043714.991646-4-mdf@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107043714.991646-1-mdf@kernel.org>
References: <20210107043714.991646-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>

The value of the field dfl_device.type comes from the 12 bits register
field DFH_ID according to DFL spec. So this patch changes the definition
of the type field to u16.

Also it is not necessary to illustrate the valid bits of the type field
in comments. Instead we should explicitly define the possible values in
the enumeration type for it, because they are shared by hardware spec.
We should not let the compiler decide these values.

Similar changes are also applied to dfl_device.feature_id.

This patch also fixed the MODALIAS format according to the changes
above.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl.c |  3 +--
 drivers/fpga/dfl.h | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b450870b75ed..5a6ba3b2fa05 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -298,8 +298,7 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct dfl_device *ddev = to_dfl_dev(dev);
 
-	/* The type has 4 valid bits and feature_id has 12 valid bits */
-	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
+	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",
 			      ddev->type, ddev->feature_id);
 }
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 5dc758f655b7..ac373b1fcff9 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -520,19 +520,19 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
  * enum dfl_id_type - define the DFL FIU types
  */
 enum dfl_id_type {
-	FME_ID,
-	PORT_ID,
+	FME_ID = 0,
+	PORT_ID = 1,
 	DFL_ID_MAX,
 };
 
 /**
  * struct dfl_device_id -  dfl device identifier
- * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
- * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
+ * @type: DFL FIU type of the device. See enum dfl_id_type.
+ * @feature_id: feature identifier local to its DFL FIU type.
  * @driver_data: driver specific data.
  */
 struct dfl_device_id {
-	u8 type;
+	u16 type;
 	u16 feature_id;
 	unsigned long driver_data;
 };
@@ -543,7 +543,7 @@ struct dfl_device_id {
  * @dev: generic device interface.
  * @id: id of the dfl device.
  * @type: type of DFL FIU of the device. See enum dfl_id_type.
- * @feature_id: 16 bits feature identifier local to its DFL FIU type.
+ * @feature_id: feature identifier local to its DFL FIU type.
  * @mmio_res: mmio resource of this dfl device.
  * @irqs: list of Linux IRQ numbers of this dfl device.
  * @num_irqs: number of IRQs supported by this dfl device.
@@ -553,7 +553,7 @@ struct dfl_device_id {
 struct dfl_device {
 	struct device dev;
 	int id;
-	u8 type;
+	u16 type;
 	u16 feature_id;
 	struct resource mmio_res;
 	int *irqs;
-- 
2.30.0

