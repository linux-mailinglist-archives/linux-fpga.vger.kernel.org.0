Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A84539E547
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Jun 2021 19:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFGR02 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Jun 2021 13:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230522AbhFGR0Z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Jun 2021 13:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623086673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEbyFeW80QMIpdYKjW+aZzDgMZUI77VaMOflkO8h6rs=;
        b=GW1lMzHPTGO39PfVkZcUm/e5iTDwAj5AuVcrDayyhICPYKMTE6hMtHYXg6nVuojOF0A3i9
        mtiOL5C4P5rInJTxsy/KJjgTYNQzkuRtkSUvLHSa2nldQzwf6vIP+JyfF/ZPL9NDrtVtiL
        vUDEmreSZPD4ndAn+Y2oxVNzQkcOXs8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-5qVw1Mn_O3SsO70dTuZ1pg-1; Mon, 07 Jun 2021 13:24:32 -0400
X-MC-Unique: 5qVw1Mn_O3SsO70dTuZ1pg-1
Received: by mail-oi1-f199.google.com with SMTP id l123-20020acad4810000b02901f1fb44dca7so4959676oig.15
        for <linux-fpga@vger.kernel.org>; Mon, 07 Jun 2021 10:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEbyFeW80QMIpdYKjW+aZzDgMZUI77VaMOflkO8h6rs=;
        b=rjsNW0B05AIZHNORJc0oSEcH4g1cpmqnjlKoHGIeyVDnBajUuZ2j58vlfI0+nCsZz8
         fXlOA2nt3fWD5gjzFtVn0i6QFFPEhPLWnX5+2unskrLVAYxWr6mmlXuGU7KkZ0MC+F1j
         fQ+nicag0mqBQf0M29RXUV9uslUSfvsl+SKBGJkBiMHsTUfrazEKObjFw0DIe+XAnrFb
         NKpeJefMWck+i+AuiPrBRuebnkDXIePt8ZbGdMcVjnnMy8wRm+/Q2ljb+fzXYmfo4gF+
         leZ253N1k0dVC+x98U8V9mEy+xJrfPFIbzk5r/jorA+h7LPXUikE6qKMnGIt8U/CyOf6
         DKZw==
X-Gm-Message-State: AOAM533zmQXwS3jyCmufXRMuNc4m1wo+qWqTJmr1hgVKpIog+ajLcqsx
        kghPihP/yLZ5jk1O6vrqU6Iepp6I9JfsC+j+YoYjCgRik4XvM7ivg16YPfKNOCwvePNM1S9mvaa
        h5FlZRI0kcSagx91AyS+rLw==
X-Received: by 2002:a4a:952b:: with SMTP id m40mr14054024ooi.69.1623086672036;
        Mon, 07 Jun 2021 10:24:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU4iBtCJ074OuzGQTVAEsS9VugipnW5FrZyj5UcXmgr+HN+HU4/UgZKKLwOvSNn74uqAKqVw==
X-Received: by 2002:a4a:952b:: with SMTP id m40mr14054006ooi.69.1623086671810;
        Mon, 07 Jun 2021 10:24:31 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm2409859oij.26.2021.06.07.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:24:31 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 3/7] fpga: wrap the write() op
Date:   Mon,  7 Jun 2021 10:23:58 -0700
Message-Id: <20210607172402.2938697-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210607172402.2938697-1-trix@redhat.com>
References: <20210607172402.2938697-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The board should not be required to provide a
write function. Move the op check to the wrapper.
Default to -EOPNOTSUP so its users will fail
gracefully.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index dadad2401502..c484b4309b2f 100644
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

