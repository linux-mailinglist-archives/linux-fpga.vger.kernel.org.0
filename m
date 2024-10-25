Return-Path: <linux-fpga+bounces-894-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08809B12BF
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DD928319B
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2820920EA3A;
	Fri, 25 Oct 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CM7sD/GZ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F51D4148;
	Fri, 25 Oct 2024 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895859; cv=none; b=uJpGYjwcBnI2MnBv4ZwxwgiPPk2OExTm3OC+walTGsrmz+5JYiYrZDFhEn2EFI7HDjyGm1aiNfBVsJAUI/WiHZhKviSbLkGzu5JwiTNcwDyi/iBvNdqx6uBJ+x2qFFPGj4lzO2HOpN02wjbe1Ys57F/YOfHGe550K5lMt4MOQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895859; c=relaxed/simple;
	bh=IDSnJY7RsKjislw4CKrh2p9I65EaCS/4prjVLqvtiDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2wFtzB+Sx+hyQa3gWBcmwbUqvPX3eBRjyiRZdhcKcJj5fRG850wLb09JX0KnwhMOCq7hq1RWWpX2IwfrZuT3EgAdXUPo4jeOZxRIhFk2y3RAV9QEuLBhVwEV40UvStDMtXUQRlBu8o7ymIWPV/4XJoX5hnfRQ3OBaOtB5hgN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CM7sD/GZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895857; x=1761431857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IDSnJY7RsKjislw4CKrh2p9I65EaCS/4prjVLqvtiDc=;
  b=CM7sD/GZa+9CLxTsqzCCGCoj4rw3TQu3Qqr02w60pCcxGU6jhcnRapnT
   iHMQLe8fdRGv8NjFNT/uZJ62mthseyijw50q3aYyzL6ux/+ty1yDjiWPt
   JDT0aQMeAfAGu4X1ypkWCM9Mw09PfYrMD4iaLwNkiEfExtFN3PGBobu8k
   LsteDTGEj3R0NGFjbl9isAazx9UFOzd3l8rkpNA2k/R5mrqjzBmgi9glN
   RRuCV/4BjSupnMg8MuYQmJvrFLayPYu5joBV9jHvrj4jyJ2orEEP9jLTx
   z47XCWs6i1hX0qFYjB4wBWYP5unZbvOYLYITwJ3s4ebHkMiPJ2n7+4m9T
   Q==;
X-CSE-ConnectionGUID: KdZPFd20Sum5LQqiDPCIuQ==
X-CSE-MsgGUID: e07nVacLRzGnjQdqDHNvTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474620"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474620"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:36 -0700
X-CSE-ConnectionGUID: iP2gRJdkQiqNQDwAUAx8jA==
X-CSE-MsgGUID: jBUP6c7cSgatJZfCWgRx4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596132"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:36 -0700
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
Subject: [PATCH v4 01/19] fpga: dfl: omit unneeded argument pdata from dfl_feature_instance_init()
Date: Fri, 25 Oct 2024 18:36:56 -0400
Message-ID: <20241025223714.394533-2-peter.colberg@intel.com>
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

The argument pdata passed to dfl_feature_instance_init() was never used.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- No changes.

Changes since v2:
- New patch extracted from monolithic v1 patch.
---
 drivers/fpga/dfl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c406b949026f..8512a1da6570 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -520,7 +520,6 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
 
 static int dfl_feature_instance_init(struct platform_device *pdev,
-				     struct dfl_feature_platform_data *pdata,
 				     struct dfl_feature *feature,
 				     struct dfl_feature_driver *drv)
 {
@@ -587,8 +586,7 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
 	while (drv->ops) {
 		dfl_fpga_dev_for_each_feature(pdata, feature) {
 			if (dfl_feature_drv_match(feature, drv)) {
-				ret = dfl_feature_instance_init(pdev, pdata,
-								feature, drv);
+				ret = dfl_feature_instance_init(pdev, feature, drv);
 				if (ret)
 					goto exit;
 			}
-- 
2.47.0


