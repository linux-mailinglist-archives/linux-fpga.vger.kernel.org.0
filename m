Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62FF4F53D7
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Apr 2022 06:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiDFEDz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Apr 2022 00:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573334AbiDES4R (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Apr 2022 14:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 433344D9C3
        for <linux-fpga@vger.kernel.org>; Tue,  5 Apr 2022 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649184856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ePJI6vLaNk30K4WDlJXEh2MYG+aNmDa1MxEoKA++MGw=;
        b=MoJ81XxadEGbKHxH87Q3VXOpW5N62dSK7cchISS5GgwXVNUqWZ51cWMSh7svRuvyPVCPYN
        zhDNfrUNMGgO8bS17w8TweFJfcDBsRomoqLU38npQHRp9MzpIpZEs9w57rb1cDNuHCGBqm
        oIeM/B7WHJtZZJfSPZkz3POt9p1gx4A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-icz-8rhpMxi-zLpFZkpuEQ-1; Tue, 05 Apr 2022 14:54:12 -0400
X-MC-Unique: icz-8rhpMxi-zLpFZkpuEQ-1
Received: by mail-ed1-f71.google.com with SMTP id i13-20020aa7dd0d000000b0041ccfefe3f4so4122026edv.14
        for <linux-fpga@vger.kernel.org>; Tue, 05 Apr 2022 11:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePJI6vLaNk30K4WDlJXEh2MYG+aNmDa1MxEoKA++MGw=;
        b=Wyk3c7gRydqfA2GqSQefxrohC92RBY6V6StsBVOK60Zot0fQ4vETp/8TfdD5Dj1LdJ
         eGlcb/V/taqr2qzL614qJ/FSpgzhsKHXR69e9Fpy7UpPwJwXywUdsYI/Aw+CzGk/GL91
         YpIUatLxii+0C9EEGEObCGCFt1B3zKyRsZ88NNOQQrXy19QTN9xtJwXI6eb0/LROtFy6
         nagwyRmkixNjciiQQPsA6ADae+XmzZMFGSQ2ZmklddHGvkCUE3o/H8Ck4BOEG4CS6o2K
         zEnfjqybiR1zg/CqRJ82cfozTp9X42FRm7OPkUnzbdXxq251fZfVtbZakj6oLpO2uKBd
         aHsg==
X-Gm-Message-State: AOAM532kWAD7MMw0W6BhvY1hOHAzB4YrOUBZSktUJMnbfOqJPkd81Uwo
        sgvQUEMU1y0Eu09/ZbUNpXJR2Pt3VaK7KTWMkjzWHjlrExvsmHG/kuki7mtl+WZsKumpi++7f2Q
        zZKxnGSjkiflPMrcOj9ZG
X-Received: by 2002:a17:907:9705:b0:6e4:b769:286f with SMTP id jg5-20020a170907970500b006e4b769286fmr4790984ejc.728.1649184851337;
        Tue, 05 Apr 2022 11:54:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH06ru9gb7oT8rBwDeYyDkG6AW/6djpQzjZJ7rxCFFf6I/5LGo02htK6mf8a0wRGlyfoigqw==
X-Received: by 2002:a17:907:9705:b0:6e4:b769:286f with SMTP id jg5-20020a170907970500b006e4b769286fmr4790969ejc.728.1649184851120;
        Tue, 05 Apr 2022 11:54:11 -0700 (PDT)
Received: from auir.station (net-188-216-47-188.cust.vodafonedsl.it. [188.216.47.188])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090646d000b006e093439cdfsm5821273ejs.89.2022.04.05.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:54:10 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: altera-pr-ip: fix unsigned comparison with less than zero
Date:   Tue,  5 Apr 2022 20:53:49 +0200
Message-Id: <20220405185349.220607-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fix the "comparison with less than zero" warning reported by
cppcheck for the unsigned (size_t) parameter "count" of the
"alt_pr_fpga_write()" function.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/altera-pr-ip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index be0667968d33..2ff3d8e46a0c 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
 	u32 *buffer_32 = (u32 *)buf;
 	size_t i = 0;
 
-	if (count <= 0)
+	if (count == 0)
 		return -EINVAL;
 
 	/* Write out the complete 32-bit chunks */
-- 
2.35.1

