Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8123E559522
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jun 2022 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiFXION (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Jun 2022 04:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiFXIOM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Jun 2022 04:14:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A3117A99;
        Fri, 24 Jun 2022 01:14:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v14so2071727wra.5;
        Fri, 24 Jun 2022 01:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wvv/vrHvwmy2mxhPfUGHWbiPDLURWGMr96fl5IvBniw=;
        b=qyGG4GjwXNIyf9/ElePBK8frxbza7O52bLokfygBQDwyjulb7ukG+XwHFZPNz0LhID
         uX5XpKAzo0SpxUHwJumpaOc+8pOgeFjj37wLW65qHq1HN8FOYG/FWChQPi9GAGxI6uvr
         xTnTa0CFigtJz5bEozHuOP9qkeHR80XcMj6Q+0luQkT0QPLC6tKdQfGDuO7AHSSjl1gg
         MVMTDc6jBNFKo3snu3qrUlgr7AyqD0Sne/tW3XIPNMwuFRs3jm6bfk/50kiA2g0uwyNl
         hLy9dWFF2L61ndlpcro4GkltpwEopfA7iPNXVoCVYUc/B+R8FogqbRvZV1Re3QAEugsy
         uu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wvv/vrHvwmy2mxhPfUGHWbiPDLURWGMr96fl5IvBniw=;
        b=L2OZiI0mvX51DEtYxlL1GkYWwYPpH/9xKhfdvJrxMBPrDp4ds8eIMU5hInv6DrplJa
         Hp5Tg0A3ZYB/UaRdhhJbjvUmsX8/1AL9tmcrFJCLar6M164zhq2xYfoe4AzhbSaqhh72
         u70TF+PsZkHbRoXaKACPm1lXCLfn2J3J0liFGZx/YqBu+i7OoyoLmJbAEvF50J/vNdnd
         0KphfaKlVcHSzwUnyyUC+RNXPlqShcWkS7ikE2K1FFO5fg3oEpbocYkiAgMdjKG9gei2
         Eon5slc3ugkvfYED2w3WKYgBQev9W077ztxFEJhPj3SEitaX1istgmau0Rgcq3w1KRi4
         HH+w==
X-Gm-Message-State: AJIora9MDgpDx6g8Q5c5PwtmHHz+64z6HqiqzCtNW6vnaJqD3V1HEJl2
        oHp3D1QEe3Qt/KzO8rp1Ea0=
X-Google-Smtp-Source: AGRyM1s25Ea1vYBiZiSzS1RlpACJfZkh1eF5ve33ts5qJ2PhPpvT/VxD+PmRMgShrpeh3DRdA21IJA==
X-Received: by 2002:a05:6000:10c5:b0:21b:9aed:47e3 with SMTP id b5-20020a05600010c500b0021b9aed47e3mr12277870wrx.570.1656058450361;
        Fri, 24 Jun 2022 01:14:10 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t11-20020adff60b000000b0021b962f4256sm1570843wrp.80.2022.06.24.01.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:14:09 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] fpga: fpga-mgr: Fix spelling mistake "bitsream" -> "bitstream"
Date:   Fri, 24 Jun 2022 09:14:09 +0100
Message-Id: <20220624081409.14760-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is an spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/fpga/fpga-mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a0fa0a2cb8af..8efa67620e21 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -158,7 +158,7 @@ static int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,
 	ret = fpga_mgr_parse_header(mgr, info, buf, count);
 
 	if (info->header_size + info->data_size > count) {
-		dev_err(&mgr->dev, "Bitsream data outruns FPGA image\n");
+		dev_err(&mgr->dev, "Bitstream data outruns FPGA image\n");
 		ret = -EINVAL;
 	}
 
-- 
2.35.3

