Return-Path: <linux-fpga+bounces-896-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5489B12C3
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2557F282F7F
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE732214435;
	Fri, 25 Oct 2024 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nu020YXP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671620EA27;
	Fri, 25 Oct 2024 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895860; cv=none; b=ZoslKDqOIhgU6zwZaqCbjUNqi3QqykcAxyVIoO1myiPOFAFgFeXviCvCrOa7gzvt/MaC7f5DMQAHISdt4Ynvq7Vv0PXuC21yyleVir0lBd8+XzGdBT03AkHUp0dgnYSk/Onj2zV1Pe5kPs1gYGbMPJoQiRKRUa+pJY3ArDPpBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895860; c=relaxed/simple;
	bh=TIhPf4gICUkQlHeW3/dFU2F3Ui/ikGZEwT0j5BenxZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogjpO8JYmvT78rkbUbwUdssar6gm80Ikv5AEfQCi+/hVz6cbyOGcwWSby0bgYdPHXlpZEngb8TYOp2lKAmRW0wFwjcdKHBf6MkL6ymMeFjbm0E3IVTfojgDuzl7KzPiS25il4Z10ajvy/xZnaTlY6pVN1RsSKQXW/5by00Wuhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nu020YXP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895858; x=1761431858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TIhPf4gICUkQlHeW3/dFU2F3Ui/ikGZEwT0j5BenxZo=;
  b=nu020YXPgApI4VvRKYYqH+25UkCfX7NwZtgTnO0PFlhvJNNJQHVk0JoP
   7StNQTcxNdaqvTu3iaV03lmEXv+pVLRuwD2K/xG5Ow5tv4IVRp7wAFj0n
   rlisRlmOAH62PEOfcLq1xvymvSumKnJwnonfsT1Rlw9dwQyNHUTvXkZ6N
   k6uwrox+MkHWvMurXHH0wM8YXnsDtUjysQMDoTGNs6HbiuXq7IodPKj89
   pW/drcfv71BaKECUXqmK6SUA2WHJFY4w3cZwrMXmgy4u6DfHFzrILMJTy
   SE5iTYIO5WbPIIIaIJjysevwtQyjBpTITjcPZwz5YFrmpEpAwVbjOizE/
   g==;
X-CSE-ConnectionGUID: wxXPY2MWTB2afRqTl7k3hw==
X-CSE-MsgGUID: 2Bt/RGEuQPWvb6cD4/aYkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474628"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474628"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:36 -0700
X-CSE-ConnectionGUID: 8Vmv2uZYS9yXTdR0tvfu/A==
X-CSE-MsgGUID: LTqm3GKNQlqBVFjMiBnP9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596138"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:37 -0700
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
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v4 03/19] fpga: dfl: afu: use parent device to log errors on port enable/disable
Date: Fri, 25 Oct 2024 18:36:58 -0400
Message-ID: <20241025223714.394533-4-peter.colberg@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025223714.394533-1-peter.colberg@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
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
physical DFL, e.g., PCIe FPGA device instead for logging errors.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- Replace "physical" with "physical DFL" (device) in description for
  consistency with other patches.

Changes since v2:
- New patch extracted from monolithic v1 patch.
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
2.47.0


