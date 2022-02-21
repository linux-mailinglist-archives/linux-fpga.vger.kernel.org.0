Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7FE4BD5FF
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 07:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245641AbiBUGMu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 01:12:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbiBUGMf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 01:12:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4245913CD4
        for <linux-fpga@vger.kernel.org>; Sun, 20 Feb 2022 22:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645423918; x=1676959918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KO4G+aB/+FrGpT1JIXYmqE45IgDBZkbTPP4EFosXkSI=;
  b=ffh/hr8cwdublgEnek47LoM7ClfRnJOywgNsO+pZM1vY2AlNtqN4GOjE
   P0i6M3a2jfU3LWZ5yHgtYwjul2M5FQ3U8fz3ScIK4E5rdZ1p4uNP75nJL
   mdCvehWiNL21htqUNwx5/kWSTNTl93fuGV0y6DzelCD5zcha/gVIMNqLP
   rHcJQgrDCKAoQ668Z2JKXI9yCXk71xxkkBiZWHtAVVdXRjOeIgHMoN7P5
   1q5Z48oAgS80iUa/ypCg5JAEZ7tcBNz7Yzcob6tGmRj3jGHv+RiULxCRR
   kZ3BvtnyqTcOY7bXkmbUkwl5jCy+bm8LY6+MT/o+NVDaQCe5urcacsG+Z
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251196056"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251196056"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 22:11:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="490333256"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2022 22:11:56 -0800
From:   tien.sung.ang@intel.com
To:     Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     linux-fpga@vger.kernel.org, Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH] fpga: altera-cvp: Increase the credit timeout
Date:   Mon, 21 Feb 2022 22:11:27 +0800
Message-Id: <20220221141127.3765-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

Increase the timeout for SDM (Secure device manager) data credits from
20ms to 40ms. Internal stress tests running at 500 loops failed with the
current timeout of 20ms. At the start of a FPGA configuration, the CVP
host driver reads the transmit credits from SDM. It then sends bitstream
FPGA data to SDM based on the total credits. Each credit allows the
CVP host driver to send 4kBytes of data. There are situations whereby,
the SDM did not respond in time during testing.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/fpga/altera-cvp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4ffb9da537d8..5295ff90482b 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -52,7 +52,7 @@
 /* V2 Defines */
 #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
 
-#define V2_CREDIT_TIMEOUT_US		20000
+#define V2_CREDIT_TIMEOUT_US		40000
 #define V2_CHECK_CREDIT_US		10
 #define V2_POLL_TIMEOUT_US		1000000
 #define V2_USER_TIMEOUT_US		500000
-- 
2.25.1

