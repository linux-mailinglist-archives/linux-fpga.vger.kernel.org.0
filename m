Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811583B4968
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFYTyo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 15:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229978AbhFYTyj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BoEiwZWmcnwYp+vuFKo9FHmPBN3oC7TpcdPOM8LN0s=;
        b=ciAyWIKLinOlVin3Ue5AM08487WidiBIg4g5jvI0beRd9XB8ub6s/DNBJJpFjmTMz8lqyB
        EjzzwjxfjUWx+zS8pG33bgIyMVfFnCkSokUTqUoFJio6awzzvQCCW2a/tQTDn2IiA+eaa9
        58w8bTsJcZGqIrAf+FOPVn/mpkxmYdg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-EzHfd-31NleeCEKcq43GUg-1; Fri, 25 Jun 2021 15:52:15 -0400
X-MC-Unique: EzHfd-31NleeCEKcq43GUg-1
Received: by mail-oo1-f71.google.com with SMTP id z1-20020a4ab8810000b029024abe096a35so6422910ooo.12
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BoEiwZWmcnwYp+vuFKo9FHmPBN3oC7TpcdPOM8LN0s=;
        b=HpvlLJR3HaYG5zfOzjt8QAyACRyK4iCE3o9Fj7uk8YNp+dNDvmEWwf5xVHnnyu9Djg
         K8V1zkXTmRFWG2R5ltPVapC/kjU5qYKJCveiS6+7x30Yj4Gq0mnITlbdUoW0BxDbdH8U
         kaR+RCRFotGNYukzrWw+qUrLKHYmtfP60Rw8DvEh2haynfW4dBxaX9LtaknYWMFZyl3i
         e0BwTMoa3oan5LpBVyxh4l3TPg9oCh9GNMkOkB5Eun99Nu/ajZldulyIkOrapeE2UgFA
         Nk0FqytcJbRLks7WcDbzeC0G7dF0CfZv65vlGM4d8H/4oCvZ58NhEbT4O6NJy66CMOTZ
         b+hA==
X-Gm-Message-State: AOAM533KbS1k4D92sr0hrHCHcYFUT4pJBKDcb36edsDaDImVjJlUZjWK
        xGtLwaCK44VfQEXz4z+SKZehzpj5QQlEW7N6kaWrXooWb40IJMurAU2SBpRRzoJdOH/QQ5kbXEo
        pZw3RT+kwNQzdcfDZfoM/rw==
X-Received: by 2002:a4a:e2d5:: with SMTP id l21mr3723010oot.8.1624650735212;
        Fri, 25 Jun 2021 12:52:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkkI3SZznlD6Uem8J6dDkJCRpJZ9IID/gLUHaZnjy+WJWItpPPMuJ7BvNbnRc9MgSQ3n+HUw==
X-Received: by 2002:a4a:e2d5:: with SMTP id l21mr3722997oot.8.1624650735048;
        Fri, 25 Jun 2021 12:52:15 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:14 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 5/7] fpga-mgr: wrap the state() op
Date:   Fri, 25 Jun 2021 12:51:46 -0700
Message-Id: <20210625195148.837230-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195148.837230-1-trix@redhat.com>
References: <20210625195148.837230-1-trix@redhat.com>
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
index 43518b6eed21e..b3380ad341d22 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,13 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+static inline enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
+{
+	if (mgr->mops->state)
+		return  mgr->mops->state(mgr);
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
 static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
 {
 	if (mgr->mops->status)
@@ -589,7 +596,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->state) {
+	if (!mops) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
@@ -707,7 +714,7 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 	 * from device.  FPGA may be in reset mode or may have been programmed
 	 * by bootloader or EEPROM.
 	 */
-	mgr->state = mgr->mops->state(mgr);
+	mgr->state = fpga_mgr_state(mgr);
 
 	ret = device_add(&mgr->dev);
 	if (ret)
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index a2cea500f7cc6..047fd7f237069 100644
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

