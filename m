Return-Path: <linux-fpga+bounces-1297-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894F5B1C121
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 09:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55F3184899
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 07:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C691EA7CE;
	Wed,  6 Aug 2025 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9BWhP9W"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CE171C9
	for <linux-fpga@vger.kernel.org>; Wed,  6 Aug 2025 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464551; cv=none; b=YkuVUvkKVVFz4KlUdXTYUy20TNsgCWtvVjN4nDHU8UzGcIY51OFbureuhSw1B4zn7dO5CyWMSv+m47yDxWRG/Wt8VzDlJimwSXn2vefcEMDo1t0xduWlGEnHnxnioxogIt3jOfclHpEyE/SUXCLNfgl8rWgXppbrKXyfogD0spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464551; c=relaxed/simple;
	bh=aNOwor/28mKKCQPMhgi5fV+RJ7tEn8qfbzTyDcg08oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMLAe/OQAWY7324xv6aNon/YdCgyiU1cvLLm5GYtm3sGJR/keiYFGTp1v09ZBApr7JbKxm6gZEcte7fYLY+yQdkempBhJd46JlBGLK2bAzqlwoeRWqGFAGZor53/dVYJRso5dcLAe8+G0VetnWbs4fUX8xVjRkF6E4OOfhdeHgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9BWhP9W; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754464550; x=1786000550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aNOwor/28mKKCQPMhgi5fV+RJ7tEn8qfbzTyDcg08oc=;
  b=k9BWhP9W0wbXRhW6e7nkA68Y+LAY82yTtKspAWEo3Gcpv2zeDjh6C6qV
   JEF0Wyy8kWlgRXjfpfy2saWch0pGr2AgMV6rtk4wsLZwKeTlJIXaTT7o8
   GNA/QLoyilEloeFv+Cy8RUJLxHzcbuyCdbcrVL1GoPnbtcgpDTMiKDLWu
   o/N9hSDh56vrm9ZND2xloqmOmSPcGINqgMVpnnYM4aIgTEFbcL3oEuF+k
   HbfmicwItNUCqdwQyQPcJYdhNqtSJom7Qj4P8Nsmsiz9knjAXt2dtfwbT
   I2D+onRLnkCC1pfjkK8ILgi5JRyP3fqP9OhQ0REKB2KLK0qEGOeuW1sdU
   A==;
X-CSE-ConnectionGUID: S+Tmmz84SLyJUNA+E2MKOA==
X-CSE-MsgGUID: 2rY7hSoSQh2hpVqzAtuvRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="68147567"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="68147567"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 00:15:49 -0700
X-CSE-ConnectionGUID: XWihbK42RRSSFOl2HxExjw==
X-CSE-MsgGUID: VSORGXVUQPOEsjTdouyWQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="163952248"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 06 Aug 2025 00:15:47 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: jgg@nvidia.com,
	m.szyprowski@samsung.com,
	pisa@fel.cvut.cz,
	yilun.xu@intel.com,
	linux-fpga@vger.kernel.org,
	mdf@kernel.org
Subject: [PATCH 1/1] fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()
Date: Wed,  6 Aug 2025 15:06:05 +0800
Message-Id: <20250806070605.1920909-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250806070605.1920909-1-yilun.xu@linux.intel.com>
References: <20250806070605.1920909-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_map_sgtable() returns only 0 or the error code. Read sgt->nents to
get the number of mapped segments.

CC: stable@vger.kernel.org
Fixes: 37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers")
Reported-by: Pavel Pisa <pisa@fel.cvut.cz>
Closes: https://lore.kernel.org/linux-fpga/202508041548.22955.pisa@fel.cvut.cz/
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
---
 drivers/fpga/zynq-fpga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 0be0d569589d..b7629a0e4813 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 		}
 	}
 
-	priv->dma_nelms =
-	    dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
-	if (priv->dma_nelms == 0) {
+	err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
+	if (err) {
 		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
-		return -ENOMEM;
+		return err;
 	}
+	priv->dma_nelms = sgt->nents;
 
 	/* enable clock */
 	err = clk_enable(priv->clk);
-- 
2.34.1


