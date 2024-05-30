Return-Path: <linux-fpga+bounces-536-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4698D540B
	for <lists+linux-fpga@lfdr.de>; Thu, 30 May 2024 22:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47AA1C22C9E
	for <lists+linux-fpga@lfdr.de>; Thu, 30 May 2024 20:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255617F4E0;
	Thu, 30 May 2024 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gywXmoA5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348017F389;
	Thu, 30 May 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102376; cv=none; b=s++smZZaVSFI+gzNP5+44apl/s3f5DoZtH8je4kFLFc2Dbv99YCCGd6GBY4tNbCrvEV9YeoaooxTEma+oTxblsviFi0C3ed0xikkgCL44+BejH6a2xHQvkSqfbseoRUxMOn1u02dATS/miMKxiaZja5ZuPFBx0XzNO2bHvptcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102376; c=relaxed/simple;
	bh=v1t3bcwh1RL6LWmOFS1e78KKbeW/7EkaRNrtN7aV18g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4xH4PbZJOKGCffjEJKz/x6TyACFybEo+djxoN7vfAy0ePjrqyOz9WXp0DWs79eKgpZVmdoSJNF8Ybh+lCmMaPFDZH9Vx1ej9nGbOxE8YhsIE1iseZwlxbAvMgSMDa3jT8ohRh62zwA4PLk0KpLtrHGTOCQNNiBxJ6eRULCbFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gywXmoA5; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=rXAB2+WF8BwUdxgU9KjiQNXT75UW2gSVnSYkTrjovNU=; b=gywXmoA5bV2SAtBd
	SNcCTR7mpkVvC8Ocvl06U/1jifmH8pLYkj8m58SiuEyeq2lHBAg5VqDMkwwCb557fJTEQafleQCIM
	aQw1IkYy+qKtxVeOrW24fqbZjf42jk26aEfztcmlXZRGpan1VBvHrvRvX04BIr6jhiTz9erFqh09x
	Ie/AIkD4lsh8VilhgYFkoYNErBnKVspmVc+v/ABT0Mx7OpqXS2YtrTtH/BgXMzoYc3iWgJOcnzzHf
	i44aCKqbKZesWqatdbKmqbScLhPxnzr4YPf25APaGJrujnfFv3xhbLCn+XMsF9FzXqKeT9GkF89NX
	ZOC/HTws/+pYH7uF4g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sCmlT-003RRb-2U;
	Thu, 30 May 2024 20:52:48 +0000
From: linux@treblig.org
To: mdf@kernel.org,
	hao.wu@intel.com
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] fpga: altera-fpga2sdram: remove unused struct 'prop_map'
Date: Thu, 30 May 2024 21:52:45 +0100
Message-ID: <20240530205245.125513-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'prop_map' has been unused since the original
commit e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/fpga/altera-fpga2sdram.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index 6b60ca004345..f4de3fea0b2d 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -75,12 +75,6 @@ static int alt_fpga2sdram_enable_set(struct fpga_bridge *bridge, bool enable)
 	return _alt_fpga2sdram_enable_set(bridge->priv, enable);
 }
 
-struct prop_map {
-	char *prop_name;
-	u32 *prop_value;
-	u32 prop_max;
-};
-
 static const struct fpga_bridge_ops altera_fpga2sdram_br_ops = {
 	.enable_set = alt_fpga2sdram_enable_set,
 	.enable_show = alt_fpga2sdram_enable_show,
-- 
2.45.1


