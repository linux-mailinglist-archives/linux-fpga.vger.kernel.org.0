Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3185544E5C
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jun 2022 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbiFIOFk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Jun 2022 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbiFIOFj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 9 Jun 2022 10:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 882C812FB2F
        for <linux-fpga@vger.kernel.org>; Thu,  9 Jun 2022 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654783536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xhgrKuwsMFGqD7N/R0k/QMWuYyV386FPUEYFwR1ivao=;
        b=ZGjR7MnVWIkQMamv09045MKUT3WBWJWyAV9V8LQkygDUPTLduejddLK74KLcL8PNyspgqS
        NcD/vno9KN0qd8sKwQd/hFlLCLWwckWLnTV6QhRJAix+04i2xX4ShdOakseRxDEuMEI0iE
        tov0/vs5gwN0y/Yx19l9r2oMKGo9l3s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-DyFXXYvvPqCkNC89GP4G0g-1; Thu, 09 Jun 2022 10:05:35 -0400
X-MC-Unique: DyFXXYvvPqCkNC89GP4G0g-1
Received: by mail-ed1-f70.google.com with SMTP id eh10-20020a0564020f8a00b0042dd9bf7c57so17204341edb.17
        for <linux-fpga@vger.kernel.org>; Thu, 09 Jun 2022 07:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhgrKuwsMFGqD7N/R0k/QMWuYyV386FPUEYFwR1ivao=;
        b=C9ihEgz2wMWaSeFCjyV8BqILeRZwv/r1qqH+gqR5Id2UwE90FP5/03ijDCBaVDfYUN
         D4eNdri/gmRwHEN5QIz+Oi1sNmcvigom25FrJmtsYfj7909P4rlB/LrGih393osFcjfr
         0bhw/LDwIBnGDngt/k5nXAlHsPMZWVAdAYf3+08eCgdxCi3CCzWDK3PdGerW1T3mtaOt
         nM6I7axJQNfPuMJSstDnU/b0OkFTFqkrEHPq/CAqM5fqH6Q+tVriX0AEgtgDw3vH/CcB
         /UVhTp+Jxndsf262G8RgK3QDtCszcLnCx5zJZVyloifoJJR8yoiO4iLkSd7ceKQumhmf
         rKOg==
X-Gm-Message-State: AOAM533JfbrGrqP4CZrEQ0DvnXHnBiibiMlnEkl/9/LE5FtG5UpGBa+3
        +S0dspCwLqlIfa8zZoKH9U945grJgtNiGhz54rT77sKCnnWfotJ5cG/DjFQVsAkwUTNOTyfFGfm
        ZjguSbqCVaYRdAKNd5qVU
X-Received: by 2002:a05:6402:160b:b0:431:35df:63c0 with SMTP id f11-20020a056402160b00b0043135df63c0mr30958628edv.124.1654783533635;
        Thu, 09 Jun 2022 07:05:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyat2k8+xqz5HSlqoTKaB+b/XqaUBP/0sro/fhR+EAmjl++CgbKpOl7FWRGYDLChRrJ8P//iw==
X-Received: by 2002:a05:6402:160b:b0:431:35df:63c0 with SMTP id f11-20020a056402160b00b0043135df63c0mr30958587edv.124.1654783533372;
        Thu, 09 Jun 2022 07:05:33 -0700 (PDT)
Received: from auir.station (net-188-216-46-176.cust.vodafonedsl.it. [188.216.46.176])
        by smtp.gmail.com with ESMTPSA id o2-20020aa7dd42000000b0042dc460bda6sm14371070edw.18.2022.06.09.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:05:32 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] fpga: altera-pr-ip: fix unsigned comparison with less than zero
Date:   Thu,  9 Jun 2022 16:05:19 +0200
Message-Id: <20220609140520.42662-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Fixes: d201cc17a8a3 ("fpga pr ip: Core driver support for Altera Partial Reconfiguration IP")
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
Changes v1 -> v2:
- Coding style fix
Changes v2 -> v3:
- Added Fixes tag
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

