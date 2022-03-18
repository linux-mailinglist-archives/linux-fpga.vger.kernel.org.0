Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523AB4DD232
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Mar 2022 02:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiCRBBD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 21:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiCRBBB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 21:01:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1325718B;
        Thu, 17 Mar 2022 17:59:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e3so6277108pjm.5;
        Thu, 17 Mar 2022 17:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPi7qafOCETIMPSsawZV1A+wzBisJGD5S6jwVe4yEdc=;
        b=jYQfblf4upRN392OGvwkDOx0xqz0G8EI+KlIdMm9mA39eW2iabhwYbwmufQfeHCNVB
         cik9WiAD49Dwp4z4WcNcjiVCu2lDP/ofIVRJMnk7XVtpkfy1cPnrPOq8pQsfAFzhYdD+
         0vou01/zzOaxO/9PIa7vPf6lfwKHNVzm/q4j3Ith28S7Oh/3Pi62IpWK048OToZ3DRJC
         itHxJscDtB8Zyd7TkrlO2uzZuJ86YTpeCyoQtmgbIjerlKx3VabNbfEtBvUGW9IQxw+p
         GsZXvziFoHwB8gsUx3r3+wECjufpbzBQqgd0ZihoIwygQv8+L4uTHw2VD0KZxNNFPTB3
         euEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPi7qafOCETIMPSsawZV1A+wzBisJGD5S6jwVe4yEdc=;
        b=CbTh2gDfBdf0nB4B/bxq9CVqwHxXkTZeRZK2GGroTVyMFqQIQZcnc9/bZKXp0o+I20
         cNSd4AxMfqKX9ZXBdkqlAkX5ApdqrnoJx/8r4YYwRfVr4MZ4nvwgB9AEc0gLLXd+pdxL
         HJN45IxEnyteEJOhce+2xAkgqJI7Jhso+q7tRp6fH5G7DVJf7Y4nNZe7faKuDGGrLwIy
         0/gcCKdhShRtaFdbKj1OMIgsFriU6Bp61g7d3lahQC95pQw/XmPOM1dzi9U9J7ZYu+ur
         TYuA+R32wMr8/ZmzYw1SWSEy4zR6e+eWNghbcuQPk2BPfloqfAomv4T3gzHcyQI+XtyC
         5t9Q==
X-Gm-Message-State: AOAM531LUm1xjVFG4qxgJJfVNrZw6AzCoOlu0eQQnfP8buX2QrbE7XsD
        jOrCxpYVzqwIyi3RG+rOJJM=
X-Google-Smtp-Source: ABdhPJxsXFpylByBwSZcWAou4WQqsUHrgo6k2ysdJfmwETpyA/5kamnWAhiEB9M+MPwoqD51z//7Hw==
X-Received: by 2002:a17:902:8e82:b0:151:777b:6d7 with SMTP id bg2-20020a1709028e8200b00151777b06d7mr7843302plb.172.1647565183544;
        Thu, 17 Mar 2022 17:59:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 63-20020a630942000000b00372a99c1821sm6160191pgj.21.2022.03.17.17.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:59:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     hao.wu@intel.com
Cc:     trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fpga: dfl: pci: Remove useless DMA-32 fallback configuration
Date:   Fri, 18 Mar 2022 00:59:38 +0000
Message-Id: <20220318005938.2142028-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/fpga/dfl-pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 717ac9715970..42fdfa7a28d6 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -356,8 +356,6 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 	pci_set_master(pcidev);
 
 	ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
-	if (ret)
-		ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
 		goto disable_error_report_exit;
-- 
2.25.1

