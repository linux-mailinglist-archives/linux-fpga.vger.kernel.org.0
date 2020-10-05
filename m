Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4F283D80
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgJERh4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:37:56 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:34718 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgJERhz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:55 -0400
Received: by mail-pg1-f181.google.com with SMTP id u24so6457097pgi.1;
        Mon, 05 Oct 2020 10:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5exJHrExp6hH+fiLalmCGHAHxK2W/BK4vVbjWgODn4=;
        b=CAd7ejEaBXrxMRMsnW2WhJG0sd25eaKkG+RMlZJ7dL3Ww+I5yibSz5T/QRGgcJxqtG
         JYTq8BV8cwqbFeLaROVHZ0qFQXBqbEkOqSBbb/v+5s/XhTyMHUmo4vKVrTLVtXKyAF3W
         U/eINnIPYCLYn6vTPDEULPRTj7qpXXTml0v1ST6gXDi9vhIVZfQJjuOTk9KTZaKn9eTP
         DJ7ZmuiFegNf2/o1/ol/8FE7ZKau4TS2j2j+G9Y8vZcfwrMwpWijQYADPAIc33QxvfUt
         TuTgNiPWz0cs1PeppVibv0LxpToCz7+Xst8lhmZ83AG+f7h+QjJzlk1SQUSoo0fPN+Pe
         XndA==
X-Gm-Message-State: AOAM532+5A5RsLmEdEYhXEstxx9eZwRzSzr6JMYVm1BLJTPxuucf8UzK
        +WrbdRk35ZlvaUvtdkxAcaYXrSaNkxY=
X-Google-Smtp-Source: ABdhPJx+vPTMXgGqXUfLGXSmTwUGiHqJ1pGXF30jVnvKd2Kzjtnaau7tvdWmbper+dTMFbKEvw9Duw==
X-Received: by 2002:a62:54c4:0:b029:142:2501:34d3 with SMTP id i187-20020a6254c40000b0290142250134d3mr871545pfb.44.1601919473565;
        Mon, 05 Oct 2020 10:37:53 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id f17sm533028pfq.141.2020.10.05.10.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:53 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 08/10] fpga: fpga-mgr: xilinx-spi: Simplify registration
Date:   Mon,  5 Oct 2020 10:37:33 -0700
Message-Id: <20201005173735.162408-9-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005173735.162408-1-mdf@kernel.org>
References: <20201005173735.162408-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/xilinx-spi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 824abbbd631e..27defa98092d 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -259,18 +259,7 @@ static int xilinx_spi_probe(struct spi_device *spi)
 	if (!mgr)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int xilinx_spi_remove(struct spi_device *spi)
-{
-	struct fpga_manager *mgr = spi_get_drvdata(spi);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(&spi->dev, mgr);
 }
 
 static const struct of_device_id xlnx_spi_of_match[] = {
@@ -285,7 +274,6 @@ static struct spi_driver xilinx_slave_spi_driver = {
 		.of_match_table = of_match_ptr(xlnx_spi_of_match),
 	},
 	.probe = xilinx_spi_probe,
-	.remove = xilinx_spi_remove,
 };
 
 module_spi_driver(xilinx_slave_spi_driver)
-- 
2.28.0

