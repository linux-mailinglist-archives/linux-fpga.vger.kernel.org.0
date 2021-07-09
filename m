Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE03C2523
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhGINpo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 09:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232009AbhGINpk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Jul 2021 09:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625838177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wz+VSo4V9K18GbntS6U5gCGz01NIx30Fco4WkjLLzY=;
        b=AQuOhYOMxoKjq3Jv+ETM0VluDGglm1ZczPsQeDSSoT4Pd2n+qfRFNJwDsjBGSbbE0/FaXI
        VZOwxCBJPJq7THzbvheWU1Mu0QcbcGCh06QKuUHnJ790PZAB8BWEL/mqiQLjg+vcT10f6q
        0bd/WVoJ+JA76sj+UoFe4lhO5i4hLsg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188--yZszxaXMH6t0r8wu-2VOg-1; Fri, 09 Jul 2021 09:42:55 -0400
X-MC-Unique: -yZszxaXMH6t0r8wu-2VOg-1
Received: by mail-oo1-f71.google.com with SMTP id o186-20020a4a2cc30000b029025bea4a7246so2748649ooo.8
        for <linux-fpga@vger.kernel.org>; Fri, 09 Jul 2021 06:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wz+VSo4V9K18GbntS6U5gCGz01NIx30Fco4WkjLLzY=;
        b=louyv3DgBsnuk7kwkhnILkVYRJ7iWIAF8vgnninQd5iwRenKEgKYTaCbAXBOHAD1Kj
         c3wGOUuTn4srda+mdLQQl8mv30D34ex2qlm4q5IeWpnvkxVMdaBxlYdcpjU7hcazZZci
         9Es6tzXleAZMtaL8XHLMwYUeYvN/6lNY7nHaNu3EDrxztMstLF0gN8lrurL8cBzVBwt6
         AU1MmUVwgT6Auqzvr8z/+l1uWRloDKLe1hnyRUWaGjs10UXcsSK1HukRc144W7JiIfcN
         fwGgysHf1ZQqco9XnJyIYKd2LNHqlbPL6lFaQLliyHHqaX0eEGa4g22Nr9NEGmeZ3aMT
         t4cA==
X-Gm-Message-State: AOAM532pArQrqEV37soB2XItD+h6oahvVg7yxh++c01RCfLVjbX+cGyX
        Y6QaqDIUY9Know9/4yJVBb83F9QrEnhzHAx1346nf/ReXL1+PkBtoJqGlpw7DWl/qOThk04GT5d
        vbcofXvWzG5dYBT3gGpIbrw==
X-Received: by 2002:a05:6830:1bd8:: with SMTP id v24mr28542668ota.343.1625838175131;
        Fri, 09 Jul 2021 06:42:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyct9gWfuz8J4WdA0JiUc5G3he1tUaqh++CoaPW1Hq4K8Vh7x7DTNLAC9435HjMvp1BII3xog==
X-Received: by 2002:a05:6830:1bd8:: with SMTP id v24mr28542648ota.343.1625838174975;
        Fri, 09 Jul 2021 06:42:54 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j23sm1215948oie.9.2021.07.09.06.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:42:54 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 3/4] fpga: dfl: implement the compat_id_show region op
Date:   Fri,  9 Jul 2021 06:42:28 -0700
Message-Id: <20210709134229.2510349-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210709134229.2510349-1-trix@redhat.com>
References: <20210709134229.2510349-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Make sure dfl will work as previously when compat_id is removed
from struct fpga_manager.  Store and pass the compat_id values
internal to dfl.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-fme-mgr.c    | 16 +++++++++++++---
 drivers/fpga/dfl-fme-region.c | 14 ++++++++++++++
 drivers/fpga/dfl.h            | 14 ++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b3069..cd0b9157ea6e5 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -22,6 +22,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/fpga/fpga-mgr.h>
 
+#include "dfl.h"
 #include "dfl-fme-pr.h"
 
 /* FME Partial Reconfiguration Sub Feature Register Set */
@@ -70,6 +71,7 @@
 struct fme_mgr_priv {
 	void __iomem *ioaddr;
 	u64 pr_error;
+	struct dfl_compat_id compat_id;
 };
 
 static u64 pr_error_to_mgr_status(u64 err)
@@ -272,13 +274,21 @@ static const struct fpga_manager_ops fme_mgr_ops = {
 	.status = fme_mgr_status,
 };
 
-static void fme_mgr_get_compat_id(void __iomem *fme_pr,
-				  struct fpga_compat_id *id)
+static void _fme_mgr_get_compat_id(void __iomem *fme_pr,
+				   struct dfl_compat_id *id)
 {
 	id->id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
 	id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
 }
 
+void fme_mgr_get_compat_id(struct fpga_manager *mgr,
+			   struct dfl_compat_id *id)
+{
+	struct fme_mgr_priv *priv = mgr->priv;
+	*id = priv->compat_id;
+}
+EXPORT_SYMBOL_GPL(fme_mgr_get_compat_id);
+
 static int fme_mgr_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
@@ -306,7 +316,7 @@ static int fme_mgr_probe(struct platform_device *pdev)
 	if (!compat_id)
 		return -ENOMEM;
 
-	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
+	_fme_mgr_get_compat_id(priv->ioaddr, &priv->compat_id);
 
 	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
 				   &fme_mgr_ops, priv);
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index ca7277d3d30a9..d21eacbf2469f 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -17,6 +17,7 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
 
+#include "dfl.h"
 #include "dfl-fme-pr.h"
 
 static int fme_region_get_bridges(struct fpga_region *region)
@@ -27,8 +28,21 @@ static int fme_region_get_bridges(struct fpga_region *region)
 	return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list);
 }
 
+static ssize_t fme_region_compat_id_show(struct fpga_region *region, char *buf)
+{
+	struct fpga_manager *mgr = region->mgr;
+	struct dfl_compat_id compat_id;
+
+	fme_mgr_get_compat_id(mgr, &compat_id);
+
+	return sysfs_emit(buf, "%016llx%016llx\n",
+			  (unsigned long long)compat_id.id_h,
+			  (unsigned long long)compat_id.id_l);
+}
+
 static const struct fpga_region_ops fme_fpga_region_ops = {
 	.get_bridges = fme_region_get_bridges,
+	.compat_id_show = fme_region_compat_id_show,
 };
 
 static int fme_region_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2b82c96ba56c7..a83fd11b390fc 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -169,6 +169,20 @@
 #define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts num */
 #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
 
+/**
+ * struct dfl_compat_id - id for compatibility check
+ *
+ * @id_h: high 64bit of the compat_id
+ * @id_l: low 64bit of the compat_id
+ */
+struct dfl_compat_id {
+	u64 id_h;
+	u64 id_l;
+};
+
+void fme_mgr_get_compat_id(struct fpga_manager *mgr,
+			   struct dfl_compat_id *id);
+
 /**
  * struct dfl_fpga_port_ops - port ops
  *
-- 
2.26.3

