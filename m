Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0499D3B498F
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFYUBd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 16:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhFYUBb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 16:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624651149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqSN7YKNu7jB+HrLuLUg+PFT/fO3y/oLnfYjNwzT7ZY=;
        b=eBvlDG3iy0xw37x9W4uflrd8jWzIMnng7KgQOKLxscoNrVzSz6ZCQfPCKgwsJxk62xvprx
        FAb4vjqzaE03mwCh2rn/kh2ffO0UBz3CiwkoQCKrnewDlu1yK1eyLVEdXFOTFxVvI4uiFb
        2lDGr7EoeNWw/Exg3qHT7hdArCqnGEY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-IBgyyG1YO2OR0ZOocN0SDg-1; Fri, 25 Jun 2021 15:59:08 -0400
X-MC-Unique: IBgyyG1YO2OR0ZOocN0SDg-1
Received: by mail-oo1-f72.google.com with SMTP id r26-20020a4acb1a0000b029024c388a4835so2766213ooq.7
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqSN7YKNu7jB+HrLuLUg+PFT/fO3y/oLnfYjNwzT7ZY=;
        b=PSKzi5GuNEY0OI3jKzBb9hvjqCXkYoPx/lw45hM4B5ZvJyUWuow91pM5rCaSlIyQrA
         sHIztxM0f+V2DeR1rJl8F+sImQuRQoAd0FMr4HPXg9wndJrNpBtWBeOjl64d4LTyPmDS
         ygKS/FrFEDLgsF+JCI/IeLJ+8G7Aj03yBAY3K/JX2kvEwHi84i9udkpFnBcsmz3Psf/9
         OAi9a6WoF2lYGCA8Vc5WnPrPlBQqAPdzIo/hur71DAA6Qun/TQTgaEXIlJ66jKxbp1Ph
         88RiFpjR7Dv+Y3icaXEVFIYECdJCmWTiXr/spXLmyVx2xv8eSlBv0xABOWQHlokKPOco
         lIpw==
X-Gm-Message-State: AOAM5303PlH37GrWCsCNdlDoPuHUe9DMlucbo76NWzYtiRXBVW+iQB+w
        sih3um+PTPMOPRZqkQkSj1RBmrrNBw+dhrLHY/O9kwM5/fNBYMfLlnUvvORBxb+KZeKYaReKQyr
        HBNH2sGpJzi1C+H00HyV42A==
X-Received: by 2002:a9d:7748:: with SMTP id t8mr10592306otl.110.1624651147439;
        Fri, 25 Jun 2021 12:59:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu34MbJmcblH8cUFKOa/B1UaUgiD0OGN1o/K/VsRr/ozopnaksdv0CoB7hGyKwnTfZVZXWwg==
X-Received: by 2002:a9d:7748:: with SMTP id t8mr10592285otl.110.1624651147242;
        Fri, 25 Jun 2021 12:59:07 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r204sm1467374oih.11.2021.06.25.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:59:06 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v5 3/4] fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
Date:   Fri, 25 Jun 2021 12:58:48 -0700
Message-Id: <20210625195849.837976-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195849.837976-1-trix@redhat.com>
References: <20210625195849.837976-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Refactor fpga_manager_write* functions for reimaging, pass
the update_ops as a parameter.  Continue the passing of the update_ops
to the write wrapper functions.  Only do the reconfig ops.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 90 ++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 31c51d7e07cc8..c8a6bfa037933 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -45,10 +45,12 @@ static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
 	return 0;
 }
 
-static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
+static inline int fpga_mgr_write(struct fpga_manager *mgr,
+				 const char *buf, size_t count,
+				 const struct fpga_manager_update_ops *uops)
 {
 	if (mgr->mops->reconfig.write)
-		return  mgr->mops->reconfig.write(mgr, buf, count);
+		return  uops->write(mgr, buf, count);
 	return -EOPNOTSUPP;
 }
 
@@ -57,13 +59,14 @@ static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size
  * finish and set the FPGA into operating mode.
  */
 static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
