Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4FF39E54D
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Jun 2021 19:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhFGR0c (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Jun 2021 13:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231419AbhFGR0a (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Jun 2021 13:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623086678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiUiVni7HRdj/fMNccMqDWFIL2bqdt7yewe5StEQKT4=;
        b=HQQGv6mIytMd7BUnIy67/R/p6DsptBa1RwESHBsND7Qx28fcBo7BQBbv3m9LZSNp7D27zt
        uUtXWIPLHfuYupyGnAqbsKaZZJGy8NsAf3Izqo8GlYIrYBNoUIQ6TD9FDv9gga5i+gqy2k
        HOoa8/wMZv8I/m3vdjxWrpFGS2mPuTQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-uIDnbsZgOaaYjd35k--VjQ-1; Mon, 07 Jun 2021 13:24:37 -0400
X-MC-Unique: uIDnbsZgOaaYjd35k--VjQ-1
Received: by mail-oo1-f72.google.com with SMTP id b9-20020a4a87890000b0290248cb841124so9400243ooi.4
        for <linux-fpga@vger.kernel.org>; Mon, 07 Jun 2021 10:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tiUiVni7HRdj/fMNccMqDWFIL2bqdt7yewe5StEQKT4=;
        b=i6rRYVsNHRecJsVNCaem0lji9SgXFNgWJlHjvQ+ugkaKk4Y5I6lazP1HG+7U9pMJ5K
         megpvl3MSeUPc+YES50paieaqfaj0LHR5HmkI/8vllDZTwsB1YrSURTYfM1DKBB2vp1g
         /hDG5Ktz45qb2eNiaxpXMxoIPWEW4mYxprJ+rQlxHeyqh9XPKu7kEUYnGj9IQGyl0PqC
         8CjpX88N7aKyFbxqGkoXKETmQ7UHxbR2EV9X9YS6KP6HvIIxJSXkPG/YQFo71Ax/D81X
         ui89ei2g/6ljtPSFj+CdLkiDwuaLRkFdDoPhpavh3M0M62WIljSvWfO79eGMob99SaVo
         baiQ==
X-Gm-Message-State: AOAM5335dz5d2JTkWmttgEvz9Ui1P7WCjsFOiNCnsY+bB+NQwapIK1cF
        76W+mRf95wiANc0MxdzYoQAP5RsWpq343etXZj2O2Iszy4+GFN8LFN004Jq9ZGVVLR2JG62udQj
        5m41f8RU825ZGMUMeXJr7qA==
X-Received: by 2002:a05:6808:985:: with SMTP id a5mr156775oic.42.1623086677110;
        Mon, 07 Jun 2021 10:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX3CF8WfnS+aeD9xD/trkVT+VJIk8ws9Dd+CpNLkE8C8DuDcq2UDWOfKRoaNzbTM3tQfIkeg==
X-Received: by 2002:a05:6808:985:: with SMTP id a5mr156764oic.42.1623086676962;
        Mon, 07 Jun 2021 10:24:36 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm2409859oij.26.2021.06.07.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:24:36 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 7/7] fpga: collect wrappers and change to inline
Date:   Mon,  7 Jun 2021 10:24:02 -0700
Message-Id: <20210607172402.2938697-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210607172402.2938697-1-trix@redhat.com>
References: <20210607172402.2938697-1-trix@redhat.com>
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
index 84808c7ca440..198a44a62058 100644
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

