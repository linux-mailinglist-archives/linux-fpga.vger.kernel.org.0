Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DED472134
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Dec 2021 07:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhLMGtH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Dec 2021 01:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhLMGtH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 13 Dec 2021 01:49:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01475C06173F;
        Sun, 12 Dec 2021 22:49:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so13948213pja.1;
        Sun, 12 Dec 2021 22:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GS6TBSkNvGlEIjVNsFvYKFeWjbTrFdDN1acBfD429pE=;
        b=ov16Lr8WDwm71/zA2oJCmtDvLel/EF2ZkZ0Vd9nZPAXlsCuIdVLmz8t4ErfHcjjOEg
         eDYS4gE/gvcS0a97ICH7ucndAeq86oFu9GqQlbBMaJAwA4V4lVb/9xXTTEqOIE4h3U9V
         XtkLlwcMvDXnY6nDuM7p+8/EWKG30zue/ZCDxNyJzHW3U/B+hdi1g2iw97ZpjclRiiJQ
         mEtH+FfhgiLSj4knWDmvo62W2ukvRRE9WWsTDYiESiT20q1+GMsXCb3sjCE5luRyfC6c
         dfQlu76DudK9mCvMr8yOqyoADKS2kPTDJXxm7SEXBu+XhWivc4FdxcIinqh9WOoZ15Gu
         SPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GS6TBSkNvGlEIjVNsFvYKFeWjbTrFdDN1acBfD429pE=;
        b=h8jDKlczPckjo5BN571wojekwPn42EBDeSs2feG/ejc7IlR9+Z91sn4pZDyoki7Tto
         McQTdH4l9nWV7tf1uufYkaUVC5qG77QO0mSOmAAgtZofGXyl6uJRTPqT9Swaj5Gsqftq
         A1ltEfBSwb7kP5Bh/6D2ixeuwueobStCDMDc8b2I7TyMvPmj4maFcyuY6KoJTy8g5vSu
         lSyV3Pb8kig3N0buQAqD8ivzJ504tQrOGologl80/78Og7FAKiNIvCwH81wsEGKULgLp
         jskvfQC79dX87LtY1TFqNZUCtkqm2efPUF2K2eBBYW3AzmjpfM5Yq21bFnQGqUVP9DHc
         ZnmA==
X-Gm-Message-State: AOAM533L7kn50AlXiE5mlhLjvvFS2LRO+tBLQtLr6p82rRDCrQxN9JBG
        HawsmZiooGmWIbcFof4hizw=
X-Google-Smtp-Source: ABdhPJyUJCjObbObAlvLYVaHaGdai5j/wPqetffkbDAo+1TIV2oOwnbrEHTsPiBJYSYmO5CfYwy7DA==
X-Received: by 2002:a17:90b:3810:: with SMTP id mq16mr42306638pjb.128.1639378146498;
        Sun, 12 Dec 2021 22:49:06 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id c18sm11959670pfl.201.2021.12.12.22.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 22:49:06 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     hao.wu@intel.com
Cc:     linmq006@gmail.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, trix@redhat.com,
        yilun.xu@intel.com
Subject: [PATCH v3] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
Date:   Mon, 13 Dec 2021 06:49:00 +0000
Message-Id: <20211213064900.10386-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <DM6PR11MB3819B3918DA4D58E59228CAC85749@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <DM6PR11MB3819B3918DA4D58E59228CAC85749@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The stratix10_svc_allocate_memory function does not return NULL. It
returns ERR_PTR(-ENOMEM). Use IS_ERR check the return value.

Fixes: e7eef1d7633a("fpga: add intel stratix10 soc fpga manager driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/stratix10-soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 047fd7f23706..91212bab5871 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -213,9 +213,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	/* Allocate buffers from the service layer's pool. */
 	for (i = 0; i < NUM_SVC_BUFS; i++) {
 		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
-		if (!kbuf) {
+		if (IS_ERR(kbuf)) {
 			s10_free_buffers(mgr);
-			ret = -ENOMEM;
+			ret = PTR_ERR(kbuf);
 			goto init_done;
 		}
 
-- 
2.17.1

