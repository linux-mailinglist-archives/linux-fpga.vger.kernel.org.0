Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD6C2B8CFE
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Nov 2020 09:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKSIW0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 Nov 2020 03:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgKSIWY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 Nov 2020 03:22:24 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A231C0613CF
        for <linux-fpga@vger.kernel.org>; Thu, 19 Nov 2020 00:22:24 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id e3so3465520pgu.1
        for <linux-fpga@vger.kernel.org>; Thu, 19 Nov 2020 00:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=FWN8vtpAUFSliD9r5qA234EvoKipyGx7znJTwH2RLNs=;
        b=iIo8gAb97kW2uaKXeJVL/GC07Lv3WshoQvzkpZdc4y57wIoJ4Y0ChoKojRuwjDxmx0
         rlPtBF5nNSyMo+jvEtIhMp7647de8++C4cC00wIN8cEoE3tBoWwqtIPL0e2jkjoFsV+a
         31W8DWRA1IEHuy1yINIlT6ypQCQj2nfg8Cnd6vizjfjlwI+kAhoEtAuEsKOpaLv7WsuA
         bxoiTckskQM3jWzKZR4NgoqrYqedoZKseAsh7Vgdi89LxZm4rs98479B/vsPbUrvE3ha
         U7VedZDxU3AiPH/wEzNSW8HMTtS9Sfy9kGmuKV1ynf86KTd6leuTMubYRGgp3Sp3d+LV
         8cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=FWN8vtpAUFSliD9r5qA234EvoKipyGx7znJTwH2RLNs=;
        b=hPQIHmEhKI6MHMqeFb23igb9ZdR44OqRJYs+ec1pK0YY9/bdC6npoMdShonltX/XmV
         d/CdJIBFD9cYup+BTBrTpRzvBV3qwZMIpGSIyvd4FjDy40Y/JE3wvNmknsYGHXH+6BeG
         8vdhpXEHqejJfPsyRrqwM4UZbAgVkNQP85iBHJpDxxIwMlhPQjZ9IOKZEIVjsteACQHQ
         bztQz8zoT9ZWPVfYDR9QysiDCN+FzPvOV1PM3SZDQQM015oN/ejTqoiqP/WDFf7cB2sk
         F4i9y74fwv1iDv3Fc9GIYREYG/yUSf6WIsKahor+Rlyr/RZoyRjwIRZYS0G5vn0Zxe0p
         c3bQ==
X-Gm-Message-State: AOAM5302ADgMnO67VpG4U6rmAeOulokFIXgbzN01kgVcHam76rPfOSeV
        Acuyngy2icQLN6zdhNhTu62nJLyBXJRIQA==
X-Google-Smtp-Source: ABdhPJz2LnxoPXoTAaPRQABbIQtfV+cePysfoy8t13zqC6H1e5lIKV6Kr3YbTCdsY2+ho1C7fej25tjmEsW+gw==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a17:902:6acc:b029:d8:c6ee:6d6c with SMTP
 id i12-20020a1709026accb02900d8c6ee6d6cmr7772518plt.7.1605774143537; Thu, 19
 Nov 2020 00:22:23 -0800 (PST)
Date:   Thu, 19 Nov 2020 00:22:09 -0800
Message-Id: <20201119082209.3598354-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
From:   David Gow <davidgow@google.com>
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
functions, it should depend on HAS_IOMEM.

This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
HAS_IOMEM.

Signed-off-by: David Gow <davidgow@google.com>
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
2.29.2.454.gaff20da3a2-goog

