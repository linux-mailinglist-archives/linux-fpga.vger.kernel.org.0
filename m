Return-Path: <linux-fpga+bounces-903-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419479B12D2
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD21280EA0
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47577217649;
	Fri, 25 Oct 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dD2/C0GD"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF4217451;
	Fri, 25 Oct 2024 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895869; cv=none; b=jE8IeP7NWFF9qY4+MTHkgTxWN/wlk70h1DQGWIemMGFyXQOku4qM2JVrOnp9N1JMuUkK65SmZD0pjNz5QWCeMXXzLXJtIpwlz0fcpZHXjs1Q+gM8fil1x5ustmXSxDBcFcnrJMC5cNUFbtTWv0BAZA4Jz3mJpDTbCl6LtN1nEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895869; c=relaxed/simple;
	bh=VxSKDHNNoNQrmUsSmHtwgnSSuoA76Ld7CX00Bv7KunE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qz7O9H07CBvDaMVgFMIM7YrzKKv4cpR1bznXxnsix7hW80+f5sOBkde6wvZFshhh7tw3YawD1+W+WHq4dGD4Rnv2DddVNMaNcwnrYaNIU9SgyQIuBvN+hBiW+5gaFMZG54XUMXJOr2ICwJjA3WUe+VVK/UgYeMwmO1+te43zjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD2/C0GD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895867; x=1761431867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VxSKDHNNoNQrmUsSmHtwgnSSuoA76Ld7CX00Bv7KunE=;
  b=dD2/C0GD61uc4rdVGqrg7CUXooaftkeHobLqdtcEE/Bxa/8K2C4VPLAa
   MiLhBYAR9apVq/O3LAc9P13ncdDgf8vh/AWinQBU9IVLvlafifhToALl2
   T6tq8vSuRoYmzsdsNFKYFUVprLxy0AdBd2egv7dOaOz0YuXbodSfhPuaw
   6yHNv31iL0+b3OVvMPHdOylb1XfV4vektbPSsiYjxrisqAmUW6E3OGbGq
   VwCRiUUGcvp7SovC6s5t1vR5J0kyIPspIGrYc7AJfZcJ+nCd9rr+g4HJp
   pPLTy54ldgVoW+b8hUcsiSMLm2zTxAwJ9COxkmGdUX0NBsWE+EpaAnOdc
   A==;
X-CSE-ConnectionGUID: O8hTlGw1RQyfuRlVLSRYpQ==
X-CSE-MsgGUID: d4ah0wjTQwe49U1zgNMnjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474670"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474670"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
X-CSE-ConnectionGUID: fPrFJs44Q4WMTUCa1RE7ag==
X-CSE-MsgGUID: LT2xqMQqQciixwj/cLVTYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596176"
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
Subject: [PATCH v4 13/19] fpga: dfl: store platform device name in feature device data
Date: Fri, 25 Oct 2024 18:37:08 -0400
Message-ID: <20241025223714.394533-14-peter.colberg@intel.com>
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

Add a new member, pdev_name, to the structure dfl_feature_dev_data that
holds the platform device name for convenience. A subsequent commit will
completely destroy the platform device during port release, after which
fdata->dev is unavailable, while fdata itself remains available.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 3 ++-
 drivers/fpga/dfl.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 46c1b2534430..560d35857405 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -160,7 +160,7 @@ struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_dev_data *fda
 
 	list_for_each_entry(ops, &dfl_port_ops_list, node) {
 		/* match port_ops using the name of platform device */
-		if (!strcmp(fdata->dev->name, ops->name)) {
+		if (!strcmp(fdata->pdev_name, ops->name)) {
 			if (!try_module_get(ops->owner))
 				ops = NULL;
 			goto done;
@@ -768,6 +768,7 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 
 	fdata->dev = fdev;
 	fdata->type = type;
+	fdata->pdev_name = dfl_devs[type].name;
 	fdata->num = binfo->feature_num;
 	fdata->dfl_cdev = binfo->cdev;
 	fdata->id = FEATURE_DEV_ID_UNUSED;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 921d946e4820..cbff5d543c44 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -309,6 +309,7 @@ struct dfl_feature {
  * @lock: mutex to protect feature dev data.
  * @dev: ptr to the feature's platform device linked with this structure.
  * @type: type of DFL FIU for the feature dev. See enum dfl_id_type.
+ * @pdev_name: platform device name for the feature dev.
  * @dfl_cdev: ptr to container device.
  * @id: id used for the feature device.
  * @disable_count: count for port disable.
@@ -325,6 +326,7 @@ struct dfl_feature_dev_data {
 	struct mutex lock;
 	struct platform_device *dev;
 	enum dfl_id_type type;
+	const char *pdev_name;
 	struct dfl_fpga_cdev *dfl_cdev;
 	int id;
 	unsigned int disable_count;
-- 
2.47.0


