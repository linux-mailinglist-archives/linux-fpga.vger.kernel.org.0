Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98609283D7F
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgJERhy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:37:54 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41026 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgJERhs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:48 -0400
Received: by mail-pf1-f173.google.com with SMTP id g10so4157434pfc.8;
        Mon, 05 Oct 2020 10:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThjGMNgrLrI2Onk47mH0ZJ6H9pM2blvwAMK0KJCWHWs=;
        b=AGyp/1tfM9s/Kfp85D2r9QJvh9PQJC3Sf5wVaSYu1lFDJnQ7D6mQokZ0N28Roqr8fy
         WwwGNt/QAXXpeifFlsjP2TKIGt2qptD3qFXfLDp1nCZH21ZxPVVoXuNU815tbKpTPllZ
         U7heK05k6kWKmpKsrDnaPbDGXeQZGKI6o3I0gLVXGAcHY2d4x6cukQM7q64yaRYSQclY
         c46VdHHQf1AHWLlwZnpzt90Emtm0ySWly8fSm/QsSuqvSppSgMP60IvgcRIbxjcmi60s
         gbsIan42DqGBAjJMt0u3UPLxqZLFCLB3DRUIeBddSdvIQ1LGRGuFEE9g6sbfs7b81BCd
         3ORQ==
X-Gm-Message-State: AOAM531u8GdArFt9wS1cOmleCP5myaogwF1MEFHAXXsL/393SawXtBct
        HJfYTAXpCf8iR7wYR+8+vOTZso9Vh+c=
X-Google-Smtp-Source: ABdhPJxEdp5j5KzsM62NicgFATzxlcJoG8NRfOiT4HPR0BHeK2mXx3G8hMQ0HgCYon8j3czzKKqecA==
X-Received: by 2002:a62:e308:0:b029:152:8cc3:ebdc with SMTP id g8-20020a62e3080000b02901528cc3ebdcmr663995pfh.42.1601919467294;
        Mon, 05 Oct 2020 10:37:47 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a185sm232173pgc.46.2020.10.05.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:46 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 03/10] fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
Date:   Mon,  5 Oct 2020 10:37:28 -0700
Message-Id: <20201005173735.162408-4-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005173735.162408-1-mdf@kernel.org>
References: <20201005173735.162408-1-mdf@kernel.org>
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
2.28.0

