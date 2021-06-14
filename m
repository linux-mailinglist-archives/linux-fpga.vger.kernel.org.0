Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6F73A6CD1
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhFNRL4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:11:56 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:36774 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbhFNRLz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:11:55 -0400
Received: by mail-pf1-f176.google.com with SMTP id c12so11023528pfl.3
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64IvQlrXeou9jXkno2E2GgEDTZxDLn+r8yPnV7jM6oo=;
        b=PTFh+wR3BfMUsUFYBkD28ry8bASJiIgV2+eSB5rM44x5OHB7/sjeg3aE4/QZv7kmlg
         vc5Y3a7HBVwKyn0INNDnED1WanoZ61Lhv9hpviejR0dS+f7uWAkHCILOj6dWpCsYJCzP
         JFxXFKAh88ksDkPyc4hHdy2Pv6Yvi3Wnw7zT0RciD2hAhdLVCv5i43GeT/W3x9X35DyE
         xuDEzi7h/w1vCJwQQKENhlFyh1/5MPWZsUontJSSHpms8Jnmm8nNSxSMI+qFr18u3zBU
         xtseqdSiCmdrdojGKPiJL+hIHF8b1t433elvKMI+ySCAKVVuqmgCUk1EbHdjMzXh36Fv
         vE+w==
X-Gm-Message-State: AOAM533dqhSRwT5c/1K1SLQ9uxgNb/v1NXhiQvrs24hQb7ipWx5QuaBd
        PTFzWSfjV/YOTPwFdmx42BE=
X-Google-Smtp-Source: ABdhPJx5kOEjSsaSYR/Db6aGJrE6a9pEL2diVwV4qJ/d7Cqzg+CY5I86v7QtB/7EDnPBHpnKlDlddw==
X-Received: by 2002:a65:624e:: with SMTP id q14mr17720484pgv.103.1623690575797;
        Mon, 14 Jun 2021 10:09:35 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 20sm12842816pfi.170.2021.06.14.10.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:09:35 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 8/8] fpga: region: Use standard dev_release for class driver
Date:   Mon, 14 Jun 2021 10:09:09 -0700
Message-Id: <20210614170909.232415-9-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210614170909.232415-1-mdf@kernel.org>
References: <20210614170909.232415-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

The FPGA region class driver data structure is being treated as a managed
resource instead of using standard dev_release call-back to release the
class data structure. This change populates the class.dev_release function
and changes the fpga_region_free() function to call put_device().
It also changes fpga_region_unregister() to call device_del() instead
of device_unregister().

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-region.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 4d60d643cada..bdc15fab60c0 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -204,8 +204,10 @@ struct fpga_region
 		return NULL;
 
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
-		goto err_free;
+	if (id < 0) {
+		kfree(region);
+		return NULL;
+	}
 
 	region->mgr = mgr;
 	region->get_bridges = get_bridges;
@@ -219,17 +221,12 @@ struct fpga_region
 	region->dev.id = id;
 
 	ret = dev_set_name(&region->dev, "region%d", id);
-	if (ret)
-		goto err_remove;
+	if (ret) {
+		put_device(&region->dev);
+		return NULL;
+	}
 
 	return region;
-
-err_remove:
-	ida_simple_remove(&fpga_region_ida, id);
-err_free:
-	kfree(region);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(fpga_region_create);
 
@@ -239,8 +236,7 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
  */
 void fpga_region_free(struct fpga_region *region)
 {
-	ida_simple_remove(&fpga_region_ida, region->dev.id);
-	kfree(region);
+	put_device(&region->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_region_free);
 
@@ -310,12 +306,16 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
-	device_unregister(&region->dev);
+	device_del(&region->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	kfree(region);
 }
 
 /**
-- 
2.31.1

