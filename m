Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F01F1965
	for <lists+linux-fpga@lfdr.de>; Mon,  8 Jun 2020 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgFHMzN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Jun 2020 08:55:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39043 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729873AbgFHMzN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 8 Jun 2020 08:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=94nJdUycanNanCZe+2t27kRR21T+ISEyAQyR3Es+4pA=;
        b=JPhIfnm+2I1KhSpb0+CoUphF0Ny6eNZnVhbpGU4Rbg4ErkLAAlgmheX1DPLkaW/JkzMLjc
        iSKCkabvHFBdibrEIbXYklxvjK96JbrnkYxCQM2dgWsWkzk3oLa1tbUjB5erg+VBJatCE2
        Gtv6/ukPh5kjmxwaniYZUWDJPNUUK5g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-rcNsjTj0NPGy1boB-L6KmA-1; Mon, 08 Jun 2020 08:54:58 -0400
X-MC-Unique: rcNsjTj0NPGy1boB-L6KmA-1
Received: by mail-qk1-f200.google.com with SMTP id t18so14229172qke.8
        for <linux-fpga@vger.kernel.org>; Mon, 08 Jun 2020 05:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=94nJdUycanNanCZe+2t27kRR21T+ISEyAQyR3Es+4pA=;
        b=tojPnUO8X3p0gGEPnqSk2I377VEK9rDtsw/hYDuftofLRJF4F8bGyMEpOgfSZtX3yx
         lpy/1oHqY8D7Ef55jBzoC2SM2u0vKw4IDxvxpLkOhagohN7o6Xz3bVSsZ5P9oDYbe2mo
         UYyAGIjRfGStVHGhGSFGNrw0pj9PHAIpQTLNCF9S9TcYIXjaaFN98rVY/muB42kruIaa
         IbD3hCCWTfLqtkeLU1CeXseGSBBh7anUr/QrWOVtLwPImilEepp38mJ211LLkNQFURK/
         WOXU9kJou0ljkfxRaPruc/yNInZCHkOslDzaLzc/zj7SiNoeFZXz46fmVvyI9hhsWla2
         LGAg==
X-Gm-Message-State: AOAM5314y49qUNE3ocIjhjXFzWVHlahOpBiPWr1jTS2jWW21YqP8W8X3
        5kovtiqt1rK4xCKtjXchKNULuNB1bpGlkrtdW/iNw7T8HvGXU8l73qSjg64DP77e+AWwfTYmZK0
        wVFRbhOezN/Rn+xi7aVsZdw==
X-Received: by 2002:ac8:6882:: with SMTP id m2mr22888053qtq.231.1591620897778;
        Mon, 08 Jun 2020 05:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP3YB11T91nyIrlQME0Zb6Gnr2YlMqwkDqVq5/W1h1DTMqeGm+8O+nE1LzuskYtdUwSzpNFw==
X-Received: by 2002:ac8:6882:: with SMTP id m2mr22888042qtq.231.1591620897574;
        Mon, 08 Jun 2020 05:54:57 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y54sm7750628qtj.28.2020.06.08.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:54:56 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 2/2] fpga: Fix dead store in fpga-bridge.c
Date:   Mon,  8 Jun 2020 05:54:46 -0700
Message-Id: <20200608125446.23311-3-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200608125446.23311-1-trix@redhat.com>
References: <20200608125446.23311-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Using clang's scan-build/view this issue was flagged
a dead store issue in fpga-bridge.c

warning: Value stored to 'ret' is never read [deadcode.DeadStores]
                  ret = id;

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

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
-- 
2.18.2

