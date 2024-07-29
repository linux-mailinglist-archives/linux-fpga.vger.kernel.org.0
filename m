Return-Path: <linux-fpga+bounces-584-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174B893F30E
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 12:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85950B20A91
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E03C7603A;
	Mon, 29 Jul 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JAPkoOZ+"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12170143C70
	for <linux-fpga@vger.kernel.org>; Mon, 29 Jul 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249812; cv=none; b=dR9nFPklSa/xWKJBHsnSUv6BMBsSpIwhx9wVp5Xw2yVZJfbaRr9tha6+q05TDRGOadDuvl+WLfOYr3Vc/y10bJQKWByh4KjTVY1vyF2npcs0M6d3E+jl7/cvaI53wifPukU5xBDCHJHxROzg64UOuUvLu2edn5dMe4gzE8xEK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249812; c=relaxed/simple;
	bh=a46opLhWXRISn0yHezknen5pt2VuyhwMrmdE03QNWIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvvKP/tcINDKU8PVbRn30Z5akj1GcuaGF1Kyiqn6vg6XigNOtM7YItGSpJQ7AerW/jYhH8YqlmYOPECmtD2Lk8szdmZ6XqqCo3Jovp443iT91yHIEsfkqEGdWnVc87V1VgmVLAhLqfxK6VND0g7E7a/pnUuyDxhs2ghUjHObI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JAPkoOZ+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=mNG1QcRukPbrV7A1uveNagm98lJhJ5wFJcz8A26m1zk=; b=JAPkoO
	Z+n2Ses9yaiTs6RuJ/aoTn2lpClzYrxffn8QaCwQ52pa76XVEeR559nk2rhsTEVJ
	CcNHxoBt9OhuiwD7jBXZrOUyXh2WQ+uvW6bFs+FG+DyxxKCvirPe3b4mJgesKNyI
	YmRw0dmbsfRyJ1jzdLz8VwtblHZXLdeAj51XPB8+8FmEDlfznkA3uP24+X3QD/+w
	9RRn9pZS0PMOxtghSxCFhm1op+oWBZpqN5A0DMV8avrxtBHPpZgQYC/q2ZU7ynnL
	IjcNYnaLRAv7uMJe8AYGwVtS4a3TGr8RyI0qTL4D0ArXVWsv4YD5tKpGXCyDbor8
	+Sct3XXY7UTvUGOw==
Received: (qmail 4072162 invoked from network); 29 Jul 2024 12:43:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jul 2024 12:43:25 +0200
X-UD-Smtp-Session: l3s3148p1@w0/dh2Ae1uEgAwDPXxLGAIH3oZkcU6AS
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-fpga@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] fpga: zynq-fpga: Rename 'timeout' variable as 'time_left'
Date: Mon, 29 Jul 2024 12:42:23 +0200
Message-ID: <20240729104319.2658-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729104319.2658-1-wsa+renesas@sang-engineering.com>
References: <20240729104319.2658-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named
'timeout' to store the result of wait_for_completion_timeout() causing
patterns like:

        timeout = wait_for_completion_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the
code self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v2: reworded shortlog

 drivers/fpga/zynq-fpga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 0ac93183d201..4db3d80e10b0 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -387,7 +387,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	const char *why;
 	int err;
 	u32 intr_status;
-	unsigned long timeout;
+	unsigned long time_left;
 	unsigned long flags;
 	struct scatterlist *sg;
 	int i;
@@ -427,8 +427,8 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	zynq_step_dma(priv);
 	spin_unlock_irqrestore(&priv->dma_lock, flags);
 
-	timeout = wait_for_completion_timeout(&priv->dma_done,
-					      msecs_to_jiffies(DMA_TIMEOUT_MS));
+	time_left = wait_for_completion_timeout(&priv->dma_done,
+						msecs_to_jiffies(DMA_TIMEOUT_MS));
 
 	spin_lock_irqsave(&priv->dma_lock, flags);
 	zynq_fpga_set_irq(priv, 0);
@@ -452,7 +452,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 
 	if (priv->cur_sg ||
 	    !((intr_status & IXR_D_P_DONE_MASK) == IXR_D_P_DONE_MASK)) {
-		if (timeout == 0)
+		if (time_left == 0)
 			why = "DMA timed out";
 		else
 			why = "DMA did not complete";
-- 
2.43.0


