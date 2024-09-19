Return-Path: <linux-fpga+bounces-714-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2EC97CE7D
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF5EB22DC9
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F5C14D719;
	Thu, 19 Sep 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cK8ofqHp"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B514A4D2;
	Thu, 19 Sep 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778107; cv=none; b=C3pOOFUS9aBNxiTggiUFstFy5aMXmuzNwdrYigXted6pigW+b7CjMAv1COFRnyQEXfvYfMEZr7xt3wJ2uVJTlgLdI+BoUqLlrWmtqfF+h6Ef+r0bYtxtKoiPsVO8dcD0XbEF/rHVYhtjm9CJomTxMfNR76a8MAIZ2/lbnDgJh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778107; c=relaxed/simple;
	bh=M/Ey+raeb9Xu9MDcS2B8YvQgV4TVAH8hLRAShm8GBsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6aMuVzVB3q7hEQ4owgBdFojCTeLd6KLnYKH4K2JzSuhynF4Anp6R70e9bm8LXNsRLos05/ANo6Artfkwyy6GkbRBencbNClcL1Hp17WcaWD6dK9sbdNx8UEVvyW8tYPkqP03mVEQsBZkhQ6nH/tWXH/WyeQ2QEyFtkaS/GOq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cK8ofqHp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726778106; x=1758314106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/Ey+raeb9Xu9MDcS2B8YvQgV4TVAH8hLRAShm8GBsI=;
  b=cK8ofqHpjOg999sutrNlfqL/f8m7qVp1KI3QZnyf4u8GH2pADte9SdEH
   R/2bR0cWD4jyk/Ppl2s7mOx6hR9syWd3O844hwDVd4uIbopKJQlw7x446
   9HtlWBf3vyS+r/pZghQwsMkV4STMoANG9wZd6OiaoQx7sfu4U74C+j7fL
   bm8FzaKOk2Gr7QeH380SFdZZ2omIhf6At0/W8M5Rsd8uKiDt8NiqXQgr9
   okvOgL8o5Ioj2irMZoInJ9J3ZsKgTakj4CBTnhSEnwd0wrDm7yUITvwxR
   +iXCmaiYfoeozSCV7sfwp8cB7C7+o9NXZY0uMalrSEdFE5Dmm1Y1bgarR
   g==;
X-CSE-ConnectionGUID: Xa1hnr8iSHGIKTQUHkc5/Q==
X-CSE-MsgGUID: rDp6jw/eRrK6d70Jy7OwhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25912939"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25912939"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:06 -0700
X-CSE-ConnectionGUID: PpTlETwuSnmEDsas7qZeZg==
X-CSE-MsgGUID: KP4+QLOJQ3mxcxqMN9h8fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="93338318"
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
Subject: [PATCH v3 1/9] fpga: dfl: omit unneeded argument pdata from dfl_feature_instance_init()
Date: Thu, 19 Sep 2024 16:34:22 -0400
Message-ID: <20240919203430.1278067-2-peter.colberg@intel.com>
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

The argument pdata passed to dfl_feature_instance_init() was never used.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
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
2.46.1


