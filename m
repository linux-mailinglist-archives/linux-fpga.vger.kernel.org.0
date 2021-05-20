Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A75E38B607
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhETSbv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 14:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233462AbhETSbu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 14:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/bPnMh8D9HEJogKStb+MSo8WLoMkx+68yj+/mcrE5vw=;
        b=OXvfoIAwQRFzegxOksvSoWUjT3UiOg18sWEfTlyBmWucnQOwHTKwoceKtfhTWvia00p1f+
        G0KR9WdXivOrE4pKEWt6fvdKmAURT+zJIA7kQQ0crRLyt4E7ean/mqOBcm0h8TYZQev7VL
        lIwGme4y2tQaxCOW5FdS8rjaAbseWsg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-crN2U07tO02FXMqymTZHSQ-1; Thu, 20 May 2021 14:30:27 -0400
X-MC-Unique: crN2U07tO02FXMqymTZHSQ-1
Received: by mail-qv1-f72.google.com with SMTP id b24-20020a0cb3d80000b02901e78b82d74aso13930967qvf.20
        for <linux-fpga@vger.kernel.org>; Thu, 20 May 2021 11:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bPnMh8D9HEJogKStb+MSo8WLoMkx+68yj+/mcrE5vw=;
        b=dXCQFvYArJ+oXEY0j+qjYDzpmcTVlWDRpGbpbUeT5SQyUunIqs+xnrJ+NJSvHYMGwP
         MhJpHuQyN9fteDyTH3U00CJrWWN04tl28Vbgxin8tcsS98lUsKWS1d4OWl9Sm+grt+Tz
         W++T67RrV5IkBCqDhRoA29OD0M2Quqvxy4dtuGK5r2iofNW9POqcr+Q7ZvFyt4oJmmdL
         Cl6rm/gtwFrhU2OTgVo8K03HS6tsuLYXsDK52IIE7CPsCcNnKDNvOeP+vME9gY8QtvD0
         Z3DT4NY7/XLu/D1KWLC2zZ3fcjO9URXfG/AX16/6f0gYl7sRL8OHddJDRIQutym1Q2ZO
         gtfg==
X-Gm-Message-State: AOAM533CgK1TslrGg2q9Q6sEmWTD2ITo0ICk2wl13PAa4gMGoDxCDMlN
        8JIyDpLW4HE2omYwzhH679N9m8VGPCQnqtmDRjovw+doQOuIyiX4+EMZNfmDdWrEYr3IhYJjJKC
        pwy+6cSNY6SkUQCj+llfouA==
X-Received: by 2002:ad4:420b:: with SMTP id k11mr7416626qvp.18.1621535426950;
        Thu, 20 May 2021 11:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfidu4zN2uet8HOwwObbCGcgkQBZyXWsGSIncju4TJAnj0jTlP5hQB9h0cdJsfDlnQx5Otkw==
X-Received: by 2002:ad4:420b:: with SMTP id k11mr7416605qvp.18.1621535426777;
        Thu, 20 May 2021 11:30:26 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u26sm2512296qtf.24.2021.05.20.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:30:26 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 3/5] fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
Date:   Thu, 20 May 2021 11:30:22 -0700
Message-Id: <20210520183022.2022394-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Refactor fpga_manager_write* functions for reimaging, pass
the update_ops as a parameter.  Only do the reconfig ops.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 57 ++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index e3fc1b0bd7181..4263c9e94949d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -77,16 +77,17 @@ EXPORT_SYMBOL_GPL(fpga_image_info_free);
  */
 static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 				   struct fpga_image_info *info,