-					  struct fpga_image_info *info)
+					  struct fpga_image_info *info,
+					  const struct fpga_manager_update_ops *uops)
 {
 	int ret = 0;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	if (mgr->mops->reconfig.write_complete)
-		ret = mgr->mops->reconfig.write_complete(mgr, info);
+	if (uops->write_complete)
+		ret = uops->write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -76,18 +79,20 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
 
 static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
 				      struct fpga_image_info *info,
-				      const char *buf, size_t count)
+				      const char *buf, size_t count,
+				      const struct fpga_manager_update_ops *uops)
 {
-	if (mgr->mops->reconfig.write_init)
-		return  mgr->mops->reconfig.write_init(mgr, info, buf, count);
+	if (uops->write_init)
+		return  uops->write_init(mgr, info, buf, count);
 	return 0;
 }
 
 static inline int fpga_mgr_write_sg(struct fpga_manager *mgr,
-				    struct sg_table *sgt)
+				    struct sg_table *sgt,
+				    const struct fpga_manager_update_ops *uops)
 {
-	if (mgr->mops->reconfig.write_sg)
-		return  mgr->mops->reconfig.write_sg(mgr, sgt);
+	if (uops->write_sg)
+		return  uops->write_sg(mgr, sgt);
 	return -EOPNOTSUPP;
 }
 
@@ -143,16 +148,17 @@ EXPORT_SYMBOL_GPL(fpga_image_info_free);
  */
 static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 				   struct fpga_image_info *info,
-				   const char *buf, size_t count)
+				   const char *buf, size_t count,
+				   const struct fpga_manager_update_ops *uops)
 {
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
+		ret = fpga_mgr_write_init(mgr, info, NULL, 0, uops);
 	else
 		ret = fpga_mgr_write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
+		    mgr, info, buf, min(mgr->mops->initial_header_size, count), uops);
 
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
@@ -165,7 +171,8 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
-				  struct sg_table *sgt)
+				  struct sg_table *sgt,
+				  const struct fpga_manager_update_ops *uops)
 {
 	struct sg_mapping_iter miter;
 	size_t len;
@@ -173,7 +180,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	int ret;
 
 	if (!mgr->mops->initial_header_size)
-		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
+		return fpga_mgr_write_init_buf(mgr, info, NULL, 0, uops);
 
 	/*
 	 * First try to use miter to map the first fragment to access the
@@ -183,7 +190,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	if (sg_miter_next(&miter) &&
 	    miter.length >= mgr->mops->initial_header_size) {
 		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
-					      miter.length);
+					      miter.length, uops);
 		sg_miter_stop(&miter);
 		return ret;
 	}
@@ -196,7 +203,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 
 	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
 				mgr->mops->initial_header_size);
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
+	ret = fpga_mgr_write_init_buf(mgr, info, buf, len, uops);
 
 	kfree(buf);
 
@@ -208,6 +215,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
  * @mgr:	fpga manager
  * @info:	fpga image specific information
  * @sgt:	scatterlist table
+ * @uops:       which update ops to use
  *
  * Step the low level fpga manager through the device-specific steps of getting
  * an FPGA ready to be configured, writing the image to it, then doing whatever
@@ -222,24 +230,25 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
  */
 static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 				struct fpga_image_info *info,
-				struct sg_table *sgt)
+				struct sg_table *sgt,
+				const struct fpga_manager_update_ops *uops)
 {
 	int ret;
 
-	ret = fpga_mgr_write_init_sg(mgr, info, sgt);
+	ret = fpga_mgr_write_init_sg(mgr, info, sgt, uops);
 	if (ret)
 		return ret;
 
 	/* Write the FPGA image to the FPGA. */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	if (mgr->mops->reconfig.write_sg) {
-		ret = fpga_mgr_write_sg(mgr, sgt);
+	if (uops->write_sg) {
+		ret = fpga_mgr_write_sg(mgr, sgt, uops);
 	} else {
 		struct sg_mapping_iter miter;
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
+			ret = fpga_mgr_write(mgr, miter.addr, miter.length, uops);
 			if (ret)
 				break;
 		}
@@ -252,16 +261,17 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 		return ret;
 	}
 
-	return fpga_mgr_write_complete(mgr, info);
+	return fpga_mgr_write_complete(mgr, info, uops);
 }
 
 static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 				    struct fpga_image_info *info,
