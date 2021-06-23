Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84EA3B2037
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFWS07 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 14:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhFWS0v (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEQMbiKZrppCytQ0u2udkzjR7r7bZTZL+PVWVEdpAcU=;
        b=I9pnL2hTjT33xvtEC/Hf39uzCNJvbEnYww4XyZE6liCRQ+95Jg86K2npyvSvA/G5O2eCjx
        ph9BLE4r5Lfl+GpTIEkknCIjF0N3glgNOXpdGt4leL2o+ra8vlHEJa6KcJyRDOTuMMQpDO
        sSWbE6aRf/PG385IRfSlOwluJRkweZc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-TA0VtefJNtW_Gif_1pFBWQ-1; Wed, 23 Jun 2021 14:24:31 -0400
X-MC-Unique: TA0VtefJNtW_Gif_1pFBWQ-1
Received: by mail-oi1-f197.google.com with SMTP id j20-20020aca17140000b02901f3ef48ce7dso2226080oii.12
        for <linux-fpga@vger.kernel.org>; Wed, 23 Jun 2021 11:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEQMbiKZrppCytQ0u2udkzjR7r7bZTZL+PVWVEdpAcU=;
        b=TExaVgJDTehNHza7+AJNBpZKibRrEyVJVtXkWNZmsk7fyISDmsN79/nVEiQIDYe55U
         HA6bcM+GV0/jzi/7mfGarE9mLWTZ3PswcT8AFjHzUYuuU6tJ6C124pQWriDtiGfj1VJ/
         WmPfnZnfrDYb2qahhocCBqHMKPokCxGdWefyGEvswLoeklUsTkg9iE6xfzu07H3LJIqm
         Bwl0G8YE//Ff/y+2ePYoeDmlEUhKphdQ35M936rdH3JMAWKruKQbzSqBGwt0AvGkLjTd
         OCjLPwAdegRWx+0lF+MXHAT6t2fq0y7Y04RNfxZciT+m3s91D2SUg2GNygn6UblzMo8w
         9dIw==
X-Gm-Message-State: AOAM533kT0RtfUuckSh3AOaQTOtdbqtFb44uSwC5iKa3s4F7dNppI7vC
        ozDPYfKqLGuQ9O6Gw0uSBgSPunAkWXPjKxcxGc/1tYSvaIwAEWV+KcfjFz9Yf5AJNq9vuqTQFHs
        /unpkJyITZ3Hzr40Bx9y7IA==
X-Received: by 2002:a05:6830:18c3:: with SMTP id v3mr1088681ote.41.1624472671164;
        Wed, 23 Jun 2021 11:24:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzofWL0s+9K9OfNcc82SlTa5xfyHlsy/iefBW//+vvA1JA43DNnvVFDylzr6dXYxVOuD53ow==
X-Received: by 2002:a05:6830:18c3:: with SMTP id v3mr1088673ote.41.1624472671014;
        Wed, 23 Jun 2021 11:24:31 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:30 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 3/7] fpga-mgr: wrap the write() op
Date:   Wed, 23 Jun 2021 11:24:06 -0700
Message-Id: <20210623182410.3787784-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
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
index 1c2cce1320367..8f97e16e36f7e 100644
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
@@ -577,9 +584,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
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

