Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B73E66AC6F
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Jan 2023 17:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjANQFK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 14 Jan 2023 11:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjANQFJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 14 Jan 2023 11:05:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E078903A;
        Sat, 14 Jan 2023 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673712309; x=1705248309;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kuWsyWIvywj0tHgOXuTlfBAihSjHtVUPvzJ5T6gRDb8=;
  b=OuOK+JqD6tDW46J6HJRewO/69YZNun/M4Z5GQTXogGyb4r1l5J/dUdxt
   Wv3efDg4eljOmK3KhKoTBRSqMSpNnOVtguPqRIygA1eNP5ET2YHo6CZw4
   GS+5qHr73XclN82485jelLelkPCIGT+cr/Nh6/34y0BTxgsJVX3X37pRV
   gFZR6MVl4g20Bukx1CMXXeb1jgXxVgHd6JR69+AgngvnUmYVuyM+XWF/N
   +rgOMZC1IvjagJoILWTYDLUMjLx0nK2+JDkT9k8c+PvvUdMfz6Allq+i9
   s4Q35Mpn7PUH8wcuMj9+C9hP0Y6GefF+MYIwdnRJ1et184N7j9+Jk4ber
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="388698712"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="388698712"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 08:05:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="721846041"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="721846041"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jan 2023 08:05:06 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     rdunlap@infradead.org, hao.wu@intel.com, trix@redhat.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: dfl: more kernel-doc corrections
Date:   Sat, 14 Jan 2023 23:54:44 +0800
Message-Id: <20230114155444.794712-1-yilun.xu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fix more kernel-doc warnings in drivers/fpga/:

$ ./scripts/kernel-doc -none drivers/fpga/*
drivers/fpga/dfl-afu.h:61: warning: expecting prototype for struct fpga_afu_dma_region. Prototype was for struct dfl_afu_dma_region instead
drivers/fpga/dfl-afu-region.c:52: warning: Function parameter or member 'pdata' not described in 'afu_mmio_region_add'
drivers/fpga/dfl-fme-perf.c:161: warning: Function parameter or member 'node' not described in 'fme_perf_priv'
drivers/fpga/dfl-fme-pr.h:70: warning: expecting prototype for struct dfl_fme_bridge_pdata. Prototype was for struct dfl_fme_br_pdata instead
drivers/fpga/dfl.h:256: warning: Function parameter or member 'revision' not described in 'dfl_feature'

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-afu-region.c | 1 +
 drivers/fpga/dfl-afu.h        | 2 +-
 drivers/fpga/dfl-fme-perf.c   | 2 +-
 drivers/fpga/dfl-fme-pr.h     | 2 +-
 drivers/fpga/dfl.h            | 1 +
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
index 0804b7a0c298..2e7b41629406 100644
--- a/drivers/fpga/dfl-afu-region.c
+++ b/drivers/fpga/dfl-afu-region.c
@@ -39,6 +39,7 @@ static struct dfl_afu_mmio_region *get_region_by_index(struct dfl_afu *afu,
 /**
  * afu_mmio_region_add - add a mmio region to given feature dev.
  *
+ * @pdata: afu platform device's pdata.
  * @region_index: region index.
  * @region_size: region size.
  * @phys: region's physical address of this region.
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index e5020e2b1f3d..674e9772f0ea 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -41,7 +41,7 @@ struct dfl_afu_mmio_region {
 };
 
 /**
- * struct fpga_afu_dma_region - afu DMA region data structure
+ * struct dfl_afu_dma_region - afu DMA region data structure
  *
  * @user_addr: region userspace virtual address.
  * @length: region length.
diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 587c82be12f7..7422d2bc6f37 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -141,7 +141,7 @@
  * @fab_port_id: used to indicate current working mode of fabric counters.
  * @fab_lock: lock to protect fabric counters working mode.
  * @cpu: active CPU to which the PMU is bound for accesses.
- * @cpuhp_node: node for CPU hotplug notifier link.
+ * @node: node for CPU hotplug notifier link.
  * @cpuhp_state: state for CPU hotplug notification;
  */
 struct fme_perf_priv {
diff --git a/drivers/fpga/dfl-fme-pr.h b/drivers/fpga/dfl-fme-pr.h
index 096a699089d3..761f80f63312 100644
--- a/drivers/fpga/dfl-fme-pr.h
+++ b/drivers/fpga/dfl-fme-pr.h
@@ -58,7 +58,7 @@ struct dfl_fme_bridge {
 };
 
 /**
- * struct dfl_fme_bridge_pdata - platform data for FME bridge platform device.
+ * struct dfl_fme_br_pdata - platform data for FME bridge platform device.
  *
  * @cdev: container device.
  * @port_id: port id.
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 06cfcd5e84bb..5fc424d505c8 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -231,6 +231,7 @@ struct dfl_feature_irq_ctx {
  *
  * @dev: ptr to pdev of the feature device which has the sub feature.
  * @id: sub feature id.
+ * @revision: revision value of this sub feature.
  * @resource_index: each sub feature has one mmio resource for its registers.
  *		    this index is used to find its mmio resource from the
  *		    feature dev (platform device)'s resources.
-- 
2.25.1

