Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56F3B9B29
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Jul 2021 05:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhGBD5E (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Jul 2021 23:57:04 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:55170 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhGBD5D (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Jul 2021 23:57:03 -0400
Received: by mail-pj1-f50.google.com with SMTP id g24so5617414pji.4;
        Thu, 01 Jul 2021 20:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axeE3qqRemvQk/CeV8uQnaAFZ4FSAIWZdT1IUl7NUtU=;
        b=ntsllHWKq0RMBh1wyazeR/RkSjfRFV91xlKzcFNVO+rq7alDd7ekHF1S6dRBCFtuCS
         hJDP402BpM0Qh8UsCd3hks+KKicLCrVs14WB3+ciEMqL4wxrhzzzOaIUL3sRtQBZIONv
         leCO4qOmdcEOpmOPthqRzTCjzbH19y4ytU9M9L1QxoDdQuLs7P3EdLr2f4oLExIk3uDn
         HRveKV0SZj7CF4974whsA4hIHLpd6N45coUhY1gMdfg14gA4oh3vWTyoe/ZicOxJ+zKs
         ks7x03xhTGHi0gOqzrMCQ7OWQ9DFnM7QYifPxAiET8+KLvDpuCMNV50bKp18m37fuV3f
         X5pg==
X-Gm-Message-State: AOAM5301MJyxgc6TCffl4kfZw61cIebolryAKH+gkN7pzSwEASKkoLYD
        5IYLsv1H9TZ6gSa/laLJJiQrNtF6mflhAA==
X-Google-Smtp-Source: ABdhPJyuO9FEskcEZcjmssYdg8HSI23EWUmy4VI2MuoUdlFBJ1OZpQmlRwnK0LdrwZPE52R4pGjHKA==
X-Received: by 2002:a17:90a:2809:: with SMTP id e9mr13496497pjd.216.1625198071461;
        Thu, 01 Jul 2021 20:54:31 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id q89sm1208284pjq.42.2021.07.01.20.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 20:54:30 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 3/4] fpga: xilinx-pr-decoupler: Address warning about unused variable
Date:   Thu,  1 Jul 2021 20:54:03 -0700
Message-Id: <20210702035404.397853-4-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702035404.397853-1-mdf@kernel.org>
References: <20210702035404.397853-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

warning: ‘xlnx_pr_decoupler_of_match’ defined but not used
 [-Wunused-const-variable=]
 static const struct of_device_id xlnx_pr_decoupler_of_match[] = {

Fixes: 7e961c12be42 ("fpga: Add support for Xilinx LogiCORE PR Decoupler")
Cc: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/xilinx-pr-decoupler.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index ea2bde6e5bc4..e986ed47c4ed 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -81,6 +81,7 @@ static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
 	.enable_show = xlnx_pr_decoupler_enable_show,
 };
 
+#ifdef CONFIG_OF
 static const struct xlnx_config_data decoupler_config = {
 	.name = "Xilinx PR Decoupler",
 };
@@ -99,6 +100,7 @@ static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
+#endif
 
 static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 {
-- 
2.32.0

