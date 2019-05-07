Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B52168A9
	for <lists+linux-fpga@lfdr.de>; Tue,  7 May 2019 19:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfEGRDS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 May 2019 13:03:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44037 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfEGRDR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 May 2019 13:03:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so4461061plj.11
        for <linux-fpga@vger.kernel.org>; Tue, 07 May 2019 10:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZgOuuMrrhj8XAofs6xeZ/fsPkpFUrdc6Z7bFfUFRLkU=;
        b=Yj7pSTj/CigBx6S7GlaFN2VYCEp+SJcpifN3Wp/sZgtM9Ga4FGwVbi9vvxqWEfFbzU
         d4bkLy/6FgvE8Mwy2hVJB9gKxchwDTtmlZG0b71QqE3yrAj3v0ByAMAOyuG9mPGqpzsH
         1LSBy8epy9E56/NZkFAYEm6Ja/ciD3KmfScgCXFky3AZxzm4YCGCIw6L/Ika9pRGkxeY
         LyzzUNEf5jhgzGI+I+Zzv/8XUfzVkaizPW4eePKfL69AhCwWXuapcuVdmkgUCyuf6JpZ
         ntidEg8PVEiam4bnqP7QrVwvOau+wUHUm0M0/D9PxA1HjQL6kG41FfrePPMw6F7GYVtY
         gahw==
X-Gm-Message-State: APjAAAUJIFfQjEig3dESDs7a+2iwE/mYdTeZjxfTPR3GuoRDQEXJ6HC4
        ShLMi16JXqauFvX5nuoInnjXid6ToA9xQQ==
X-Google-Smtp-Source: APXvYqwNDn3NrBxsLCzzv0AbtjUL+SxTQfXa4VJ+Fy/gn2Z/CVWh+d8UM3NntMwIqWZ7Z/heKmrJ2Q==
X-Received: by 2002:a17:902:8483:: with SMTP id c3mr39962344plo.19.1557248596403;
        Tue, 07 May 2019 10:03:16 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id n15sm31360519pfb.111.2019.05.07.10.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:03:15 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     atull@kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        Moritz Fischer <mdf@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] fpga: zynqmp-fpga: Correctly handle error pointer
Date:   Tue,  7 May 2019 10:02:57 -0700
Message-Id: <20190507170257.25451-1-mdf@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixes the following static checker error:

drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
error: 'eemi_ops' dereferencing possible ERR_PTR()

Note: This does not handle the EPROBE_DEFER value in a
      special manner.

Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
Xilinx zynqmp")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/zynqmp-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f7cbaadf49ab..abcb0b2e75bf 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	char *kbuf;
 	int ret;
 
-	if (!eemi_ops || !eemi_ops->fpga_load)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
 		return -ENXIO;
 
 	priv = mgr->priv;
-- 
2.21.0

