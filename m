Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CFD4D1078
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 07:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiCHGr3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 01:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiCHGr2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 01:47:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E1E1DA7D
        for <linux-fpga@vger.kernel.org>; Mon,  7 Mar 2022 22:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646721992; x=1678257992;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dl9fT7uzb/Rm41WFTRLAFzUA7zVXAJmxvfpRvA9dl0Y=;
  b=HALO5rpCrY5l6BRALuJBqnBxa2DwWxui/w6cUpvQZfjg05sGbhK0iREK
   SsEQLEyvbN/k9bXgn83JsBF70gx8GRjLi75N2vHexl/Q125Cq81lHgHjE
   AcU3q9Ip07QeTH8IZExjqoBCKNmht6q41K+ymjOIenBlCjx3HerqDBzzY
   ke4NDdgoYHQnsQSmmqvbeEDbKKph93V03ALpbxntoKYzFDLXP3zhv5anX
   Jvwd5dLt8ptxO/GUhZctr96PHnK3QtkUsjaEmPBQgp376HY3q+peWZxJq
   iLT2JrM8y1uHpmLxfDoGmivMfGtPuiXN3GNlpHiTqviK6Ek5t7CGXy5oT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254799303"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="254799303"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 22:46:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="711429193"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2022 22:46:29 -0800
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1] uio: dfl: add HSSI feature id
Date:   Tue,  8 Mar 2022 01:43:15 -0500
Message-Id: <20220308064315.1452217-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
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

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add the feature id of the OFS High Speed Serial Interface
subsystem to table of ids supported by the uio_dfl driver.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/uio/uio_dfl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
index 89c0fc7b0cbc..660e1d0bf6b9 100644
--- a/drivers/uio/uio_dfl.c
+++ b/drivers/uio/uio_dfl.c
@@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
 }
 
 #define FME_FEATURE_ID_ETH_GROUP	0x10
+#define FME_FEATURE_ID_OFS_HSSI		0x15
 
 static const struct dfl_device_id uio_dfl_ids[] = {
 	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
+	{ FME_ID, FME_FEATURE_ID_OFS_HSSI },
 	{ }
 };
 MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
-- 
2.26.2

