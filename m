Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BBB513FE3
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Apr 2022 03:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353601AbiD2BCR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Apr 2022 21:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbiD2BCQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Apr 2022 21:02:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA8B9F38
        for <linux-fpga@vger.kernel.org>; Thu, 28 Apr 2022 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651193940; x=1682729940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KKNCxTu+99qwXWlFXVm9YNtdsjLfxYjBNRBEyc2G6G4=;
  b=PuNvJKnzrJi7HKSep+48S8ZlgN/J0PC5LruEjfF1eSv8XFviAeGpQmju
   ZvIGlHrqB3GKzyAiEPjUXsD5MQWua3xK+fvxkS7bv4l3XdvqRE5S5PO+Q
   9bjCsgHFWmJkyrkYpFUN7tU+QNlbPMInR7gXA8jCVcfgiz+idTQtyldOZ
   jJFjoT+dlJcbZQFTrKZIXG0PBCBmAu7jW/12uHGMcse+tFEooA4yBe9tb
   Fo1zcJqgeSmDQp6tjCVmA9LjimDo5nRg2siupY4yHeh8l8QrIZJ4X07Zk
   cawCq9jSXtx1xpsMWvZuwi5pnqNaTdoJoq1wnrwYTngHzeAO624R9FPA1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246398152"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="246398152"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 17:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="651515393"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Apr 2022 17:58:58 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3] uio: dfl: add HSSI subsystem feature id
Date:   Thu, 28 Apr 2022 20:55:21 -0400
Message-Id: <20220429005521.607678-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add the Device Feature List (DFL) feature id for the
High Speed Serial Interface (HSSI) Subsystem to the
table of ids supported by the uio_dfl driver.

The HSSI Subsystem is a configurable set of IP blocks
to be used as part of a Ethernet or PCS/FEC/PMA pipeline.
Like the Ethernet group used by the N3000 card, the HSSI
Subsystem does not fully implement a network device from
a Linux netdev perspective and is controlled and monitored
from user space software via the uio interface.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
v3: change the name of this feature id to HSSI_SUBSYS and rewrite
    the git message.
v2: add HSSI introduction and the git repo of Feature ID table.
---
 drivers/uio/uio_dfl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
index 89c0fc7b0cbc..8f39cc8bb034 100644
--- a/drivers/uio/uio_dfl.c
+++ b/drivers/uio/uio_dfl.c
@@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
 }
 
 #define FME_FEATURE_ID_ETH_GROUP	0x10
+#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
 
 static const struct dfl_device_id uio_dfl_ids[] = {
 	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
+	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
 	{ }
 };
 MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
-- 
2.26.2

