Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770E63B9B2B
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Jul 2021 05:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhGBD5H (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Jul 2021 23:57:07 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38826 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhGBD5G (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Jul 2021 23:57:06 -0400
Received: by mail-pl1-f177.google.com with SMTP id b1so4910701pls.5;
        Thu, 01 Jul 2021 20:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3cei0fPvalLZixteq5fEWoBhZmvhldd5uZk56XF+jc=;
        b=NGtEIQy78FxYwxzZ4ezesizirlWihq/6m0jl3Qw70CyHpf9darKR0fkV5vc4eskb93
         /7hg5Z0E1xPe+JjwqK1BjjWtMX+58ZoXr77hBRe297p7dRWWMaqsTP3cmkZzrXgyR/cJ
         roclq835YElBxVNs7TqI3sGdms1SuSVs6MN4Vp1vtftsd3nLeEL6YECa5uxrGdyQAsux
         J7tvzL5vqf4oxaLmD+UjpjG5WMqTYMsRf6Ke8pE5nIOCg5AQ6L+KS4djbWhI3C+x2WAS
         sZ//0KxoPdpk2hv0KDAboIxnGO1BSFsR6d3R3hcAxZBQ/hgpDF/ZqrSzY2L/mutUOCHj
         xsNw==
X-Gm-Message-State: AOAM530pWLHa46LHo4jcojKGsYuxm+vBkrl9YbdsYY4+2oH2pRNyskfg
        7AHtVV7gqahQ2MuM1Fs/nm0ECagUzrirew==
X-Google-Smtp-Source: ABdhPJyeSo5UfYr+IkXHTTJtMIbtGuaMm70drBuDyWfvv8NXcVpP/u/UWUknSIjVVIgBoE9oo7xYsw==
X-Received: by 2002:a17:902:82ca:b029:129:c3:af1d with SMTP id u10-20020a17090282cab029012900c3af1dmr2486113plz.55.1625198073267;
        Thu, 01 Jul 2021 20:54:33 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o20sm1551362pgv.80.2021.07.01.20.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 20:54:32 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 4/4] fpga: zynqmp-fpga: Address warning about unused variable
Date:   Thu,  1 Jul 2021 20:54:04 -0700
Message-Id: <20210702035404.397853-5-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702035404.397853-1-mdf@kernel.org>
References: <20210702035404.397853-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

warning: ‘zynqmp_fpga_of_match’ defined but not used
 [-Wunused-const-variable=]
 static const struct of_device_id zynqmp_fpga_of_match[] = {

Fixes: c09f7471127e ("fpga manager: Adding FPGA Manager support for
Xilinx zynqmp")
Cc: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/zynqmp-fpga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797f..b3240f75f0c7 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -110,12 +110,13 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 	return devm_fpga_mgr_register(dev, mgr);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id zynqmp_fpga_of_match[] = {
 	{ .compatible = "xlnx,zynqmp-pcap-fpga", },
 	{},
 };
-
 MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
+#endif
 
 static struct platform_driver zynqmp_fpga_driver = {
 	.probe = zynqmp_fpga_probe,
-- 
2.32.0

