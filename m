Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51D1F1962
	for <lists+linux-fpga@lfdr.de>; Mon,  8 Jun 2020 14:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgFHMzB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Jun 2020 08:55:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729866AbgFHMy6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 8 Jun 2020 08:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=V0bHFV3loTq46ks0PZDncVrsS74x60RNv6LFRDVPSL0=;
        b=Qy8B4wJDKvfraLafojz56pxROmbsda8eaHs10hIT1OADPx+goKnbIOptLSTkwZxEEbQIJR
        M4JuXbVYlXOEHGx7yXTzmDiLAGskJmrND2N9eh3WZUBIGk+r4j2/p9PG1PVt8cNp4pOpaX
        eZyWaNKm2XrxUtmDndqriIA2qi7lAOI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-kjBK571cNSqjupmEOUp0tw-1; Mon, 08 Jun 2020 08:54:55 -0400
X-MC-Unique: kjBK571cNSqjupmEOUp0tw-1
Received: by mail-qk1-f197.google.com with SMTP id t18so14229069qke.8
        for <linux-fpga@vger.kernel.org>; Mon, 08 Jun 2020 05:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V0bHFV3loTq46ks0PZDncVrsS74x60RNv6LFRDVPSL0=;
        b=QoabXQKXQ5kx2wxp2TlVZxElKO+TVoDqzFw1lMNnAJJsAkYtuSf5oUYHTpI0Y+OO7I
         3zyOwZ9jgXEr6LV9Sw/mskDsg+NJLYdiYhm//jApzANMZQSxIZWxGeqLKKN6JMNunfkA
         BRiAecCELppKo90Tpk2ggfGfykfF3U4hnLKsSkx+A24dy9sVpctM54kJhrw51M35y//X
         a62JA410zzt6j5cle5PoOZ02ZExTs73JZJ2sKrp//ECHKrhOdtjlkODej51UXdP2Koxg
         6LkH/iVdohOSjAG98btABirs1gifaBCtO+kH7cLr4PnhzCKFR+G10p2FUaAxv5VUwJ2f
         pSUw==
X-Gm-Message-State: AOAM531WnfNBs2DElgBlpo2QCc0o6uRuzowXIDB/JRwF2mflqJDxZAn+
        FGG581JRVl5YLQYD4wZdqwwN8SSgNNFDjRxyqCf1BZZdOzZnQS5DTAoDvc/IhvI1/0YItR4/Wp0
        wDZYn3hO2Mkh1MC7owbjYBQ==
X-Received: by 2002:a37:a210:: with SMTP id l16mr22564942qke.213.1591620895376;
        Mon, 08 Jun 2020 05:54:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztS/xAlUYqSPPtL8j22b2Uu64X9c9LuNcyK8DjxfEZaxHffE4fVO6REb1jIXn60l0bFUdEHg==
X-Received: by 2002:a37:a210:: with SMTP id l16mr22564916qke.213.1591620895143;
        Mon, 08 Jun 2020 05:54:55 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y54sm7750628qtj.28.2020.06.08.05.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:54:54 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/2] fpga: Fix dead store fpga-mgr.c
Date:   Mon,  8 Jun 2020 05:54:45 -0700
Message-Id: <20200608125446.23311-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200608125446.23311-1-trix@redhat.com>
References: <20200608125446.23311-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Using clang's scan-build/view this issue was flagged in fpga-mgr.c

  drivers/fpga/fpga-mgr.c:585:3: warning: Value stored to 'ret' is never read [deadcode.DeadStores]
                  ret = id;

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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
2.18.2

