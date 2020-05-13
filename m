Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF32D1D1EBD
	for <lists+linux-fpga@lfdr.de>; Wed, 13 May 2020 21:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbgEMTOI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 13 May 2020 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387469AbgEMTOH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 13 May 2020 15:14:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E374C061A0C;
        Wed, 13 May 2020 12:14:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r22so156331pga.12;
        Wed, 13 May 2020 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c4MBhFXOZtr5piYHjKdaYmafG5GWt17HP85GQ80yZ6A=;
        b=jfWQvgy9ENnwG5CcetrHoZhWpOg0qxn9CCtOg7/r5BIUuHmE9sjz1OGtTvOBNhVT82
         f61YDuBaA+0tSxjOGTT5lQWaGu6Gqmvn41AKPHBTUVi3Pr93LuVOy254Uk0cLfetbZ9W
         t6bQFlh/BSDg2G9rRW1qdDV3/0HI+hQO9vLyfoWfZhYPoeXNpuEz2SxqwmH83rr32gjL
         UjeESdgKhtOuhMtyDhkq0GKsGo0wMBNBA0CpW8wrVqatmhwWCYOSwkFBEyyC7037WiEv
         8Bd3PT1XiH+UhWaKzq1FfhGnocGZHQC49TIGtYAKZZn3qQR5cQvlDg4p+JSL+thHAc6t
         cW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c4MBhFXOZtr5piYHjKdaYmafG5GWt17HP85GQ80yZ6A=;
        b=j2Q3WtowwajRMGjenxzF/lSMUmKcLe9U5f2ZfF6sFTLaya3Y3zIIagnn3wGAGriNYx
         6SOsD4qVhZdQdkAw3EjtlJaCqOjiyLgMQbo2ZtMtCMd5CqcXIRAh3NqW1uwAp09mEwj6
         bxPjBgVNz/fZNa2VHFLhHbpcnRyE/eoUV2fv2yhhw2SjeqeikohSJwBM7lIgsBPPchAJ
         mTKN6GPsPgOkj/VbNaxapn9OLAf8tYe/sT71KlJpkDbLyBDXsPaUo/qgx0m1kz3+/cYt
         tbjXfgonKEyLZUmqbC68I7Gc01tR/1q9jxGh7CLaJnzdiWG3zg60IBhhXp0j+5dCmc5P
         nVdQ==
X-Gm-Message-State: AOAM532VIl5oylgd5VU8lIV7BDji+3rEzhjN66nm+JdN8gXn/urgfQ1s
        CD6jwDWbkkPzz1p499LOPmX9O3D0
X-Google-Smtp-Source: ABdhPJxNEH6+i12BxVCz0Pgw2eTsEWUsYCIJFOLPQE4CLdonkT30/A05utKJZBsJG12RKdExCn+XqQ==
X-Received: by 2002:a63:c306:: with SMTP id c6mr729118pgd.311.1589397245758;
        Wed, 13 May 2020 12:14:05 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.196.79])
        by smtp.gmail.com with ESMTPSA id b16sm277986pfp.89.2020.05.13.12.14.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 12:14:04 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     hao.wu@intel.com, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] fpga: dfl: afu: Corrected error handling levels
Date:   Thu, 14 May 2020 00:52:05 +0530
Message-Id: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Corrected error handling goto sequnece. Level put_pages should
be called when pinned pages >= 0 && pinned != npages. Level
free_pages should be called when pinned pages < 0.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 62f9244..5942343 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -61,10 +61,10 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 				     region->pages);
 	if (pinned < 0) {
 		ret = pinned;
-		goto put_pages;
+		goto free_pages;
 	} else if (pinned != npages) {
 		ret = -EFAULT;
-		goto free_pages;
+		goto put_pages;
 	}
 
 	dev_dbg(dev, "%d pages pinned\n", pinned);
-- 
1.9.1

