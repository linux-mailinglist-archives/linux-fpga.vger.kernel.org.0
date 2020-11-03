Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5123C2A3D78
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCHVW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:21:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35555 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHVV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:21:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id f38so12999746pgm.2
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OOpWyyHN6uEjTvvh/CVgoIUoFWTPjExj/lMI6RgwbCs=;
        b=FeZSkAWcCh00kT1Dh9uSZOzqPWHzUPmYWJtsb93AiBuJzdB181HlvB84/0TFANjnop
         HuIYCz6Omr/HRulTyTmclR6koMh60loTSib32gIPaV2sfPNBjnpuTy7XST730UpzmCUd
         HULDN1RuXqUbhV/2dnLGy2B7N2Rib6rynp7Zlf6vABNne/7Jdm+idGP0xHSahITCFvDl
         2knR+/F1xSn2Cc/k2s5IxJLAu3EIWPYX11GKhv+arRLnlZkRqSHgVc7wnduVKTt9uYuz
         OGxgAX6tMqv8cMpa+yqNJsZmxkJQNVe0CrU+1JPRXzbTtg/Iy9rWDdBcCHCt8FSMYiSM
         62wg==
X-Gm-Message-State: AOAM533b5tOL4MzjKLnBRHFsls3uWLu74fHQA0PsMREaWWDHmySUzdzk
        3c+TiJAcJMw9m2nJfFSa9Y0=
X-Google-Smtp-Source: ABdhPJyZ46fJyMlfSYG/hN1MaxfeIP9tzsSxvDbslRAOFhEVOzum4WDewVzMirmUfSkUX/ou9zsDzA==
X-Received: by 2002:a17:90a:4295:: with SMTP id p21mr2395451pjg.217.1604388079739;
        Mon, 02 Nov 2020 23:21:19 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id e23sm15388992pfi.191.2020.11.02.23.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:21:19 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/4] fpga: dfl: fix the definitions of type & feature_id for dfl devices
Date:   Mon,  2 Nov 2020 23:21:01 -0800
Message-Id: <20201103072104.12361-2-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103072104.12361-1-mdf@kernel.org>
References: <20201103072104.12361-1-mdf@kernel.org>
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
2.29.2

