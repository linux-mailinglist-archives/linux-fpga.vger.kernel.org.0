Return-Path: <linux-fpga+bounces-952-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6DA9D31AC
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2B1B23E8E
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8673460DCF;
	Wed, 20 Nov 2024 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cH+vutvT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02045BEC;
	Wed, 20 Nov 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065101; cv=none; b=prGBzKl7jGweGBGbeXu6AYBNZ2KRtIxrmMxeQOt7XQFrz/No0Q4MQO4Lr92g6dL+jNlsd4SlWCNtfE5o76Qv5RoPJ3X0lcHsJ+6tHf4C3ZFpF4CzybbUPZS4YszYyyx26lurL50JlEf4jDLUVKuNfyr9pvVetvJmTyB2Yk4YKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065101; c=relaxed/simple;
	bh=3FS3Nb1TRN/BBL2lkcEJ0LrrIU13wBZn2sLRF6rAmcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJkGCOFdoHBZhsQcaz9Sd7/HkcpJMV31MoU+dF2qomN6WnlWHa3jX8LoICzG9+36KoTQfkHhi1bbicjYZyv6ebmXad2qfbboAiu2rSR/wVN4n2DmUexhqTufxOBW2/W3496XCZGr8vtK9OVNq9LNAbjujyW3HfCJ+oS3Sklv02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cH+vutvT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065100; x=1763601100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3FS3Nb1TRN/BBL2lkcEJ0LrrIU13wBZn2sLRF6rAmcc=;
  b=cH+vutvTIhdOBsb5kqBoFKczaUHaDY64Uvbn/+Uno9sq9QJ20E+NXXJU
   jhlootq2J9JFGTxWZPKz2Hquocvdme2aZYd39fREPxI5jByQrW86seqq/
   MibN0IAe5GTSDyd0bzepr6rm5+zKaPWdqKiXCaO4gLvD0EzKuhC35WKRG
   f9e+0s0ZIG3yz5u4YWytLhnYmZAVCQbtYEHoejioCKtRVi6Y21TCNiasf
   xDQM4GeCitMFZjDgwcSHa1YneWbIA+pY6/+tRQWytYUz5FEYRrOfNuo/p
   FZfmwB5teZGW5SVGxw+l+wsk2w+Rjut01VOmzWJP3UQAcZkClfE5zh9eg
   A==;
X-CSE-ConnectionGUID: qy6t2anQShGsMDiPpBeQ7A==
X-CSE-MsgGUID: Sm1OELT/RR6kR+a6Zwee6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42612972"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42612972"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:39 -0800
X-CSE-ConnectionGUID: RCmNvFYbRmCKMFRMcHKzOA==
X-CSE-MsgGUID: wsa9iQ8YQZyvoJ4B9OX+nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813572"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:39 -0800
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
Subject: [PATCH v5 03/18] fpga: dfl: afu: use parent device to log errors on port enable/disable
Date: Tue, 19 Nov 2024 20:10:19 -0500
Message-ID: <20241120011035.230574-4-peter.colberg@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120011035.230574-1-peter.colberg@intel.com>
References: <20241120011035.230574-1-peter.colberg@intel.com>
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
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

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


