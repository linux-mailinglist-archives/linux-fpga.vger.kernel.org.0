Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBB4283D90
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgJERi1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:38:27 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40447 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgJERht (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:49 -0400
Received: by mail-pg1-f180.google.com with SMTP id i2so2736196pgh.7;
        Mon, 05 Oct 2020 10:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjZwZs24cnHRvJI8qZINqO75sV6sdKQ+viQiqkSfwzU=;
        b=Sd5XuzoTha9nyBqUoeIvW1Hqii4b6B8Lxd54RzjKfoEXRISA9x6BXyh/88T9LtAOey
         9F4RbsC/0r4ToR+zZEbpWLcr4JPm1n8JDv+EJc2Tpvoh32y0cmtDBT1lTKrG6Vqfmitm
         6uVoOMHR8mbVDoKp0ZQ70/ew3htohEPC/MUkPf/mw09yDJi3hERr9oH/OkkGMlGupbAI
         WXEGXLYzbguS55KX9U/zgN1592mV8H2+gZjHeDcl4FhbepA3wlFtfaA7UpVHNqU3NM+1
         HvtblsjJYCkLFD916cy1LPDOUMq1uF86zJU9koUwWLkYDntKbYRJVYUrU8o+ewn0Rjr4
         ccVQ==
X-Gm-Message-State: AOAM530uwrY2/+VD1s29tNhaUQM77H26nNND6qGImXogyk3YOjOZ8Dt8
        im6h6OZxk0F67E+5CSytkuq4qlBFJ/E=
X-Google-Smtp-Source: ABdhPJz+xTZGsV+G9I/y4Tu5r6e6ngwl1Wdi2JL23ASYEWVc9SGhzTOe+58nfh7bc/SlSiNneHHtCw==
X-Received: by 2002:a62:52ce:0:b029:13e:50c8:499b with SMTP id g197-20020a6252ce0000b029013e50c8499bmr905498pfb.14.1601919468616;
        Mon, 05 Oct 2020 10:37:48 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id q16sm486765pfu.206.2020.10.05.10.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:48 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 04/10] fpga: fpga-mgr: ice40-spi: Simplify registration
Date:   Mon,  5 Oct 2020 10:37:29 -0700
Message-Id: <20201005173735.162408-5-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005173735.162408-1-mdf@kernel.org>
References: <20201005173735.162408-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/ice40-spi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 8d689fea0dab..69dec5af23c3 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -183,18 +183,7 @@ static int ice40_fpga_probe(struct spi_device *spi)
 	if (!mgr)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int ice40_fpga_remove(struct spi_device *spi)
-{
-	struct fpga_manager *mgr = spi_get_drvdata(spi);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 static const struct of_device_id ice40_fpga_of_match[] = {
@@ -205,7 +194,6 @@ MODULE_DEVICE_TABLE(of, ice40_fpga_of_match);
 
 static struct spi_driver ice40_fpga_driver = {
 	.probe = ice40_fpga_probe,
-	.remove = ice40_fpga_remove,
 	.driver = {
 		.name = "ice40spi",
 		.of_match_table = of_match_ptr(ice40_fpga_of_match),
-- 
2.28.0

