Return-Path: <linux-fpga+bounces-951-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A529D31AA
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEACB2839BB
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3597450EE;
	Wed, 20 Nov 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b91JPccU"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6D39ACC;
	Wed, 20 Nov 2024 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065099; cv=none; b=LYAufLCb9QiqlZ007YEjeU9vTlQkaxZDTIUfibNahQfFAd8JiPRXT48/utsA3wKbfRLiGgh7+gme0brVRtzym1lU1RQi3/jOaq/TxrPPRsuaAXzPqvZd6D+OueQAuukaqcs/H5sHMCizCZDTX75KCA3g/Q5q5dBt2t1ZhAS1QqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065099; c=relaxed/simple;
	bh=1x27NWWS83zIzo6LwNlNJX7BDiwIlQt3oTjI0k+dPNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQCyZggz0BdZCrb6/K/3eB6QX+DGH7nE69IfU1Vnnsjww5jIpL/UUHnKilmYcpDDgpndYJ2ElhUTaa4Bg7JvgiAGVZuRE6KchKJChhmRPsCGzc5btelIjV/xJoVvoHsqX4doBwM80H8662SHZqkQgNfRyx1K2LNKq0hdMwf1lxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b91JPccU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065098; x=1763601098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1x27NWWS83zIzo6LwNlNJX7BDiwIlQt3oTjI0k+dPNc=;
  b=b91JPccUxhy93OJKZLlCRZeqGZUES7v0GSHNXB9cpASCp6gBTfKrAGxm
   Mt44Pt72g6vqa0vud1Xp7bNyAjiUQJ1MW97knQGQZSWTokGXeE0bEI52p
   mGii4XcJerKAsfkH/9BbSiyt0ED3N1L/egPIqW0IvxVtEe1Di003L6P6T
   +Z6jqwf/oCk4Bdf/66FVgQWyW/Vw8xaDanzX75+i9VJ5UY6JP5LJSwTdJ
   RRI1Mm9MtWl8uBRKD+ORRpAS5C4zgDts7DOo1ObIpFbYihJH6+u8uOh1d
   RL9vGF2s1z4D5/OlfFIrGZ1zILDfU6OZBbWrKOUsHx5Z0DPTpcdPZyIH3
   Q==;
X-CSE-ConnectionGUID: GEh/ta1/TO2yBauYD6RFHw==
X-CSE-MsgGUID: D2uuUIMsS+2uS1bgQmkIxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42612960"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42612960"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:38 -0800
X-CSE-ConnectionGUID: I7XDgIQfQtupSZT4vHRZVQ==
X-CSE-MsgGUID: lirTOejtRHCGWQY4uQN17Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813561"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:37 -0800
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
Subject: [PATCH v5 01/18] fpga: dfl: omit unneeded argument pdata from dfl_feature_instance_init()
Date: Tue, 19 Nov 2024 20:10:17 -0500
Message-ID: <20241120011035.230574-2-peter.colberg@intel.com>
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

The argument pdata passed to dfl_feature_instance_init() was never used.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

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


