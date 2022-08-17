Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1AF59790C
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Aug 2022 23:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiHQVi1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Aug 2022 17:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiHQVi0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Aug 2022 17:38:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32463326FE;
        Wed, 17 Aug 2022 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660772305; x=1692308305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+mzhpuJJwANU8+VmioTlZp7MgaQiVl0cGFTHv1TVDAc=;
  b=oKw4j7DxauuYOSiOTOpZCDZ2s0Iao5jG0rhf+aJTTEzh2xkUFLnNZw87
   9qBb+wnVEjbRS+Klq80cLxhZJbqhnKAKc/1e5+tPjHURQm8V2hwP8TbAl
   puhDI/WtoIyLiaPIb5D3K2CuLC10I+5eqKHBiQ4L2pFdj83lHEgkQEmoE
   AgSXCk2WLPjxmT6kFI9XCfcIPRdCSfJfR5Im+PnzLRvG6Lphwkrbmc9kE
   4iDi1HVL5jV3IsFEB+yZ6O+t4dNjNww6XjFD0l7ea9lqo+z/xyDJDpRpm
   CX4337hLmhC3ZMTJITsoFjysd5wfRmL38lXyaQ+dx7MAiNBFBYTaJEqqI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275659822"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="275659822"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:38:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="636545861"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:38:24 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v1] uio: dfl: add IOPLL user-clock feature id
Date:   Wed, 17 Aug 2022 17:37:46 -0400
Message-Id: <20220817213746.4986-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add a Device Feature List (DFL) feature id for the configurable
IOPLL user clock source, which can be used to configure the clock
speeds that are used for RTL logic that is programmed into the
Partial Reconfiguration (PR) region of an FPGA.

The DFL feature id table can be found at:
https://github.com/OPAE/dfl-feature-id

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
 drivers/uio/uio_dfl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
index 8f39cc8bb034..69e93f3e7faf 100644
--- a/drivers/uio/uio_dfl.c
+++ b/drivers/uio/uio_dfl.c
@@ -46,10 +46,12 @@ static int uio_dfl_probe(struct dfl_device *ddev)
 
 #define FME_FEATURE_ID_ETH_GROUP	0x10
 #define FME_FEATURE_ID_HSSI_SUBSYS	0x15
+#define PORT_FEATURE_ID_IOPLL_USRCLK	0x14
 
 static const struct dfl_device_id uio_dfl_ids[] = {
 	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
 	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
+	{ PORT_ID, PORT_FEATURE_ID_IOPLL_USRCLK },
 	{ }
 };
 MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
-- 
2.28.0

