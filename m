Return-Path: <linux-fpga+bounces-961-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C79D31BC
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4821F2374D
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469751474A2;
	Wed, 20 Nov 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ankQF2gA"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C9E143C72;
	Wed, 20 Nov 2024 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065109; cv=none; b=GFZJROuhw8HQZcR8nA5YoJKYw863QcbEPWziC4hXFecOEfUlKaft3sF4a2zMWh7T56fTDVJfZNIKTm+A8Vg+zVJoEvtCcWn3zs3dw9m9g2gOcOZ1tY+kWduBIQ2+8NBLJ/GKSmv1Nl0kDI4UtCLGBySwQYubwtgodDY+Ebt5LDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065109; c=relaxed/simple;
	bh=8ARDcixT0WgGqMBo6PwCM+qR6fnR3X6O+bgJ6f5O+48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLyhYexs9zrXh4oetU3EbFU89euiV+X8e0ezuILN+lHW4AEzwWF0u+9LpHuc0sjEWLjIqgo34DNjCd4lV/HU961JyFwrLEQU8TEHR8OiPYmhqE4+Lm7l2nU5uzOpoUpaf7LEkMnEqt+wqYI2LXoxEiWxwr0DLAWZLw+N0k7OfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ankQF2gA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065108; x=1763601108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ARDcixT0WgGqMBo6PwCM+qR6fnR3X6O+bgJ6f5O+48=;
  b=ankQF2gAu6mkHNMb0m7DKOBpcHfCamLsW7QZComOkVU9Q36gAAotbkVy
   rMDzRKMTRxoov4Yvjef5z4uUcHUsFYHxRxeyGe2jUoy2lwhnYMY1Gc/sP
   6jZnwQwB3Df3627SFWkwObPsMuEsyoTyF8EHpYXL1Ds7wPMkL0VHVbPJI
   bbZNukZSq31rpq9kfXVaIzd3c1EQ7LIuIRbXxHeGIgT9MD8VfBCMO3COn
   WyrJUkY/ug0+u0J7hBZC6UY1rH71qtwQbjfYE/OgLxrhyE5KhZQaPp6Lo
   ILisSPegCbzqupv+QvnTtCWXwYG7POfrtJb7UdwBAtlvKphIwpiN163Wv
   A==;
X-CSE-ConnectionGUID: gkeKkWHXR7KpKyeWeWG2uQ==
X-CSE-MsgGUID: wTuNc9wwQBKww3yd6ZB4eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42613006"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42613006"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
X-CSE-ConnectionGUID: tVD17cRkQcGw/7g6N1LAWw==
X-CSE-MsgGUID: BNOui7EnRnOpIBT7qOD6AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813598"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:40 -0800
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
Subject: [PATCH v5 11/18] fpga: dfl: convert features from flexible array member to separate array
Date: Tue, 19 Nov 2024 20:10:27 -0500
Message-ID: <20241120011035.230574-12-peter.colberg@intel.com>
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

Use a separate array allocation for features and substitute a pointer
for the flexible array member in the feature device data. A subsequent
commit will add another array for resources. The current commit converts
the flexible array member to a separate allocation for consistency.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 7 ++++++-
 drivers/fpga/dfl.h | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 22291ffea95d..bf2c7381eebd 100644
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


