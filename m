Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042702A3D5F
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgKCHOa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:30 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38973 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgKCHO3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:29 -0500
Received: by mail-pf1-f174.google.com with SMTP id z3so7017775pfz.6
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBr5nDKX9MwkDZ7ftTeRFUSoljDD0EUdqGjYF8U//7Q=;
        b=J3hxQX0bdMZ/vBQW9P8/bO5JgMXDJi5zVu0VVMeuZUBKF9i3Itfi8t+WfajY8ghEJ5
         YeqSZeFSHPz66Db5mB3UzV0Poxq67S5nfKN897FWFQUfMRL5y0SgS/7SIHem5qdbCM+/
         mcB6zqMgkOkAYw1O3oG1S4/7ByOsNfzwCIXo8LODS4aTBnx/2JPg7hJZzmpweA5U8GvI
         NBtaHwL+OI9GQnPa/AWKLEYl2GJ7Ya8NweSfSe8PdZcaTiKgovxgRKVW1XJCMJdIURHW
         fnle2r9Pf5PGIF4arqckQQrYI5sHCim3/Z4Ykp2pvDZEwIKOIDPSrRiku49auwOeJIVK
         VD8Q==
X-Gm-Message-State: AOAM530w7n6Ajq8hSG3rEdCfXTBPT/vrIxOaXb1veeVZI3evIMUDxR7E
        BB1JS+Ft6lyb3wzdlbcn8Mc=
X-Google-Smtp-Source: ABdhPJzHTwEIZTEMLLhykXqoVtSeCQFOsM9uyl0oTdY3nwWjUqwsWMTYLGnbG1DwX1uXBgotKUe3yA==
X-Received: by 2002:a17:90b:385:: with SMTP id ga5mr2413186pjb.13.1604387669050;
        Mon, 02 Nov 2020 23:14:29 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id v4sm14799001pfm.57.2020.11.02.23.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:28 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 05/10] fpga: fpga-mgr: machxo2-spi: Simplify registration
Date:   Mon,  2 Nov 2020 23:14:06 -0800
Message-Id: <20201103071411.11997-6-mdf@kernel.org>
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

