Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B051E570
	for <lists+linux-fpga@lfdr.de>; Sat,  7 May 2022 10:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446046AbiEGIIb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 7 May 2022 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiEGIIa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 7 May 2022 04:08:30 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7765AA7C;
        Sat,  7 May 2022 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=YkcjSWg7/91RhMrEqYEY6CqgGvvSpHevTEfvdDlA+ek=;
        b=hMArBkbsLxomLZY1B/073kOZWe5oQAKzpu7OGgZCdqxU7gcrV9ugjFUpRiJpE1RMGZHUTyh5uE/hq
         /iuPsKLFUYDJWEGPDeNlrloTngMeyGJeEHnv1UxCvuNSeGjyIRvpzMLCXuY62ijR+ey6gBRGuhHQ3C
         zKTFckwr4ETy+zHnV5UOz7t1xwhV3dmPn2oUIhitiJdmcODwf/W05su1J5XCmH5kq6P0vJT7GRLJ7t
         nXmkraP/Zyqa/YcaO6OpNIo52ZNj7N/n8xalndFMEPLk/v++YPzuYRbR/27NhR1b73yY4rIDqFM4jC
         dA/y/9ZgWJutzPZaVeKYTwRBItpOBYg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1422, Stamp: 3], Multi: [Enabled, t: (0.000012,0.031018)], BW: [Enabled, t: (0.000020,0.000001)], RTDA: [Enabled, t: (0.066656), Hit: No, Details: v2.39.0; Id: 15.52k95k.1g2eoop69.2j8j; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sat, 7 May 2022 11:04:21 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru, Ivan Bornyakov <i.bornyakov@metrotek.ru>
Subject: [PATCH v11 1/3] fpga: fpga-mgr: support bitstream offset in image buffer
Date:   Sat,  7 May 2022 10:43:02 +0300
Message-Id: <20220507074304.11144-2-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507074304.11144-1-i.bornyakov@metrotek.ru>
References: <20220507074304.11144-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

At the moment FPGA manager core loads to the device entire image
provided to fpga_mgr_load(). But it is not always whole FPGA image
buffer meant to be written to the device. In particular, .dat formatted
image for Microchip MPF contains meta info in the header that is not
meant to be written to the device. This is issue for those low level
drivers that loads data to the device with write() fpga_manager_ops
callback, since write() can be called in iterator over scatter-gather
table, not only linear image buffer. On the other hand, write_sg()
callback is provided with whole image in scatter-gather form and can
decide itself which part should be sent to the device.

Add header_size and data_size to the fpga_image_info struct and adjust
fpga_mgr_write() callers with respect to them.

  * info->header_size indicates part at the beginning of image buffer
    that is *not* meant to be written to the device. It is optional and
    can be 0.

  * info->data_size is the size of actual bitstream data that *is* meant
    to be written to the device, starting at info->header_size from the
    beginning of image buffer. It is also optional and can be 0, which
    means bitstream data is up to the end of image buffer.

Also add parse_header() callback to fpga_manager_ops, which purpose is
to set info->header_size and info->data_size. At least
initial_header_size bytes of image buffer will be passed into
parse_header() first time. If it is not enough, parse_header() should
set desired size into info->header_size and return -EAGAIN, than it will
be called again with greater part of image buffer on the input.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/fpga-mgr.c       | 151 ++++++++++++++++++++++++++--------
 include/linux/fpga/fpga-mgr.h |  13 ++-
 2 files changed, 128 insertions(+), 36 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 6bd018f20793..c6ca395909a0 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -74,6 +74,15 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
 	return 0;
 }
 
+static inline int fpga_mgr_parse_header(struct fpga_manager *mgr,
+					struct fpga_image_info *info,
+					const char *buf, size_t count)
+{
+	if (buf && mgr->mops->parse_header)
+		return mgr->mops->parse_header(mgr, info, buf, count);
+	return 0;
+}
+
 static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
 				      struct fpga_image_info *info,
 				      const char *buf, size_t count)
@@ -136,31 +145,61 @@ void fpga_image_info_free(struct fpga_image_info *info)
 EXPORT_SYMBOL_GPL(fpga_image_info_free);
 
 /*
- * Call the low level driver's write_init function.  This will do the
- * device-specific things to get the FPGA into the state where it is ready to
- * receive an FPGA image. The low level driver only gets to see the first
- * initial_header_size bytes in the buffer.
+ * Call the low level driver's parse_header then write_init functions.
+ * This will do the device-specific things to get the FPGA into the state
+ * where it is ready to receive an FPGA image. If parse_header sets
+ * info->header_size, the low level driver's write_init only gets to see the
+ * first info->header_size bytes in the buffer, mgr->mops->initial_header_size
+ * otherwise. If neither initial_header_size nor header_size are not set,
+ * write_init will not get any bytes of image buffer.
  */
 static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 				   struct fpga_image_info *info,
 				   const char *buf, size_t count)
 {
+	size_t header_size;
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
-	count = min(mgr->mops->initial_header_size, count);
-	if (!mgr->mops->initial_header_size)
-		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
-	else
-		ret = fpga_mgr_write_init(mgr, info, buf, count);
+	ret = fpga_mgr_parse_header(mgr, info, buf, count);
+	if (ret) {
+		if (ret != -EAGAIN)
+			dev_err(&mgr->dev,
+				"Error while parsing FPGA image header\n");
 
+		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return ret;
+	}
+
+	header_size = mgr->mops->initial_header_size;
+	if (info->header_size)
+		header_size = info->header_size;
+
+	ret = fpga_mgr_write_init(mgr, info, header_size ? buf : NULL, header_size);
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
-		return ret;
 	}
 
