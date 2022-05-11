Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BA522C88
	for <lists+linux-fpga@lfdr.de>; Wed, 11 May 2022 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiEKGoN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 May 2022 02:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbiEKGoL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 11 May 2022 02:44:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AEF6C0C0;
        Tue, 10 May 2022 23:44:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i24so1164699pfa.7;
        Tue, 10 May 2022 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmHkqlWr7c4QFgT4EmfZ9lldeIHOaKWpbWlbDUJ786E=;
        b=Xie9XphIFkYPUZEie/Egz6ibA1CeJIe4XjLyItsFWpUS85J9v+hVZGpZ5dPmH2DxrW
         p8Y+/oNNubymXLVYOnrO9YyCdAF2lXqIyuXH9dqn/5OQ0zwq8djccpTv66HhHK2YtKd/
         hNXhA/XcGMIUvp6NpmMyhgGOan2MUmaeiQBt9GzJnTRPa4u7UvCKyt+5JSv4SouDtdJU
         uzeSFLzZNYW+Vajx9EHEs/uR9GOVEu/gWTcGs788/nZS7klvKLZcs+jMaAqsJEPXG70w
         Vf1Qn75mR4hmzAU3XM2Qi54gRUxLyBzM/7qxoV3Zg617vFLzOTB95HB7HgjfGFh/uz8R
         FRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmHkqlWr7c4QFgT4EmfZ9lldeIHOaKWpbWlbDUJ786E=;
        b=gTdUEGx6QR+oy/27l+jJWjxiFdjuLsgerjBRyBklf4ukYOhNlymArf2Q3j+h7mgIJH
         mQt5retpmatEpQbjRfogQmWqpe2kszia2oYxOr9FmaFy1xNQmHVAhWiBoOZ8GNvZTXsV
         1VX3bqt+19+08zJ9loVoVrfMT+/ZVbjvamgI5Vx8/fHPg6d5eoyeGSRmBZox8Zz3Ctc7
         thsUgRKAWSK5SgWbGsgLdHf0SlP3XBLUFr47zgt/XWHAVRE1IM8VrS4R9ofcDvRBaYDR
         7pLS/BT4Oh9vm73AMehHCprGQuD00qLS6wv83E3+Sj6dT/tXIyzcfVc3k7ulzb4OFT7I
         6UnQ==
X-Gm-Message-State: AOAM533G4z/W9iw9HaOCC2kapkbNgiUaQqC1MTXg5WXenX01rSiYPk1s
        TbmHgGq8laNF/DQROsidTQFHdzabRWTupsZjgOo=
X-Google-Smtp-Source: ABdhPJz4gMyxezuz3NNsXZsooFJpcRZR+boVRmrZ1TbuIvUZm0lsMkMbXWpFXPUPR7twYVbJF5IOHQ==
X-Received: by 2002:a63:c015:0:b0:385:fe06:eb86 with SMTP id h21-20020a63c015000000b00385fe06eb86mr19418244pgg.132.1652251449932;
        Tue, 10 May 2022 23:44:09 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id c23-20020a63da17000000b003c14af50639sm858113pgh.81.2022.05.10.23.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:44:09 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Alan Tull <atull@kernel.org>, Shiva Rao <shiva.rao@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] fpga: Fix memory leak in build_info_create_dev
Date:   Wed, 11 May 2022 10:44:00 +0400
Message-Id: <20220511064400.63518-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

platform_device_alloc() create a platform device object.
we should call platform_device_put() in error path to
release the resource.

Fixes: 543be3d8c999 ("fpga: add device feature list support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/fpga/dfl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 599bb21d86af..f0b945bd975f 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -879,8 +879,10 @@ build_info_create_dev(struct build_feature_devs_info *binfo,
 	INIT_LIST_HEAD(&binfo->sub_features);
 
 	fdev->id = dfl_id_alloc(type, &fdev->dev);
-	if (fdev->id < 0)
+	if (fdev->id < 0) {
+		platform_device_put(fdev);
 		return fdev->id;
+	}
 
 	fdev->dev.parent = &binfo->cdev->region->dev;
 	fdev->dev.devt = dfl_get_devt(dfl_devs[type].devt_type, fdev->id);
-- 
2.25.1

