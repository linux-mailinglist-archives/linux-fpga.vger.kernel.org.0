Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B72A3D62
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgKCHOf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:35 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:33954 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgKCHOf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:35 -0500
Received: by mail-pl1-f180.google.com with SMTP id p4so819168plr.1
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/2eDS20UzGAqGhaYPkcdC2pYUk22axFOkNxIUP22Xw=;
        b=E2vsxC7gfE2S4KUwbagLwgpOfbovbTJBwxGziqsJe3IuE+rQ5GhHJFcOaI312OBzbl
         8v/USCm/q3qpB3y86t6ty5wpP534xx5CbWnfb54E4CgG1+MzOj1Bvpos/h0NEalvvqqa
         24wwLfyC9MF7FuaCRHrSYBJIcN7ew85Hr+RdKcqPmExnBpeDYrMJy4HZj4TID6POmUa0
         kmjW3+LtZHX9VtaMReRdBhP4a4D6Rwqz04oOQYxMKZHOBgRtQ0nre5nYFtM4XR+SJP/6
         ajqmd+5u2ZSlA9vHy+EdtA+VTfJB2XQN6aYeKti18IWW7DxaFSeGvGj3LEjQKhOLdYBx
         tS2Q==
X-Gm-Message-State: AOAM530/cO9Li2+lir8+uB0MZgV1Y/SXG9/UADKhVlWlGNzqP7Z62lTR
        JrnyBz4G13dWoKESw9kDXZs=
X-Google-Smtp-Source: ABdhPJy+u+HLt80DhRGhv3Ri+/OZgoItuF38vTSHCLAzybcVHis4TqP7gLaN9LtATCGiCkkGzq3Chg==
X-Received: by 2002:a17:902:e788:b029:d6:dc69:80a8 with SMTP id cp8-20020a170902e788b02900d6dc6980a8mr4169620plb.59.1604387673305;
        Mon, 02 Nov 2020 23:14:33 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id g1sm1289387pjl.33.2020.11.02.23.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:32 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 08/10] fpga: fpga-mgr: xilinx-spi: Simplify registration
Date:   Mon,  2 Nov 2020 23:14:09 -0800
Message-Id: <20201103071411.11997-9-mdf@kernel.org>
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

