Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C514282905
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 07:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgJDFOz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 01:14:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35392 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgJDFOv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id k8so4330774pfk.2;
        Sat, 03 Oct 2020 22:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSj7Q4DJpFXdzJS4vXtNFyUBZMMtSs/e2uyvh4UrDmQ=;
        b=d39SzYM9WPmFOxpI4dDNg04wfqjYOZfPuqAHm7HfRCD86WiBloduBlPCeAs8r4HQKc
         R8o4NYzQF6tW1VmIP+Bu5cIMRzxc88EcdYXWtOtfO0jSw+CFAEBB7fNMirzpF7FwadZA
         KuABYR38LmpdxRvtQCBsAcPtsyxpDQ/LwjMMzv0xqxBRd16guskiXCjYQyLzORcBo9bH
         UhtcqAyG5Jh2WzXPOT5QI6kKkboJNS6ko82T2Q+fS0KM6Gm1TZEvAWT4qeru9zmTOZz3
         +ZFPbLl8t1pUjGPy8segLS6Doo2ICzRIh7xNcpnyMBao1x9sWeehWTJkl7xpWde7pBJ3
         75Gg==
X-Gm-Message-State: AOAM532Et66OBdUjJ8UQ7U2H13SFaIz9oHH6vb/YGTqqJEKNh+vplxAA
        V7tbZyLXWQ7rgxnAeS+Jze0U4ha1+1g=
X-Google-Smtp-Source: ABdhPJybuo0dyW8OLj8mYrHhMS47SCaTGtBZJS+mWm/CWtLz6MfEeeQJWsN379s5pc735Hfm4Af9vA==
X-Received: by 2002:a65:4987:: with SMTP id r7mr8670662pgs.228.1601788490855;
        Sat, 03 Oct 2020 22:14:50 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u2sm6249750pji.50.2020.10.03.22.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:50 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 03/10] fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
Date:   Sat,  3 Oct 2020 22:14:16 -0700
Message-Id: <20201004051423.75879-4-mdf@kernel.org>
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
 drivers/fpga/dfl-fme-mgr.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index b3f7eee3c93f..3fc2be87d059 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -316,16 +316,7 @@ static int fme_mgr_probe(struct platform_device *pdev)
 	mgr->compat_id = compat_id;
 	platform_set_drvdata(pdev, mgr);
 
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
@@ -333,7 +324,6 @@ static struct platform_driver fme_mgr_driver = {
 		.name    = DFL_FPGA_FME_MGR,
 	},
 	.probe   = fme_mgr_probe,
-	.remove  = fme_mgr_remove,
 };
 
 module_platform_driver(fme_mgr_driver);
-- 
2.28.0

