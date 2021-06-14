Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317373A6CCE
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhFNRLt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:11:49 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:45594 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhFNRLs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:11:48 -0400
Received: by mail-pl1-f176.google.com with SMTP id 11so6912006plk.12
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8wHrGuc0HXPDKaZ6I66XrZzjraoB4R/382pU9HsLcU=;
        b=iEkLkl636vR5LDE4VfBx4zJZwUH2HiKR6mTM1klHb8ayeWo9s7pxt+ggKqYhXBnZ7/
         RY9jrHYfCfDhBOf9OGpb9SeWGIovyq6lefVQZ4X00fgjeAxjnmGCnff/Pq+hU2kRK0Q/
         CPNp3mA7xmi0mfxq7+y67sZazCYJeXfh24yI+Fq9X1Owssw7pEhWyGiY9hvbcTqL24cD
         BE7Cd2yLH1Q0LBy8P5hutyCqgQIuNcO2IyaEyN9bsDGA3NWvL453JtMbhgpTMxDFG4P/
         1LQRfxctPS3FPxm2Xwg1+EP0QkB/kAcWijm59pisVXa2KPU874RxjzVYtRbgSzC1e/x6
         ndkw==
X-Gm-Message-State: AOAM530ojNOD40LBEwlstr5OcPQm91dwn3o9Q+cMxf15L32jAjiqsNEu
        6oZWVslf/dsgQ4dv3aJdB/8=
X-Google-Smtp-Source: ABdhPJyxx3G1c96tEsoJkdiyb2/N5uA/uFfxEUtrboI79uaYLCySFtLo8X4BxZ9OME+OJOKOHGoDbg==
X-Received: by 2002:a17:902:dac2:b029:110:994a:abc3 with SMTP id q2-20020a170902dac2b0290110994aabc3mr241234plx.78.1623690572526;
        Mon, 14 Jun 2021 10:09:32 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u4sm1648661pfu.27.2021.06.14.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:09:31 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 6/8] fpga: mgr: Use standard dev_release for class driver
Date:   Mon, 14 Jun 2021 10:09:07 -0700
Message-Id: <20210614170909.232415-7-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210614170909.232415-1-mdf@kernel.org>
References: <20210614170909.232415-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

The FPGA manager class driver data structure is being treated as a
managed resource instead of using the class.dev_release call-back
function to release the class data structure. This change populates
the class.dev_release function, changes the fpga_mgr_free() function
to call put_device() and changes the fpga_mgr_unregister() function
to call device_del() instead of device_unregister().

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-mgr.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 42ddc0844781..9f6c3760b6ff 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -585,8 +585,10 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
-		goto error_kfree;
+	if (id < 0) {
+		kfree(mgr);
+		return NULL;
+	}
 
 	mutex_init(&mgr->ref_mutex);
 
@@ -602,17 +604,12 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	mgr->dev.id = id;
 
 	ret = dev_set_name(&mgr->dev, "fpga%d", id);
-	if (ret)
-		goto error_device;
+	if (ret) {
+		put_device(&mgr->dev);
+		return NULL;
+	}
 
 	return mgr;
-
-error_device:
-	ida_simple_remove(&fpga_mgr_ida, id);
-error_kfree:
-	kfree(mgr);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_create);
 
@@ -622,8 +619,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_create);
  */
 void fpga_mgr_free(struct fpga_manager *mgr)
 {
-	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
-	kfree(mgr);
+	put_device(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_free);
 
@@ -692,16 +688,11 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 
 	ret = device_add(&mgr->dev);
 	if (ret)
-		goto error_device;
+		return ret;
 
 	dev_info(&mgr->dev, "%s registered\n", mgr->name);
 
 	return 0;
-
-error_device:
-	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
@@ -722,7 +713,7 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 	if (mgr->mops->fpga_remove)
 		mgr->mops->fpga_remove(mgr);
 
-	device_unregister(&mgr->dev);
+	device_del(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
 
@@ -781,6 +772,10 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
 
 static void fpga_mgr_dev_release(struct device *dev)
 {
+	struct fpga_manager *mgr = to_fpga_manager(dev);
+
+	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
+	kfree(mgr);
 }
 
 static int __init fpga_mgr_class_init(void)
-- 
2.31.1

