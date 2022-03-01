Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187B34C8121
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 03:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiCACoT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 21:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiCACoT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 21:44:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E330C3206F;
        Mon, 28 Feb 2022 18:43:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4so12877491pjh.2;
        Mon, 28 Feb 2022 18:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gSw/HNQYSR407E/KJnPFe9WedOBNX+uo3iMrt/usYg=;
        b=UghJp81VDWqQx0L5EFLqGQ7cIlFeaujtgz+DS/qhPjgoFil6WjQvS8KApnWABdeNQz
         y4V2faoUDZyk7F2EzcsloDf8de0I36ZOYpN7XeR2+dC2Wjoqf9HxSEqKwQt1AqDSvBr8
         hirH0BWeDU5kYHWAfTYZdCnG4l8iBax6KxIDgt7vDStdxCcPPh1J/NAgoNtJggehtBpu
         yQz2oeUsMe8Ml/jC7MP0TSLIlWww9uzSoTz4QDN/ZmmbAYypIpqFmsYfWuvsghPPsInP
         3GT+6Yya0ilNcfeEHW0ZZ1Ph5kWV/jFgI3BVhMkD8ouww2v4zXRCXN++qMNc7TFLGE0v
         hHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gSw/HNQYSR407E/KJnPFe9WedOBNX+uo3iMrt/usYg=;
        b=ymwi5e/16GwD0VkBUm6wsOxpm08r9Olnj1GpnY+GZoMz3C8qesMfIZ3LOcWMsolvjN
         g9uBFwJvzfiu0G2+1tnVL1W3f9XzhmC/TkxRtrnh158SdlULRDpsXShohqzW/qETpEt9
         MM2JlahTUf8O2EM8drMb/Wrhto4s9qZe2FBNdFtP+kPZHKWsF1t1AcJzTuUfaHpB4TP5
         UEfI845G0LW8OjixA1GOGaiveqKHXcuRrUEs8T3v0dJQmOGlNPlhYYYDIGbmvFoJ/cIM
         1eYQ2ScH8njVChlsrDi1xG24GTZYaNP8g6r1/77/w5O/6GdaOpiw9PUh2p1D551ksQ3v
         au3g==
X-Gm-Message-State: AOAM5339QgmCPDFHsYEOhqNl4XVIODL3QWh1OltFyxMJl7mZNCU9N4fm
        r90kdPxo0rJitvUiZCtdK/MNydPzF57Etw==
X-Google-Smtp-Source: ABdhPJw4EyMp7bbCNiLEG+0k2iIXUCcqp07poSXHgblz780rSKA8jXpbWpyR6asWH2z+nuJLHzJfOQ==
X-Received: by 2002:a17:90a:dd46:b0:1b8:8:7303 with SMTP id u6-20020a17090add4600b001b800087303mr19538880pjv.197.1646102619167;
        Mon, 28 Feb 2022 18:43:39 -0800 (PST)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id s16-20020a63ff50000000b003650ee901e1sm11347137pgk.68.2022.02.28.18.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 18:43:38 -0800 (PST)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, yilun.xu@intel.com, mdf@kernel.org,
        trix@redhat.com, hao.wu@intel.com,
        Yusuf Khan <yusisamerican@gmail.com>
Subject: [PATCH -next] fpga: dfl: pci: Make sure DMA related error check is not done twice
Date:   Mon, 28 Feb 2022 18:43:35 -0800
Message-Id: <20220301024335.7155-1-yusisamerican@gmail.com>
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

