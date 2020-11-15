Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F082B38D6
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgKOTvd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:33 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45822 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgKOTvd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:33 -0500
Received: by mail-pg1-f171.google.com with SMTP id 62so10779645pgg.12;
        Sun, 15 Nov 2020 11:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gv5YgYJ8YTJ3R7OvjrDzA+z8efZW97/lIglyWelRkeo=;
        b=HXg6CP41VbdXOZikXsGo23uE2A6E4KS9bwxFQbH6gdoLMQ9EwnYJda8/zY3go9Ufbh
         H00y69pmkAvCfdLrgJKBIUTc5m2FcbPPJe9b16sdHCPc+n+EsaWCuHXxUd8LyOWRzdSo
         MkH75JJYm0MZi1Q+wBBENlGuzGKR8laIqSOTbdq5BDnWZUywr2r0YnMreyPM4U4AfWzq
         NeY47pZN7NadEKERsqmFEtzha/HV2GQGMoCdGLiZgupo/mCJqtriX9tmYTmbx9uK9FW3
         TWaKAOL8mkhvxNTK8SN7GIKQ77dryBa/r0Czg7m1tNHL91CW3oMYujIH0AXSERvTL8H2
         MITQ==
X-Gm-Message-State: AOAM531MJSAHLku5g6VvbgbrYWg3fUgq45VMdVShSNx+DtXqrXwnXJQS
        gOikpO6AzYh5b2oatOsAFKk=
X-Google-Smtp-Source: ABdhPJzreaOwndoKWDr4DBWNwpE0W5ACzhsDXSUcuY6Uv/sRsH3srffclGtCywFsSBPBJOlfFxOxjg==
X-Received: by 2002:a62:3850:0:b029:18b:70ea:1537 with SMTP id f77-20020a6238500000b029018b70ea1537mr11149281pfa.68.1605469892467;
        Sun, 15 Nov 2020 11:51:32 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id t12sm16213341pfq.79.2020.11.15.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:31 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 02/10] fpga: fpga-mgr: altera-ps-spi: Simplify registration
Date:   Sun, 15 Nov 2020 11:51:19 -0800
Message-Id: <20201115195127.284487-3-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115195127.284487-1-mdf@kernel.org>
References: <20201115195127.284487-1-mdf@kernel.org>
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

