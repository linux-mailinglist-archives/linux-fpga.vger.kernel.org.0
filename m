Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CABB2B38DC
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgKOTvg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:36 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:40871 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgKOTvf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:35 -0500
Received: by mail-pg1-f172.google.com with SMTP id h16so6726749pgb.7;
        Sun, 15 Nov 2020 11:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBwW1+6BENeZRQOZlmvQP7cIaRFiF4Q75GwsKxUaHjk=;
        b=F4gTXPCEOo3a10GTNBKar9+TUIwuWJNymQ+WZHo4PRRs/fCQlRXOa1W99aJ3iETU2Z
         FSrQtREW7ibnrFPfwXC4iaJswEhnL7e6VA4elHUJe+TMp4mraGuV40504SeFMOibXCRd
         +k6nY70GL7to7CfSdcp12LH02a5TV56/Db1U5EJ1y9f/7uiDAmfgOgh3SqLE7v0LsSZj
         gJ46j2jjQ2ZAe2h+LAzG2xoBmfJRWNX+O10fCNtJ3+ho6dhNxs8DjCjGmxRcuvkOU0+7
         uy8k1Vdnp5odanmOOZSzXBOcLlqq0fxNX732m2WJuWr6pOj7i9iyb+IpQB9WeTc4xiQm
         42+A==
X-Gm-Message-State: AOAM532jnMVYbMVkeA23Wo+ndriCY/oEWcf07PuZbmT7txQL9rCaCwG/
        mvYFUZ3FkiMwv+bDdjnwYanYA+mReg8=
X-Google-Smtp-Source: ABdhPJxqle0zjwf6uUZaQK/1eAp+Yk2Z9AWoN5EnVknYvpDGFO7Uc9kpM3dleB7QpygDZSTKxoDKgQ==
X-Received: by 2002:a63:887:: with SMTP id 129mr10015088pgi.81.1605469893832;
        Sun, 15 Nov 2020 11:51:33 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o16sm14335839pgn.66.2020.11.15.11.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:33 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 03/10] fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
Date:   Sun, 15 Nov 2020 11:51:20 -0800
Message-Id: <20201115195127.284487-4-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115195127.284487-1-mdf@kernel.org>
References: <20201115195127.284487-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-mgr.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index b3f7eee3c93f..d5861d13b306 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -314,18 +314,8 @@ static int fme_mgr_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mgr->compat_id = compat_id;
-	platform_set_drvdata(pdev, mgr);
 
-	return fpga_mgr_register(mgr);
-}
-
-static int fme_mgr_remove(struct platform_device *pdev)
-{
-	struct fpga_manager *mgr = platform_get_drvdata(pdev);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 static struct platform_driver fme_mgr_driver = {
@@ -333,7 +323,6 @@ static struct platform_driver fme_mgr_driver = {
 		.name    = DFL_FPGA_FME_MGR,
 	},
 	.probe   = fme_mgr_probe,
-	.remove  = fme_mgr_remove,
 };
 
 module_platform_driver(fme_mgr_driver);
-- 
2.29.2

