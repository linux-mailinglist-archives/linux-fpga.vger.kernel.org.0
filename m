Return-Path: <linux-fpga+bounces-583-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8DD93F30D
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 12:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DCC1F214D6
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6652F5A;
	Mon, 29 Jul 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="W2Lj+x3K"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211B7603A
	for <linux-fpga@vger.kernel.org>; Mon, 29 Jul 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249812; cv=none; b=e165DC9uluOOQW+1DRU4z/WYTO0E2hfneBgsbQv0hOpRD2MRd+SNemxmM3ugnHTiEjwCntdM0+NWUZ7apRo4o7E+w9+s0F7UM3udRqa6I+w91DkHQFZIVuYtrHryq/XUft4mjClI0hr88TCCpSZn9CMz/pWWCZwv1Fiv0rAXW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249812; c=relaxed/simple;
	bh=VNE6XAhuezcJF2rshSVxPglyAfXKBkqHlj7by9x+EzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HerB3v6o4sKQducb8LX+A/jXoAPhBIF+h/+uWtF264ZhHgurfPWaJ0T7wGVSgHakcBlxBFgAK3WuQcPCuYt3oJEYOY0NjEExbU2PouDcjRO12lnh68+p36Pj17jalFIYSt1FRuq7Z3cH4TR1LwFKGnxTp4S7CiD2pY6zGp8wB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=W2Lj+x3K; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=ZTpB+5mktez89Y
	xP0809+lLeKO+NW6i9cQIMPjxqWUk=; b=W2Lj+x3K0Ymq66ik2KFwvLlOM4AvaN
	Acx+4y5FSUIkSmxp5TIF1Ib+fpqqLIgvh841TsbAgKfCQzqh8NU5nkiIheVe/Tw1
	5MG6+lVLrZtoeHTRyP7tlzMCBAr8PPxWFSAlUhSPSr3jLz0a5XfXYd/3PUhZnksB
	GprOhWvrREK6uMuSKHnPzw4r3Txj8YdbTPZ+NnX2c7bnYqD3ztTcY9RRs/ig/e7v
	WZAYCZcvR8PbaLtyyCEDLXZD50LDGw/8WyXRPsuGCjprFjd1eTs44TTPSwvqJzf8
	I8Orlcj5fiDlPYUojNDQ+1AvKR8lxelZ4zDJzr+x0xoJib5/XOiu8d9w==
Received: (qmail 4072128 invoked from network); 29 Jul 2024 12:43:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jul 2024 12:43:24 +0200
X-UD-Smtp-Session: l3s3148p1@EUDRh2Ae0uEgAwDPXxLGAIH3oZkcU6AS
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-fpga@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v3 1/2] fpga: mgr: Rename 'timeout' variable as 'time_left'
Date: Mon, 29 Jul 2024 12:42:22 +0200
Message-ID: <20240729104319.2658-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named
'timeout' to store the result of
wait_for_completion_interruptible_timeout() causing patterns like:

        timeout = wait_for_completion_interruptible_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the
code self explaining.

Fix to the proper variable type 'long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v2: reworded shortlog

 drivers/fpga/socfpga.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 723ea0ad3f09..b08b4bb8f650 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -301,16 +301,17 @@ static irqreturn_t socfpga_fpga_isr(int irq, void *dev_id)
 
 static int socfpga_fpga_wait_for_config_done(struct socfpga_fpga_priv *priv)
 {
-	int timeout, ret = 0;
+	int ret = 0;
+	long time_left;
 
 	socfpga_fpga_disable_irqs(priv);
 	init_completion(&priv->status_complete);
 	socfpga_fpga_enable_irqs(priv, SOCFPGA_FPGMGR_MON_CONF_DONE);
 
-	timeout = wait_for_completion_interruptible_timeout(
+	time_left = wait_for_completion_interruptible_timeout(
 						&priv->status_complete,
 						msecs_to_jiffies(10));
-	if (timeout == 0)
+	if (time_left == 0)
 		ret = -ETIMEDOUT;
 
 	socfpga_fpga_disable_irqs(priv);
-- 
2.43.0


