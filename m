Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002C12B38E1
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgKOTvn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:43 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:43975 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgKOTvm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:42 -0500
Received: by mail-pg1-f180.google.com with SMTP id 34so7529036pgp.10;
        Sun, 15 Nov 2020 11:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxJeDzUo1JlM94sM/0JUoVzyH5QVj44C4f1rGzo7Qbs=;
        b=tpP/Amn4q+qgJVxw+ddxuWUoS1KDSPYAhVJdZ2EawgMtdBVUwmqzJw2GTwiFTG8vNk
         3xxxqjw55RGV/NuDpcI3H5JQohOuTwhhiilb5u1PnL1TDeXKnDEUcnv9g0oSOHu+h47k
         88PZK0tz0NhLaDKL19Fqfmsx9QHTNTwF9/CPGahFXXglwv+lTCnEYXNEBeqNp7NaMcrw
         DsixbldbkwIq27JlejigoMQhUMmHDjOspOpV5xCyxXwRII+agYP9S3flr9mbKH7PRtbU
         MaHAy7M1CPI1L7yFuVOo8YbXToL+JuTaaUn/9XpTL/YBICqJxmveWlVJQ2eKvvAoxMxX
         FDuA==
X-Gm-Message-State: AOAM530VEuICzn/d1n98KiSVrmV1MahkEB2Saa2WQ3SxjzZxu7VE/X53
        TqDbP8OUR6AxxuXw5fJOtHI=
X-Google-Smtp-Source: ABdhPJzC7Q+r7/Q/RVac6Zis7cdiy1ml9VaZ8M/jmxT6S/3NPbqJK9isug383iQdZM8ThKzfYIuguA==
X-Received: by 2002:a17:90a:1705:: with SMTP id z5mr5006456pjd.129.1605469901800;
        Sun, 15 Nov 2020 11:51:41 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 64sm5530825pfe.0.2020.11.15.11.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:41 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 09/10] fpga: fpga-mgr: zynqmp: Simplify registration
Date:   Sun, 15 Nov 2020 11:51:26 -0800
Message-Id: <20201115195127.284487-10-mdf@kernel.org>
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

