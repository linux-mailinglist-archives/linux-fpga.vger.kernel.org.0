Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA325A87BA
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Aug 2022 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiHaUtJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Aug 2022 16:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiHaUtI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Aug 2022 16:49:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A75F240B;
        Wed, 31 Aug 2022 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661978946; x=1693514946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HmiW7PexacLNr8e6ySi2jlIwoco6aRi8m2ckyoKLdh0=;
  b=jj/SBq8rAq4B0t9dDR2m6Z/0t7VuA7LQoQQ4nrJhvTbXXLOn5vyiJhUp
   63Rc+lSNuUXzro9aJ6RFQoth66YLHoejtRiKz7vGEfOSzCN8j6mQKcuhO
   pNsTvReiC5XpGF2ONInAxhHQpzY4yNV/iyJUUmykQ4QYspLgc3FAZ3f5X
   dcrkhR4UNnC/3xJGbm56411KK7fpLBYn0j4ytvQIGWJSscSO1nbD8Ho94
   /4trC05GUJJf3Eozev09JPA1oPtRFQvwQrkOBiOuO2Gq7E7UsJ7N2R2EJ
   XwNhI7neg/W4Obiw4r4ntP2t7ejN4vhWzzoofjVLBLQ0MLjNg815qzeYK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="278558549"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="278558549"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 13:49:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="589176109"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 13:49:04 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Peter Colberg <peter.colberg@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3] uio: dfl: add IOPLL user-clock feature id
Date:   Wed, 31 Aug 2022 16:48:51 -0400
Message-Id: <20220831204851.4683-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220826150116.16014-1-peter.colberg@intel.com>
References: <20220826150116.16014-1-peter.colberg@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add a Device Feature List (DFL) feature id [1] for the configurable
IOPLL user clock source, which can be used to configure the clock
speeds that are used for RTL logic that is programmed into the
Partial Reconfiguration (PR) region of an FPGA.

The IOPLL user-space driver [2] contains frequency tables [3]
with the specific user clock frequencies for an implementation.

For each desired frequency, the table values are produced by calling
the quartus tool, the same tool that generates the IOPLL RTL logic.
The quartus tool allows the RTL designer to select different options
which can affect the table values. The table-driven, user-space
driver allows for supporting future, modified implementations and
provides users the ability to modify the IOPLL implementation.

[1] https://github.com/OPAE/dfl-feature-id
[2] https://github.com/OPAE/opae-sdk/blob/a494f54a9f0356d0425edbff228f0254a4c70303/libraries/plugins/xfpga/usrclk/fpga_user_clk.c
[3] https://github.com/OPAE/opae-sdk/blob/a494f54a9f0356d0425edbff228f0254a4c70303/libraries/plugins/xfpga/usrclk/fpga_user_clk_freq.h

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
v3:
	Reorder Signed-off-by: such that submitter is last
	Add Acked-by: Xu Yilun

v2:
	Describe IOPLL user-space driver in commit message
	Add Signed-off-by: Russ Weight
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

