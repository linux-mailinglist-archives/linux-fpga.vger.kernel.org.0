Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F19447140D
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Dec 2021 14:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhLKNni (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Dec 2021 08:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhLKNnh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 11 Dec 2021 08:43:37 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D1DC061714;
        Sat, 11 Dec 2021 05:43:37 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x131so10897499pfc.12;
        Sat, 11 Dec 2021 05:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=xt13Z5yrhiBpiSbrA3spSqaz9lxIFhXxgvvzrcAvgHQ=;
        b=hMBxWy/L7MRxtNlyL7GMa99EfLioNuSltV6dOfTJVWuju/w4EteL0LNruNi1thKnwn
         hXDuHwsno8bnmlCDSko6UrKI2jVv9Mq/NeYr/vwep3Tuu96ONYSC56SFlzQq8jDNjgfm
         wHcm+osVaKQUnU3gIDjBh53h9c3S68+QTx/k+E9smIzDy1rQt5h8MMHfotwtqKVvi/Sb
         JvIJuFTMyD+G34pIHvLdxwBh6e7y59AXitorDrYLi/uGPKDceXni4qhkCfHaSpywi41h
         2uBeunyuAX4xBGJerjD3/Nbu0jA3xf/No3oPBQ8qc2/dPhaVqsg6DDbbfR5Vy73Q1nFw
         qwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xt13Z5yrhiBpiSbrA3spSqaz9lxIFhXxgvvzrcAvgHQ=;
        b=Ykert5SsQZE0HwoRKshnTqZH833KfTFg+YivG13g4G67XtCfEnTGiIdCCchtimIOCT
         mwzbpX/+AbPlpI7iC8V+7TfTUlGggzHld1tLaX8USmW+srQy//zNZvtAjNvzwddPnTfQ
         qafyMQ1pGS8/IMQSfhpaDQVaWJep2i/P7JD/bIWg1LbKm9fD2RkCFTa2TLMWRxz18rTF
         tgqRuxwBSUhVA8rySdHwER6vmGV61vTTz1pSTYEdoIs4rTVdV28zO9iLS2tb3sQ9EE4B
         b20LuOJngmozeVotyc0p49jYF9cP0MgLYf+o0lKkiVKHsE4vDYGyk4oRICG6WwD9HJku
         wy7A==
X-Gm-Message-State: AOAM533XvMoyZAmkqkAcTMYKAwsmhsZ3qlc13ewjEBqHfntNngVA5xE/
        vgPk/4XEJD0w3+JBF03X9Yk=
X-Google-Smtp-Source: ABdhPJwY/lCwWXUTgu9e26XMOIINXeBEO7l6hgdd0JmJM3MjLgdlqlO2PLQJuzamxd56B03fH6/11w==
X-Received: by 2002:a63:170b:: with SMTP id x11mr40328705pgl.71.1639230216944;
        Sat, 11 Dec 2021 05:43:36 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id nv12sm2133058pjb.49.2021.12.11.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 05:43:36 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
Date:   Sat, 11 Dec 2021 13:43:32 +0000
Message-Id: <20211211134332.21679-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The stratix10_svc_allocate_memory function does not return NULL. It
returns ERR_PTR(-ENOMEM). Use IS_ERR check the return value.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/fpga/stratix10-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 047fd7f23706..2d2687a90ae6 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -213,7 +213,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	/* Allocate buffers from the service layer's pool. */
 	for (i = 0; i < NUM_SVC_BUFS; i++) {
 		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
-		if (!kbuf) {
+		if (IS_ERR(kbuf)) {
 			s10_free_buffers(mgr);
 			ret = -ENOMEM;
 			goto init_done;
-- 
2.17.1

