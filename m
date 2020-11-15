Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2982B38E2
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKOTvl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:41 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:36785 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgKOTvl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:41 -0500
Received: by mail-pf1-f173.google.com with SMTP id a18so11378730pfl.3;
        Sun, 15 Nov 2020 11:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/2eDS20UzGAqGhaYPkcdC2pYUk22axFOkNxIUP22Xw=;
        b=j4DfU2T9Ofna4UhVwYBE0FiyVvn6OmCW0z7hZ4Xs2Ad0jf7THrW7K3w+WGdG/qMCPN
         f2sXRp1IuzdR6usBQtSaW5offiUH9fR8uuZoj2do4s00vUSUWnTIW7IPJDyi6L7AnF6p
         s2ZH3TXuqvUPopYMPNp34qyt0SNDYhb5EK4dpArtTO3dE2NOC3lOoWr6vLMbMQSNNHcj
         0phnKb3kbah+JrC/lnYfLw+cyWM0sEVTzso5XBdYHU+lEXX8EjGS/A/pkotHVxcIlsW3
         Axw62cGsJ9CVGvTO1AQh27hy/LnUvFqgHkY6+MfcfOceBz+q3GRBS+7Sb3K/N3maDKWC
         t5MQ==
X-Gm-Message-State: AOAM533D6lnqV1o+UnqsaQckTVteIGHVzoooHpCp9RpPhsPYR7C1YEjo
        /WNQWuxw0GC//2/ny5NCiOpD4Gg9aUA=
X-Google-Smtp-Source: ABdhPJzjiI+oVHsUDWkWUoM7krc3mUOhSyRm2IdKh6sdo9UALFY69sK9PNWwAmcGDv5POWLWNFKspw==
X-Received: by 2002:a63:570e:: with SMTP id l14mr9720158pgb.302.1605469900508;
        Sun, 15 Nov 2020 11:51:40 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x18sm15415683pfi.206.2020.11.15.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:40 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 08/10] fpga: fpga-mgr: xilinx-spi: Simplify registration
Date:   Sun, 15 Nov 2020 11:51:25 -0800
Message-Id: <20201115195127.284487-9-mdf@kernel.org>
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
2.29.2

