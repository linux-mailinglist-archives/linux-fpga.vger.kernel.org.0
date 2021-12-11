Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1194B471448
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Dec 2021 15:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhLKOuo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Dec 2021 09:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhLKOuo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 11 Dec 2021 09:50:44 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1236C061714;
        Sat, 11 Dec 2021 06:50:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b13so8172263plg.2;
        Sat, 11 Dec 2021 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wDneBruR/+Vgw69rZ+/2vtN1/5b9F/dnX6HBL4pH5nY=;
        b=NqQeJz5VnN5ffSHfdM84WIajbgSNDRhcScpalQxK73Bbes/wVYqqCj2TqnD0IIt0xM
         FBU7m+zKydwJBMAEsUTRIlCCxjCq4EZFV4FcXsVQad3/bNyFEUGGX5g2nJ68XrtoK/Yk
         5us2ftyLkLoz+2Ixo5kERdLspsPow8m73g57hLJBJWXrR/RdS3dercmjKDHviRJCTtW4
         DNHs06U5C2LcUuR/QMVHwXMF2Bj6tp6KHe9YOWx2Gp9AzmXOGdgEfnun2WXOBnIGLC9N
         Y3UfcQxONpHrtY2L+8JfmI4pqXhT7eA5CL2p+e2Oy9cs/K5yPt9R23dFCsbQijNl15FZ
         DXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wDneBruR/+Vgw69rZ+/2vtN1/5b9F/dnX6HBL4pH5nY=;
        b=MruQeD7EyJMJHY9ptmWHVCUgZVknYvZhc82DHFZYKiTpQhsj3+Vnw/H6pYkiKHWeb2
         NTuZU6A2iAswOM9IpdU9YX7JKxWrPjx1jlaBxqDT7VQitmKgWMksuDqryy2ajuGu0q1M
         r+cktBfNKYL4fvZSjsz1mzhN0bUl87xM2jTMpXn5yA9bZyv1iHBTGOW697wZ92NicHnR
         FofNug/4g2CCLgpNX9VJwq3+DnJGIwhR2w5mRd4PWYbchaOLsSF7MuFZirR2HBEZans5
         pFLiDMk6DtPSblozbxJOzNvyBn/QBGBKoKnQQluukcmEqfY1qfTbRui9sKVokw5RJd5S
         9oWg==
X-Gm-Message-State: AOAM5334K7Y5hKZjyTEUFXzLcNad7d3B+QU2QqWDg0lGN5JWUHp1DYJ9
        qUmFrKO/V/N4xXlBSNhTUh27mnvak6A99XG37Ds=
X-Google-Smtp-Source: ABdhPJyyAranTStmuL1wUcwMnje0zK4eMT416MOfz8BIQfljMD4ZBA1+w1O2uBLg4vWK5QSC2BUI2A==
X-Received: by 2002:a17:903:283:b0:142:1243:d879 with SMTP id j3-20020a170903028300b001421243d879mr83941265plr.61.1639234243396;
        Sat, 11 Dec 2021 06:50:43 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q10sm1820544pjd.0.2021.12.11.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 06:50:43 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, linmq006@gmail.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com
Subject: [PATCH v2] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
Date:   Sat, 11 Dec 2021 14:50:38 +0000
Message-Id: <20211211145038.31612-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b1186cd9-c29c-397b-080b-dcfc6b02525f@redhat.com>
References: <b1186cd9-c29c-397b-080b-dcfc6b02525f@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The stratix10_svc_allocate_memory function does not return NULL. It
returns ERR_PTR(-ENOMEM). Use IS_ERR check the return value.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
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

