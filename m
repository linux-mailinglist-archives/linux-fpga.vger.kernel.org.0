Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD84D0035
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Mar 2022 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiCGNhE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Mar 2022 08:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiCGNhD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Mar 2022 08:37:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F857F6C1;
        Mon,  7 Mar 2022 05:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646660169; x=1678196169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHh+EolUvrWVabUArdD8w545wIaDTMlbOBhkPiamHz0=;
  b=Tq94u5Zo7N/XVxWjBNl26poXB+3tU9ilAy6YuVCwdtNEVIdfL0ieyT40
   2D2cmHLK4ZzxmIoUExrfuo161XjCip3LCDnwdoKw7xehvHkq0+bSxGJM7
   UunTN2Wg8CW6Sk+iyB1OjYKpi/zkOErEsnPkf8IXIVVFcCKJgOTVakTv9
   dML5ORjZaBE6aiQlwWyDwxr/onXbYpMDiSzO78XMFszTPPU+Nh2MeWWzN
   JdPIJAc1bhAnMXD2+VLqqLmZIRhb8HL1N5yiKqQNPVEtVg0CifoqJiRra
   Pl4PUG2vqOngK2vQi++jbALvtWV3TvCxxkwC5wtxIkU7p3xzrZZSDbtkM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254579336"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254579336"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:36:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643246979"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 05:36:05 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v4 3/6] fpga: dfl: check released_port_num and num_vfs for legacy model
Date:   Mon,  7 Mar 2022 08:32:40 -0500
Message-Id: <20220307133243.1426300-4-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220307133243.1426300-1-tianfei.zhang@intel.com>
References: <20220307133243.1426300-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

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

