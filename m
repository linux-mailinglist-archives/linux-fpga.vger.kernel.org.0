Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372193DF430
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Aug 2021 19:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbhHCRyI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Aug 2021 13:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238458AbhHCRyE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Aug 2021 13:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628013232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/0n5SoN8Nphb5rzz25bARIpmrkKEpvuDmecyvrfz4es=;
        b=gNRS5TS54ifJpreDyP8zdS/IEa9zQW9DhHJoJhNn5U2mrlq2ZViBNWxDxxZo6cc/3r0HSM
        XHA2msaEUTGYjdQa90gW2UEhetQ+cKo8XEhNa98MNHb6ibfm62r683OIiLebiSNz+en2Tl
        0TmDelOwxo3yzIUnwRPIW5gGp9khdtc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-tEC-5ZwtNZmA8zg03PEQOg-1; Tue, 03 Aug 2021 13:53:50 -0400
X-MC-Unique: tEC-5ZwtNZmA8zg03PEQOg-1
Received: by mail-qt1-f200.google.com with SMTP id g10-20020ac8768a0000b029023c90fba3dcso13877823qtr.7
        for <linux-fpga@vger.kernel.org>; Tue, 03 Aug 2021 10:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0n5SoN8Nphb5rzz25bARIpmrkKEpvuDmecyvrfz4es=;
        b=i8HWx1yp4WPuuIrrO54AemAAxI1HkbwlyZArEjk/XBXIqzl517SrOzKg5KhPCQur9v
         KbVk2uyRR5IotfypAHHU2qEnfI2VPvVdf5MKR8IME+FtsGGv+rQY9q8iCsTyiuQCzZQS
         EpxGJ78MeHSzP/p4LUwJZT6eiaCWLT41JzoVpbYy8l1vQNleOZDgpJktMXXK6BkbmF4u
         2zMiEDsep79rDbAVxf37kGdmzaYmYnmIvEixO6U/zKBxaUokwK/qg2fCA2RE98B9+CW/
         ANx+T33eB+oUR5dfcwWd0MPsU58V6vqn8MwJwLwunOmrDF/cBifFfdsohGWhilqeHSuN
         xkFw==
X-Gm-Message-State: AOAM5327CbEOt3DpO+fbGTk1pNklpwm95TofaKvJO9KquTqi5TlptMk7
        x1M6+evaOdKhdudFsbcTsHq+1+8IHENaXqYcmfc8UsKt0rYfTTfmcVFgXqJrZyFK1BwX+67sAMC
        9I0DLtxjja9Usit7iDMzqhA==
X-Received: by 2002:a0c:a321:: with SMTP id u30mr22583318qvu.57.1628013229739;
        Tue, 03 Aug 2021 10:53:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9FGRasKGf+YgUsw6Wgz0pUGMFYXqvQ6gMelUB9a5jlrqdy6GjCGvjirQ4tcLScZk+68wk9g==
X-Received: by 2002:a0c:a321:: with SMTP id u30mr22583296qvu.57.1628013229398;
        Tue, 03 Aug 2021 10:53:49 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l4sm8364697qkd.77.2021.08.03.10.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 10:53:49 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: region: introduce fpga_region_ops
Date:   Tue,  3 Aug 2021 10:53:18 -0700
Message-Id: <20210803175318.446646-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Convert passing of a get_bridges() function pointer in the
the *fpga_region_create() to passing an ops table with
get_bridges() as an element.

For backward compatibility, because *create() could take a NULL
function pointer, *create() and take a NULL ops table.

Non NULL uses were converted to ops tables.

Add a fpga_region_get_bridges() wrapper handle to the NULL cases.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 Documentation/driver-api/fpga/fpga-region.rst |  6 +++-
 drivers/fpga/dfl-fme-pr.c                     |  2 +-
 drivers/fpga/dfl-fme-region.c                 |  6 +++-
 drivers/fpga/fpga-region.c                    | 32 +++++++++++--------
 drivers/fpga/of-fpga-region.c                 |  6 +++-
 include/linux/fpga/fpga-region.h              | 22 ++++++++++---
 6 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index 2636a27c11b24..b18fec6c4be56 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -46,6 +46,7 @@ API to add a new FPGA region
 ----------------------------
 
 * struct fpga_region - The FPGA region struct
