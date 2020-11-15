Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96962B38D9
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgKOTvk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:40 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:41410 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgKOTvj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:39 -0500
Received: by mail-pf1-f181.google.com with SMTP id c20so11367263pfr.8;
        Sun, 15 Nov 2020 11:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IkrjI+jYJKCZGOoumt4rFok/JaaTpF6hO9yu3jQfDM=;
        b=JAAeviqGkrP+BlYPJsZ48lyrBsJMbQQRQ6HB1zE75assLsN+wBNisq+/Fq5xFx0krf
         9Y4xNHKXqHdRDWHR1HGGNxQu8FFRE9NWQFFSGwDLPyFY0oGntCL2BfqY9YaAJ/yHm5Sj
         X9deV7JIz5BU9KhlalZv/Cb2//0fI3r5C12DQ2rv8Ax5FKc+L3TkLFtOmFTTES1QOckr
         4Y0vqsvTS2zlp4DhlbWuqlgzhEQqFL8VKzMLIR7+JnU8JqSrw6DBw7iwfgC1CP3Da86I
         xcg4fbvgHkbr+AwBNvPc35su/2b/HrgPR8rb/GqSE12ISMESXYbpCrFL6AOkoH6XqnBL
         q4sQ==
X-Gm-Message-State: AOAM531Ot5RHBF7/cZi7I8XsALeqEsnrir4csUyVQFzsMwwc+cC9+/Cp
        XjxhxuA0/KOp2OXhS1o/N/YH0IbFi1U=
X-Google-Smtp-Source: ABdhPJxSMIYuFjiey1OxrsgqasSWiR7kWdX0rlWcsnHPkBI100KrXF8t52gbx1Y1FlV88lCKuO9Gqw==
X-Received: by 2002:a17:90b:316:: with SMTP id ay22mr12611069pjb.8.1605469897899;
        Sun, 15 Nov 2020 11:51:37 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id t32sm15225015pgl.0.2020.11.15.11.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:37 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 06/10] fpga: fpga-mgr: socfpga: Simplify registration
Date:   Sun, 15 Nov 2020 11:51:23 -0800
Message-Id: <20201115195127.284487-7-mdf@kernel.org>
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
 drivers/fpga/socfpga.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 4a8a2fcd4e6c..1f467173fc1f 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -576,18 +576,7 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	if (!mgr)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int socfpga_fpga_remove(struct platform_device *pdev)
-{
-	struct fpga_manager *mgr = platform_get_drvdata(pdev);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 #ifdef CONFIG_OF
@@ -601,7 +590,6 @@ MODULE_DEVICE_TABLE(of, socfpga_fpga_of_match);
 
 static struct platform_driver socfpga_fpga_driver = {
 	.probe = socfpga_fpga_probe,
-	.remove = socfpga_fpga_remove,
 	.driver = {
 		.name	= "socfpga_fpga_manager",
 		.of_match_table = of_match_ptr(socfpga_fpga_of_match),
-- 
2.29.2

