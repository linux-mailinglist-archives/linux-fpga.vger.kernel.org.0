Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063BF4B4F4D
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352302AbiBNLjq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 06:39:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352036AbiBNLja (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 06:39:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E112E0B2;
        Mon, 14 Feb 2022 03:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644838187; x=1676374187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jy4XCIjAms8bGp66mP+cp45glqNgaC+j1VDAlljF7SE=;
  b=nFnNAXzGUvE1MBoDbq7nO7Qgf35ALCx+ygRNdHuohWD3xhxmV4IFz+g/
   Pg7RI9QRZwQTRl/zx5OctrqO6nU91HvW/KaJDH2DQNeX3ASJ0iNDPVehb
   xAu1QM8oXw5Dz/1c5QkfGREAaDZ/9m5SgNji4jIzYlJ2SzZ45rEO66YNC
   Bu5kXictDl6u/TxtUs8KRio7G/BMbQJ0wVdusRt3F7fjLX8JlwcqpqjO5
   fpkstiEzK/igFDN3QAI3SNYINgM3EHIVhzvQ6Flk+9gyxUD1Bz1xVJs87
   NWxbfpWIirpE98xpR0ZgmUOEcClUWjKZR3heZI4EKNXeKBRt9csj8FlCe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250276742"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250276742"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587167031"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2022 03:29:45 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 5/7] drivers: fpga: dfl: handle empty port list
Date:   Mon, 14 Feb 2022 06:26:17 -0500
Message-Id: <20220214112619.219761-6-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220214112619.219761-1-tianfei.zhang@intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Not all FPGA designs managed by the DFL driver have a port.
In these cases, don't write the Port Access Control register
when enabling SRIOV.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index cfc539a656f0..a5263ac258c5 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1708,6 +1708,8 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 	int ret = 0, port_count = 0;
 
 	mutex_lock(&cdev->lock);
+	if (list_empty(&cdev->port_dev_list))
+		goto done;
 
 	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
 		if (pdata->dev)
-- 
2.17.1