+* struct fpga_region_ops —  Low level FPGA region driver ops
 * devm_fpga_region_create() - Allocate and init a region struct
 * fpga_region_register() -  Register an FPGA region
 * fpga_region_unregister() -  Unregister an FPGA region
@@ -63,7 +64,7 @@ The FPGA region will need to specify which bridges to control while programming
 the FPGA.  The region driver can build a list of bridges during probe time
 (:c:expr:`fpga_region->bridge_list`) or it can have a function that creates
 the list of bridges to program just before programming
-(:c:expr:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
+(:c:expr:`fpga_region_ops->get_bridges`).  The FPGA bridge framework supplies the
 following APIs to handle building or tearing down that list.
 
 * fpga_bridge_get_to_list() - Get a ref of an FPGA bridge, add it to a
@@ -75,6 +76,9 @@ following APIs to handle building or tearing down that list.
 .. kernel-doc:: include/linux/fpga/fpga-region.h
    :functions: fpga_region
 
+.. kernel-doc:: include/linux/fpga/fpga-region.h
+   :functions: fpga_region_ops
+
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: devm_fpga_region_create
 
diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index d61ce9a188792..4805d8c533d4a 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -151,7 +151,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	 * reenabling the bridge to clear things out between acceleration runs.
 	 * so no need to hold the bridges after partial reconfiguration.
 	 */
-	if (region->get_bridges)
+	if (region->rops && region->rops->get_bridges)
 		fpga_bridges_put(&region->bridge_list);
 
 	put_device(&region->dev);
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 1eeb42af10122..ca7277d3d30a9 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -27,6 +27,10 @@ static int fme_region_get_bridges(struct fpga_region *region)
 	return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list);
 }
 
+static const struct fpga_region_ops fme_fpga_region_ops = {
+	.get_bridges = fme_region_get_bridges,
+};
+
 static int fme_region_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_region_pdata *pdata = dev_get_platdata(&pdev->dev);
