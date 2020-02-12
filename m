Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F76915AAD3
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2020 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBLORP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 Feb 2020 09:17:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53861 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgBLORP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 12 Feb 2020 09:17:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so2465622wmh.3
        for <linux-fpga@vger.kernel.org>; Wed, 12 Feb 2020 06:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LwGwjsE161QKaZxxfEh4p9giXbnfmZYI+gQ4RyZqzRM=;
        b=xpJQ2n7iz3OLop+srmqVp2xSid1hQiWJDRkGordH3NJI4gVP8vUI2quU2a6zuNQSYa
         t4Z1/XOYIoSsMaBXCv2IijvHQUQJPKZ9kVXYnT9XLAUMP35zDq4hg3782+qQ0/CawA6/
         p4GQxTXeGQ2+A8PSpFLlQEvjvaHxCwj3gRbSvcGSEAmQALt3RduFAYJA8Y+wJS4Bl4qp
         ipvNXtNbEw0f5/VQsmyE5rcooarTlpfk0RCLk283wzNsOTX+wis4pkhoWL6YLLuxc5ro
         HxA7GVpdisDLuGREK0xGlPhrhq+l3+4wdvsy4acQTHRyvg29vO2vRiq2HswKiKS3AAKw
         UYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LwGwjsE161QKaZxxfEh4p9giXbnfmZYI+gQ4RyZqzRM=;
        b=IFQLCrHw5AnALYfTN13AhEIoiQnI6pelzflv7KPmeuZ77EC2F7MKXf13C1bZX7JB4j
         Y/INWqrDWnJSJ/nJhgpHSl/r+4hTTZcK3ShHZL+qpN/evshy5mIB+SgaMtj9V+BuKdUG
         aNCVw7UNG5MP+nZm1sAvJNY7ra7AwGbs0jugZci5LsYiXfS0JXRglL9fKeLXRskcWPYM
         dUnDmsYLItLnVidh0Ic/i/MB9qbxrzII6P5vBgRZurdz4Z/mNcoh5Bkc7gGm6G0RmkT5
         IpECDleyfhbcKaQ74QvdIXZOQUIg9encNceF2i+XtJoHzIW4t+HARmb6z1urkWU1Bbsx
         B09g==
X-Gm-Message-State: APjAAAWSM8Udvy7A+Tk2NaGBtX0AtnQLXQHlgjqzOn8Wi+cqzgdqmOUd
        0dWvOe546EKR33JEWd9jBuQPQg==
X-Google-Smtp-Source: APXvYqy5MQ0xJFtURF5infE1DyoAcLJYC9xHBVxAmBgueHqbGr4Q/KMtujLl9eu7440cf5BIeiY7qg==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr6708371wmd.163.1581517030745;
        Wed, 12 Feb 2020 06:17:10 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id h2sm826355wrt.45.2020.02.12.06.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 06:17:09 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
Subject: [PATCH] fpga: zynq: Remove clk_get error message for probe defer
Date:   Wed, 12 Feb 2020 15:17:08 +0100
Message-Id: <0060e55f0b8d3a57e129d7eb096267cc96eae846.1581517026.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In probe, the driver checks for devm_clk_get return and print error
message in the failing case. However for -EPROBE_DEFER this message is
confusing so avoid it.

The similar change was done also by commit 28910cee898c
("fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer")

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/fpga/zynq-fpga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index ee7765049607..07fa8d9ec675 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -583,7 +583,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 
 	priv->clk = devm_clk_get(dev, "ref_clk");
 	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "input clock not found\n");
+		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
+			dev_err(dev, "input clock not found\n");
 		return PTR_ERR(priv->clk);
 	}
 
-- 
2.25.0

