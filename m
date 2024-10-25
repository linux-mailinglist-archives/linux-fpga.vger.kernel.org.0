Return-Path: <linux-fpga+bounces-905-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C919B12D6
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639171C21FB4
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C4218926;
	Fri, 25 Oct 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dutgcn6K"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50311213142;
	Fri, 25 Oct 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895871; cv=none; b=cl8haO90c8+RuWDuvQ1wSCNIw42TQIRSLt+fwVGJhDx5AVAkLIozuwDY2Tw1oYtW0SXuAEU1iPdLIHNndHWRMd7xP3HZAfR+1vDUxhvBcU4R8SQjl4c6rgVqQmNT9bbR3rSKlL4OVlraSnnIElcu+thL+VuZjyKS8nhTbanIoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895871; c=relaxed/simple;
	bh=9Euj4+tmjMl6tgNNZl+Np0awrshyvhZBAyvVAHZroeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlLXvq/MGqts/pvXgo9GQjYBhRPTiGlhyU63YrFi+Qd4ID3WdmaFx3SUnKfp7DZpimgWL73FAYKy76JTn2mJUxozBRQvppZf14VK6s0KUslycq4guSXOKK+sD/nT+PeED6aGUoHK2taCP2mUtIiu4gicsj7Aln1AIXfV2IIWrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dutgcn6K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895869; x=1761431869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Euj4+tmjMl6tgNNZl+Np0awrshyvhZBAyvVAHZroeA=;
  b=Dutgcn6KaGVwjqZpzeoCf7Ha+MOkk/nncv62EUpFDkT14o0dUNhKy8NO
   RSnCJGlGnbN6dNc6Pd51Kh+vHQfk2eW4Wg/+SxmfuW6E31BWBrrWWZthz
   cHAHwZr6hQmK2CMHSA0CP6h/Hwa5Ctfbfdbg58OhuIbajuBueXIGsxmd1
   oVPknowKJK0OqAWoBQ3FpifrG69uXOOjue31NI/ezZWkpQ0FNpzyP2y/I
   +zu2elrPskcSiBdF2AyDHhQlPI4fdZQbnp3cm/NuORU2C21593j0WnLXh
   Rxpy1PF1L4tYc9ID6YI4xmdcJ4/i1B1USd8ODSSFGcRUITOIvfOAa/QV+
   A==;
X-CSE-ConnectionGUID: 8cRdTjQqTwKIFSq9JQcMmw==
X-CSE-MsgGUID: PRXL6+c8S4KOv8Dg9G//Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474663"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474663"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:37 -0700
X-CSE-ConnectionGUID: 8+Ma2bvhR7iZtAnFKpbb3A==
X-CSE-MsgGUID: 2dUCzM2RQGe7PlINcJOOgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596170"
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
Subject: [PATCH v4 11/19] fpga: dfl: convert features from flexible array member to separate array
Date: Fri, 25 Oct 2024 18:37:06 -0400
Message-ID: <20241025223714.394533-12-peter.colberg@intel.com>
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

Use a separate array allocation for features and substitute a pointer
for the flexible array member in the feature device data. A subsequent
commit will add another array for resources. The current commit converts
the flexible array member to a separate allocation for consistency.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 7 ++++++-
 drivers/fpga/dfl.h | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4268a61bb9f7..094bba647085 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -752,10 +752,15 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
 		return ERR_PTR(-EINVAL);
 
-	fdata = devm_kzalloc(binfo->dev, struct_size(fdata, features, binfo->feature_num), GFP_KERNEL);
+	fdata = devm_kzalloc(binfo->dev, sizeof(*fdata), GFP_KERNEL);
 	if (!fdata)
 		return ERR_PTR(-ENOMEM);
 
+	fdata->features = devm_kcalloc(binfo->dev, binfo->feature_num,
+				       sizeof(*fdata->features), GFP_KERNEL);
+	if (!fdata->features)
+		return ERR_PTR(-ENOMEM);
+
 	fdata->dev = fdev;
 	fdata->type = type;
 	fdata->num = binfo->feature_num;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index bcbdfcdb9742..d2765555e109 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -330,7 +330,7 @@ struct dfl_feature_dev_data {
 	int open_count;
 	void *private;
 	int num;
-	struct dfl_feature features[];
+	struct dfl_feature *features;
 };
 
 /**
-- 
2.47.0


