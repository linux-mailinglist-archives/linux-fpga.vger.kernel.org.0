Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772C038921D
	for <lists+linux-fpga@lfdr.de>; Wed, 19 May 2021 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhESPAM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 May 2021 11:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237147AbhESPAL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 19 May 2021 11:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621436331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d8x5WXETUL/PCG0K619poG/b8n5dSXC7U60P72mCXBs=;
        b=MdmuRdzOlppffQ421IcIh9JNiMSMpb7/KvLjUKyeSsGFi332f4ognKJUV7S0DixaAH39pD
        vc2Vs1U3Tlf2LOsZ2y5Z3qfit4NjPJdpKAMo8F0ODLnHvxjz5DTwLd9voHq2WZdrwXh9iY
        5paWIK73jrDkKYHeZepmNSQBlLSkDas=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-_8rLCwXFMV-Ss5PPoabChg-1; Wed, 19 May 2021 10:58:49 -0400
X-MC-Unique: _8rLCwXFMV-Ss5PPoabChg-1
Received: by mail-qv1-f71.google.com with SMTP id fi6-20020a0562141a46b02901f064172b74so5655343qvb.3
        for <linux-fpga@vger.kernel.org>; Wed, 19 May 2021 07:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8x5WXETUL/PCG0K619poG/b8n5dSXC7U60P72mCXBs=;
        b=PK8JdVK+idkVRpwSMidusC3xW6g4lQSt90kP1yDS+FwyOWN/UKm7uHb8ZBf7VLkx7s
         eRFZ1qKXECKVkST/hLW7EAKK5UgLbnLKb1CVGiZ8+wZW241IOi5/THLqP0uOHG3JrInh
         t3aJ/38UR4NHBtfBVsHOlRr9M9FXGdyzNY8bemKCn7W0yIMVa/nhB4gv0WEYIHQiiXu1
         FRPad8ZfFVYGwzdjiv0XjL9lFwbFoy7UNKPdbl858YqRaROuapdf81pU1uvm0KJQXv1h
         i5k5v6cZaReh9PA3C40r4uGjWk14AKz9BURveaaJzLbuAViimGRdC/fTJdQsn9Q6rUuF
         8Y6A==
X-Gm-Message-State: AOAM533V/EXMtdAXT++E5tGH2BaJJ9ry/Kpqd9r+bT1hYFIo5HrjLhwm
        bd3b1dxEgPa7PzwxxUwDNNf+5/q81RldUiKEAHwvR9nlQhIePUU6ET1o0HC2WD/NBPNT59Kud7P
        xJj/p6fZaffV5NcSo/cxkyw==
X-Received: by 2002:ac8:5d93:: with SMTP id d19mr11832266qtx.289.1621436328116;
        Wed, 19 May 2021 07:58:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQZo8HEiW7kD1AY+ztdvMUBBHcl88sQ++J5N3ArYR07BD3gL8VSyoIza33ujucPGZa7Ns2+A==
X-Received: by 2002:ac8:5d93:: with SMTP id d19mr11832253qtx.289.1621436327962;
        Wed, 19 May 2021 07:58:47 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k2sm13679873qtg.68.2021.05.19.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:58:47 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: remove empty release functions
Date:   Wed, 19 May 2021 07:58:44 -0700
Message-Id: <20210519145844.1962294-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Unneeded functions, so remove.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 5 -----
 drivers/fpga/fpga-mgr.c    | 5 -----
 drivers/fpga/fpga-region.c | 5 -----
 3 files changed, 15 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index e9266b2a357f6..6510c7803a784 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -473,10 +473,6 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
 
-static void fpga_bridge_dev_release(struct device *dev)
-{
-}
-
 static int __init fpga_bridge_dev_init(void)
 {
 	fpga_bridge_class = class_create(THIS_MODULE, "fpga_bridge");
@@ -484,7 +480,6 @@ static int __init fpga_bridge_dev_init(void)
 		return PTR_ERR(fpga_bridge_class);
 
 	fpga_bridge_class->dev_groups = fpga_bridge_groups;
-	fpga_bridge_class->dev_release = fpga_bridge_dev_release;
 
 	return 0;
 }
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index b85bc47c91a9a..e0e1835beab77 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -779,10 +779,6 @@ int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
 
-static void fpga_mgr_dev_release(struct device *dev)
-{
-}
-
 static int __init fpga_mgr_class_init(void)
 {
 	pr_info("FPGA manager framework\n");
@@ -792,7 +788,6 @@ static int __init fpga_mgr_class_init(void)
 		return PTR_ERR(fpga_mgr_class);
 
 	fpga_mgr_class->dev_groups = fpga_mgr_groups;
-	fpga_mgr_class->dev_release = fpga_mgr_dev_release;
 
 	return 0;
 }
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index c3134b89c3fe5..ddaca70b21de5 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -314,10 +314,6 @@ void fpga_region_unregister(struct fpga_region *region)
 }
 EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
-static void fpga_region_dev_release(struct device *dev)
-{
-}
-
 /**
  * fpga_region_init - init function for fpga_region class
  * Creates the fpga_region class and registers a reconfig notifier.
@@ -329,7 +325,6 @@ static int __init fpga_region_init(void)
 		return PTR_ERR(fpga_region_class);
 
 	fpga_region_class->dev_groups = fpga_region_groups;
-	fpga_region_class->dev_release = fpga_region_dev_release;
 
 	return 0;
 }
-- 
2.26.3

