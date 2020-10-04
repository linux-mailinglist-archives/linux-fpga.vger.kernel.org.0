Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716492828FC
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgJDFOz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 01:14:55 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:43635 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJDFOy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:54 -0400
Received: by mail-pg1-f170.google.com with SMTP id t14so3607268pgl.10;
        Sat, 03 Oct 2020 22:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CY8rx+JPKKfkbPpYC3tH6s+YCb6Yq/lPkTs7PIs9fZ0=;
        b=lPl4/TRJIRh+3MpSzQz5buA4CFeYgkZm3M6hYwYG2Q7Wo8KJxpq1nTgisjfNFAh023
         nCLmw/PAZUViPnIAeuAmWItDjq4C+4ky+0qB5uEWIZmyJO+em/z194ENbLI230BDUuAB
         G3in4FeCAVOz/zGqQKZX9vpe7ofQRSuNOMnE2bNP6TyqO+HJ8rB+7u01BLXOCnlPHkZc
         F4Z+m44g0AgQCUyuHtCc+pQm/IWhB9NV4FFpJE3EW+0vYYdkBo+MyxZLUzCMpuJB758V
         Z8/t4ML88lhJ9noY5rptEo5C1oRZzIDvlrHbtwA0bbgVs6cX1XrdcyjYhnkFItSd7aSp
         c9yw==
X-Gm-Message-State: AOAM531/Kac+e37mk9xIfOd7mEd/qO5hbroscZ6U767m/a1qVFIYStup
        iCy+jydCYXF6evZ3A6anqxp8h2fMdVE=
X-Google-Smtp-Source: ABdhPJylfz6ldue6IS1BSmQ4jToXnd6z5f5GUuPiixCD0HN3WGR88U6ArNPlB8bpkX35XLSgpDCDIA==
X-Received: by 2002:a63:5d66:: with SMTP id o38mr8617139pgm.366.1601788493258;
        Sat, 03 Oct 2020 22:14:53 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id j25sm7459393pfn.212.2020.10.03.22.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:52 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 05/10] fpga: fpga-mgr: machxo2-spi: Simplify registration
Date:   Sat,  3 Oct 2020 22:14:18 -0700
Message-Id: <20201004051423.75879-6-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004051423.75879-1-mdf@kernel.org>
References: <20201004051423.75879-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

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
2.28.0

