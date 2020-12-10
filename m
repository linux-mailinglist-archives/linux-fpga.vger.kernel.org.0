Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430C82D62C1
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Dec 2020 17:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392367AbgLJQ7L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Dec 2020 11:59:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46105 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391047AbgLJQ7C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Dec 2020 11:59:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id v3so3058736plz.13
        for <linux-fpga@vger.kernel.org>; Thu, 10 Dec 2020 08:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FB/dx3m3KpkN+8L+NF1K6qL9jxEZGu8bEPcBWOE4EPE=;
        b=IptAvlSAtFtqUGjFdiZwTeDr6n7vAkxLvmOuz/+rRp41IdE1QhLgKBwGtr9kbdmOIG
         ORXJTOzYKxyGwUp58IWqDcg76M5bjc5xClIFIyaW77vI+1skZxz+fmHk0+42PLr4XY/b
         k1k5Iv0Uy/fK8gxOtsbq7I3/3ABDcBMZo0icJKdKJWAPZJ64kxV5cHXmHFGk9gn7YmKE
         uK2dnMgTwJCHeanVtfLBx7RTVWB2dAIWLW4EoPCMwUW8OOx/z1z5wmd8gK5QDJfl36Xw
         eIxTX8beVlP/jJObEeg+bzQE3cDH9zJ6bhn1Z6hxaHM8W/N+FnIdil8gvhAbkyuFd4Mb
         Rh4g==
X-Gm-Message-State: AOAM532jT/xFmNRmMaTqF+CMUV6IAzxTe7a0+gRSRZa8KKHdBN+jKUaa
        l4rrnUkxftHL5zOlsW3axgk=
X-Google-Smtp-Source: ABdhPJyFFMcOtrRutS0+HYwS5RuXWLx1qzbyP1PbzP0tCFUu8hKcJp7MMk+LNxBidGG1Ku5K+Seuow==
X-Received: by 2002:a17:902:8649:b029:d9:fcd9:522a with SMTP id y9-20020a1709028649b02900d9fcd9522amr7289863plt.83.1607619501431;
        Thu, 10 Dec 2020 08:58:21 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id c8sm7081791pgg.51.2020.12.10.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:58:20 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 3/8] fpga: dfl: fix the definitions of type & feature_id for dfl devices
Date:   Thu, 10 Dec 2020 08:57:59 -0800
Message-Id: <20201210165804.44234-4-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210165804.44234-1-mdf@kernel.org>
References: <20201210165804.44234-1-mdf@kernel.org>
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
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Tom Rix <trix@redhat.com>
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
2.29.2

