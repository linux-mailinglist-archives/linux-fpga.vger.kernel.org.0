Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B172C2BC2D4
	for <lists+linux-fpga@lfdr.de>; Sun, 22 Nov 2020 01:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgKVAP5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 21 Nov 2020 19:15:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39140 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgKVAP5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 21 Nov 2020 19:15:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id f17so2264785pge.6
        for <linux-fpga@vger.kernel.org>; Sat, 21 Nov 2020 16:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAYBk8rKdzgXh+F2pRCniTXRdc8Q+2yq0sxbqekn5Z4=;
        b=gZQpVcqLkA0M7QANRJIscaKsdNV0XvRMBB8TIurlRM6Bdy02i0/7/vYYqZ3bww9mYQ
         t70yFjUtM/kmIRlyXfWdMgyOeiTaGrBNzgM4Pje3e6CzLraCJe9ar3IkF4Z9YG7GbKl2
         xRAjItiHzcTJw42d458dUdaLypiy2MGNnTWKgJkXSL56THjGTfElmP1sg2p5OXuoMTpX
         dquHRa1TgX7BdktTcf/iSs2qceNxRWO16dNxlUB5HiAmt76onowQ75kB7KVdpuR0wV3c
         zx2fWTlwi+ew9vbOIh34vdMclu94f3u8Dl3lN7vsoH9mFweRCCjbllRYf+wS8euEr4e9
         9pKw==
X-Gm-Message-State: AOAM530+eFbWozFgCbMVMM/ZTaNqm72dFsnHj2sOMVbEIiSx9DeINfYB
        FtFVEN4ntxpFyclCIE/NN7I=
X-Google-Smtp-Source: ABdhPJw47IGnj8x/le+XujbUb2mK89oBnafHwE+ULj9Oy1lp43Pv0IBnAnBwemZUWWZh13gIETrUQQ==
X-Received: by 2002:aa7:82d0:0:b029:18b:d594:9dc5 with SMTP id f16-20020aa782d00000b029018bd5949dc5mr19741628pfn.63.1606004163050;
        Sat, 21 Nov 2020 16:16:03 -0800 (PST)
Received: from localhost (c-73-235-149-126.hsd1.ca.comcast.net. [73.235.149.126])
        by smtp.gmail.com with ESMTPSA id 12sm9355147pjt.25.2020.11.21.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 16:16:02 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        David Gow <davidgow@google.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/1] fpga: Specify HAS_IOMEM dependency for FPGA_DFL
Date:   Sat, 21 Nov 2020 16:15:49 -0800
Message-Id: <20201122001549.107023-2-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122001549.107023-1-mdf@kernel.org>
References: <20201122001549.107023-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: David Gow <davidgow@google.com>

Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
functions, it should depend on HAS_IOMEM.

This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
HAS_IOMEM.

[mdf@kernel.org: Removed "drivers: " in commit message]
Fixes: 89eb35e810a8 ("fpga: dfl: map feature mmio resources in their own feature drivers")
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7cd5a29fc437..5645226ca3ce 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -142,6 +142,7 @@ config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
 	select FPGA_REGION
+	depends on HAS_IOMEM
 	help
 	  Device Feature List (DFL) defines a feature list structure that
 	  creates a linked list of feature headers within the MMIO space
-- 
2.29.2

