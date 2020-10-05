Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32D5283D99
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgJERic (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:38:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42221 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgJERhr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id m34so6439894pgl.9;
        Mon, 05 Oct 2020 10:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdqITJDQRbpmmuyzbiSajCMT3fTgONqCxlfl7IqR5tU=;
        b=ngfdJM0IEh4BrRmG7lH5W8DjBMMJq/L8H1NX3YiAAokj6Jh0GFyTuQ5HwclMbYBIrv
         wgQ+VqhtoGLUJRHt0ie3cM++3hE7PK9X5hAWGHbkyl8nL/Ed23tiJb7v1NvwAKkV1mIq
         ZIAvpL6iy2pUt6hD4FFYluVb/ZI17rQDCdwpV/TAh3ZaSvD7gM01/uLtnQw5w3oSGSHK
         Iejepz81C8NM+ZTSk3xo83gDk2Z+7YbJfG76t1IMe8/tzpNNsBhu6AvwzgJzEDe/a9vS
         CZyP+EZIoRACOuHCys3Rk+9TQw8WQtKVGUlE2P3UV2A9qgggkKgHe0vCZ7YOnL6WhTob
         dJcw==
X-Gm-Message-State: AOAM5320O/g9N1rmgTI+TfDEhA0sj3jZ2lvur5y6jdzLnq6rwe1Pt9ZV
        g28btRTRD3+smsRwnNIGDnSG2ArxCKQ=
X-Google-Smtp-Source: ABdhPJyEAGXc53tWtwzjvRMpUKdIkNcVVRhtV1iI9clNxea1rhdeEQ09BgMlQgzbOvT87bj9SQxytQ==
X-Received: by 2002:a63:3d8c:: with SMTP id k134mr592201pga.22.1601919466093;
        Mon, 05 Oct 2020 10:37:46 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id g9sm225231pgm.79.2020.10.05.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:45 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 02/10] fpga: fpga-mgr: altera-ps-spi: Simplify registration
Date:   Mon,  5 Oct 2020 10:37:27 -0700
Message-Id: <20201005173735.162408-3-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005173735.162408-1-mdf@kernel.org>
References: <20201005173735.162408-1-mdf@kernel.org>
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
2.28.0

