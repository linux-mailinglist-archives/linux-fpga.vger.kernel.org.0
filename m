Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D812B38E5
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgKOTvk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:40 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:39809 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgKOTvj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:39 -0500
Received: by mail-pg1-f176.google.com with SMTP id p68so337950pga.6;
        Sun, 15 Nov 2020 11:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kkAXw7Tt0cYJ71J1z6lzt/Cc75SkXOHsBVdYO06bFQ=;
        b=G5qFB+tgscIML+UFLviy89v+oyQqOsFfp0/er8iouEBguvJ2PxC76CpxSyGb6FAw5w
         x1qIsjI+8A+W1lxtzibm5uCF1kmpqzqYb7vgjcsBfv1U0NmjVEvS0R/pobgIRFOv12qf
         QBL08imvSjd1/rXbV94NGMCNZyAkfOUW+7T13c7oSgN3+PoEC+t+ok9RSCy4i2RCX6qn
         K4S9lb2AdZ6dIx0IM02xx18ROCFKEsKLo6kBcKVZcmln5/j6/UmoW2vAaM4lYBVhKRMO
         sdGZX/G2UjQkc86G9gv51denAwqstVF3tR/AJBKrzJLe5JaDW/I6P0V9FI3BoFKlI2Yx
         U02w==
X-Gm-Message-State: AOAM531Et/wyroYcMUt3gwAo8RSxkPTZbQW1hqrwuFQKKfHAzqDl8MyB
        YOXCT7Z5Ni7SnmZPYzUDjU0=
X-Google-Smtp-Source: ABdhPJwCT35QiWLZ8cF7fflkonArqZ3NG2yXCPxUoCQpagWVp0kBhzcGONF7SWfiv6cHMDqM5LbX1w==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr9961186pgb.165.1605469899212;
        Sun, 15 Nov 2020 11:51:39 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id v196sm16148139pfc.34.2020.11.15.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:38 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 07/10] fpga: fpga-mgr: ts73xx: Simplify registration
Date:   Sun, 15 Nov 2020 11:51:24 -0800
Message-Id: <20201115195127.284487-8-mdf@kernel.org>
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
 drivers/fpga/ts73xx-fpga.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 2888ff000e4d..101f016c6ed8 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -127,18 +127,7 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 	if (!mgr)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int ts73xx_fpga_remove(struct platform_device *pdev)
-{
-	struct fpga_manager *mgr = platform_get_drvdata(pdev);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(kdev, mgr);
 }
 
 static struct platform_driver ts73xx_fpga_driver = {
@@ -146,7 +135,6 @@ static struct platform_driver ts73xx_fpga_driver = {
 		.name	= "ts73xx-fpga-mgr",
 	},
 	.probe	= ts73xx_fpga_probe,
-	.remove	= ts73xx_fpga_remove,
 };
 module_platform_driver(ts73xx_fpga_driver);
 
-- 
2.29.2

