Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF934C83FE
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 07:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiCAGZh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 01:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiCAGZf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 01:25:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2171C8B;
        Mon, 28 Feb 2022 22:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646115892; x=1677651892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=24p7OOw6w729bcrujGtk33vHmfAenl7pX1TqgA5rAzs=;
  b=HSdvxiPf9upVZaKwKJI66Mi8R9OhyrzKRF4Z4h99EFO66IYJBDmgTmbe
   vBxktTDfMBXCjh87Svugr7oMuUtcA+daq/ab/xqTqPhLL1hvvNF9s7Afx
   lfIUhpz/as2thnnUJMdqxzLRQtvSt8rZ/Fbe4rSiW7PVP9q0MdUpiy9UF
   JsC/JH0C6fmIqZX2qwiJWWalR2SbtoO3ZE33G0qL22nQ4PGSphvOB3WGK
   VpdMAB/TSwdV8gPe5NPBjQ/jGMC73IBg+Mtq+K7zGLzn4zUZppyWdBnf8
   5fvRhVJYhCGPCVI5UO5Oj4UbfOuoTLLm/WhOILCoUKOoaTPuVn7b+dcQz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251900319"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="251900319"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="708941766"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 22:24:42 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 3/5] fpga: dfl: fix VF creation in OFS
Date:   Tue,  1 Mar 2022 01:21:21 -0500
Message-Id: <20220301062123.818687-4-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220301062123.818687-1-tianfei.zhang@intel.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In OFS legacy model, there is only 1 Port device related to
1 VF, the flag DFL_FEAT_PORT_CONNECTED_AFU will take notes for
this model. In legacy model, it need to check the released port
number match VF device number or not. But in "Multiple VFs per
PR slot" model, the Port device would not connected to AFU/PR
slot, so we don't need to release the Port device before creating
the VFs.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 5872031c2e9f..fd04ef5c8b03 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1702,11 +1702,13 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 
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
+	if ((cdev->features & DFL_FEAT_PORT_CONNECTED_AFU) &&
+	    cdev->released_port_num != num_vfs) {
 		ret = -EINVAL;
 		goto done;
 	}
-- 
2.26.2

