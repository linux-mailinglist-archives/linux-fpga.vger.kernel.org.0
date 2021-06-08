Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC23A04B5
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhFHT5V (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 15:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234618AbhFHT5M (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 15:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+ieZpNx5CLGtvApXLWeUj3JhBAH5I6pceFuxGmJ04c=;
        b=C7H1GEO/fLNlOc0yN0sP1v3rU6t65UQNq3bLCtvq8U2ibTWxSI0kZlFWkKDrGy8RqnzLXz
        LJSjoZ+OpbWfnd6FbS09W8YjrEa5Aed1596Ixscdty/k2IeZUJK4qjC5kGyEQXuvQLSaoT
        3wjsJOOYKxnFhYSRLLxggJrSiAFr2dA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-FEI6dFUcNeCEZb5dDySklg-1; Tue, 08 Jun 2021 15:55:17 -0400
X-MC-Unique: FEI6dFUcNeCEZb5dDySklg-1
Received: by mail-oi1-f198.google.com with SMTP id l1-20020a5441010000b02901ecd2ee1861so8844610oic.13
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 12:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+ieZpNx5CLGtvApXLWeUj3JhBAH5I6pceFuxGmJ04c=;
        b=tVof5N/W2SqfhJ3fWGknB45AYoVXJ98oVl5NfBRz8XHcIsETz+CdZiOyvnhqUHkKeZ
         aZAhb/WfwZDD74g4DgP3iSHhc70oPrB1WGeccFiCimxeZzwkF7w3py7vLqlKAz5ghVwm
         /StmOPOXxOUpiYvw5bNsoRgwY4hNFsp57FiIU21c22CyvP8nImuexoOI4nif0ENTNS0U
         QkRB3kLTLaQzt4FGimzUwG06JrzbXDLhCiZCejD//cVfrJmzXtfGqwARcTQqJVYAsYhG
         GKVhv7WrektP0Rvto+NUrdMXRygT/TWw6LgKDJhyo369BPXKrZnl75CD6i1mOj+8YCEC
         xxEQ==
X-Gm-Message-State: AOAM5318vXmS0JRWjWzTx2/Fwz8xMBP4pWXY5kNOXbUb93kkWlhkHDFW
        mGaJNh4W+dpXTxfmyuV1o7JE03NfIpw1yq5wVrRjiFK4f7fYzTTKwyMnmzUSb4UFJjhPB/+0cVt
        zmWK/igy19HlYFkg6kcimfw==
X-Received: by 2002:a9d:6d01:: with SMTP id o1mr3273298otp.285.1623182116398;
        Tue, 08 Jun 2021 12:55:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzSar9h1GULVkRSGLcpyrS0rYxMTcGF2lkZPgA01LIMglsS8alL7LOIgUpvolCuPMbXVdeVw==
X-Received: by 2002:a9d:6d01:: with SMTP id o1mr3273286otp.285.1623182116240;
        Tue, 08 Jun 2021 12:55:16 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:15 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 3/7] fpga-mgr: wrap the write() op
Date:   Tue,  8 Jun 2021 12:55:02 -0700
Message-Id: <20210608195506.3022550-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager should not be required to provide a
write function. Move the op check to the wrapper.
Default to -EOPNOTSUP so its users will fail
gracefully.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index dadad24015020..c484b4309b2f4 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -167,6 +167,13 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
 	return 0;
 }
 
+static int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	if (mgr->mops && mgr->mops->write)
+		return  mgr->mops->write(mgr, buf, count);
+	return -EOPNOTSUPP;
+}
+
 /**
  * fpga_mgr_buf_load_sg - load fpga from image in buffer from a scatter list
  * @mgr:	fpga manager
@@ -203,7 +210,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = mgr->mops->write(mgr, miter.addr, miter.length);
+			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
 			if (ret)
 				break;
 		}
@@ -233,7 +240,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	ret = mgr->mops->write(mgr, buf, count);
+	ret = fpga_mgr_write(mgr, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
@@ -577,9 +584,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->state ||
-	    (!mops->write && !mops->write_sg) ||
-	    (mops->write && mops->write_sg)) {
+	if (!mops || !mops->state) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
-- 
2.26.3

