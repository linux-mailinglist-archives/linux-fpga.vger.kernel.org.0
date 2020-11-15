Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FFC2B38E7
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgKOTvg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:36 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:41409 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgKOTvf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:35 -0500
Received: by mail-pl1-f174.google.com with SMTP id 5so263066plj.8;
        Sun, 15 Nov 2020 11:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WDy5qn9Dd1AOqQC/fHx0aM5r8uAiocYkoWjGzpwBnU=;
        b=tQBUpmNqvMrTBVo6lk0TQe02/w0gD4gTgcz+mXTnxa01K49602ECVU919Vs0q6JwFK
         KJsZanBZBtgqvlkXc+zGQNJw9B0w2YVlkqbBN/4FnfkENwsqaf6OO2fV9UWjK95pVdHx
         uM9N+IzTeuZrgP9cN2Cg118qXefThOOSf8pT4og42rVsHc0hfqUdGzFqKRWkOs9Qj3oU
         1lCas+D+nJjr3DOLcLEuqxtfB+BB9cQ0ZL5PGUUUmyppt9aORIBt2duGPO/Dfq6CqF8c
         I8lHIeLhgykJ+DSv9l1xtuINBMargppJqsBDZNbcqbnQYw1h+lGelf37OyZ7YJZo3N5z
         S9iA==
X-Gm-Message-State: AOAM532jxIObEL0CjW2lXFCozT5Fl9+nlnk9dAVEqsxZswsZycgDYCr7
        1WKX3M9k3DpuQqI8KaRLHvk=
X-Google-Smtp-Source: ABdhPJzUG79CU/5ncdOviY0t2iNblNcM60ZxI8b0FHt4iDbjvUt24w2inQziUUWNWuNWQGQFexFWkg==
X-Received: by 2002:a17:902:8f88:b029:d6:d62c:e437 with SMTP id z8-20020a1709028f88b02900d6d62ce437mr10148743plo.73.1605469895187;
        Sun, 15 Nov 2020 11:51:35 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id q15sm14245092pgk.93.2020.11.15.11.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:34 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 04/10] fpga: fpga-mgr: ice40-spi: Simplify registration
Date:   Sun, 15 Nov 2020 11:51:21 -0800
Message-Id: <20201115195127.284487-5-mdf@kernel.org>
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
2.29.2

