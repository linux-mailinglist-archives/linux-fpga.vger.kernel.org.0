Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6473B9B25
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Jul 2021 05:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhGBD5A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Jul 2021 23:57:00 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:46671 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbhGBD5A (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Jul 2021 23:57:00 -0400
Received: by mail-pg1-f170.google.com with SMTP id w15so8297977pgk.13;
        Thu, 01 Jul 2021 20:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGO2PnJpZgZgjLLbVMuyhPShy1MPH3RADIXKmAu7S1U=;
        b=uJX+FI2IjWb78hW326s4+KcmlucdhkzNA/BVtlNEAtVZL1oJuE6L31ld03xlBVNPqh
         8hI4WYpoV3pHCwf6EE9vJ4vEK+7cbBoGtyQISXRQ+W6VD8rDserS4RIcdv1AwjBEP6cR
         E3MOxwO3fI5zJ1YYgHnq6rudUhOAt4c8W6plPSf6NktVajeRPz3ILz6ZKCiFCqUgYnpp
         vXxgBQiPunq0/6fvv3reNhEn+73Pocopdp9DrzJfIjvArG3VWdCfip8EoQdrWKPObX0Y
         lCRDaDuSuT2uBvsDE9XYEnuRYaWX55pFVBJVA4QWqq4phxGcLBz3v6wK8fdMSU4SO5Zj
         XPcQ==
X-Gm-Message-State: AOAM530+FoHS8/Z4kSvm6FGB07dI22Fj2zjeLmaHDr1FUwh11vD7KG73
        XoRtG+lgfbJ93K3Su6oRa8vS3krMpU5DmA==
X-Google-Smtp-Source: ABdhPJypJ7QiJX9+dCX4aTFtXAxIX0ucmJvCdUy869hvwPHRwU+T/+3YfvODz/l+5VciwGXzQezyBQ==
X-Received: by 2002:a05:6a00:1a0f:b029:314:7bdf:9491 with SMTP id g15-20020a056a001a0fb02903147bdf9491mr2278753pfv.33.1625198068210;
        Thu, 01 Jul 2021 20:54:28 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id j15sm1535165pfh.194.2021.07.01.20.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 20:54:27 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/4] fpga: altera-freeze-bridge: Address warning about unused variable
Date:   Thu,  1 Jul 2021 20:54:01 -0700
Message-Id: <20210702035404.397853-2-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702035404.397853-1-mdf@kernel.org>
References: <20210702035404.397853-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

warning: unused variable 'altera_freeze_br_of_match'
 [-Wunused-const-variable]
  static const struct of_device_id altera_freeze_br_of_match[] = {

Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
Cc: Tom Rix <trix@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/altera-freeze-bridge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index dd58c4aea92e..7d22a44d652e 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -198,11 +198,13 @@ static const struct fpga_bridge_ops altera_freeze_br_br_ops = {
 	.enable_show = altera_freeze_br_enable_show,
 };
 
+#ifdef CONFIG_OF
 static const struct of_device_id altera_freeze_br_of_match[] = {
 	{ .compatible = "altr,freeze-bridge-controller", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, altera_freeze_br_of_match);
+#endif
 
 static int altera_freeze_br_probe(struct platform_device *pdev)
 {
-- 
2.32.0

