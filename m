Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260B53B203F
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhFWS1K (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 14:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229907AbhFWS05 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nnushO3xnTHoZzlU30ytNGeGLULTAlS7H2DDhaf9BHk=;
        b=Hb+LLHJImoK2EsHZb3NFUpOJsgUGAef1oAcRkrhTMB38Cfwc85mTnIrfvUNSAYCISp7ILo
        Ix+/t5weEHCzzQ+RNpnnJc4jp7GoLSL4vlTYR7sGH1MfXLiVzyFxR/BJoGN8EvpdEevth+
        jM/6/c8BMq7hkSGDojzgg2kmC3HA+pY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-IkY7WrVKPA2v5Nb06FiqBw-1; Wed, 23 Jun 2021 14:24:37 -0400
X-MC-Unique: IkY7WrVKPA2v5Nb06FiqBw-1
Received: by mail-oo1-f71.google.com with SMTP id e25-20020a4ab9990000b029024aa2670b1cso2183201oop.21
        for <linux-fpga@vger.kernel.org>; Wed, 23 Jun 2021 11:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnushO3xnTHoZzlU30ytNGeGLULTAlS7H2DDhaf9BHk=;
        b=MH/AGqKu9fmeGUIr5cpU4JKdHC66EsPpV6Dn/j/AxnAyv1ebJGc3b6r2fwSYdbxFF9
         FfN2w/oaRfGv5wh/eg34K6+71oHOrsNUCJFeu9Dz34jqQn1qG0nqEYzK7PdizLM1Ly0A
         CRnXn/uXxpgiE6z/6sj4m8wCJXQVieYvJpQ/ZdgQxp08106ykmkILr/POM0/A/HgcWsG
         C2MiW9ofnrwwvzOGB3254/R+/gLm7SwgUyUaikn5m/TJylY1bR4B2jAiBBFLtzsGmr4y
         4g/wd29ng9hJGVViXkWdsWJ9M5azYCAih/3vSNKZ5j4LdLj4NUfMyYsb4wOWQmkt9NS4
         kgQw==
X-Gm-Message-State: AOAM532FO/VNJvCSd6JjtE6IXpzcZhzP+/toXKWFkaTGs89wyJwDBlu7
        PDqfi/APZkiA8X8zikMv6Rhs2jA+h79RmQ2Wjc30g50VP3F4+asVp2I8f/PSJUyBL18kFSK2/no
        kraKGh4feRuY9XryzLi6Nag==
X-Received: by 2002:a9d:4a8a:: with SMTP id i10mr1085013otf.282.1624472676161;
        Wed, 23 Jun 2021 11:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRwK3CQevF5ggD6yIeDOdZ80qiz0j6vxnsGn0oIWl17p/tCiW1qUTO4zyKA8PqRdv8zMXuLg==
X-Received: by 2002:a9d:4a8a:: with SMTP id i10mr1084998otf.282.1624472676003;
        Wed, 23 Jun 2021 11:24:36 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:35 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 5/7] fpga-mgr: wrap the state() op
Date:   Wed, 23 Jun 2021 11:24:08 -0700
Message-Id: <20210623182410.3787784-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
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
index 6bfc4482abbf4..7d50ce26bf00c 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -589,7 +589,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->state) {
+	if (!mops) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
@@ -692,6 +692,13 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *nam
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
  * fpga_mgr_register - register an FPGA manager
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

