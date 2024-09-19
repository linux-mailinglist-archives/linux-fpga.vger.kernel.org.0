Return-Path: <linux-fpga+bounces-716-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E30B97CE80
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 22:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239572830D0
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A2A1531D6;
	Thu, 19 Sep 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nj4UfAMQ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61114E2E1;
	Thu, 19 Sep 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778109; cv=none; b=Nj2WJRd7HZPhj9sNlB2sr4GdO2VDq68lIVLCFZQNFY521nWujVYCPCvCyk3mF7xn2ENjuzkqvMNtSHHgAmFn7zjFGPkOR/05ofkYyiIYSlA2jXMCkEam12lGLsXAWf+i0G1dQ56Obfkx3u54tSK533KWyaLWVmVgZSp2RvLjqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778109; c=relaxed/simple;
	bh=G6yi6OBInB4Kt5f39NnXenJh5aR+D4w/IosKRGEAtpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBsWnYdrywCDoc4AYjAe9Mu1jISE6zdOpUzWES5l8rmSVAY5Bo46nG3TAhjijIbpe1rgavza1yeb6T6TWsQbSf3xmXtma6p/D0Is2m/pVEFQRGp8hc3IpFMOaYCUgI9e5nSoFYMVMgLxRjAsmadkMWkHPw5Qhb/wG+mII5gVhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nj4UfAMQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726778108; x=1758314108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G6yi6OBInB4Kt5f39NnXenJh5aR+D4w/IosKRGEAtpg=;
  b=nj4UfAMQXW4p2oWFqsTY2M90P2/Hbv/tl7ZSgNKDl6/bvbGoba5iwGyb
   s3pQTe85sMw56J2acn7ofCRHVfRRMLwmsIANwebeUDUGHGpRKJ2OmoTbq
   T1i09nEvLbqNotFK5zk8J7IYVbJZVc/6jiwI+TO53sQN7Z0EdGm6+wY2L
   s738+kahV/fPEIWbZU9SUqZd7fflI/a+uwrtwN9B/WoxcyvqPJ9NOyRfu
   1/fjRdPy1jhmttpxO/9Jl9o6kEkLfxMnfsieilDogaIW/+PdH0UpqYwU7
   DPDvF5fPPxanHyRsuWg8yT+Kx2eHws1hQ27Og32JeHMSYae+jEdsv4Nb0
   A==;
X-CSE-ConnectionGUID: hBduQWPWSDaIvgZGpYd0XQ==
X-CSE-MsgGUID: KLPRCLwtSrCt+ftC7Ct0RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25912947"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25912947"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:06 -0700
X-CSE-ConnectionGUID: x3dO0U62R+WLswTikSyWXg==
X-CSE-MsgGUID: R98jBxpXQfWhDfb6Vu5nTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="93338324"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:05 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v3 3/9] fpga: dfl: afu: use parent device to log errors on port enable/disable
Date: Thu, 19 Sep 2024 16:34:24 -0400
Message-ID: <20240919203430.1278067-4-peter.colberg@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240919203430.1278067-1-peter.colberg@intel.com>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AFU port enable/disable may be triggered from userspace at any point,
e.g., after a port has been released. This commit prepares a subsequent
commit that destroys the port platform device on port release, which is
then no longer available during port enable/disable. Use the parent,
physical, e.g., PCIe FPGA device instead for logging errors.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl-afu-main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 6125e2faada8..c0f2db72b5b9 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -60,7 +60,8 @@ int __afu_port_enable(struct platform_device *pdev)
 	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
 			       !(v & PORT_CTRL_SFTRST_ACK),
 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
-		dev_err(&pdev->dev, "timeout, failure to enable device\n");
+		dev_err(pdata->dfl_cdev->parent,
+			"timeout, failure to enable device\n");
 		return -ETIMEDOUT;
 	}
 
@@ -99,7 +100,8 @@ int __afu_port_disable(struct platform_device *pdev)
 	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
 			       v & PORT_CTRL_SFTRST_ACK,
 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
-		dev_err(&pdev->dev, "timeout, failure to disable device\n");
+		dev_err(pdata->dfl_cdev->parent,
+			"timeout, failure to disable device\n");
 		return -ETIMEDOUT;
 	}
 
-- 
2.46.1


