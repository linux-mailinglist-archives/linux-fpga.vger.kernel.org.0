Return-Path: <linux-fpga+bounces-909-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC99B12DC
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763891F234AE
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669C21B846;
	Fri, 25 Oct 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M68btwYY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B87218936;
	Fri, 25 Oct 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895874; cv=none; b=tCtjHuKX8fFShaLUmGEHYYIT2VdKD+V3TEzrDZ0vtuCQS5vcHKv/daFOqLOsnJyGh0xH+Zc7UMLPJLuWCAUV2vxqS9Hf9xLJnCVIaEQ9AmYsSjsJK/KRlnABTes4jAU+5mhbIPIQAuBgWuGtZ+/OgiDBddrE43w6shTmiozRJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895874; c=relaxed/simple;
	bh=oyrGP68L+m/yEjVuCrFUZOoZlfjTWsoYiD1UjFeOMaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uguhuH42CZ5egkWQ8zeC4/ZvEyd52RCDSvhs++iolH2jUQKvp5kNTqIVylHqbAilrv1HYcyDnLnwSo3o3+Ea1UtGyBi95S5nZrfgog02K96xXMaIPAYTU1172DJGtvGEOdxFBT1PWUzIE4VpfKmKcSvYZNIfq9rP6+t7azebTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M68btwYY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895872; x=1761431872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyrGP68L+m/yEjVuCrFUZOoZlfjTWsoYiD1UjFeOMaY=;
  b=M68btwYYBhLkjPkD9BwNIhUJdQQ/VArCZ2cZ3DC9T6IETkToL706TcGC
   0wQIvzwa2214FEvHwjeBNyMuw7j6YeoPl9/SLTE1V8nzse1KctH8Jks/m
   IFq3TZJHLLOkhT9kn3W51e+O4WAEhUXiaZh0D6ffsSJUxBH3HEbqCZIMP
   AihJNJh+GVhQ/LYUgBn/9cV9psQHDnWWhy1DVqONO6wHq6SM1Yp+WGUDs
   /0RhntybZYATW4f9qG8U1Plq5WlNI2u7V7yooXnqqaTtfLI4vLNm64g2Q
   ToAV5zQYjxGrrLYCr7arzrOzJgPLR8wZW0ZWyifODfAJcVeBEGi9FVutF
   A==;
X-CSE-ConnectionGUID: GtOjx8UcQdW90EgkP+ny0A==
X-CSE-MsgGUID: SG5tXkExRIyZBHYEDqZMJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474686"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474686"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
X-CSE-ConnectionGUID: skI7CRA7SLensJJqbSNHgw==
X-CSE-MsgGUID: /mx8/ywhQUG6N8Yjc+DWnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596189"
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
Subject: [PATCH v4 17/19] fpga: dfl: remove unneeded function build_info_create_dev()
Date: Fri, 25 Oct 2024 18:37:12 -0400
Message-ID: <20241025223714.394533-18-peter.colberg@intel.com>
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

Now that the platform device allocation has been moved from
build_info_create_dev() to feature_dev_register(), the former
no longer serves its original purpose and may be removed.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index d9cef150ed0d..a2459b0cbc68 100644
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
@@ -1316,11 +1306,8 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
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


