Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0144F80D7
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Apr 2022 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbiDGNkP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Apr 2022 09:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiDGNkO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Apr 2022 09:40:14 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C375229;
        Thu,  7 Apr 2022 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=b1yyYtz2GdU/r5eopTZQx0YeXHlPl8KQW9yD+PhHq6I=;
        b=NCdmti/2FZt7wIvsk7xxtlUiQId6T1IWClxRxQYN/lH7WuwfXNxxVhnd3zX5VG9wnWbMyykw3Vm9h
         JYzTQ8QobExth4dnBZUZ1m8+7dC5o8tQWGOCEmL8RXWG3ww2thy5IsXwkaatEQgWOpue0jaFoQTEO6
         hWf9//y8aaYzy384ba+iNLNZe/S59IY69GFfysiaIXDXCL5mkLuU8rQUsII1m8aNdfEWYdwDwhZgof
         YVN01C9w36so/p84wDjNxmpiWG0GwD9wQ8oNR8yNWS+dYkPgiYJEURxE2+ub2vQ9tD0vY5FY1UK+0a
         +hhutGwrpomdzYdR6JIzabXwDS2l8ug==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000008,0.014288)], BW: [Enabled, t: (0.000018,0.000001)], RTDA: [Enabled, t: (0.083807), Hit: No, Details: v2.34.0; Id: 15.52k9il.1g023tlhi.7ob6; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 7 Apr 2022 16:37:45 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 1/3] fpga: fpga-mgr: support bitstream offset in image buffer
Date:   Thu,  7 Apr 2022 16:36:56 +0300
Message-Id: <20220407133658.15699-2-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407133658.15699-1-i.bornyakov@metrotek.ru>
References: <20220407133658.15699-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

It is not always whole FPGA image buffer meant to be written to the
device.

Add bitstream_start and bitstream_size to the fpga_image_info struct and
adjust fpga_mgr_write() callers with respect to them.

If initial_header_size is not known beforehand, pass whole buffer to low
level driver's write_init() so it could setup info->bitstream_start and
info->bitstream_size regardless.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/fpga-mgr.c       | 48 +++++++++++++++++++++++++++++------
 include/linux/fpga/fpga-mgr.h |  5 ++++
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d49a9ce34568..c64e60e23a71 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -139,7 +139,8 @@ EXPORT_SYMBOL_GPL(fpga_image_info_free);
  * Call the low level driver's write_init function.  This will do the
  * device-specific things to get the FPGA into the state where it is ready to
  * receive an FPGA image. The low level driver only gets to see the first
- * initial_header_size bytes in the buffer.
+ * initial_header_size bytes in the buffer, if initial_header_size is set.
+ * Otherwise, the whole buffer will be passed.
  */
 static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 				   struct fpga_image_info *info,
@@ -148,12 +149,10 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
-	if (!mgr->mops->initial_header_size)
-		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
-	else
-		ret = fpga_mgr_write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
+	if (mgr->mops->initial_header_size)
+		count = min(mgr->mops->initial_header_size, count);
 
+	ret = fpga_mgr_write_init(mgr, info, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
@@ -235,13 +234,33 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 	if (mgr->mops->write_sg) {
 		ret = fpga_mgr_write_sg(mgr, sgt);
 	} else {
+		size_t offset, count, length, bitstream_size;
 		struct sg_mapping_iter miter;
 
+		offset = info->bitstream_start;
+		bitstream_size = info->bitstream_size;
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
+			if (bitstream_size)
+				length = min(miter.length - offset,
+					     bitstream_size - count);
+			else
+				length = miter.length - offset;
+
+			count += length;
+
+			ret = fpga_mgr_write(mgr, miter.addr + offset, length);
+			if (ret || count == bitstream_size)
 				break;
+
+			offset = 0;
 		}
 		sg_miter_stop(&miter);
 	}
@@ -265,6 +284,19 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	if (ret)
 		return ret;
 
+	if (info->bitstream_start > count) {
+		dev_err(&mgr->dev,
+			"Bitstream start %zd outruns firmware image %zd\n",
+			info->bitstream_start, count);
+		return -EINVAL;
+	}
+
+	if (info->bitstream_size)
+		count = min(info->bitstream_start + info->bitstream_size, count);
+
+	buf += info->bitstream_start;
+	count -= info->bitstream_start;
+
 	/*
 	 * Write the FPGA image to the FPGA.
 	 */
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0f9468771bb9..32464fd10cca 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -85,6 +85,9 @@ enum fpga_mgr_states {
  * @sgt: scatter/gather table containing FPGA image
  * @buf: contiguous buffer containing FPGA image
  * @count: size of buf
+ * @bitstream_start: offset in image buffer where bitstream data starts
+ * @bitstream_size: size of bitstream.
+ *	If 0, (count - bitstream_start) will be used.
  * @region_id: id of target region
  * @dev: device that owns this
  * @overlay: Device Tree overlay
@@ -98,6 +101,8 @@ struct fpga_image_info {
 	struct sg_table *sgt;
 	const char *buf;
 	size_t count;
+	size_t bitstream_start;
+	size_t bitstream_size;
 	int region_id;
 	struct device *dev;
 #ifdef CONFIG_OF
-- 
2.25.1


