Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334D53B5C2
	for <lists+linux-fpga@lfdr.de>; Thu,  2 Jun 2022 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiFBJIo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 2 Jun 2022 05:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFBJIm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 Jun 2022 05:08:42 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9BD186F3;
        Thu,  2 Jun 2022 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=kCSwY81MDG7mk4EfD3Vjt8u1QP2og1Vcs8hZSKjo6NI=;
        b=PTGcTBeu/CTtef5AYDILNqlBrNo4KXRHQHXoPTtXoBPUjCG2q2ItsIdfdiSMjPtYDsEuRHtSDV0oM
         fR4HkKtBNFpCb4VuGay8JvTkgYktBjd7U9qGqyM5rAvvAgolOFDC9cMewZ256iOrk8cPDp8uJTbArh
         /DhHasaQLlXLoSWSh9MbHW0Of5RmpS3xyRPwEYJ4OFU5JSLlZ8fWNfZDlpzLBos2OJS7UfNcgONvxZ
         0/MgpnvrUnadNfeoqtuodIasY2ZeFBxcer7Wo/v8Ko+UE0OSwSDIPy9dSrIOcizsehI+dgX+dN4Bbk
         IwxuWvaIOlR0pTsbr39djwV7IcYYebA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000013,0.037117)], BW: [Enabled, t: (0.000021,0.000001)], RTDA: [Enabled, t: (0.072277), Hit: No, Details: v2.39.0; Id: 15.52k6j5.1g4hqohos.mdml; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 2 Jun 2022 12:08:18 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: [PATCH v15 1/3] fpga: fpga-mgr: support bitstream offset in image buffer
Date:   Thu,  2 Jun 2022 11:45:48 +0300
Message-Id: <20220602084550.4380-2-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602084550.4380-1-i.bornyakov@metrotek.ru>
References: <20220602084550.4380-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
set desired size into info->header_size and return -EAGAIN, then it will
be called again with greater part of image buffer on the input.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/fpga-mgr.c       | 176 ++++++++++++++++++++++++++++------
 include/linux/fpga/fpga-mgr.h |  17 +++-
 2 files changed, 165 insertions(+), 28 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a3595ecc3f79..34473d482c21 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -74,6 +74,15 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
 	return 0;
 }
 
+static inline int fpga_mgr_parse_header(struct fpga_manager *mgr,
+					struct fpga_image_info *info,
+					const char *buf, size_t count)
+{
+	if (mgr->mops->parse_header)
+		return mgr->mops->parse_header(mgr, info, buf, count);
+	return 0;
+}
+
 static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
 				      struct fpga_image_info *info,
 				      const char *buf, size_t count)
@@ -136,24 +145,57 @@ void fpga_image_info_free(struct fpga_image_info *info)
 EXPORT_SYMBOL_GPL(fpga_image_info_free);
 
 /*
- * Call the low level driver's write_init function.  This will do the
+ * Call the low level driver's parse_header function. This will set
+ * info->header_size and info->data_size. The low level driver gets entire
+ * buffer provided. If it is not enough, driver should set desired size into
+ * info->header_size and return -EAGAIN, then parse_header() will be called
+ * again with greater part of image buffer on the input.
+ */
+static int fpga_mgr_parse_header_buf(struct fpga_manager *mgr,
+				     struct fpga_image_info *info,
+				     const char *buf, size_t count)
+{
+	int ret;
+
+	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
+	ret = fpga_mgr_parse_header(mgr, info, buf, count);
+	if (ret && ret != -EAGAIN) {
+		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
+		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
+	}
+
+	return ret;
+}
+
+/*
+ * Call the low level driver's write_init function. This will do the
  * device-specific things to get the FPGA into the state where it is ready to
- * receive an FPGA image. The low level driver only gets to see the first
- * initial_header_size bytes in the buffer.
+ * receive an FPGA image. If info->header_size is defined, the low level
+ * driver gets to see at least first info->header_size bytes in the buffer,
+ * mgr->mops->initial_header_size otherwise. If neither initial_header_size
+ * nor header_size are not set, write_init will not get any bytes of image
+ * buffer.
  */
 static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 				   struct fpga_image_info *info,
 				   const char *buf, size_t count)
 {
+	size_t header_size;
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
-	if (!mgr->mops->initial_header_size) {
+
+	if (info->header_size)
+		header_size = info->header_size;
+	else
+		header_size = mgr->mops->initial_header_size;
+
+	if (header_size > count)
+		ret = -EINVAL;
+	else if (!header_size)
 		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
-	} else {
-		count = min(mgr->mops->initial_header_size, count);
+	else
 		ret = fpga_mgr_write_init(mgr, info, buf, count);
-	}
 
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
@@ -164,16 +206,17 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 	return 0;
 }
 