+				   const struct fpga_manager_update_ops *uops,
 				   const char *buf, size_t count)
 {
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = mgr->mops->reconfig.write_init(mgr, info, NULL, 0);
+		ret = uops->write_init(mgr, info, NULL, 0);
 	else
-		ret = mgr->mops->reconfig.write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
+		ret = uops->write_init(
+			mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
@@ -99,6 +100,7 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
+				  const struct fpga_manager_update_ops *uops,
 				  struct sg_table *sgt)
 {
 	struct sg_mapping_iter miter;
@@ -107,7 +109,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	int ret;
 
 	if (!mgr->mops->initial_header_size)
-		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
+		return fpga_mgr_write_init_buf(mgr, info, uops, NULL, 0);
 
 	/*
 	 * First try to use miter to map the first fragment to access the
@@ -116,7 +118,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 	if (sg_miter_next(&miter) &&
 	    miter.length >= mgr->mops->initial_header_size) {
-		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
+		ret = fpga_mgr_write_init_buf(mgr, info, uops, miter.addr,
 					      miter.length);
 		sg_miter_stop(&miter);
 		return ret;
@@ -130,7 +132,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 
 	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
 				mgr->mops->initial_header_size);
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
+	ret = fpga_mgr_write_init_buf(mgr, info, uops, buf, len);
 
 	kfree(buf);
 
@@ -142,12 +144,13 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
  * finish and set the FPGA into operating mode.
  */
 static int fpga_mgr_write_complete(struct fpga_manager *mgr,
-				   struct fpga_image_info *info)
+				   struct fpga_image_info *info,
+				   const struct fpga_manager_update_ops *uops)
 {
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	ret = mgr->mops->reconfig.write_complete(mgr, info);
+	ret = uops->write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -162,6 +165,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
  * fpga_mgr_buf_load_sg - load fpga from image in buffer from a scatter list
  * @mgr:	fpga manager
  * @info:	fpga image specific information
+ * @uops:       which update ops to use
  * @sgt:	scatterlist table
  *
  * Step the low level fpga manager through the device-specific steps of getting
@@ -177,24 +181,25 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
  */
 static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 				struct fpga_image_info *info,
+				const struct fpga_manager_update_ops *uops,
 				struct sg_table *sgt)
 {
 	int ret;
 
-	ret = fpga_mgr_write_init_sg(mgr, info, sgt);
+	ret = fpga_mgr_write_init_sg(mgr, info, uops, sgt);
 	if (ret)
 		return ret;
 
 	/* Write the FPGA image to the FPGA. */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	if (mgr->mops->reconfig.write_sg) {
-		ret = mgr->mops->reconfig.write_sg(mgr, sgt);
+	if (uops->write_sg) {
+		ret = uops->write_sg(mgr, sgt);
 	} else {
 		struct sg_mapping_iter miter;
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = mgr->mops->reconfig.write(mgr, miter.addr, miter.length);
+			ret = uops->write(mgr, miter.addr, miter.length);
 			if (ret)
 				break;
 		}
@@ -207,16 +212,17 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 		return ret;
 	}
 
-	return fpga_mgr_write_complete(mgr, info);
+	return fpga_mgr_write_complete(mgr, info, uops);
 }
 
 static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 				    struct fpga_image_info *info,
+				    const struct fpga_manager_update_ops *uops,
 				    const char *buf, size_t count)
 {
 	int ret;
 
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, count);
+	ret = fpga_mgr_write_init_buf(mgr, info, uops, buf, count);
 	if (ret)
 		return ret;
 
@@ -224,20 +230,21 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	ret = mgr->mops->reconfig.write(mgr, buf, count);
+	ret = uops->write(mgr, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
 		return ret;
 	}
 
-	return fpga_mgr_write_complete(mgr, info);
+	return fpga_mgr_write_complete(mgr, info, uops);
 }
 
 /**
  * fpga_mgr_buf_load - load fpga from image in buffer
  * @mgr:	fpga manager
  * @info:	fpga image info
+ * @uops:       which update ops to use
  * @buf:	buffer contain fpga image
  * @count:	byte count of buf
  *
@@ -250,6 +257,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
  */
 static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 			     struct fpga_image_info *info,
+			     const struct fpga_manager_update_ops *uops,
 			     const char *buf, size_t count)
 {
 	struct page **pages;
@@ -264,8 +272,8 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	 * contiguous kernel buffer and the driver doesn't require SG, non-SG
 	 * drivers will still work on the slow path.
 	 */
-	if (mgr->mops->reconfig.write)
-		return fpga_mgr_buf_load_mapped(mgr, info, buf, count);
+	if (uops->write)
+		return fpga_mgr_buf_load_mapped(mgr, info, uops, buf, count);
 
 	/*
 	 * Convert the linear kernel pointer into a sg_table of pages for use
@@ -300,7 +308,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	if (rc)
 		return rc;
 
-	rc = fpga_mgr_buf_load_sg(mgr, info, &sgt);
+	rc = fpga_mgr_buf_load_sg(mgr, info, uops, &sgt);
 	sg_free_table(&sgt);
 
 	return rc;
@@ -322,6 +330,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
  */
 static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
+				  const struct fpga_manager_update_ops *uops,
 				  const char *image_name)
 {
 	struct device *dev = &mgr->dev;
@@ -339,7 +348,7 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 		return ret;
 	}
 
-	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size);
+	ret = fpga_mgr_buf_load(mgr, info, uops, fw->data, fw->size);
 
 	release_firmware(fw);
 
@@ -358,12 +367,14 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
  */
 int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
+	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
+
 	if (info->sgt)
-		return fpga_mgr_buf_load_sg(mgr, info, info->sgt);
+		return fpga_mgr_buf_load_sg(mgr, info, uops, info->sgt);
 	if (info->buf && info->count)
-		return fpga_mgr_buf_load(mgr, info, info->buf, info->count);
+		return fpga_mgr_buf_load(mgr, info, uops, info->buf, info->count);
 	if (info->firmware_name)
-		return fpga_mgr_firmware_load(mgr, info, info->firmware_name);
+		return fpga_mgr_firmware_load(mgr, info, uops, info->firmware_name);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_load);
-- 
2.26.3