-	return 0;
+	return ret;
+}
+
+static void *fpga_mgr_sgt_bounce_buf(struct sg_table *sgt, size_t count)
+{
+	size_t len;
+	void *buf;
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf, count);
+	if (len != count) {
+		kfree(buf);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return buf;
 }
 
 static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
@@ -168,37 +207,46 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 				  struct sg_table *sgt)
 {
 	struct sg_mapping_iter miter;
-	size_t len;
+	size_t header_size;
 	char *buf;
-	int ret;
+	int ret = -EAGAIN;
 
-	if (!mgr->mops->initial_header_size)
+	header_size = mgr->mops->initial_header_size;
+	if (!header_size)
 		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
 
-	/*
-	 * First try to use miter to map the first fragment to access the
-	 * header, this is the typical path.
-	 */
 	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
-	if (sg_miter_next(&miter) &&
-	    miter.length >= mgr->mops->initial_header_size) {
-		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
-					      miter.length);
-		sg_miter_stop(&miter);
-		return ret;
+	if (!sg_miter_next(&miter)) {
+		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		ret = -EFAULT;
 	}
-	sg_miter_stop(&miter);
 
-	/* Otherwise copy the fragments into temporary memory. */
-	buf = kmalloc(mgr->mops->initial_header_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	while (ret == -EAGAIN) {
+		/*
+		 * First try to use miter to map the first fragment to access
+		 * the header, this is the typical path.
+		 */
+		if (miter.length >= header_size) {
+			ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
+						      miter.length);
+		} else {
+			/*
+			 * Otherwise copy the fragments into temporary memory.
+			 */
+			buf = fpga_mgr_sgt_bounce_buf(sgt, header_size);
+			if (IS_ERR(buf)) {
+				mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+				ret = PTR_ERR(buf);
+				break;
+			}
 
-	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
-				mgr->mops->initial_header_size);
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
+			ret = fpga_mgr_write_init_buf(mgr, info, buf, header_size);
+			kfree(buf);
+		}
 
-	kfree(buf);
+		header_size = info->header_size;
+	}
+	sg_miter_stop(&miter);
 
 	return ret;
 }
@@ -235,13 +283,33 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 	if (mgr->mops->write_sg) {
 		ret = fpga_mgr_write_sg(mgr, sgt);
 	} else {
+		size_t offset, count, length, data_size;
 		struct sg_mapping_iter miter;
 
+		offset = info->header_size;
+		data_size = info->data_size;
+		count = 0;
+
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
-			if (ret)
+			if (offset >= miter.length) {
+				offset -= miter.length;
+				continue;
+			}
+
+			if (data_size)
+				length = min(miter.length - offset,
+					     data_size - count);
+			else
+				length = miter.length - offset;
+
+			count += length;
+
+			ret = fpga_mgr_write(mgr, miter.addr + offset, length);
+			if (ret || count == data_size)
 				break;
+
+			offset = 0;
 		}
 		sg_miter_stop(&miter);
 	}
@@ -265,6 +333,19 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	if (ret)
 		return ret;
 
+	if (info->header_size + info->data_size > count) {
+		dev_err(&mgr->dev, "Bitsream data outruns FPGA image\n");
+		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return -EINVAL;
+	}
+
+	if (info->data_size)
+		count = info->data_size;
+	else
+		count -= info->header_size;
+
+	buf += info->header_size;
+
 	/*
 	 * Write the FPGA image to the FPGA.
 	 */
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0f9468771bb9..a49b97bccfa2 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -85,6 +85,8 @@ enum fpga_mgr_states {
  * @sgt: scatter/gather table containing FPGA image
  * @buf: contiguous buffer containing FPGA image
  * @count: size of buf
+ * @header_size: offset in image buffer where bitstream data starts
+ * @data_size: size of bitstream. If 0, (count - header_size) will be used.
  * @region_id: id of target region
  * @dev: device that owns this
  * @overlay: Device Tree overlay
@@ -98,6 +100,8 @@ struct fpga_image_info {
 	struct sg_table *sgt;
 	const char *buf;
 	size_t count;
+	size_t header_size;
+	size_t data_size;
 	int region_id;
 	struct device *dev;
 #ifdef CONFIG_OF
@@ -137,9 +141,13 @@ struct fpga_manager_info {
 
 /**
  * struct fpga_manager_ops - ops for low level fpga manager drivers
- * @initial_header_size: Maximum number of bytes that should be passed into write_init
+ * @initial_header_size: minimum number of bytes that should be passed into
+ *	parse_header and write_init.
  * @state: returns an enum value of the FPGA's state
  * @status: returns status of the FPGA, including reconfiguration error code
+ * @parse_header: parse FPGA image header to set info->header_size and
+ *	info->data_size. In case the input buffer is not large enough, set
+ *	requierd size to info->header_size and return -EAGAIN.
  * @write_init: prepare the FPGA to receive configuration data
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
@@ -155,6 +163,9 @@ struct fpga_manager_ops {
 	size_t initial_header_size;
 	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
 	u64 (*status)(struct fpga_manager *mgr);
+	int (*parse_header)(struct fpga_manager *mgr,
+			    struct fpga_image_info *info,
+			    const char *buf, size_t count);
 	int (*write_init)(struct fpga_manager *mgr,
 			  struct fpga_image_info *info,
 			  const char *buf, size_t count);
-- 
2.35.1


