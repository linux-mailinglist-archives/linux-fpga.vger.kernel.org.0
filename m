Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7569D2828FA
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 07:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgJDFOv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 01:14:51 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37264 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJDFOu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:50 -0400
Received: by mail-pj1-f65.google.com with SMTP id kk9so3344193pjb.2;
        Sat, 03 Oct 2020 22:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2zKZStKzcWmg98lvUeSyfN/9/+uQar1D5BGHJR0sMs=;
        b=gjuzUyLwvSD3mI/tKm8fbjY0d1z3jrg28sseZYMHEOzkCnk13Iy4wY17ctE5MeDlZy
         KjEKbtG5exD+J9084vzcRzDoe8d0Cez68UWvJCIctmY4Z7zJz6BpCs1k2LVeHrNEMDLS
         /mJ1hY53qT+5xbeXLJvaOVpFUfLmJiX9HzpYko5tWwKiQko+MLnn9h8/Cw5Mr+1Lpbti
         b0xpUR4KdBDR+haxKa9dB35XR9DO7vXkCKFXh9zZTts1MNX7epjOAtQ95LcigTte7pIG
         tt4yghl6/7VSIdIlzad6EY4m4Vi9cUO3xqgMqq760KOKuEsaxTlixCIHFhlkJvOtNqic
         E/dQ==
X-Gm-Message-State: AOAM531Jx30NRKYj3zlGflx41eMuhdLSY4MTsKSfmSwZWEZdudk9iNr4
        YLuhpjArBJYrH3FyLzq5zwh9kGGmL8w=
X-Google-Smtp-Source: ABdhPJxRYQRBkbg0GgZNWMM1nKDMiId/ovDb91fIRnSMkHNx4u7R6Ja/V7HikZ8TKKvNf6zwxSf1Eg==
X-Received: by 2002:a17:90a:e545:: with SMTP id ei5mr10050838pjb.45.1601788489550;
        Sat, 03 Oct 2020 22:14:49 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id i17sm7445294pfa.29.2020.10.03.22.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:49 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 02/10] fpga: fpga-mgr: altera-ps-spi: Simplify registration
Date:   Sat,  3 Oct 2020 22:14:15 -0700
Message-Id: <20201004051423.75879-3-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004051423.75879-1-mdf@kernel.org>
References: <20201004051423.75879-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration by using new devm_fpga_mgr_register() API.

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
2.28.0

