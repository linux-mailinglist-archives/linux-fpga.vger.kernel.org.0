Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4F4D74D2
	for <lists+linux-fpga@lfdr.de>; Sun, 13 Mar 2022 12:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiCMK7m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Mar 2022 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiCMK63 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Mar 2022 06:58:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8529B1749FE;
        Sun, 13 Mar 2022 03:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647169040; x=1678705040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=82RRYaqdq5m//xBFiiE6/hsoZBDz6vsg38N2TZZZ+hQ=;
  b=kFFa7Cs+z4qbdY3aEfjhFXadO2mllcztJJ5qC9NkYR/B2Uq3ZK+9K5iW
   +lyNQWdCK+hA/GUWZnzgN7YjtAlGchQ01An2KiXPtqeQnr6D/Ctj//isg
   nz+f2vPjrWC5dbehKpXrbtGK2pi9tbteCJSx0nI9jKdHMwyBYx3T3riMj
   GfDri13OpxhfrYO9GTN5EbBqDD3Hom91atgjkWjxbul6FUIKhSVZKhh9q
   LJ2pPEUhWOjgULItKIQuB28+II+3sFDaOY0wgEz9wf5Fa3DYTMh6PF83z
   TsHF/s1qDvTci/6CNcr8qCwECFsFwhI/45EvQZWwzh+4Er9sO5sFqq2ED
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="319086330"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="319086330"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 03:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713380329"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 03:56:07 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v5 3/6] fpga: dfl: check released_port_num and num_vfs for legacy model
Date:   Sun, 13 Mar 2022 06:52:39 -0400
Message-Id: <20220313105242.1567774-4-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220313105242.1567774-1-tianfei.zhang@intel.com>
References: <20220313105242.1567774-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

In OFS legacy model, there is 1:1 mapping for Port device and VF,
so it need to check the number of released port match the number of
VFs or not. But in "Multiple VFs per PR slot" model, there is 1:N
mapping for the Port device and VFs.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl.c | 10 ++++++----
 drivers/fpga/dfl.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 712c53363fda..b95b29c5c81d 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1707,11 +1707,13 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 
 	mutex_lock(&cdev->lock);
 	/*
-	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
-	 * device, so if released port number doesn't match VF device number,
-	 * then reject the request with -EINVAL error code.
+	 * In the OFS legacy model, it can't turn multiple ports into 1 VF
+	 * device, because only 1 port conneced to 1 VF device, so if released
+	 * port number doesn't match VF device number, then reject the request
+	 * with -EINVAL error code.
 	 */
-	if (cdev->released_port_num != num_vfs) {
+	if ((dfl_has_port_connected_afu(cdev) &&
+	     cdev->released_port_num != num_vfs)) {
 		ret = -EINVAL;
 		goto done;
 	}
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index bc56b7e8c01b..83c2c50975e5 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -471,6 +471,8 @@ void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
 #define DFL_PORT_CONNECT_BITS  MAX_DFL_FPGA_PORT_NUM
 #define DFL_FEAT_PORT_CONNECT_MASK ((1UL << (DFL_PORT_CONNECT_BITS)) - 1)
 
+#define dfl_has_port_connected_afu(cdev) ((cdev)->flags & DFL_FEAT_PORT_CONNECT_MASK)
+
 /**
  * struct dfl_fpga_cdev - container device of DFL based FPGA
  *
-- 
2.26.2

