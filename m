Return-Path: <linux-fpga+bounces-963-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A59D31C2
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2419C283BB8
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F614B077;
	Wed, 20 Nov 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yg3it/WQ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17523146A9B;
	Wed, 20 Nov 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065110; cv=none; b=J7VmcnxHMXgxZ+gpbiXkYNAHPmSnwTo0j0otidf9hnWoWn1sXYXDaHjZidwjPmIyxA/99tO3HDorRyNGssa3fEeLiXrLVnCLW0V2Qept1Z1rwCfNYLBGMSZVuHZj2iREMEgC9ZCW5mKijXkIqzrn2mnpe5n1D+xrbYNMXvQmCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065110; c=relaxed/simple;
	bh=3Ykk/Bq4AaSPjAV5ELrKLvKtoy7APZzfsMSoIDBIXBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJsHEiB44LmZ7upltp2dLJTepZJZ68siFgQ0uxDSPgSm9tYh/NhR3hjgdTqKCpWcitsvl1oadApDy7xyyaejHs/LT8801Brh77pInHq/cwjf5OAWspPvuWs9rQ3CwxwhrwXAb9OQJSFnNtzTQA7amrovBFnIgKCnSnx56E8w0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yg3it/WQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065109; x=1763601109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Ykk/Bq4AaSPjAV5ELrKLvKtoy7APZzfsMSoIDBIXBM=;
  b=Yg3it/WQB+8MVTIao9CRxT1BPxHDKTnnm23W2+2XGz3LLoO8mhcfIgtt
   Ntfr1qUTehP0ELVvalxcFpjhtmgP1ThJfwtaiWLsQNxMaM61a21uyrHrg
   BgfW6vK/edKXQljb2Tsl3kIn9m7U98KJe755l0NshNtfwGON18yRBX+CE
   A4qowbhdtHwZj4cd3j0uxZPF+Uv+8yCh4jpFI6/0CHC5uZG4kaJjcua1a
   IZaRdYOsTVFe3z1ddSe1FxFDScL28Wdy6V2TWk4Oxks7+gDVpicMMmgYb
   lxLvwjNCdMAQwaZAhlGKf+bGs4EcfnjZufvv0ab3ZVzy7RuaGYHnF0HOr
   w==;
X-CSE-ConnectionGUID: CGqcsP3iRK2dvKWv8xw5ig==
X-CSE-MsgGUID: lx4X7jv9TE++bTOuHqGhbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42613023"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42613023"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
X-CSE-ConnectionGUID: G27dMiQOSXidnqFHUEblBg==
X-CSE-MsgGUID: 2Vb4eBFfQFKQb3rozFUCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813605"
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
Subject: [PATCH v5 13/18] fpga: dfl: store platform device name in feature device data
Date: Tue, 19 Nov 2024 20:10:29 -0500
Message-ID: <20241120011035.230574-14-peter.colberg@intel.com>
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

Add a new member, pdev_name, to the structure dfl_feature_dev_data that
holds the platform device name for convenience. A subsequent commit will
completely destroy the platform device during port release, after which
fdata->dev is unavailable, while fdata itself remains available.

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
 drivers/fpga/dfl.c | 3 ++-
 drivers/fpga/dfl.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 5e9052b98c4a..c8e4b977a233 100644
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


