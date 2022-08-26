Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76515A2A4B
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Aug 2022 17:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbiHZPCo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Aug 2022 11:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243730AbiHZPCj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Aug 2022 11:02:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A979DA3C2;
        Fri, 26 Aug 2022 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661526151; x=1693062151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtAdrPErhjfMtG2XjUFseiD+T/7y59+TgXca0rfF0MY=;
  b=eD74UNEyHVhjsExa6U1fkIKdqvfvRCF9w+/+2Ito+IuDmumfju9npBeM
   1iKJNH5jpuJby5VErSaC1qVDv/LskEvwjHy0K/xhTtS2IBBquHEGRlVg7
   6c7C458GknayzbJyXFZhwDEmUtjNIgGTVQmM5AX+UmXwDUfQogDHtGcuf
   GC+l8mrT58i7Jm4LLtoRpkIdjvMdY8u3msqGhkYFKQWgLgTDNgRnb6HJ4
   pGeYzf+WIB8FvhmA2BhERwN1+bOuv0QyhcF/Y6yC06bWyZgNnIw43mmq4
   9pqF6DTIl6/0CdzCfjqHIyCrNH/YguysPjTk6KNTdyxEWxsUnBJbPn8rn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295796602"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295796602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 08:02:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="671493154"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 08:02:30 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Peter Colberg <peter.colberg@intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2] uio: dfl: add IOPLL user-clock feature id
Date:   Fri, 26 Aug 2022 11:01:16 -0400
Message-Id: <20220826150116.16014-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220817213746.4986-1-peter.colberg@intel.com>
References: <20220817213746.4986-1-peter.colberg@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
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