-				    const char *buf, size_t count)
+				    const char *buf, size_t count,
+				    const struct fpga_manager_update_ops *uops)
 {
 	int ret;
 
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, count);
+	ret = fpga_mgr_write_init_buf(mgr, info, buf, count, uops);
 	if (ret)
 		return ret;
 
@@ -269,14 +279,14 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	ret = fpga_mgr_write(mgr, buf, count);
+	ret = fpga_mgr_write(mgr, buf, count, uops);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
 		return ret;
 	}
 
-	return fpga_mgr_write_complete(mgr, info);
+	return fpga_mgr_write_complete(mgr, info, uops);
 }
 
 /**
@@ -285,6 +295,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
  * @info:	fpga image info
  * @buf:	buffer contain fpga image
  * @count:	byte count of buf
+ * @uops:       which update ops to use
  *
  * Step the low level fpga manager through the device-specific steps of getting
  * an FPGA ready to be configured, writing the image to it, then doing whatever
@@ -295,7 +306,8 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
  */
 static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 			     struct fpga_image_info *info,
-			     const char *buf, size_t count)
+			     const char *buf, size_t count,
+			     const struct fpga_manager_update_ops *uops)
 {
 	struct page **pages;
 	struct sg_table sgt;
@@ -309,8 +321,8 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	 * contiguous kernel buffer and the driver doesn't require SG, non-SG
 	 * drivers will still work on the slow path.
 	 */
-	if (mgr->mops->reconfig.write)
-		return fpga_mgr_buf_load_mapped(mgr, info, buf, count);
+	if (uops && uops->write)
+		return fpga_mgr_buf_load_mapped(mgr, info, buf, count, uops);
 
 	/*
 	 * Convert the linear kernel pointer into a sg_table of pages for use
@@ -345,7 +357,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	if (rc)
 		return rc;
 
-	rc = fpga_mgr_buf_load_sg(mgr, info, &sgt);
+	rc = fpga_mgr_buf_load_sg(mgr, info, &sgt, uops);
 	sg_free_table(&sgt);
 
 	return rc;
@@ -356,6 +368,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
  * @mgr:	fpga manager
  * @info:	fpga image specific information
  * @image_name:	name of image file on the firmware search path
+ * @uops:       which update ops to use
  *
  * Request an FPGA image using the firmware class, then write out to the FPGA.
  * Update the state before each step to provide info on what step failed if
@@ -367,7 +380,8 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
  */
 static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
-				  const char *image_name)
+				  const char *image_name,
+				  const struct fpga_manager_update_ops *uops)
 {
 	struct device *dev = &mgr->dev;
 	const struct firmware *fw;
@@ -384,7 +398,7 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 		return ret;
 	}
 
-	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size);
+	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size, uops);
 
 	release_firmware(fw);
 
@@ -403,12 +417,14 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
  */
 int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
+	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
+
 	if (info->sgt)
-		return fpga_mgr_buf_load_sg(mgr, info, info->sgt);
+		return fpga_mgr_buf_load_sg(mgr, info, info->sgt, uops);
 	if (info->buf && info->count)
-		return fpga_mgr_buf_load(mgr, info, info->buf, info->count);
+		return fpga_mgr_buf_load(mgr, info, info->buf, info->count, uops);
 	if (info->firmware_name)
-		return fpga_mgr_firmware_load(mgr, info, info->firmware_name);
+		return fpga_mgr_firmware_load(mgr, info, info->firmware_name, uops);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_load);
-- 
2.26.3

