Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DD4BF0E8
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Feb 2022 05:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiBVE1n (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 23:27:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBVE1n (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 23:27:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAB0A2516;
        Mon, 21 Feb 2022 20:27:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v4so17172839pjh.2;
        Mon, 21 Feb 2022 20:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9Dy9ATNXPst4Mef0JsUspuz+079EqeggMltgA0idnI=;
        b=brpGL05yQ2REOrBfeg/TRj70pb1/jN3LN0V4WmsVlYNFgCB4KzRUxFCWvoaAblVskk
         MyoC3pMIsZpdYv2ySjp6NlAffZCZi/rkzFGtq721Fra5b1nGttlwQtkSmueE+KCC5z03
         3ps0V0s93v/MhiHxUIh8YxBXmYfiGvNTiAgtYIfWFYB6QYMBhL6nep5uRZIDxIOKPcXY
         t8yekh67hxEuT1IV5wKvBhHYbyn66ALKD0ihf56O0va53xMHk8OzIj3ho0DtIXZD2WUU
         5I/8ECF+BQPvBpAVS9RUL+C9HlAO0Kxs4efifYy3Mht1aXK0JWrkvqhTdBaxwK2O/bEs
         BI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9Dy9ATNXPst4Mef0JsUspuz+079EqeggMltgA0idnI=;
        b=UigUC36v7TM/qXYGaVfrd/+9UOTMoERGwabge32al3x/P76PBdpZJTJns6nJiC/BB+
         F9KH/tw/5zT0KLzA6dy+RgeL5m7lLZi5BOUtdnsnHKiBkdEWfoj/ukWDVnQzhfCvJmaY
         ECrcHdyMQbi1o4ivjoP1XZ7uDFPfHpyGVuzjiY5tZSlW6c/b5y0+6hYSJcghpJhzdYfG
         hUKqkxKN1x4jz4PPlGBkHTlV1bg7WXE1Zhw9VeXVsbXR487hwQXHG4yuFv1oABcCCmuK
         5W1FjoiUzIwFA4rvuACHvHUQPPc3iMDLBHk8qhrrfVb4nq0L2+6B8LG+PzB9TVTNgjTc
         ig2A==
X-Gm-Message-State: AOAM530Tg6tPrB/bwUb74x7AJKCHQ5uGZoY84P26j/FFJnKLCSqEbnia
        GHa/SKZ4zd5raWt0NsWyURiIfjxSLxlxcWf0
X-Google-Smtp-Source: ABdhPJxkZcsnVPrCJaM+IcneEvwKW4qN7FnaXFIYNeFf0ksAYpGc9pYeYVLFrc+hOg3rz8PuKfVt5w==
X-Received: by 2002:a17:902:bd85:b0:14d:c29b:d534 with SMTP id q5-20020a170902bd8500b0014dc29bd534mr21427396pls.99.1645504036232;
        Mon, 21 Feb 2022 20:27:16 -0800 (PST)
Received: from yusufkhan-a.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id 132sm15346240pfw.21.2022.02.21.20.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 20:27:15 -0800 (PST)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, yilun.xu@intel.com, mdf@kernel.org,
        trix@redhat.com, hao.wu@intel.com,
        Yusuf Khan <yusisamerican@gmail.com>
Subject: [PATCH -next] pga: dfl: pci: Make sure DMA related error check is not done twice
Date:   Mon, 21 Feb 2022 20:27:00 -0800
Message-Id: <20220222042700.385001-1-yusisamerican@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In the case that the DMA 64 bit bit mask error check does not fail,
the error check will be done twice, this patch fixed that.

NOTE: This patch is only for use in the linux-next branch as the
commit that caused this bug happened there.

Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
---
 drivers/fpga/dfl-pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 717ac9715970..6222f18aed4b 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -356,11 +356,12 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 	pci_set_master(pcidev);
 
 	ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
-	if (ret)
-		ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
 	if (ret) {
-		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
-		goto disable_error_report_exit;
+		ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_err(&pcidev->dev, "No suitable DMA support available.\n");
+			goto disable_error_report_exit;
+		}
 	}
 
 	ret = cci_init_drvdata(pcidev);
-- 
2.25.1

