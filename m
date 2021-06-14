Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F23A6CCC
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhFNRLh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:11:37 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:39583 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbhFNRLh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:11:37 -0400
Received: by mail-pf1-f178.google.com with SMTP id k15so11019652pfp.6
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYPGmANBSfZBi4amo1Bgx2OEk3jiKcjGucI1PxoeL9E=;
        b=gltgBI6bgjY3ehx9+x/qb9nIN8qCc56V/hbPVDl7hGDuwp0/X2nrxD8JQywI6iyI+H
         A+txhSRTgmm3BfsETv8MGYSBbNXOGx6j/Ghr9te7dRgYqn9vZnZVDSypV/BiiHwMIXGI
         jOHuzTmcmJwF8jWMcTBg8p6k9HtN9/+lQs0eejrNhU2XWC4EWt9ong8Nh96WNtQ3DnZL
         DuZUtmA4ERNuDpfTXSAyux4bHlmfxlVbt7ZCn5XtYFee7b/s0r7kTrM7P2pGgO6ZkZim
         H/BNgjb2w6W9DLD5KBsO2pW/4PC2IdaHMxKxPYVTeMtp+kKIH+vNVVeqx0pZ+nqbxdYq
         x0Aw==
X-Gm-Message-State: AOAM530OQpirFlbFD87g1/d++pxlaUKjqoDN6qmGJRENygMuZF+Z5HWk
        elX/l8gzOf6Mr9cGAJwT6uk=
X-Google-Smtp-Source: ABdhPJwWePqYNeZZfFQwOKbSjRcvlQU1WUl1ddDIqGHXfH4dOxR37q94NRH5ngfqgdOtsSw4P6GRIw==
X-Received: by 2002:aa7:8509:0:b029:2e5:8cfe:bc17 with SMTP id v9-20020aa785090000b02902e58cfebc17mr22852330pfn.2.1623690574232;
        Mon, 14 Jun 2021 10:09:34 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id y3sm9753126pgr.46.2021.06.14.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:09:33 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 7/8] fpga: bridge: Use standard dev_release for class driver
Date:   Mon, 14 Jun 2021 10:09:08 -0700
Message-Id: <20210614170909.232415-8-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210614170909.232415-1-mdf@kernel.org>
References: <20210614170909.232415-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

The FPGA bridge class driver data structure is being treated as a managed
resource instead of using standard dev_release call-back to release the
class data structure. This change populates the class.dev_release function
and changes the fpga_bridge_free() function to call put_device(). It also
changes fpga_bridge_unregister() to call device_del() instead of
device_unregister().

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index d4aca0f724f5..cf06c887593a 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -340,8 +340,10 @@ struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
-		goto error_kfree;
+	if (id < 0) {
+		kfree(bridge);
+		return NULL;
+	}
 
 	mutex_init(&bridge->mutex);
 	INIT_LIST_HEAD(&bridge->node);
@@ -358,17 +360,12 @@ struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
 	bridge->dev.id = id;
 
 	ret = dev_set_name(&bridge->dev, "br%d", id);
-	if (ret)
-		goto error_device;
+	if (ret) {
+		put_device(&bridge->dev);
+		return NULL;
+	}
 
 	return bridge;
-
-error_device:
-	ida_simple_remove(&fpga_bridge_ida, id);
-error_kfree:
-	kfree(bridge);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_create);
 
@@ -378,8 +375,7 @@ EXPORT_SYMBOL_GPL(fpga_bridge_create);
  */
 void fpga_bridge_free(struct fpga_bridge *bridge)
 {
-	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
-	kfree(bridge);
+	put_device(&bridge->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_free);
 
@@ -469,12 +465,16 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
 	if (bridge->br_ops && bridge->br_ops->fpga_bridge_remove)
 		bridge->br_ops->fpga_bridge_remove(bridge);
 
-	device_unregister(&bridge->dev);
+	device_del(&bridge->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
 
 static void fpga_bridge_dev_release(struct device *dev)
 {
+	struct fpga_bridge *bridge = to_fpga_bridge(dev);
+
+	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
+	kfree(bridge);
 }
 
 static int __init fpga_bridge_dev_init(void)
-- 
2.31.1

