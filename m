Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4EE4B4EF3
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 12:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352179AbiBNLjn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 06:39:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352021AbiBNLja (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 06:39:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D07DF40;
        Mon, 14 Feb 2022 03:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644838185; x=1676374185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LyVZUfq/4Kt0u89YufhzKsBwro574htmaUqau0RQcl0=;
  b=bV7YjWRDXHWJeQFEoqNSyv7beWasxmTvNQB33sA6mqmBi/z0raVD8Tck
   X+wxmHFswIP8z4CE2M8b3pGxh8xncZ3VD5IUvqsDNKhbHcAHv7Oesi9IX
   W+q/TVfTehdEYK1zNrtXMCMhb2UL9UZg141z5AQThVSXdZvBo32EWwNqa
   Shvl5CWJeE25o+LNPR1M84/qiKoVXOc9zq4OeRoYQFAQKsKFt/8jzyFgX
   E/+w4vXb0iFR3s6Ol3QWntomASwZnZACMQasFI2ZldQG7OqQWFcd9545H
   dLFHfxs9jijYX3Ciopc6wPivu3q30f7MJLWb7a/qUa5Fiuc6bsuvn9Uoh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250276737"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250276737"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:29:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587167021"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2022 03:29:42 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 4/7] fpga: dfl: fix VF creation when ports have no local BAR space
Date:   Mon, 14 Feb 2022 06:26:16 -0500
Message-Id: <20220214112619.219761-5-tianfei.zhang@intel.com>
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

When a port is not connected to the same PCIe endpoint as
the FME, the port does not need to be released before being
virtualized.  Fix VF creation code to handle this new use
case.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 26f8cf890700..cfc539a656f0 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1705,15 +1705,22 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_pf);
 int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 {
 	struct dfl_feature_platform_data *pdata;
-	int ret = 0;
+	int ret = 0, port_count = 0;
 
 	mutex_lock(&cdev->lock);
+
+	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
+		if (pdata->dev)
+			continue;
+		port_count++;
+	}
+
 	/*
 	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
 	 * device, so if released port number doesn't match VF device number,
 	 * then reject the request with -EINVAL error code.
 	 */
-	if (cdev->released_port_num != num_vfs) {
+	if (port_count && cdev->released_port_num != num_vfs) {
 		ret = -EINVAL;
 		goto done;
 	}
-- 
2.17.1

