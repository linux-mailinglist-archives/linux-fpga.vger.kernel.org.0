Return-Path: <linux-fpga+bounces-964-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46F59D31C1
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BD1F238AE
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC814B075;
	Wed, 20 Nov 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Co1Wt8bV"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487671474A5;
	Wed, 20 Nov 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065110; cv=none; b=DqDIdpU+DPrcDjdpC0Rcafm0lFK2ruRQNGwHKkkl2hz4PFl75lGR+SoA2cFwqNzb6gV1I3RaVVir+le5JGN1mrEuzqcZ/R6bsohs6RWgl84nRk1maFBBtB/XU88kJHfEu6ynqcxaqIafpxUZ+OgSOiZNOgC7uRgprpCv4w+TUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065110; c=relaxed/simple;
	bh=xp3RlZfzVTWveBY4glj257I12Rv13of4juVhCN8tddE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgG5KgZhXMOV79E8wR9P3PLLbdp/I++C9oDxUuLMHCnTqD4/G4x1ZvlSx2NcShorePyI+y79+2D4UqAv5/xT43IskkNg2PLYfroEi6tEHaOM81CcKTmXY2fPlQ/eVSK3x4ESKLPQRWne21U6hCag+gzkpmNOcGRV6ReehbbJQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Co1Wt8bV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065109; x=1763601109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xp3RlZfzVTWveBY4glj257I12Rv13of4juVhCN8tddE=;
  b=Co1Wt8bV/mFFr0eAUERqsyNHLZWoLFZoY6Bzv+zNX7vE/RJ8FZeJLKBw
   jKZjiZq4pUMTLzxVFJTdZRzSHxADSDGztBO/wtzQmB8Hrv3hByDKvuqTz
   84U/jxpiJ9weCEKezlr03OfLX+yOLXJc3FEprhVcLggKFyg4v8eO56OAD
   8nPyLPkGY177nIO2DiJyZjahVyvGPdG+35UQh+d5BM43KatCIIb7UX0YZ
   HqlTkfBJbhQ2truQsplotWk/XZwUdy26rfV2MEU85eB6ldvESehOUAHCH
   dCI33pyK2l9/lyJOlPqf9YOu9Dav0Pjp4ymEP640KvT7IcbTCURm8775W
   w==;
X-CSE-ConnectionGUID: iocxHCcSRHqIShjgigpf6A==
X-CSE-MsgGUID: Z3amp7hpTSyOKfVsBuADkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42613033"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42613033"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
X-CSE-ConnectionGUID: 7c1PbKxwSS+myjIPXzQRdg==
X-CSE-MsgGUID: wiRLrVMeS4uOiMEBrquvWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813615"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
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
Subject: [PATCH v5 16/18] fpga: dfl: remove unneeded function build_info_create_dev()
Date: Tue, 19 Nov 2024 20:10:32 -0500
Message-ID: <20241120011035.230574-17-peter.colberg@intel.com>
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

Remove the function build_info_create_dev(), which no longer serves its
original purpose now that the allocation of the platform device has been
moved to feature_dev_register().

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v4:
- Revise commit description to be confirmative, from (the function)
  "may be removed" to "Remove the function".

Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 91f12272da3e..203b14e292b4 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -858,16 +858,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	return fdata;
 }
 
-static int
-build_info_create_dev(struct build_feature_devs_info *binfo)
-{
-	binfo->feature_num = 0;
-
-	INIT_LIST_HEAD(&binfo->sub_features);
-
-	return 0;
-}
-
 /*
  * register current feature device, it is called when we need to switch to
  * another feature parsing or we have parsed all features on given device
@@ -1326,11 +1316,8 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 		return -EINVAL;
 
 	binfo->type = type;
-
-	/* create platform device for dfl feature dev */
-	ret = build_info_create_dev(binfo);
-	if (ret)
-		return ret;
+	binfo->feature_num = 0;
+	INIT_LIST_HEAD(&binfo->sub_features);
 
 	ret = create_feature_instance(binfo, 0, 0, 0);
 	if (ret)
-- 
2.47.0


