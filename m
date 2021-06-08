Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D543A04BA
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 21:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhFHT52 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 15:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234697AbhFHT5R (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 15:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PX4XZRO4KpflUQEEgbL1ALBIADgPV7/V/iBUfhH7FVc=;
        b=Pv4Xt7SroJnz32APMAGIyGl89ObyPui3/nLVxm6uvDBWfoRh4FIkE0/F8NLVnMxAmab0hK
        mmfTEwfHKEgwhfJsis0s343efv1RU2MVJebqFiX7N6ws1ZK8EK6lb2WGzpftLLe68+Whof
        paMaV4IS0+qzFSJRZhyBEyiQOeVgDV8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-CPY-3tdfMLGlfFHnUuQyUA-1; Tue, 08 Jun 2021 15:55:22 -0400
X-MC-Unique: CPY-3tdfMLGlfFHnUuQyUA-1
Received: by mail-oo1-f69.google.com with SMTP id o21-20020a4ae5950000b0290211a73e7f50so13946694oov.12
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 12:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PX4XZRO4KpflUQEEgbL1ALBIADgPV7/V/iBUfhH7FVc=;
        b=gR40HI4FZJSfXJwJGWjHc+62atvyLDsYREE+1ljDufGVOlkCIfw/+Wf4BKD/DKph7s
         chE9X8tQjZmXElVuYX/jdugy2Lh4c+W+u6pI/sc6S4z47+BoNODcVySqWRfsksB1+Nlm
         L3bQvJYgGvcAt41f2G7O6ZswF4+e86IXrmOYzh0iPGesC9udXJ5XaMy9fI7nyyRvldzE
         UvIEY6bLyjUQVJrHI9d35ZrPCSem4o+ZdeuVAjouL0R4xfn+XGdwMXK+CfIsIpZB08Au
         h44Gia2hxDx/iuVY86Kw2vWNE5SgEc0586R0WnM5LbHaYbjq3Zet/wYh0PCAK0zrenEk
         ox0A==
X-Gm-Message-State: AOAM532qrOq+IMhIXzUn2xe/Q1/bf2F3pROoRTfproRRethYiSKYbrpb
        GPydCBrxkk2EhFlF5RqY7mfvwUh7OLq+4SAZYKi1BkaLvJF8RLMY/Ydt6JY8GWdDRBVR1RJNG51
        nR7BNYZOoI0qoMPcZWPEYig==
X-Received: by 2002:aca:af90:: with SMTP id y138mr3986011oie.92.1623182121634;
        Tue, 08 Jun 2021 12:55:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0UWwhNSy55xmGBEwarxMH51IQL5Vz8zCfespiQs2F3hecQ7wjI2E6o8F7F63GFd/GyJsx9g==
X-Received: by 2002:aca:af90:: with SMTP id y138mr3986000oie.92.1623182121452;
        Tue, 08 Jun 2021 12:55:21 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:21 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 7/7] fpga-mgr: collect wrappers and change to inline
Date:   Tue,  8 Jun 2021 12:55:06 -0700
Message-Id: <20210608195506.3022550-9-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Anyone searching for the wrappers should find all of
them together, so  move the wrappers.

Since they are all small functions, make them inline.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 117 ++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 84808c7ca4406..198a44a620583 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,65 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+/* mops wrappers */
+static inline enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->state)
+		return  mgr->mops->state(mgr);
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->status)
+		return mgr->mops->status(mgr);
+	return 0;
+}
+
+static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t count)
+{
+	if (mgr->mops && mgr->mops->write_init)
+		return  mgr->mops->write_init(mgr, info, buf, count);
+	return 0;
+}
+
+static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	if (mgr->mops && mgr->mops->write)
+		return  mgr->mops->write(mgr, buf, count);
+	return -EOPNOTSUPP;
+}
+
+/*
+ * After all the FPGA image has been written, do the device specific steps to
+ * finish and set the FPGA into operating mode.
+ */
+static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	int ret = 0;
+
+	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
+	if (mgr->mops && mgr->mops->write_complete)
+		ret = mgr->mops->write_complete(mgr, info);
+	if (ret) {
+		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
+		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
+		return ret;
+	}
+	mgr->state = FPGA_MGR_STATE_OPERATING;
+
+	return 0;
+}
+
+static inline void fpga_mgr_fpga_remove(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->fpga_remove)
+		mgr->mops->fpga_remove(mgr);
+}
+
 /**
  * fpga_image_info_alloc - Allocate a FPGA image info struct
  * @dev: owning device
@@ -69,14 +128,6 @@ void fpga_image_info_free(struct fpga_image_info *info)
 }
 EXPORT_SYMBOL_GPL(fpga_image_info_free);
 
-static int fpga_mgr_write_init(struct fpga_manager *mgr,
-			       struct fpga_image_info *info,
-			       const char *buf, size_t count)
-{
-	if (mgr->mops && mgr->mops->write_init)
-		return  mgr->mops->write_init(mgr, info, buf, count);
-	return 0;
-}
 /*
  * Call the low level driver's write_init function.  This will do the
  * device-specific things to get the FPGA into the state where it is ready to
@@ -145,35 +196,6 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	return ret;
 }
 
-/*
- * After all the FPGA image has been written, do the device specific steps to
- * finish and set the FPGA into operating mode.
- */
-static int fpga_mgr_write_complete(struct fpga_manager *mgr,
-				   struct fpga_image_info *info)
-{
-	int ret = 0;
-
-	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	if (mgr->mops && mgr->mops->write_complete)
-		ret = mgr->mops->write_complete(mgr, info);
-	if (ret) {
-		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
-		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
-		return ret;
-	}
-	mgr->state = FPGA_MGR_STATE_OPERATING;
-
-	return 0;
-}
-
-static int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
-{
-	if (mgr->mops && mgr->mops->write)
-		return  mgr->mops->write(mgr, buf, count);
-	return -EOPNOTSUPP;
-}
-
 /**
  * fpga_mgr_buf_load_sg - load fpga from image in buffer from a scatter list
  * @mgr:	fpga manager
@@ -426,14 +448,6 @@ static ssize_t state_show(struct device *dev,
 	return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
-static u64 fpga_mgr_status(struct fpga_manager *mgr)
-{
-	if (mgr->mops && mgr->mops->status)
-		return mgr->mops->status(mgr);
-
-	return 0;
-}
-
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -692,13 +706,6 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
 
-static enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
-{
-	if (mgr->mops && mgr->mops->state)
-		return  mgr->mops->state(mgr);
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
 /**
  * fpga_mgr_register - register a FPGA manager
  * @mgr: fpga manager struct
@@ -731,12 +738,6 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
-static void fpga_mgr_fpga_remove(struct fpga_manager *mgr)
-{
-	if (mgr->mops && mgr->mops->fpga_remove)
-		mgr->mops->fpga_remove(mgr);
-}
-
 /**
  * fpga_mgr_unregister - unregister a FPGA manager
  * @mgr: fpga manager struct
-- 
2.26.3

