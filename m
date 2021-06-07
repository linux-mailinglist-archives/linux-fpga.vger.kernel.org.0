Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE28839E543
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Jun 2021 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFGR0X (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Jun 2021 13:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbhFGR0X (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Jun 2021 13:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623086671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Kr/vWB+/nwKdeKs8KkDEzQieFV1Y1AcDYKa+Pf56V8=;
        b=CGNw61Kkyb/5CJN5iYASckM8W1SBY22+AGS/1qAwYc//O9H2oh0oJf2EbeJobBQ2GJhG7O
        cU4kpgFHQb3IyA8gU/CvOT1zfzN3PQM6FmAjySUxN9N/2C3zscMdsFvK0iML92H69eZZTA
        96GmL2+3pFw8NbCvswGGTaZ2wQWvlX4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-H7-Z8zBdOb6JK_J8EnRZ2Q-1; Mon, 07 Jun 2021 13:24:30 -0400
X-MC-Unique: H7-Z8zBdOb6JK_J8EnRZ2Q-1
Received: by mail-ot1-f70.google.com with SMTP id 19-20020a9d04130000b02903cb28b38d0aso10586156otc.19
        for <linux-fpga@vger.kernel.org>; Mon, 07 Jun 2021 10:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Kr/vWB+/nwKdeKs8KkDEzQieFV1Y1AcDYKa+Pf56V8=;
        b=BHFF+1+3RqSvGNxAue33LzU4fu28hpDrJeREyuKn3LqPmmNkyDw8019FBVqy/pK+WG
         ehCSrQt45CIbMcGZvjDX/wGIcLAvlPiBwSh3hJCZzZiIEObhvjJG0iBPlFWn4oDyjZjg
         ydCT09Dtwsynm2eYVWrYcbe6uYKrYeqZlC6jcMkMVji8/LVPFC252QTPoEC/cJ3bYVwP
         hJktkA6BOkq3cVvbt5wau81sP5kY844K1ATvknvw1o3g3N1+5a0khOQzxGmk3CS2f1v6
         nEDkFBuwVvbdvYAOrvbTIhcW1k1kMJxlQRfAFQOXUQReT/q1rXV43Uh7TWtPo7tGTbw1
         vdMw==
X-Gm-Message-State: AOAM532d8YUmSOa7dvMdENGrcDOB7eSlFivV1lGfdY3+DuASlvDgYFJW
        ptLzSp2scENiI1ZXpvRsO+mp8Ek6pX4UPI2F5WmeRXe74ShJHvBCOYXbeZrymPEQt1YALWD4RwU
        CPKUVe46qmel6V/8MHWxTBA==
X-Received: by 2002:a05:6830:208c:: with SMTP id y12mr14976939otq.129.1623086669451;
        Mon, 07 Jun 2021 10:24:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxx+lDqZrglifUpJyQXQIS8VUnzoYQx644bk2oknGt1yXO+O7Fiz78iL3xYwnV4DBj9rU5fJQ==
X-Received: by 2002:a05:6830:208c:: with SMTP id y12mr14976930otq.129.1623086669317;
        Mon, 07 Jun 2021 10:24:29 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm2409859oij.26.2021.06.07.10.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:24:29 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 1/7] fpga: wrap the write_init() op
Date:   Mon,  7 Jun 2021 10:23:56 -0700
Message-Id: <20210607172402.2938697-2-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210607172402.2938697-1-trix@redhat.com>
References: <20210607172402.2938697-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The board should not be required to provide a
write_init() op if there is nothing for it do.
So add a wrapper and move the op checking.
Default to success.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index b85bc47c91a9..24547e36a56d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -69,6 +69,14 @@ void fpga_image_info_free(struct fpga_image_info *info)
 }
 EXPORT_SYMBOL_GPL(fpga_image_info_free);
 
+static int fpga_mgr_write_init(struct fpga_manager *mgr,
+			       struct fpga_image_info *info,
+			       const char *buf, size_t count)
+{
+	if (mgr->mops && mgr->mops->write_init)
+		return  mgr->mops->write_init(mgr, info, buf, count);
+	return 0;
+}
 /*
  * Call the low level driver's write_init function.  This will do the
  * device-specific things to get the FPGA into the state where it is ready to
@@ -83,9 +91,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = mgr->mops->write_init(mgr, info, NULL, 0);
+		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
 	else
-		ret = mgr->mops->write_init(
+		ret = fpga_mgr_write_init(
 		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
@@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	int id, ret;
 
 	if (!mops || !mops->write_complete || !mops->state ||
-	    !mops->write_init || (!mops->write && !mops->write_sg) ||
+	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
-- 
2.26.3

