Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC12A3D5C
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgKCHOZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:25 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:38964 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHOZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:25 -0500
Received: by mail-pf1-f170.google.com with SMTP id z3so7017641pfz.6
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gv5YgYJ8YTJ3R7OvjrDzA+z8efZW97/lIglyWelRkeo=;
        b=RmxnltR7DkC722NpaLSpz4ZIH4aasHwsH2O+B83hyhuTLhfvUITfaC5lNJwpc15UHP
         sp9XC6GTRPmg5HELJjuCE+kTDiCkvtHYN4liXexCPEByITn/xlG6BgXZAPxnBTxT8exK
         2zHtIbtuG/wkk7326Yx+CjiK3Kr/K27VRURwiSxBGb8a+2cIBF7aWwEZReaURElXly1Y
         4AsuQQr+Wk4NJexoFMEAQC2tGDoWOaQk7zFtyNlbK+nTBWH/vz0IJtpOZIqApcGvqnmr
         6eLnk2j0mnMmT+JySSm3oGBXubS7UrI5ejL4zLaZzglMFqYVyQUofoM53/WoOKAHF7B1
         qKww==
X-Gm-Message-State: AOAM533knXjPfZNBfrXiuS16tZO1mCrkf6uD8ONzC/sCOKduPyt6tYFr
        5tz/Q8sj2Z2VM9uEL5VpLwQ=
X-Google-Smtp-Source: ABdhPJxHxx89qNZjf1QiaPvqa3M4V1iRJl/rNTvNUFX/xot0DMiq9GI30OrmDbVSUWA1TNSzJ6KXvA==
X-Received: by 2002:a17:90a:ab87:: with SMTP id n7mr2449893pjq.201.1604387664916;
        Mon, 02 Nov 2020 23:14:24 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id k8sm14224959pgi.39.2020.11.02.23.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:24 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 02/10] fpga: fpga-mgr: altera-ps-spi: Simplify registration
Date:   Mon,  2 Nov 2020 23:14:03 -0800
Message-Id: <20201103071411.11997-3-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103071411.11997-1-mdf@kernel.org>
References: <20201103071411.11997-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration by using new devm_fpga_mgr_register() API.

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/altera-ps-spi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 0221dee8dd4c..23bfd4d1ad0f 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -307,18 +307,7 @@ static int altera_ps_probe(struct spi_device *spi)
 	if (!mgr)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int altera_ps_remove(struct spi_device *spi)
-{
-	struct fpga_manager *mgr = spi_get_drvdata(spi);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(&spi->dev, mgr);
 }
 
 static const struct spi_device_id altera_ps_spi_ids[] = {
@@ -337,7 +326,6 @@ static struct spi_driver altera_ps_driver = {
 	},
 	.id_table = altera_ps_spi_ids,
 	.probe = altera_ps_probe,
-	.remove = altera_ps_remove,
 };
 
 module_spi_driver(altera_ps_driver)
-- 
2.29.2

