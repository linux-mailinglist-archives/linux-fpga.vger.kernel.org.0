Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D005128290B
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 07:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgJDFOz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 01:14:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgJDFOx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id g9so3102755pgh.8;
        Sat, 03 Oct 2020 22:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9sNHTAf1q0OCWdfYetz8n+dad/hcYWb7WiyvqFz4z8=;
        b=ewqIkGEHgsoaibH0dhw6urDmrO4ue463MJjiF2liOidkErE6wFF7VZJFir9Ou+5w+Q
         GwI/300Svz25Y3CG/9s4V5IhtAJ2lObvBVKd8RiT5s9ggXnNs4XRJQ91PjoCwZlp9xvk
         lV8X90cTf0xyAsgWmCVry2MLFHhviVzWgEdx02C5D3MJupD+lvTDkEeIG2pKRxd7a61Y
         2QVp2fRBycrgcXzeENrwJpsqZCuf5wWwUnRJwImzOcVunU0UIib5StgHk6XWg77kWkWv
         Xx5/+nr9vOwGXosLxL9uTDlbwRtY9FBuQg9qlOWKksV4gZucTrXR3e1FFDAPrZKtA2i3
         UEAg==
X-Gm-Message-State: AOAM532bUYrTW4bqq82rIB5/peMDKzLpLYxzYhi4QmW219zfY0ie9mZ9
        sLMY+B3Laobo7ronaknkjwsBRJt2gEg=
X-Google-Smtp-Source: ABdhPJxdCnzWHV+RefxbAoMh95yMnrJqDl2iYdqjGpXGo5cYkqv+xJUq4Y6Ol3KlPXz1LZG6F2FSKw==
X-Received: by 2002:a63:5006:: with SMTP id e6mr8795282pgb.338.1601788492032;
        Sat, 03 Oct 2020 22:14:52 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id r14sm6588558pgm.7.2020.10.03.22.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:51 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 04/10] fpga: fpga-mgr: ice40-spi: Simplify registration
Date:   Sat,  3 Oct 2020 22:14:17 -0700
Message-Id: <20201004051423.75879-5-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004051423.75879-1-mdf@kernel.org>
References: <20201004051423.75879-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/ice40-spi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 8d689fea0dab..69dec5af23c3 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -183,18 +183,7 @@ static int ice40_fpga_probe(struct spi_device *spi)
 	if (!mgr)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int ice40_fpga_remove(struct spi_device *spi)
-{
-	struct fpga_manager *mgr = spi_get_drvdata(spi);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 static const struct of_device_id ice40_fpga_of_match[] = {
@@ -205,7 +194,6 @@ MODULE_DEVICE_TABLE(of, ice40_fpga_of_match);
 
 static struct spi_driver ice40_fpga_driver = {
 	.probe = ice40_fpga_probe,
-	.remove = ice40_fpga_remove,
 	.driver = {
 		.name = "ice40spi",
 		.of_match_table = of_match_ptr(ice40_fpga_of_match),
-- 
2.28.0

