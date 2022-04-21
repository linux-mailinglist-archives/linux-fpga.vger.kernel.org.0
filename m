Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94850A2DC
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389503AbiDUOm4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389537AbiDUOmm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 10:42:42 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AB40A09
        for <linux-fpga@vger.kernel.org>; Thu, 21 Apr 2022 07:39:51 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id u15so1674492ple.4
        for <linux-fpga@vger.kernel.org>; Thu, 21 Apr 2022 07:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKciBBQrVafvysRrJtrY+blLvwiNsFJxjsp9XV7auaE=;
        b=XPPZJMJU8MdBhFIWGYTL43lqTPycZeLHY52eSZgxKlLVOg0XyPoFDqUmQ6YDk45BNI
         QE/IcLjvjrPVN3RIpiuW3DvAa365fZpcQUggPN5WsBqrqFnLFde57IQjYksxzCNs2lb+
         VvduDvwhI0Rz6cL4sLg8FvzDUp+zOh4GaF1+vsbFkutTzd+J3343CyxB8kWhiczmjUx9
         wYpA1MJdw9Ve0cGLuV99emcMAyXD+A/nq+AsLZZaiihtR8QJ9e59iSe5oUVhPGtnjXkb
         tST4xaqmK4wG2a1jySlq7Y5Cj2gH3FMjKQvF5dcjzY3qabP2qkkUwTLuwZfup3EwNfSa
         b5hg==
X-Gm-Message-State: AOAM533IolwWQF5o15DtliZ5e6cRrvbkpQhqeZDvdDRX7GuZo8Jq91xd
        NXQAiY/UINLbi8Tz5SScniclzigt5Tk=
X-Google-Smtp-Source: ABdhPJwgQwed4NTLR1PnA8zk8zB7uTnsPjhUlQwzIh4l/oWNAGWqRYeIzPnoPy3Vo6OMhUzaa+PzAA==
X-Received: by 2002:a17:90b:390f:b0:1d2:853c:5b99 with SMTP id ob15-20020a17090b390f00b001d2853c5b99mr7993pjb.8.1650551990655;
        Thu, 21 Apr 2022 07:39:50 -0700 (PDT)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id y20-20020aa79af4000000b0050832e3caadsm23636111pfp.216.2022.04.21.07.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:39:49 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     jgg@ziepe.ca, yilun.xu@intel.com, hao.wu@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga: fpga-mgr: Fix undefined behavior
Date:   Thu, 21 Apr 2022 07:39:24 -0700
Message-Id: <20220421143924.68443-1-mdf@kernel.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Incrementing void pointers is undefined behavior.

Fixes: baa6d3966351 ("fpga: Add scatterlist based programming")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 6bd018f20793..3d9b8722f5ce 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -299,7 +299,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 {
 	struct page **pages;
 	struct sg_table sgt;
-	const void *p;
+	const char *p;
 	int nr_pages;
 	int index;
 	int rc;
-- 
2.36.0

