Return-Path: <linux-fpga+bounces-547-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7AC91035E
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 13:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C441F21B75
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20891ABCC3;
	Thu, 20 Jun 2024 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Gqa7xL3w"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D41AAE2E
	for <linux-fpga@vger.kernel.org>; Thu, 20 Jun 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884230; cv=none; b=cjI40i4udC0GaDlgePD9HVi8YteifXrJF2VTTgQvueEM0OEbtVzEPn67TRupHi8gUpoTeZ9eR3zpjWLVLyAzg787iZM2WUwgHxcqUXfk31xRHh7+/W003u6iYbph23JLLPzVh+eemG/3BnVf5fLNsljwDnB/Bh/wgE0lS+QZsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884230; c=relaxed/simple;
	bh=iOzVDw446sjQ+BfSiKI2J7kMH91mM90U6cJySi28zac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+o2G+NRURz1c7J7dLHQw6fW1Vy930utwxIZLmGirNno7aBULXkcZJl+p+CrW/qME8QGZxVJfPBborr0+8e/c7/BVX6eDOhlge16PRKknAaGDZ9giMHKvdIEf1m8eCxsNC3rzWZkLN8GWa53FIRNu8FPoOp5P2idknLHty/Sjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Gqa7xL3w; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=hhjBD+ima6QVHIrHeWwX9nW5Tqwsw/JyzTU2SbaYaPA=; b=Gqa7xL
	3wzoIEK1N1y4BRR/HTbfsx9hVIkHOj7ZNq8QOmeT10XtxyONiu3clghhsrqyW1p0
	tR8/kbcQLkFW0AryJJzT4TvU+BI97J8cTHBl1MwVA5uTkYgxpwsyA9VFD0FkNp3Y
	ju5tdUp3RRtljL68wkXNVQKsGjm3oMwa6dn/9h7CmIMazCEoE9y2r49MDSK7/niw
	7jbsEde/C1eg/7i7HQv6y0GsOu7Rw+xlYYPs9P1At/WFikBkZAMgvQczRcR38i8M
	6If5LFFsJShsiLqzujggiKcqNKw+fKwuPpgTpym9Ox2FusxXSucrs0rYs/wquN2h
	W5z0VrvUAHrxk7/Q==
Received: (qmail 1002798 invoked from network); 20 Jun 2024 13:50:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2024 13:50:24 +0200
X-UD-Smtp-Session: l3s3148p1@C/+b61AbzpMgAwDPXzjQABqqX1QYyOSW
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org
Subject: [PATCH v2 1/2] fpga: socfpga: use 'time_left' variable with wait_for_completion*()
Date: Thu, 20 Jun 2024 13:50:21 +0200
Message-ID: <20240620115022.24409-2-wsa+renesas@sang-engineering.com>
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
'timeout' to store the result of
wait_for_completion_interruptible_timeout() causing patterns like:

        timeout = wait_for_completion_interruptible_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make
the code self explaining.

Fix to the proper variable type 'long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1:
* use reverse-xmas-tree for variable init
* keep chars/line limits in commit message

 drivers/fpga/socfpga.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 723ea0ad3f09..f772b754aa76 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -301,16 +301,17 @@ static irqreturn_t socfpga_fpga_isr(int irq, void *dev_id)
 
 static int socfpga_fpga_wait_for_config_done(struct socfpga_fpga_priv *priv)
 {
-	int timeout, ret = 0;
+	long time_left;
+	int ret = 0;
 
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


