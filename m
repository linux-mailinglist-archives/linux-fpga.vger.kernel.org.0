Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF277282909
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 07:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJDFPS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 01:15:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40890 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgJDFOz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id q18so3611789pgk.7;
        Sat, 03 Oct 2020 22:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHhb/VGZB3JzU7sTnLssu5Jr3MlGXPj+7Lz+7APODO4=;
        b=meaQnoxrohptcmHNyUC8uTsOZmmx0jHlD2E7BEQMOc31qJmv/v9g9pJeYxwUzBv2xa
         lcfboU6Qpw6x9n85MWpzdIF5lE+8McaRJwH/uVSP4IgMeVMM2Z37hbZ26nseX46o4vSE
         4Qsd+i0f64+BVZPfblCxRf/RxsoMMbuf3H7TblM8ZTr9twBdB8XAhs4yfcR7HVcMpPab
         GOefpgEV4o0JHhjrfxX+6VmSLSFsiBs4ipWqyc4nfTISdzkWRrkaYQn1NtKV9QHzKTlk
         v/ct4jUti+nVtF68/kVkOzC6w619K8cHPEX2V+rRNsajs5jdin0e9iMw+IM5YjysHfQG
         vqAw==
X-Gm-Message-State: AOAM532AuTOUWE9gjAxDcaIZRybfe8HgDZfuv+AhlYjoUTHD+Q0piHWM
        +iqW6phmIEhavESvoYPD3PLolkCTwuw=
X-Google-Smtp-Source: ABdhPJypO3sAzA2yTYLx70pX8unTTAwZWlujyB1hECE+9ksvS4oO4ztuZCuq9g4bz+o+Q+Ekpx0doQ==
X-Received: by 2002:a62:2b8d:0:b029:151:d7b8:ad58 with SMTP id r135-20020a622b8d0000b0290151d7b8ad58mr10508110pfr.51.1601788494519;
        Sat, 03 Oct 2020 22:14:54 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id b16sm6189565pgj.77.2020.10.03.22.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:54 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 06/10] fpga: fpga-mgr: socfpga: Simplify registration
Date:   Sat,  3 Oct 2020 22:14:19 -0700
Message-Id: <20201004051423.75879-7-mdf@kernel.org>
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
2.28.0

