Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E680851B49C
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 02:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiEEAXk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 May 2022 20:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiEEAXk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 May 2022 20:23:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0874118E06;
        Wed,  4 May 2022 17:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651710002; x=1683246002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6R7rPjZxaUlY86eW/wsAy2DZvazs20bdBd6dKtI4eIY=;
  b=jWAWtKDGF1tWta7RmqZl3a2fITsJe2liFjY8RJ1gcYUmnDIO9MaBiPj6
   uBrHrkR+b8AI8d1RgoZ77f836CbnfBLFdNSCKnP8oU7K1dqsiXMBpDrpw
   MYkzlxGfsIQP8SwGrxFyqdmDN44o2URu8f+vDIUjWzPWbHnn9qaPqMxKz
   vyffUpM7pk776dEbXtVDO15gc/lM9pWwYVt8sd1rtBigmQsLh3hralU6F
   TROe091rbiZ66vFfTSMVJi2EaGBAf2UST29KeI4rTSWpNpBEHBndtu6O5
   mmcsb4pwIWs7d/ef70rIuxsAz3S1ftLo/WCcbmwkbeaoLwQMLbdjEXmkN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268091983"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="268091983"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 17:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="599773905"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2022 17:19:59 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4] uio: dfl: add HSSI subsystem feature id
Date:   Wed,  4 May 2022 20:16:28 -0400
Message-Id: <20220505001628.681226-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

The Feature ID table of DFL can be found:
https://github.com/OPAE/dfl-feature-id

Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
v4: add Reviewed-by and Acked-by tag and add Feature ID table url in git message.
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

