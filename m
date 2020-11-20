Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF332BBA51
	for <lists+linux-fpga@lfdr.de>; Sat, 21 Nov 2020 00:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgKTXq6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 20 Nov 2020 18:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgKTXq6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 20 Nov 2020 18:46:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E6C0613CF
        for <linux-fpga@vger.kernel.org>; Fri, 20 Nov 2020 15:46:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w8so13844905ybj.14
        for <linux-fpga@vger.kernel.org>; Fri, 20 Nov 2020 15:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5uh+PylmkNxXuAdVHU5SvFd12dZOCp0wIVK8TNXkHmA=;
        b=Xg2aFlLYEUx1yHv0k78DcyOlwJ6puAYOCjBGjiXBNLn0wJnGveAMHKsrRk35eSXBbt
         IySmZy7bXkR6dOjnsULEk/4Sx+tpESe+xs2m1pALdZzMhNAjWJJatrAXddOPMkmij8/p
         L9e2jqDcpZozWgvzN2fFPQFuvnu3X+UJMs2TTADDq10/drtC+dsJ4CIE1710dGmx0Pbf
         VYFDZNnSD/IFSWDAwlB45SeXja+wgKlF7RuVjQfjAdXRxc/6f2UK+yY5NjDxMrWUbYeo
         SYXzI5iBSiXCb8Ax98x60kwLAORk7RwGJNjSuPQPbPQO4KN+jGEGlV8uxAzi6K1vC9BY
         p4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5uh+PylmkNxXuAdVHU5SvFd12dZOCp0wIVK8TNXkHmA=;
        b=awn4I1gZNOm1NPh8gPfItZTYVyTySYpb90SIw9xDvV/oe8ROtASnmssr/53PZLhM9V
         SX+p6m3/iYJCNvIrZCXfBlN+uC7iInFablaS7hX7AXySArDcwI+A1uQj94mWtZYzWa7y
         RoeiHJ9zs79QEV1/Z9jFcOpM5g1snJ5DKwr16J1oHOV396w7l3kmhPNtPuhSN60TnUGM
         q3jyjZ0K9GCkp+QlkuIESW24Qybgc5JFDRf1TXXyaFX68wPfCVZ3LVCQUrhsHsDIRDrq
         rlsUj9A4hj+4iNkbCN+XW+NPWNGAizRkDPFv6BYh9DSL5+rl/zNCazmkM7v8EFTmk5xV
         TjwA==
X-Gm-Message-State: AOAM533UtCYqUMle8GTU1VnXVMOc8vS5RojptPG7TY0MfLhf3for8/5c
        c2fJf+OEGhqmb3TQGzipinjdQtsejqz1zg==
X-Google-Smtp-Source: ABdhPJwrtyGDCkqpaR+qNYk8jG5k7OxUoYzGuCPssdJyJNCYzI4HxqCvmhHAJlwI1RGuUgAA9I2rVqshbenXfg==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:2a0a:: with SMTP id
 q10mr34014168ybq.453.1605916016059; Fri, 20 Nov 2020 15:46:56 -0800 (PST)
Date:   Fri, 20 Nov 2020 15:46:48 -0800
Message-Id: <20201120234648.4050910-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
From:   David Gow <davidgow@google.com>
To:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>
Cc:     David Gow <davidgow@google.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
functions, it should depend on HAS_IOMEM.

This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
HAS_IOMEM.

Fixes: 89eb35e810a8 ("fpga: dfl: map feature mmio resources in their own feature drivers")
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
( https://lore.kernel.org/linux-fpga/20201119082209.3598354-1-davidgow@google.com/ )
- Add Fixes tag

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
2.29.2.454.gaff20da3a2-goog

