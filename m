Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4538B2B38E6
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKOTvj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:39 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40558 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgKOTvi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:38 -0500
Received: by mail-pf1-f180.google.com with SMTP id w14so11365829pfd.7;
        Sun, 15 Nov 2020 11:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBr5nDKX9MwkDZ7ftTeRFUSoljDD0EUdqGjYF8U//7Q=;
        b=qvitEwfPN0aBQjHXJr8UGrfbr4JCzRI5OfYWWdeTqbgSD0iz/OcDpDHfBa7qvQYmP0
         TFDeV7BQ0W3QEEkhvsCsMQ4FgJBFInJG+ZRQlck9JQ6z/hHSgY6hVKe72cEGmX9ccZn3
         r9fnzqEi5p/1tnSzpIF3+GFKlohZGh+YHDcYgR0ZfqeZgRAOAWsq1JZi6x+RSsQgCWQB
         oitFcXIRe90td2X8Al26BRztbhKQwYhrtV3S9KSPylk8mXTJboM3lzAjQvDMGEau2fY3
         B8E4J0Nlv9GDGLvkTCoCTS7Zd3C+ijFVXAediNVWQMgZEeUBDeIZLJtbUwbG+pEI6evk
         zn/Q==
X-Gm-Message-State: AOAM5306pTzlZ8fgIkNY63zlq59j/90hyQFW0cONRwH7s7AS8eVMO/F0
        44YR8xl8ZarAHPeJEO25aes=
X-Google-Smtp-Source: ABdhPJz8HHmaGVJier6SJQHg4EBKzcJAB6+xSlrpxWJMz852ieiHm+RUdpgqh9/v4AlD+rZkvqpufQ==
X-Received: by 2002:aa7:91cf:0:b029:18a:9972:1aa9 with SMTP id z15-20020aa791cf0000b029018a99721aa9mr11151915pfa.46.1605469896597;
        Sun, 15 Nov 2020 11:51:36 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a18sm9182468pfa.151.2020.11.15.11.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:36 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 05/10] fpga: fpga-mgr: machxo2-spi: Simplify registration
Date:   Sun, 15 Nov 2020 11:51:22 -0800
Message-Id: <20201115195127.284487-6-mdf@kernel.org>
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
 drivers/fpga/machxo2-spi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index b316369156fe..114a64d2b7a4 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -371,18 +371,7 @@ static int machxo2_spi_probe(struct spi_device *spi)
 	if (!mgr)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int machxo2_spi_remove(struct spi_device *spi)
-{
-	struct fpga_manager *mgr = spi_get_drvdata(spi);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 static const struct of_device_id of_match[] = {
@@ -403,7 +392,6 @@ static struct spi_driver machxo2_spi_driver = {
 		.of_match_table = of_match_ptr(of_match),
 	},
 	.probe = machxo2_spi_probe,
-	.remove = machxo2_spi_remove,
 	.id_table = lattice_ids,
 };
 
-- 
2.29.2

