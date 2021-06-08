Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0548A3A04B9
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 21:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhFHT51 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 15:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234639AbhFHT5O (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 15:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KD9jjN3L1AODL3xYyQk4Owi0Be8ipyYlfv9872RELmE=;
        b=HH3OzAGnutskXHKksYrZISwUecFJNhUKAoGqQLHJzgjBa7wfC1fLeYv5hlhfrYyoFWOsUP
        /tVERhO2r7dg3iUcHJcyjkt82lw1dIbuDw3I9CCUgvLtORuITtUvja3c+/YlVnMmn5dDfZ
        hIu2j6ADq9Stc5e+zi+k1TeaZMso2fI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-7ObKQvy4MmSVcW3J0zoLFQ-1; Tue, 08 Jun 2021 15:55:19 -0400
X-MC-Unique: 7ObKQvy4MmSVcW3J0zoLFQ-1
Received: by mail-oi1-f198.google.com with SMTP id j1-20020aca65410000b02901f1d632e208so8034832oiw.16
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 12:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KD9jjN3L1AODL3xYyQk4Owi0Be8ipyYlfv9872RELmE=;
        b=iOihMUAGGfNiUVaIXlNb4kmSOcW2XXBBxp9OHVEe1CG7Bixe8VeL/0iYPg+qkDrTI/
         bqjdXArBNGo5bTI44PftNiHZ6IsmDWQQOLUkDkhpFQWadzHX2DhotYR+YHkcYnaZTOeP
         r7ontIoltpFhckK8+dqrSCCg42h2rGOZs+gMH0/jmmes7lW4eGwf0K7DpYL5FqhuBW/B
         Wh+GRRrpPPpWXQ6lRqFlmz7+0PifrQMDdLGOxDsP0nNwEYXoJpVQKXxyyEctpdwCPgV9
         g1JWEl6I1z6Pvn1piR1CtIHa259Uh84qh7UGc1nWUtPFN7A3oN0UtIo/8ERprbrjDORu
         9oOA==
X-Gm-Message-State: AOAM533H5OkDLmaObxCqYs2AsAqNcC2SEss947J2D8Lc7iFHchghIQxY
        DZpHM8vd/oZjFw5L2peT19BsC5vkTFJ8y3k3PO+I0vkRuCQIdHwPIvO+SqwL7kUjRkFGwF2N0EU
        fzzDOY3utAoCfTt7PuzgoLg==
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr19421575otq.303.1623182118955;
        Tue, 08 Jun 2021 12:55:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykl5o+u9RLuM4h3jotxgiDysFbOa6laysW8rYMHSawSoGYmKyN8um5Gh7iRgeUty8a9wXpEA==
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr19421563otq.303.1623182118802;
        Tue, 08 Jun 2021 12:55:18 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:18 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 5/7] fpga-mgr: wrap the state() op
Date:   Tue,  8 Jun 2021 12:55:04 -0700
Message-Id: <20210608195506.3022550-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager should not be required to provide a state() op.
Add a wrapper consistent with the other op wrappers.
Move op check to wrapper.
Default to FPGA_MGR_STATE_UNKNOWN, what noop state() ops use.
Remove unneeded noop state() ops

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-fme-mgr.c   |  6 ------
 drivers/fpga/fpga-mgr.c      | 11 +++++++++--
 drivers/fpga/stratix10-soc.c |  6 ------
 drivers/fpga/ts73xx-fpga.c   |  6 ------
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b3069..313420405d5e8 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -252,11 +252,6 @@ static int fme_mgr_write_complete(struct fpga_manager *mgr,
 	return 0;
 }
 
-static enum fpga_mgr_states fme_mgr_state(struct fpga_manager *mgr)
-{
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
 static u64 fme_mgr_status(struct fpga_manager *mgr)
 {
 	struct fme_mgr_priv *priv = mgr->priv;
@@ -268,7 +263,6 @@ static const struct fpga_manager_ops fme_mgr_ops = {
 	.write_init = fme_mgr_write_init,
 	.write = fme_mgr_write,
 	.write_complete = fme_mgr_write_complete,
-	.state = fme_mgr_state,
 	.status = fme_mgr_status,
 };
 
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index cc531f0537acf..d06752be9c6ef 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -589,7 +589,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->state) {
+	if (!mops) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
@@ -692,6 +692,13 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
 
+static enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->state)
+		return  mgr->mops->state(mgr);
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
 /**
  * fpga_mgr_register - register a FPGA manager
  * @mgr: fpga manager struct
@@ -707,7 +714,7 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 	 * from device.  FPGA may be in reset mode or may have been programmed
 	 * by bootloader or EEPROM.
 	 */
-	mgr->state = mgr->mops->state(mgr);
+	mgr->state = fpga_mgr_state(mgr);
 
 	ret = device_add(&mgr->dev);
 	if (ret)
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c5fc996..5219fa1b555af 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -388,13 +388,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 	return ret;
 }
 
-static enum fpga_mgr_states s10_ops_state(struct fpga_manager *mgr)
-{
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
 static const struct fpga_manager_ops s10_ops = {
-	.state = s10_ops_state,
 	.write_init = s10_ops_write_init,
 	.write = s10_ops_write,
 	.write_complete = s10_ops_write_complete,
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 101f016c6ed8c..167abb0b08d40 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -32,11 +32,6 @@ struct ts73xx_fpga_priv {
 	struct device	*dev;
 };
 
-static enum fpga_mgr_states ts73xx_fpga_state(struct fpga_manager *mgr)
-{
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
 static int ts73xx_fpga_write_init(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
 				  const char *buf, size_t count)
@@ -98,7 +93,6 @@ static int ts73xx_fpga_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops ts73xx_fpga_ops = {
-	.state		= ts73xx_fpga_state,
 	.write_init	= ts73xx_fpga_write_init,
 	.write		= ts73xx_fpga_write,
 	.write_complete	= ts73xx_fpga_write_complete,
-- 
2.26.3

