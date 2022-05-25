Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D499053403E
	for <lists+linux-fpga@lfdr.de>; Wed, 25 May 2022 17:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbiEYPP3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 25 May 2022 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245066AbiEYPPZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 25 May 2022 11:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4456CB0A63
        for <linux-fpga@vger.kernel.org>; Wed, 25 May 2022 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653491721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gcTixSZTkvL/w/7L1HwLNEqSifq3qq6EouMS7B6x8F4=;
        b=F/dfPQP5oqOdhKXnv5KmE8m4/REJe3wFZGl3hcvAarXwZjR9dF0YhCVHJoZ3FTioM+wkI0
        pJNow9+fqNGKOCYC+Ln3nXHHqQtXPRRbGcj5/6djF2xbxnQ0ffaJshm/38AsA8SFWTemBQ
        wKd9RPmadpedNxXt8jbmGFinypEeFoo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-SxHsFKXEMTqFRWPl4WO5aw-1; Wed, 25 May 2022 11:15:19 -0400
X-MC-Unique: SxHsFKXEMTqFRWPl4WO5aw-1
Received: by mail-ed1-f72.google.com with SMTP id w14-20020a50fa8e000000b0042ab142d677so15134331edr.11
        for <linux-fpga@vger.kernel.org>; Wed, 25 May 2022 08:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcTixSZTkvL/w/7L1HwLNEqSifq3qq6EouMS7B6x8F4=;
        b=flN69UVWhotgh8NrKWl96hb8Kl6tVcndMmXY+tQ+I/OaMw7OMqzyr9FO48H8L26l3N
         U05a57MQvFq5P8RulKL2CyTioGZti+b8eI7DZaFM1nYdyBGnYQrxx1nFLELiVe7pVyVK
         eIEba2teIIE+rQ/E1IURmb6+GF/WlV8wKbZCCSRhMB7fCwqrHDMXoXyzJhU6FaE0jJW1
         ugugQdgz/lT/V5f6gHjfE09Dk9sIxOg4FXbd7RofFEsmRgnXRcNXuVjfHE9KbMlphnPU
         2xw2bD0/75t3V8itru6khQYbt6DJZqXZqhhcoC+DU4djtjSKKqEsNsHon4jjZQbgc5GE
         WJ4w==
X-Gm-Message-State: AOAM532rR+bphalLNa5YkFVA8/6o/HgTbsNysgfVAxL/Am0Hrk3l1b2D
        jjCLC635jnlbW+lvQmN1cQJ7kcc1EMVAHUGmXmTT4WspDyUVdDFlHISPb6wVE7TBJsH+Z7ETQVz
        4g0fTUiPUCXe9fqnEaHaq
X-Received: by 2002:a17:906:2416:b0:6fe:a0be:91d5 with SMTP id z22-20020a170906241600b006fea0be91d5mr26367690eja.132.1653491718361;
        Wed, 25 May 2022 08:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTgN7zmlntoiNwoEyCgikQcdFrAhVHRko25ErlIb+NvzlhfgJXKvym4ZuzCjZcuR88JwVR7Q==
X-Received: by 2002:a17:906:2416:b0:6fe:a0be:91d5 with SMTP id z22-20020a170906241600b006fea0be91d5mr26367677eja.132.1653491718216;
        Wed, 25 May 2022 08:15:18 -0700 (PDT)
Received: from auir.redhat.com (net-188-216-46-176.cust.vodafonedsl.it. [188.216.46.176])
        by smtp.gmail.com with ESMTPSA id n17-20020aa7c791000000b0042ab02e3485sm10762135eds.44.2022.05.25.08.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:15:17 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fpga: altera-pr-ip: fix unsigned comparison with less than zero
Date:   Wed, 25 May 2022 17:14:52 +0200
Message-Id: <20220525151453.55725-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fix the "comparison with less than zero" warning reported by
cppcheck for the unsigned (size_t) parameter count of the
alt_pr_fpga_write() function.

Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
Changes v1 -> v2:
- Coding style fix
---
 drivers/fpga/altera-pr-ip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index be0667968d33..df8671af4a92 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
 	u32 *buffer_32 = (u32 *)buf;
 	size_t i = 0;
 
-	if (count <= 0)
+	if (!count)
 		return -EINVAL;
 
 	/* Write out the complete 32-bit chunks */
-- 
2.35.3