-static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
-				  struct fpga_image_info *info,
-				  struct sg_table *sgt)
+static int fpga_mgr_prepare_sg(struct fpga_manager *mgr,
+			       struct fpga_image_info *info,
+			       struct sg_table *sgt)
 {
 	struct sg_mapping_iter miter;
-	size_t len;
-	char *buf;
+	size_t header_size, len;
+	char *buf = NULL;
 	int ret;
 
-	if (!mgr->mops->initial_header_size)
+	header_size = mgr->mops->initial_header_size;
+	if (!header_size)
 		return fpga_mgr_write_init_buf(mgr, info, NULL, 0);
 
 	/*
@@ -182,22 +225,44 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 	 */
 	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 	if (sg_miter_next(&miter) &&
-	    miter.length >= mgr->mops->initial_header_size) {
-		ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
-					      miter.length);
-		sg_miter_stop(&miter);
-		return ret;
+	    miter.length >= header_size) {
+		ret = fpga_mgr_parse_header_buf(mgr, info, miter.addr,
+						miter.length);
+		/*
+		 * If -EAGAIN, more sg buffer is needed, otherwise the flow
+		 * would always end up in this branch.
+		 */
+		if (ret != -EAGAIN) {
+			if (!ret)
+				ret = fpga_mgr_write_init_buf(mgr, info, miter.addr,
+							      miter.length);
+
+			sg_miter_stop(&miter);
+			return ret;
+		}
 	}
 	sg_miter_stop(&miter);
 
 	/* Otherwise copy the fragments into temporary memory. */
