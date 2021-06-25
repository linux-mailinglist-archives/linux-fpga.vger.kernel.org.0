Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10EA3B4963
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhFYTyi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 15:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229934AbhFYTye (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmCqJFhviJpySBAFzJy5r5IMKlvduxQc5V68S9Vd+94=;
        b=NSgRG3A5OUP4eJmALrEns2w/TMVNvOlEJoWjjEBoN+nthgPV3IOCSWx1jIfxchVbLrHlES
        0nSWDzR0VcOQ72xqyii8nkOGsE1U0MbJ19HKY90JKhsVGPnrhf2LhHr6NaC8rajI7eHg8e
        efLU7kkRPZ92Gr4fouab1brfur5hw14=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-szrmtHItO-CuDHcBdk0BOA-1; Fri, 25 Jun 2021 15:52:11 -0400
X-MC-Unique: szrmtHItO-CuDHcBdk0BOA-1
Received: by mail-oo1-f72.google.com with SMTP id z1-20020a4ab8810000b029024abe096a35so6422820ooo.12
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmCqJFhviJpySBAFzJy5r5IMKlvduxQc5V68S9Vd+94=;
        b=GPx5Ejck0/3h6HeOWLwo9E2VQoO7kMsyZqllceB+BjElGAmsXkY1rrSpk9ZQwgKn93
         q73NGlASLVwAcPhlhdXkU9ZrUkfh81pH97RSWJbGlQcCGf7rnpzlfsqr4doqMK+zjbk2
         jQj2tTHJhv/rXav10Tl83ycNSLerTpAMsNw8tUlhgDvd4VAgPflziiVU1NzbVf1eTiZY
         +m5ErVm5VIAsEKRi7lD9yHc8JEu3S+85zMMSxSUzvNcnVvvaRHa6jS2MiCbms0DSBaYj
         90QslAJuOhWIx/d44ER9ZV7bUrpkca00WStBZ94BgDymPNrOrS+kaXwzzTkAsKKhyaAX
         U8lQ==
X-Gm-Message-State: AOAM531WkgPopuzxEX3ScQ9nPkFgUkMFpQsfJGGlE9oMcYdyqyrVgJsr
        TbsOEkOWDAVBpxE0Zo+8Lkd5EtxGa6FnVz3LAh/koQ6ieU7dwoADRqBEjbpVYfuFTa32a4asShD
        nEm2F9nWAFPIHB6IsIhvzaw==
X-Received: by 2002:a9d:6f10:: with SMTP id n16mr11442605otq.165.1624650730698;
        Fri, 25 Jun 2021 12:52:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyrgSs3HSrKX/eB4qtz68tFE9zA+wja/zPnCCLulswoCm4r95WfyEGRwhxQDpXEZZe+Gx01A==
X-Received: by 2002:a9d:6f10:: with SMTP id n16mr11442598otq.165.1624650730534;
        Fri, 25 Jun 2021 12:52:10 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:10 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 3/7] fpga-mgr: wrap the write() op
Date:   Fri, 25 Jun 2021 12:51:44 -0700
Message-Id: <20210625195148.837230-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195148.837230-1-trix@redhat.com>
References: <20210625195148.837230-1-trix@redhat.com>
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
index 05a69ab3ecb9e..8d5536d748081 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,13 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	if (mgr->mops->write)
+		return  mgr->mops->write(mgr, buf, count);
+	return -EOPNOTSUPP;
+}
+
 /*
  * After all the FPGA image has been written, do the device specific steps to
  * finish and set the FPGA into operating mode.
@@ -204,7 +211,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = mgr->mops->write(mgr, miter.addr, miter.length);
+			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
 			if (ret)
 				break;
 		}
@@ -234,7 +241,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	ret = mgr->mops->write(mgr, buf, count);
+	ret = fpga_mgr_write(mgr, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
@@ -578,9 +585,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->state ||
-	    (!mops->write && !mops->write_sg) ||
-	    (mops->write && mops->write_sg)) {
+	if (!mops || !mops->state) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
-- 
2.26.3

