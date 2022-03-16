Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F434DABA7
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Mar 2022 08:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347668AbiCPHNL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 03:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354247AbiCPHM6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 03:12:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D035DE74;
        Wed, 16 Mar 2022 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647414705; x=1678950705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=82RRYaqdq5m//xBFiiE6/hsoZBDz6vsg38N2TZZZ+hQ=;
  b=SfYA5E9IaBSag5LmC5H38xKat5RbkGZk9AHPnZJylivVjXBVON2M3J4A
   9a+YG7qXn16v51GRJDPKomIKVJemEPbqf1e4fa/UBUNpUJahBDF5Lfy5w
   iu5+GDfw05aKT05eeaQpQjzSTX9sQaRLCniE7/0RNtAMxLc9M6RSIbRVt
   9FkkEb42d347opE8U+DuBTjdkwhHjooZQqkqLR/BN95LgUnP5vg9TedAY
   0auc17uH352rhbNCB+bMpG2V4vn43uVTVW1myu/R6E/U2E0qP3qNZ5Ehl
   7i569qwispARbkhzFBB3hNbU9/8vJGyXnXqZlhTgM5NfTx3DLR6HDrhzv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281289037"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281289037"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646538353"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 00:11:42 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v6 3/6] fpga: dfl: check released_port_num and num_vfs for legacy model
Date:   Wed, 16 Mar 2022 03:08:11 -0400
Message-Id: <20220316070814.1916017-4-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220316070814.1916017-1-tianfei.zhang@intel.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

