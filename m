Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4986558F3D
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2019 02:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfF1AuW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Jun 2019 20:50:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45540 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfF1AuV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Jun 2019 20:50:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so2195296plb.12
        for <linux-fpga@vger.kernel.org>; Thu, 27 Jun 2019 17:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OncWFB2MqnR1/OaJA7wEfh0+edJpgnnSs9Q1oS9q/ZA=;
        b=KOskxktMS4fHj+/EGJnwDNpTwcJqN+uKdyWoCxRORVMI+p6OdZ0rtUumxENc/oyKkN
         UIg/LFMzRCj7dNe1V9IOVNDs13i+H/o8rl6pvMEat7jhGD70kFHw9Y0NMAw77365AozG
         UsqnPc7k/sYOBH7u34h4Oul+FG5a+VOEXwRf4IitDzo8EyrQkd0xd5iPTrOMAByPRoEj
         LxFKG36Ay4/gRrPRNdq2glrf59OFdVyeb8jDIYL6/xopRJcxz2n5DdbKXLEsh4WjUGXl
         qJSuc6L90nr8M7PTrHnDsItwtjyUT1ex1pnj65Hi+YhvFi363HMOdUsRoqx8liermhtt
         C8LA==
X-Gm-Message-State: APjAAAWvfR+Kxpf/fwVjitCL+25r2tcNsxjv+gcOeHH6ToXHhzBaKV8K
        iIBXNI9SJNeayMkMuJZd5CreU0iCGP4=
X-Google-Smtp-Source: APXvYqwmsB/Afp0fu+EJ8gtQSSN8OqTgLlckMMG2rd5xQt9eDMf1WOOOJ9gTdMpZ6Bc4ueW3IvOaLw==
X-Received: by 2002:a17:902:e490:: with SMTP id cj16mr7942734plb.136.1561683020604;
        Thu, 27 Jun 2019 17:50:20 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id h2sm269882pgs.17.2019.06.27.17.50.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:19 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 03/15] fpga: dfl: fme: align PR buffer size per PR datawidth
Date:   Thu, 27 Jun 2019 17:49:39 -0700
Message-Id: <20190628004951.6202-4-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628004951.6202-1-mdf@kernel.org>
References: <20190628004951.6202-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Wu Hao <hao.wu@intel.com>

Current driver checks if input bitstream file size is aligned or
not per PR data width (default 32bits). It requires one additional
step for end user when they generate the bitstream file, padding
extra zeros to bitstream file to align its size per PR data width,
but they don't have to as hardware will drop extra padding bytes
automatically.

In order to simplify the user steps, this patch aligns PR buffer
size per PR data width in driver, to allow user to pass unaligned
size bitstream files to driver.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-pr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index 6ec0f09e5994..3c71dc3faaf5 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -74,6 +74,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	struct dfl_fme *fme;
 	unsigned long minsz;
 	void *buf = NULL;
+	size_t length;
 	int ret = 0;
 	u64 v;
 
@@ -85,9 +86,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	if (port_pr.argsz < minsz || port_pr.flags)
 		return -EINVAL;
 
-	if (!IS_ALIGNED(port_pr.buffer_size, 4))
-		return -EINVAL;
-
 	/* get fme header region */
 	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
 					       FME_FEATURE_ID_HEADER);
@@ -103,7 +101,13 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 		       port_pr.buffer_size))
 		return -EFAULT;
 
-	buf = vmalloc(port_pr.buffer_size);
+	/*
+	 * align PR buffer per PR bandwidth, as HW ignores the extra padding
+	 * data automatically.
+	 */
+	length = ALIGN(port_pr.buffer_size, 4);
+
+	buf = vmalloc(length);
 	if (!buf)
 		return -ENOMEM;
 
@@ -140,7 +144,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	fpga_image_info_free(region->info);
 
 	info->buf = buf;
-	info->count = port_pr.buffer_size;
+	info->count = length;
 	info->region_id = port_pr.port_id;
 	region->info = info;
 
-- 
2.22.0

