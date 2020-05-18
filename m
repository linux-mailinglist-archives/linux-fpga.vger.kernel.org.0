Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F41D8488
	for <lists+linux-fpga@lfdr.de>; Mon, 18 May 2020 20:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbgERSMA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 May 2020 14:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733163AbgERSL7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 May 2020 14:11:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCFCC061A0C;
        Mon, 18 May 2020 11:11:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f23so5209074pgj.4;
        Mon, 18 May 2020 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=se9wd1uk38RXhEDmZHcWVSPKHbV3RHA1ESfUPJD0CkI=;
        b=fFoYry9bkC202CbP/RHEryK1BVp7WjWg4Lrq7JlBQj5SDRiGI+XqT09ss6aUyFsRQi
         nDymm7zrPp7UMP5R0ZQBAynNP7ZJ9nfBh7hibK7/dw1Sv7P3twxrEcTD1Sl1EZ1zuWDx
         1LPqeQTCxpkSEM/ZmQMt1ASFnCvV/mlSho8cXmkciQ4k32SbjbeBGSsjs5ra4VkC9C0/
         fUp27BpMSG6AW+5m7ZnH5xZ5Gh63mZDrC+8F/EmSIRR5cKQ7NKv6bZIfPv2YWxWYj2Sr
         kqs3r+C6Ztlh/0GPty3LSHyn2E7AxsAqAOn+2NNxyhtrBwsYwmdoYZtPX9WkowHazFU0
         HOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=se9wd1uk38RXhEDmZHcWVSPKHbV3RHA1ESfUPJD0CkI=;
        b=fE0FFvXN3qOpyO+1joryj5iD9sFBDgFr2zSYZd3tvIsmBX3V0iNNGqO5zHiMuqZsK9
         Y77S04KyNHDMS6MQ2R19AwuCTQnBrtphnw/Ons92H8pVF/lIyj73aguHPv7GtZ5i++0P
         EcYgphoppEdSiebhy7yDfgqsIqMe7mVDfQJ6Q4XAdszb9wIdkpmYUzAI9QRS7F4N7QKW
         9AdiCe6ays7zh+8LBmWrG+O50gjEKprFDC+l5Xr6pTpcmXdmJ0RIL+zY4eTfxLphPihS
         jgsfDXv0xEnaLAlWWdrHFZOh88QbFs+0jlAuZgfKWo1SEOaTt2rjdVEfW657tDw3uOyU
         AzVA==
X-Gm-Message-State: AOAM5339oFr4vEQVAWmI9Mbp3iwaIGf+EOo06+F3oi+W+i2RcKEtGnbJ
        arGDpDeKS79jxp2t56Bhgv4GuFzsMa8=
X-Google-Smtp-Source: ABdhPJx5k0G6UpPfiNaOcE/RYjDoQwzNDryfEMz6nHWXKsAwKNpGvTipLXd1sqSKTqtcte5myUUTCw==
X-Received: by 2002:a63:c34a:: with SMTP id e10mr1301316pgd.412.1589825518735;
        Mon, 18 May 2020 11:11:58 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.172.185.68])
        by smtp.gmail.com with ESMTPSA id d184sm9082427pfc.130.2020.05.18.11.11.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 11:11:57 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     hao.wu@intel.com, mdf@kernel.org, enno.luebbers@intel.com,
        guangrong.xiao@linux.intel.com, gregkh@linuxfoundation.org,
        christopher.rauer@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH v2] fpga: dfl: afu: Corrected error handling levels
Date:   Mon, 18 May 2020 23:49:51 +0530
Message-Id: <1589825991-3545-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Corrected error handling goto sequnece. Level put_pages should
be called when pinned pages >= 0 && pinned != npages. Level
free_pages should be called when pinned pages < 0.

Fixes: fa8dda1edef9 (fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/
UNMAP ioctls support)

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
v2: Updated change logs and few reviews.

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

