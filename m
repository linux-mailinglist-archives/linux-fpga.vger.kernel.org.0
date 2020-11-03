Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A332A3D5E
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgKCHOa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:30 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38978 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgKCHO2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:28 -0500
Received: by mail-pf1-f181.google.com with SMTP id z3so7017736pfz.6
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WDy5qn9Dd1AOqQC/fHx0aM5r8uAiocYkoWjGzpwBnU=;
        b=KsSUO8iZCduquENr5WKjLtsyi89cXx1YZQzHqcxKy4rUum1Hj5RL+jrhanjXR+h0qe
         hZGP4DS4cp8ikz4wpvvcVYI5nGhuRs+TPxld++udsVYvMA6mU0nIamnRBadctpXgXdRI
         Yz44FyZTN93TvXmPGlSeabAPVbM0JY9J8pQp2XtIIzlzUgiaGQvzQvTgNYyHjxpyHTHP
         dnpHe0sS9rmJ4dH+hMX0k8HyDqkTlRIx2kjIV8b9gOfFkCokOE62kb79t/iVKjVC4mE5
         lCdZrpFWSYvRg011q0IAPbvTxsD5izBoueHg78MQVN54iEuGt0Igjz1oEyHVHAm0Jeux
         lODQ==
X-Gm-Message-State: AOAM530PWe164jS2VI035D5Fhp2kns+VzNsoIytDx4Iv2+WCO+VIPY4U
        irXmvU7Nt03X0PA989dorrg=
X-Google-Smtp-Source: ABdhPJwm99N8HGhZDokL/tUHJm9Y21+kAzO42BCzBiOnWEe2KCW7MgfDt9TKtbsy8Q8nXNa9F6zKlw==
X-Received: by 2002:a17:90b:4749:: with SMTP id ka9mr2386054pjb.197.1604387667680;
        Mon, 02 Nov 2020 23:14:27 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id nv7sm1843604pjb.27.2020.11.02.23.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:27 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 04/10] fpga: fpga-mgr: ice40-spi: Simplify registration
Date:   Mon,  2 Nov 2020 23:14:05 -0800
Message-Id: <20201103071411.11997-5-mdf@kernel.org>
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

