Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA982A3D5D
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgKCHOa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:30 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:36111 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHO0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:26 -0500
Received: by mail-pl1-f176.google.com with SMTP id r10so8154948plx.3
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBwW1+6BENeZRQOZlmvQP7cIaRFiF4Q75GwsKxUaHjk=;
        b=b+VSpVyRaCraKrDTSjyUIU+U4TCqoslbtZDCtnL+gTyPMP+sAazwGimjZFjqyPc0+S
         wOxF3bSDQKSpV0hsFi45yHHbTRzfSun1ElFOAFE1D7P4AE/Bqw5C797wrl5pr7nkELYe
         /zeIMWam2t6+FVke3LIv9Y+3rMZUrslTt0kFt7q99795XaAV9Dr3DVn99CYPf4URPpy6
         XDjEOq1yesdPJ2YrADPaWJGzbAPlX/G5VRTHs30Ykv7IdMLd1lSic3tqMoTZgGDOsNLq
         sv2zDro/iy0ivs92coRZxAjaRDRVav9Ki6FKL4BWy2X8nfH0gOP/LDGcSXig4uFTuG9r
         efvg==
X-Gm-Message-State: AOAM530oygepmHRiL7NAoNrGGDxh9uWU6rlKh4bHSC/ec8pipbbYdPFk
        qYA9zHlu5g+tmDr8bpTAejFnTcEWDk8=
X-Google-Smtp-Source: ABdhPJw0guC6DdN3oYKa4xtVtz/K44ryL7c6rzsCa2M3Zkh6Hc7+7sN91S1d2Fb/0Yy65AuZ1gYVxQ==
X-Received: by 2002:a17:902:8698:b029:d3:b362:7342 with SMTP id g24-20020a1709028698b02900d3b3627342mr24267624plo.50.1604387666257;
        Mon, 02 Nov 2020 23:14:26 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id w19sm11916126pff.76.2020.11.02.23.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:25 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 03/10] fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
Date:   Mon,  2 Nov 2020 23:14:04 -0800
Message-Id: <20201103071411.11997-4-mdf@kernel.org>
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

