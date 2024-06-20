Return-Path: <linux-fpga+bounces-549-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2712910361
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E101C20F4D
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3551ABCCD;
	Thu, 20 Jun 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Vlt3Tn2D"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484B1ABCB1
	for <linux-fpga@vger.kernel.org>; Thu, 20 Jun 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884231; cv=none; b=rn4h5hwsraO2T1zve9Fo6DcgQXH152R1QMIju9KqI+I6r812htxuvFAsyxmEFkHp3cdeHDQrp6Uz2bc6sDbGEbidv+iHLFUad+jPIz9pkRXOeb9gcnEZUr6eEphWruyt+mCGfifZfqDrvHYcLRqkSbnXWP3K3FKj4XtP5YHXtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884231; c=relaxed/simple;
	bh=/fsDy/J5swdf4EmXOs+1OkO3VMutkagftRVjj5QTHnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCru5eOgFd76cxhJ+CreQvHBwZ0VtkoMSV5v1fX7eVRoob3E/QBupFJOuoK1udMLHqNGd5o267xHx27S8xhjfhBIrOdcwskWbrGNGZK1XNW0VrwDu4B4jQV0Xk70PZEsS28SHGNB9fBC0iEbkH70npdnmMpfRHie5be0Y/1Hyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Vlt3Tn2D; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=RwiFhKj6DSEa7VQUlcxMDilTp/jRlc2Dqj2vwVcpqj0=; b=Vlt3Tn
	2Do8jfLoK1eRL4FgWZISar4kfzMU8gde27BdiSj8lgTTxmhI3UJFq11TCRUvR6tZ
	Pbsq6E/E3CZBgfdazgX8Q1vjsi/qXow7oDmaf0Qd6dOambnNHXMmMasDxNAA3Ipn
	VT8megWPDDrnHORl3mVY7k4WpUImipilMeymCFdIi3WVy9kwFfJmUCTMtIIg/JkM
	5X+0MDgoErhr2Rppndy/u5YsghEhi70zSvfzGERH+aQqP2yE1SHxR2UA1uPF3Maj
	f4gTadjm+Nm6WVGltCVco4BB3Q0EI9HBlxm2xXT8zYR8OEqENAwRG98C38FB3Y1U
	4MYuFRmbtK6gkLAg==
Received: (qmail 1002835 invoked from network); 20 Jun 2024 13:50:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2024 13:50:25 +0200
X-UD-Smtp-Session: l3s3148p1@pg+p61Ab3JMgAwDPXzjQABqqX1QYyOSW
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] fpga: zynq-fpga: use 'time_left' variable with wait_for_completion_timeout()
Date: Thu, 20 Jun 2024 13:50:22 +0200
Message-ID: <20240620115022.24409-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620115022.24409-1-wsa+renesas@sang-engineering.com>
References: <20240620115022.24409-1-wsa+renesas@sang-engineering.com>
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

with all kinds of permutations. Use 'time_left' as a variable to make
the code self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---

Change since v1: added ack (Thanks Michal)

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


