Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464791F08D9
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Jun 2020 23:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgFFVDC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Jun 2020 17:03:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27527 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728399AbgFFVC4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Jun 2020 17:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591477374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=EhPcZ8ZKsOGQJhM7Y4SG5KeIBZOSBJJrvqPyygwuVxE=;
        b=XAyTi1vVUcIz9+0mn4VjYmYwKY8xXXJaOU0XA2yojAnzzd1Ra+HQMjQZhC6ao8fXj/vpzq
        xhF8LgWnWO9pCdq+7qktFiKShBwbLA9Uccp0/W5pmDBZoeojeyDDp9RMBx9Kc5f+uPxiof
        Qoohf4Dalg3M0p/QbBWfIMAC+k56YrE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-JRCDn5xWNYKKV0E5o6pAvA-1; Sat, 06 Jun 2020 17:02:53 -0400
X-MC-Unique: JRCDn5xWNYKKV0E5o6pAvA-1
Received: by mail-qk1-f197.google.com with SMTP id x22so10781508qkj.6
        for <linux-fpga@vger.kernel.org>; Sat, 06 Jun 2020 14:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EhPcZ8ZKsOGQJhM7Y4SG5KeIBZOSBJJrvqPyygwuVxE=;
        b=mmxVPjYfdGp0jfDKLm+kaUTC/1DeTcIW5Sc2gQLz4Hf43Glxir4mAJJ6EqROtvdepV
         PLtYQIzJoVVQhlNifEqbx4owEYLwJ5nwgtC/yHZYRkOWeluCkxtKInDvLLNdAzv5DYMC
         tDVmntKkLKSJ5tuDzNgg0n0AWLHVsHSyHbiLGJ3SAjO0lsm62SLXWbyPhgGCt5BgliX2
         /DqOehtjRSd76cqpGsjpGTiY7dDfRG20vF3TAbQZIS0e/xzxj5Nr4JLhTrRtMPtAbibL
         QCtiisElVB3pyg86nCLX64WOrUOyjKsL5rAGQPCGB9gLe/P/uAPYzLYBYibh3QFlU4vo
         3aKQ==
X-Gm-Message-State: AOAM533QxUd1JxZutZ3B/kuQ3BOg6cJltsPV7ycuNMyCjANon1NM7w7N
        9BeYSwW0DDUEzesfVhsTWrYUtPTR6WjzApFh7nHjYdW9iDiAtAPGBcMqY2DRFOiJ9eQV2grn/Oo
        XWgPhR2KxVyzyi/cWx8WxIA==
X-Received: by 2002:a37:9586:: with SMTP id x128mr15600404qkd.312.1591477372798;
        Sat, 06 Jun 2020 14:02:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYQc7ymCPetr6UGIR95AVlYji722MSUFRWkqI3a0x/xyB9N/48Flho6ybhZRR4Y2xAEwQyIA==
X-Received: by 2002:a37:9586:: with SMTP id x128mr15600393qkd.312.1591477372591;
        Sat, 06 Jun 2020 14:02:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d14sm3025299qkg.25.2020.06.06.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 14:02:51 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 1/1] fpga: dfl: Fix dead store
Date:   Sat,  6 Jun 2020 14:02:41 -0700
Message-Id: <20200606210241.7459-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200606210241.7459-1-trix@redhat.com>
References: <20200606210241.7459-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Using clang's scan-build/view this issue was flagged in fpga-mgr.c

  drivers/fpga/fpga-mgr.c:585:3: warning: Value stored to 'ret' is never read [deadcode.DeadStores]
                  ret = id;

A similar issue was flagged in fpga-bridge.

So remove the unused stores.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 6 ++----
 drivers/fpga/fpga-mgr.c    | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 4bab9028940a..2deccacc3aa7 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -328,7 +328,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 				       void *priv)
 {
 	struct fpga_bridge *bridge;
-	int id, ret = 0;
+	int id, ret;
 
 	if (!name || !strlen(name)) {
 		dev_err(dev, "Attempt to register with no name!\n");
@@ -340,10 +340,8 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
+	if (id < 0)
 		goto error_kfree;
-	}
 
 	mutex_init(&bridge->mutex);
 	INIT_LIST_HEAD(&bridge->node);
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index e05104f5e40c..f38bab01432e 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -581,10 +581,8 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
+	if (id < 0)
 		goto error_kfree;
-	}
 
 	mutex_init(&mgr->ref_mutex);
 
-- 
2.26.0

