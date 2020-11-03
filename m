Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724882A3D60
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgKCHOb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:31 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:42229 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgKCHOa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:30 -0500
Received: by mail-pl1-f179.google.com with SMTP id t22so8135480plr.9
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IkrjI+jYJKCZGOoumt4rFok/JaaTpF6hO9yu3jQfDM=;
        b=SQeNiWasIalMypOVAgNa5g9gMIXDmdUyKiT3fMITm6pOK5my7h94O7umNgHaoNoOlS
         Ul9F5XYbXj1LuccEHE4j8j4zLZgFO36lrPUeLdDWfJ/1QbAdorGrOQ2pT1Vo3/nqw0K8
         2J6mgoW+90NJsC1wEnjal6jl75XCbI9DrtuZsC+eahQLLf3/KIa1AqzfWyQEVy5h4eLj
         RnLdaj5DKERt0xKgDYBixeOXv/InhtKBtY4wCivwUtjm9XwBGPExcuLFdnN71uxvZiNx
         uohrlyfvDyyOhUINcvt1LpBrfSQr42wFjl87jVsC8C9hSj7TamIjH3kYM8caI+IIt2Ek
         UMNQ==
X-Gm-Message-State: AOAM530Gei+AnT07zZbW0a+7XX7lk7/8t9im01tBbYF7keluBg7XvkKo
        2sDV5dv94AeCpg3hwf0+mN8=
X-Google-Smtp-Source: ABdhPJykxjPoU6L1KYLXVWZ28dIFxDV6RI1rd7OSpbTfYHcj68tGywvsSUaAqx69Vy2/1S0gC19k7w==
X-Received: by 2002:a17:902:aa8a:b029:d3:c9dd:77d1 with SMTP id d10-20020a170902aa8ab02900d3c9dd77d1mr24490295plr.0.1604387670447;
        Mon, 02 Nov 2020 23:14:30 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 126sm4318561pfw.10.2020.11.02.23.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:30 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 06/10] fpga: fpga-mgr: socfpga: Simplify registration
Date:   Mon,  2 Nov 2020 23:14:07 -0800
Message-Id: <20201103071411.11997-7-mdf@kernel.org>
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

