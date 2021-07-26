Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD143D517E
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Jul 2021 05:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhGZC1q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Jul 2021 22:27:46 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:44026 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhGZC1q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Jul 2021 22:27:46 -0400
Received: by mail-pj1-f51.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso12321094pjs.2;
        Sun, 25 Jul 2021 20:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aD6WbqD5ZfpRdWmaXUlhND62kaV0wHPK2FjfL9i3Isk=;
        b=DBAKGxdWpVf8D9mtOMJilhB0KrOUeFx6fiyUMxRaX7SzbW/FCZIWMnoDKHtFtOY6Iz
         ZM3r495szuLCLX/a0VQBW9LcfzeDgTkGnVRyDsmX2SX1HTlmmXmiUG8oG5SMF2SaN1xd
         l4U2QQxSoxP8WvNJ2UnAcHqyttAw2apDiC3ZYINX/Yx7AKFjzmzXE+19q9xnjCugXway
         Om4073HDwaIH3qt20cn7xR8nI0QwavMYGLuO0MT+XJMh/fQhCpeDrX04acZH4QOge3Au
         SiR2UdAhb9ZQXjw9LXjHjSb+duJrIQmDrOdZp5GpKKcm10D3JW2ZNG3ZxyPmopN3MJLx
         L6NA==
X-Gm-Message-State: AOAM531wEFX4U57WTwgVj1ZM1cn7GxF+n19JHV0povX+b7Edzxtkgzza
        3ugjhRMl61684vnRuLSwfrtQAHDo2DA=
X-Google-Smtp-Source: ABdhPJx/lvhc0CFJdMe4uB1FlfxmEkcEB/Z5Qq03HhLo+Ja0LnO09ZCuvzza35gfFFTLtdy/wtNwog==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr23820263pjg.202.1627268895391;
        Sun, 25 Jul 2021 20:08:15 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id t71sm23513114pgd.7.2021.07.25.20.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 20:08:14 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga: versal-fpga: Remove empty functions
Date:   Sun, 25 Jul 2021 20:08:06 -0700
Message-Id: <20210726030806.714809-1-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Since the core framework now wraps the functions, ensuring
drives only have to implement functions that do something,
drop the now no longer required callbacks for state and
write_complete.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi Greg,

This needs to wait for the earlier pull request [1] that introduces the
wrapper functions, allowing drivers to drop the empty ones.

Unfortunately this sort of got of sync with the versal patches getting
picked up before the wrapper changes went in.


- Moritz

[1] https://lore.kernel.org/linux-fpga/YP4kHpn7CDzCYrbU@epycbox.lan/
---
 drivers/fpga/versal-fpga.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
index 1bd312a31b23..5b0dda304bd2 100644
--- a/drivers/fpga/versal-fpga.c
+++ b/drivers/fpga/versal-fpga.c
@@ -37,22 +37,9 @@ static int versal_fpga_ops_write(struct fpga_manager *mgr,
 	return ret;
 }
 
-static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
-					  struct fpga_image_info *info)
-{
-	return 0;
-}
-
-static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager *mgr)
-{
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
 static const struct fpga_manager_ops versal_fpga_ops = {
-	.state = versal_fpga_ops_state,
 	.write_init = versal_fpga_ops_write_init,
 	.write = versal_fpga_ops_write,
-	.write_complete = versal_fpga_ops_write_complete,
 };
 
 static int versal_fpga_probe(struct platform_device *pdev)
-- 
2.32.0

