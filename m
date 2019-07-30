Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B91527B1C3
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Jul 2019 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfG3SUR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Jul 2019 14:20:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41951 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfG3SQL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Jul 2019 14:16:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so30270990pff.8
        for <linux-fpga@vger.kernel.org>; Tue, 30 Jul 2019 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSxaD1cvDX0l0dBtzAMeJgIp940IH2B46uMy0iM1GB4=;
        b=dVuSDzMLTviKBGZ53KKiOY0XqYsOyAgG25J621ZBW6qyaxu0WMuC8HeQIxZkmWGKhh
         /EdV7NmqaIEZRNmikoQx4MADMjjEpHXudU1KTzY2LyXQu5ugIjzuQeTcWX5PgXyiVUEo
         4j3e25Qx8a+r6/FIMt2T10YU0KCfd/Gw/6R84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSxaD1cvDX0l0dBtzAMeJgIp940IH2B46uMy0iM1GB4=;
        b=EJrgjodL5Nxi9dpMb0cecI1snQ5o4R5bsszryARqbc8gzFmpHlvhrqormTl62HvKpb
         nucj/S3WMMBU83ee7+RFqovQ0mhNk3CKlxLxwbBEszKl8XtZE78hOMWG2l4mQvtJE9QC
         ZWXODdXKNqfPDPrgx1EVcW9BMIqq1r8HBeuK451OygX/3YuE90tFz7w1LIoq/xVOOKKN
         buWpegBUr9cNdba/e2eLuRMc8pMW5U4Kf/TbMDNX+AlxCrzg5A//qZfps5wx6wPCuF1o
         vmuxDARluDBEoJ7CpfGiWnxamJ4nuuARq6r1YTnZfKVBaFK6QZnAyymXrRmzE+P8wZ4V
         AqyA==
X-Gm-Message-State: APjAAAWb2Ehp6Datj7oleq4PMZEL8gc8EFmTBEapXSZveBjCH+7SeB58
        M4X4SSkvTmDgLixOWjqHiSg32g==
X-Google-Smtp-Source: APXvYqxSiEVJeXi09dB4/iinN17Ab01YAZHjh+BReb6f6qTSeScWj6ZV6UNPwu5NIoes1J0qimKkKA==
X-Received: by 2002:a62:1bd1:: with SMTP id b200mr42338409pfb.210.1564510571326;
        Tue, 30 Jul 2019 11:16:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:10 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 14/57] fpga: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:14 -0700
Message-Id: <20190730181557.90391-15-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/fpga/zynq-fpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 31ef38e38537..ee7765049607 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -578,10 +578,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	init_completion(&priv->dma_done);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(dev, "No IRQ available\n");
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	priv->clk = devm_clk_get(dev, "ref_clk");
 	if (IS_ERR(priv->clk)) {
-- 
Sent by a computer through tubes

