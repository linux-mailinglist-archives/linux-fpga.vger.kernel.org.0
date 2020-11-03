Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ECA2A3D63
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgKCHOf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:35 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:41880 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgKCHOf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:35 -0500
Received: by mail-pl1-f172.google.com with SMTP id w11so8138723pll.8
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxJeDzUo1JlM94sM/0JUoVzyH5QVj44C4f1rGzo7Qbs=;
        b=PwgkGPQJpVWJDFzv6bCLqKww5hkwgaezS7kdZHrvK4W7t9uUnfu1cM5LRddg576y1n
         CRfjFXj2dcE+iDD/K48cB0SRcgn+f7lPXjOw4FcFfq60TDth6Z4VeBRDujWW+zRLKhQ8
         J7STnLcrBk84Sudoa9ze591xhLaMe3kjEqncTWM+Zp5Amg7Wj0h1OS62soTvg61gyiLV
         LVZ3qspdDiQ4YVB7+4mlnYedyqGOGPJb5nL+e0iPKBooc5VEzfKLd4hUv8NDr2Iqq5Uv
         MBeYUSo19be/p1UtI1qGeREOjzsS6x3JBGNy1xo1DkaGDJ4FqhXkNeKc3kPUX+sZWdq5
         LrUg==
X-Gm-Message-State: AOAM530RPeUSDB34ps1gih/9b2BraCH3ErmotZna7UtAy3vpL/ScwfgU
        dFd5ymvC34ojSgApziIlafbTBjOF7Z4=
X-Google-Smtp-Source: ABdhPJxSvboeFN2NYiFP+B7/TwhlhxlkHzn7Tx+Zjer5UzyHMgBwIlAUx9kgDSN3QaxUs8bj2fTtWQ==
X-Received: by 2002:a17:902:7408:b029:d6:8208:bc7 with SMTP id g8-20020a1709027408b02900d682080bc7mr24187987pll.82.1604387674880;
        Mon, 02 Nov 2020 23:14:34 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id t15sm3470850pjq.3.2020.11.02.23.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:34 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 09/10] fpga: fpga-mgr: zynqmp: Simplify registration
Date:   Mon,  2 Nov 2020 23:14:10 -0800
Message-Id: <20201103071411.11997-10-mdf@kernel.org>
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
 drivers/fpga/zynqmp-fpga.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 4a1139e05280..125743c9797f 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -95,7 +95,6 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct zynqmp_fpga_priv *priv;
 	struct fpga_manager *mgr;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -108,24 +107,7 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 	if (!mgr)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, mgr);
-
-	ret = fpga_mgr_register(mgr);
-	if (ret) {
-		dev_err(dev, "unable to register FPGA manager");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int zynqmp_fpga_remove(struct platform_device *pdev)
-{
-	struct fpga_manager *mgr = platform_get_drvdata(pdev);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 static const struct of_device_id zynqmp_fpga_of_match[] = {
@@ -137,7 +119,6 @@ MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
 
 static struct platform_driver zynqmp_fpga_driver = {
 	.probe = zynqmp_fpga_probe,
-	.remove = zynqmp_fpga_remove,
 	.driver = {
 		.name = "zynqmp_fpga_manager",
 		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
-- 
2.29.2

