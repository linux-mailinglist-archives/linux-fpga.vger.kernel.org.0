Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2684283D83
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgJERh4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:37:56 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:35429 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbgJERhz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:55 -0400
Received: by mail-pf1-f177.google.com with SMTP id k8so7422108pfk.2;
        Mon, 05 Oct 2020 10:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3XiBxLGBeSPFpAxZt+y5k3Cj/REy00FOrYxsXzSQuQ=;
        b=uYGFVRH43eX3gLlICl5ihCn4o3B8OysOsbrufZLqHqMlBWBwMWCsmwtoHRjVGs++eq
         jeo+jq5qJe5qqNXi0ye4cAMjl8duJ+UZhruUe8/sV9F4e0P+646SsJLw25rc1quk6oAP
         cFN5zdh1PrzH4ibmifAeI58dQLnGGkZD/ZNNygSfScPdlzdffTyHKDu5dxB+k8TdMmiO
         ewFtzAK4jbD8QwY6tEaM+H7kvF2qUiKEEHWKS4qV9hu/9vG5fGFO1/NeKCtyVrkrMkPE
         6qEv3ym2QHEXwziJ5WB1mhMYL4+iky5ke6gAawCaf3h5mEttHxEH5vzuhb+TE1azlkS/
         JQlQ==
X-Gm-Message-State: AOAM531u3UEVxryLvTjBrTU+TqspN8H6Tr9tAU7UQVvc5eiBTjRTNoUK
        +jQwUW2GDWuzrmuIHJTpOzJjn3ZQ/Fo=
X-Google-Smtp-Source: ABdhPJyTtaSdPJRw1sHYWV0r1e3crx8Fd03UNMOyBkViknTat2ryvDRa43qd8CEpMlLrudH6Qa0F+w==
X-Received: by 2002:a62:3541:0:b029:13f:ebd9:ad5c with SMTP id c62-20020a6235410000b029013febd9ad5cmr682191pfa.30.1601919474814;
        Mon, 05 Oct 2020 10:37:54 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id f17sm533065pfq.141.2020.10.05.10.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:54 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 09/10] fpga: fpga-mgr: zynqmp: Simplify registration
Date:   Mon,  5 Oct 2020 10:37:34 -0700
Message-Id: <20201005173735.162408-10-mdf@kernel.org>
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
 drivers/fpga/zynqmp-fpga.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 4a1139e05280..125743c9797f 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -95,7 +95,6 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct zynqmp_fpga_priv *priv;
 	struct fpga_manager *mgr;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -108,24 +107,7 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 	if (!mgr)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, mgr);
-
-	ret = fpga_mgr_register(mgr);
-	if (ret) {
-		dev_err(dev, "unable to register FPGA manager");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int zynqmp_fpga_remove(struct platform_device *pdev)
-{
-	struct fpga_manager *mgr = platform_get_drvdata(pdev);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 static const struct of_device_id zynqmp_fpga_of_match[] = {
@@ -137,7 +119,6 @@ MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
 
 static struct platform_driver zynqmp_fpga_driver = {
 	.probe = zynqmp_fpga_probe,
-	.remove = zynqmp_fpga_remove,
 	.driver = {
 		.name = "zynqmp_fpga_manager",
 		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
-- 
2.28.0