@@ -39,7 +43,7 @@ static int fme_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
+	region = devm_fpga_region_create(dev, mgr, &fme_fpga_region_ops);
 	if (!region) {
 		ret = -ENOMEM;
 		goto eprobe_mgr_put;
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index a4838715221ff..dfa35c2dc2720 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -18,6 +18,14 @@
 static DEFINE_IDA(fpga_region_ida);
 static struct class *fpga_region_class;
 
+static int fpga_region_get_bridges(struct fpga_region *region)
+{
+	if (region->rops && region->rops->get_bridges)
+		return region->rops->get_bridges(region);
+
+	return 0;
+}
+
 struct fpga_region *fpga_region_class_find(
 	struct device *start, const void *data,
 	int (*match)(struct device *, const void *))
@@ -115,12 +123,10 @@ int fpga_region_program_fpga(struct fpga_region *region)
 	 * In some cases, we already have a list of bridges in the
 	 * fpga region struct.  Or we don't have any bridges.
 	 */
-	if (region->get_bridges) {
-		ret = region->get_bridges(region);
-		if (ret) {
-			dev_err(dev, "failed to get fpga region bridges\n");
-			goto err_unlock_mgr;
-		}
+	ret = fpga_region_get_bridges(region);
+	if (ret) {
+		dev_err(dev, "failed to get fpga region bridges\n");
+		goto err_unlock_mgr;
 	}
 
 	ret = fpga_bridges_disable(&region->bridge_list);
@@ -147,7 +153,7 @@ int fpga_region_program_fpga(struct fpga_region *region)
 	return 0;
 
 err_put_br:
-	if (region->get_bridges)
+	if (region->rops && region->rops->get_bridges)
 		fpga_bridges_put(&region->bridge_list);
 err_unlock_mgr:
 	fpga_mgr_unlock(region->mgr);
@@ -183,7 +189,7 @@ ATTRIBUTE_GROUPS(fpga_region);
  * fpga_region_create - alloc and init a struct fpga_region
  * @parent: device parent
  * @mgr: manager that programs this region
- * @get_bridges: optional function to get bridges to a list
+ * @rops:  optional pointer to struct for fpga region ops
  *
  * The caller of this function is responsible for freeing the resulting region
  * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
@@ -194,7 +200,7 @@ ATTRIBUTE_GROUPS(fpga_region);
 struct fpga_region
 *fpga_region_create(struct device *parent,
 		    struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *))
+		    const struct fpga_region_ops *rops)
 {
 	struct fpga_region *region;
 	int id, ret = 0;
@@ -208,7 +214,7 @@ struct fpga_region
 		goto err_free;
 
 	region->mgr = mgr;
-	region->get_bridges = get_bridges;
+	region->rops = rops;
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 
@@ -255,7 +261,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
  * devm_fpga_region_create - create and initialize a managed FPGA region struct
  * @parent: device parent
  * @mgr: manager that programs this region
- * @get_bridges: optional function to get bridges to a list
+ * @rops:  optional pointer to struct for fpga region ops
  *
  * This function is intended for use in an FPGA region driver's probe function.
  * After the region driver creates the region struct with
@@ -270,7 +276,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
 struct fpga_region
 *devm_fpga_region_create(struct device *parent,
 			 struct fpga_manager *mgr,
-			 int (*get_bridges)(struct fpga_region *))
+			 const struct fpga_region_ops *rops)
 {
 	struct fpga_region **ptr, *region;
 
@@ -278,7 +284,7 @@ struct fpga_region
 	if (!ptr)
 		return NULL;
 
-	region = fpga_region_create(parent, mgr, get_bridges);
+	region = fpga_region_create(parent, mgr, rops);
 	if (!region) {
 		devres_free(ptr);
 	} else {
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e3c25576b6b9d..2c99605e008a6 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -138,6 +138,10 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
 	return 0;
 }
 
+static const struct fpga_region_ops of_fpga_region_ops = {
+	.get_bridges = of_fpga_region_get_bridges,
+};
+
 /**
  * child_regions_with_firmware
  * @overlay: device node of the overlay
@@ -405,7 +409,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
+	region = devm_fpga_region_create(dev, mgr, &of_fpga_region_ops);
 	if (!region) {
 		ret = -ENOMEM;
 		goto eprobe_mgr_put;
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 27cb706275dba..d712344fd00a7 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -7,6 +7,20 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-bridge.h>
 
+struct fpga_region;
+
+/**
+ * struct fpga_region_ops - ops for low level fpga region drivers
+ * @get_bridges: optional function to get bridges to a list
+ *
+ * fpga_region_ops are the low level functions implemented by a specific
+ * fpga region driver.  The optional ones are tested for NULL before being
+ * called, so leaving them out is fine.
+ */
+struct fpga_region_ops {
+	int (*get_bridges)(struct fpga_region *region);
+};
+
 /**
  * struct fpga_region - FPGA Region structure
  * @dev: FPGA Region device
@@ -16,7 +30,7 @@
  * @info: FPGA image info
  * @compat_id: FPGA region id for compatibility check.
  * @priv: private data
- * @get_bridges: optional function to get bridges to a list
+ * @rops: optional pointer to struct for fpga region ops
  */
 struct fpga_region {
 	struct device dev;
@@ -26,7 +40,7 @@ struct fpga_region {
 	struct fpga_image_info *info;
 	struct fpga_compat_id *compat_id;
 	void *priv;
-	int (*get_bridges)(struct fpga_region *region);
+	const struct fpga_region_ops *rops;
 };
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
@@ -39,13 +53,13 @@ int fpga_region_program_fpga(struct fpga_region *region);
 
 struct fpga_region
 *fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *));
+		    const struct fpga_region_ops *rops);
 void fpga_region_free(struct fpga_region *region);
 int fpga_region_register(struct fpga_region *region);
 void fpga_region_unregister(struct fpga_region *region);
 
 struct fpga_region
 *devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-			int (*get_bridges)(struct fpga_region *));
+			 const struct fpga_region_ops *rops);
 
 #endif /* _FPGA_REGION_H */
-- 
2.26.3

