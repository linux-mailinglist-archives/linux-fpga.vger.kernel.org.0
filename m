Return-Path: <linux-fpga+bounces-908-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38109B12DB
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313A31C22070
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD96421A4CD;
	Fri, 25 Oct 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QptZXaPd"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016721892A;
	Fri, 25 Oct 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895873; cv=none; b=jfKgaD6PXUpV4xPNy9lo7KUdejS90SQiGPtZIebszFzH4b4ifw25E69RezvatXeJkxqDnjEprRDvm7FlZz0WnZryswQYgiphxebsVIzwydFK1sDjPJ5GwmElq7kzELn+9eul7lxJ6H22GyphWNxlZDJh05aDnblL/r3Nr9d1cg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895873; c=relaxed/simple;
	bh=1Aldk6OwAk6MF2c/Uszuz7+5CQKGrzB6NlRJ6uC/Ksk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT4VTF8AoPVMvwpBGpF+nZYSGHd/o6SCvTsqHu3DivFb9GK1LQqRRbYW1283z2blXyNdfm3wlIh1EcZpC4bPqryFiOFMEt3ynncELJj6T/bPHzVKp9KTT3yQIZnzjFGlfxZ9B8CrrDZr2AmAnJG33uAgRr1XAHINaxmU4IPhFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QptZXaPd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895871; x=1761431871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Aldk6OwAk6MF2c/Uszuz7+5CQKGrzB6NlRJ6uC/Ksk=;
  b=QptZXaPdWk/raaDTfV2nfW1ew8leQycE7oILrlF72tX+qkQhxBhYR4Ll
   MlFU/533PZzogB8cHjcU4zosPu87jM9HgEPD9a4HdsrIUrdNZ42hTKJPX
   1/5NL+KAYpA5Mk/LtEhJKuJ2J1bsyWXPz+fyW/4BxEEpvbwK2+fUndLMm
   zQ95RYLHypoBZJ7JXL9RjfpB8M9m3Q2fHssz2Mw/p7tYVom4t32NfoC8+
   UPTQuaRhZkWIr4SEKd4fQYj/H/Cr+qkzPxaKRFymF5cCCtf+a6qHdnYW4
   wlZkrwbtntw2CBi+ARE5F8MZubHebOA1rWhatzys4r50NH4EcI4Q6NQg7
   w==;
X-CSE-ConnectionGUID: JCs5AI45Q+SH58l2TAEwzQ==
X-CSE-MsgGUID: doq0Kt28Q5e+xmKeZiawRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474678"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474678"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
X-CSE-ConnectionGUID: lTxzzo4AT7C5DR3WgXe1hA==
X-CSE-MsgGUID: 3Fib14CEQ/G+eugeWxUtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596182"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
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
Subject: [PATCH v4 15/19] fpga: dfl: convert is_feature_dev_detected() to use FIU type
Date: Fri, 25 Oct 2024 18:37:10 -0400
Message-ID: <20241025223714.394533-16-peter.colberg@intel.com>
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

Use binfo->type instead of binfo->feature_dev to decide whether a
feature device was detected during feature parsing. A subsequent
commit will delay the allocation of the feature platform device
to feature_dev_register() and remove binfo->feature_dev.

This commit does not introduce any functional changes.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 758673b0290a..a9ec37278b2d 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1248,7 +1248,7 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
 	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
 }
 
-#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
+#define is_feature_dev_detected(binfo) ((binfo)->type != DFL_ID_MAX)
 
 static int parse_feature_afu(struct build_feature_devs_info *binfo,
 			     resource_size_t ofst)
-- 
2.47.0