-	buf = kmalloc(mgr->mops->initial_header_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	do {
+		if (info->header_size)
+			header_size = info->header_size;
+
+		buf = krealloc(buf, header_size, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf, header_size);
+		if (len != header_size) {
+			kfree(buf);
+			return -EFAULT;
+		}
+
+		ret = fpga_mgr_parse_header_buf(mgr, info, buf, header_size);
+	} while (ret == -EAGAIN);
 
-	len = sg_copy_to_buffer(sgt->sgl, sgt->nents, buf,
-				mgr->mops->initial_header_size);
-	ret = fpga_mgr_write_init_buf(mgr, info, buf, len);
+	if (!ret)
+		ret = fpga_mgr_write_init_buf(mgr, info, buf, header_size);
 
 	kfree(buf);
 
@@ -227,7 +292,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 {
 	int ret;
 
-	ret = fpga_mgr_write_init_sg(mgr, info, sgt);
+	ret = fpga_mgr_prepare_sg(mgr, info, sgt);
 	if (ret)
 		return ret;
 
@@ -237,11 +302,40 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 		ret = fpga_mgr_write_sg(mgr, sgt);
 	} else {
 		struct sg_mapping_iter miter;
+		size_t length, data_size;
+		bool last = false;
+		ssize_t count;
+		char *addr;
+
+		data_size = info->data_size;
+		count = -info->header_size;
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
-			if (ret)
+			count += miter.length;
+
+			/* sg block contains only header, no data */
+			if (count <= 0)
+				continue;
+
+			if (count < miter.length) {
+				/* sg block contains both header and data */
+				addr = miter.addr + miter.length - count;
+				length = count;
+			} else {
+				/* sg block contains pure data */
+				addr = miter.addr;
+				length = miter.length;
+			}
+
+			/* truncate last block to data_size, if needed */
+			if (data_size && count > data_size) {
+				length -= count - data_size;
+				last = true;
+			}
+
+			ret = fpga_mgr_write(mgr, addr, length);
+			if (ret || last)
 				break;
 		}
 		sg_miter_stop(&miter);
@@ -262,10 +356,34 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 {
 	int ret;
 
+	ret = fpga_mgr_parse_header_buf(mgr, info, buf, count);
+	if (ret) {
+		if (ret == -EAGAIN) {
+			dev_err(&mgr->dev, "Header outruns FPGA image\n");
+			mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
+			ret = -EINVAL;
+		}
+
+		return ret;
+	}
+
+	if (info->header_size + info->data_size > count) {
+		dev_err(&mgr->dev, "Bitsream data outruns FPGA image\n");
+		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
+		return -EINVAL;
+	}
+
 	ret = fpga_mgr_write_init_buf(mgr, info, buf, count);
 	if (ret)
 		return ret;
 
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
@@ -424,6 +542,10 @@ static const char * const state_str[] = {
 	[FPGA_MGR_STATE_FIRMWARE_REQ] =		"firmware request",
 	[FPGA_MGR_STATE_FIRMWARE_REQ_ERR] =	"firmware request error",
 
+	/* Parse FPGA image header */
+	[FPGA_MGR_STATE_PARSE_HEADER] =		"parse header",
+	[FPGA_MGR_STATE_PARSE_HEADER_ERR] =	"parse header error",
+
 	/* Preparing FPGA to receive image */
 	[FPGA_MGR_STATE_WRITE_INIT] =		"write init",
 	[FPGA_MGR_STATE_WRITE_INIT_ERR] =	"write init error",
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0f9468771bb9..cba8bb7827a5 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -22,6 +22,8 @@ struct sg_table;
  * @FPGA_MGR_STATE_RESET: FPGA in reset state
  * @FPGA_MGR_STATE_FIRMWARE_REQ: firmware request in progress
  * @FPGA_MGR_STATE_FIRMWARE_REQ_ERR: firmware request failed
+ * @FPGA_MGR_STATE_PARSE_HEADER: parse FPGA image header
+ * @FPGA_MGR_STATE_PARSE_HEADER_ERR: Error during PARSE_HEADER stage
  * @FPGA_MGR_STATE_WRITE_INIT: preparing FPGA for programming
  * @FPGA_MGR_STATE_WRITE_INIT_ERR: Error during WRITE_INIT stage
  * @FPGA_MGR_STATE_WRITE: writing image to FPGA
@@ -42,6 +44,8 @@ enum fpga_mgr_states {
 	FPGA_MGR_STATE_FIRMWARE_REQ_ERR,
 
 	/* write sequence: init, write, complete */
+	FPGA_MGR_STATE_PARSE_HEADER,
+	FPGA_MGR_STATE_PARSE_HEADER_ERR,
 	FPGA_MGR_STATE_WRITE_INIT,
 	FPGA_MGR_STATE_WRITE_INIT_ERR,
 	FPGA_MGR_STATE_WRITE,
@@ -85,6 +89,8 @@ enum fpga_mgr_states {
  * @sgt: scatter/gather table containing FPGA image
  * @buf: contiguous buffer containing FPGA image
  * @count: size of buf
+ * @header_size: offset in image buffer where bitstream data starts
+ * @data_size: size of bitstream. If 0, (count - header_size) will be used.
  * @region_id: id of target region
  * @dev: device that owns this
  * @overlay: Device Tree overlay
@@ -98,6 +104,8 @@ struct fpga_image_info {
 	struct sg_table *sgt;
 	const char *buf;
 	size_t count;
+	size_t header_size;
+	size_t data_size;
 	int region_id;
 	struct device *dev;
 #ifdef CONFIG_OF
@@ -137,9 +145,13 @@ struct fpga_manager_info {
 
 /**
  * struct fpga_manager_ops - ops for low level fpga manager drivers
- * @initial_header_size: Maximum number of bytes that should be passed into write_init
+ * @initial_header_size: minimum number of bytes that should be passed into
+ *	parse_header and write_init.
  * @state: returns an enum value of the FPGA's state
  * @status: returns status of the FPGA, including reconfiguration error code
+ * @parse_header: parse FPGA image header to set info->header_size and
+ *	info->data_size. In case the input buffer is not large enough, set
+ *	required size to info->header_size and return -EAGAIN.
  * @write_init: prepare the FPGA to receive configuration data
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
@@ -155,6 +167,9 @@ struct fpga_manager_ops {
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


