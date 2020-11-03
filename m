Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C062A3D61
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgKCHOc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:32 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:36110 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgKCHOc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:32 -0500
Received: by mail-pg1-f179.google.com with SMTP id z24so12987331pgk.3
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kkAXw7Tt0cYJ71J1z6lzt/Cc75SkXOHsBVdYO06bFQ=;
        b=eTvNnj3lUvoojT8SJ2dr1uikTM5VnAEXJAJZ1Cyj6veC+b1i2OzS8E8dLGmUHLIZoE
         hh/yd6htr3RTozGIRMBNpl9r0C1J9Bm2eRyUETGupsSg7yh2vCDbyOkWZOLtQwY7qISO
         +myFS+OzdfPHp8ZKp4URg0xVWgCDIQjrJoKtzNGkmKIXBvpueZ4e3UYhZdeshFAF+Wl0
         onsBHrlrkbMIaEJJssVx67N5aJc1nmhESsDpBxnjbTNTX2DcTtqSgNY/YBTrrvpCXVn8
         ytfz0C4C31X4ikKyi0+W5cQAS8PjUbS9ahsEXInL+Jb0sAyuwLCbQfhXRP/5J2aeS6sx
         YNxQ==
X-Gm-Message-State: AOAM533kYIc3kS0mxHZjey7TekXRVowsH8lqFnwajKaajOR4+ssbGdEu
        tRsKUV7UGfQ953JxD92TKbI=
X-Google-Smtp-Source: ABdhPJz2FfIJOaCkrBqXjMg6fUEne1HyamOPAy0CdZ6TcxWCzw+9DTXp5GqdM6FwROB60fI+bMKotQ==
X-Received: by 2002:aa7:85c3:0:b029:156:78e8:1455 with SMTP id z3-20020aa785c30000b029015678e81455mr24592291pfn.68.1604387671880;
        Mon, 02 Nov 2020 23:14:31 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id f17sm16018030pfq.141.2020.11.02.23.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:31 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 07/10] fpga: fpga-mgr: ts73xx: Simplify registration
Date:   Mon,  2 Nov 2020 23:14:08 -0800
Message-Id: <20201103071411.11997-8-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103071411.11997-1-mdf@kernel.org>
References: <20201103071411.11997-1-mdf@kernel.org>
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

