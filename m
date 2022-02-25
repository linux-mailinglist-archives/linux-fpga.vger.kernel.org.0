Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E654C3C41
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Feb 2022 04:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiBYDN5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Feb 2022 22:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiBYDNy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Feb 2022 22:13:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FA74618;
        Thu, 24 Feb 2022 19:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645758801; x=1677294801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwdCvXzSdTBDzvJOc2d5fc844vP3KlSqJURgIRaEWqs=;
  b=FMmsHONSgVQ9dSUzhiiW8rpdlNKz8FaqEzHDJvKwDsh4ulXSuTGTpV4t
   fUxcx83oNSG/icbTawHHsQJpWxU1s5t8UWMAqaR7YWsi7HB4oGe/x3sY+
   SI6GsJYqPdYEGCXu94eJlGSAkx5OR8wFYcY2zpqFoVqp+tNExgCql3GUh
   /FGoQMiUXnVxpxNcRY/ZYhxmlchb597TLUpp3HKrbhFurArYzQwUdag27
   PgUZ3fFKW/uOsXaU1dwo+xaC1UKPqTBwAXMLptDmSscsNgmSNadSaTipk
   PXZ8zn64nHvSFsKijjy7ztOLyFZS1AJOCbOU4dd97JlIsqZpWJkpss9d3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252602995"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="252602995"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="684512482"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 19:13:18 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 3/5] fpga: dfl: fix VF creation in IOFS
Date:   Thu, 24 Feb 2022 22:10:00 -0500
Message-Id: <20220225031002.261264-4-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220225031002.261264-1-tianfei.zhang@intel.com>
References: <20220225031002.261264-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In IOFS legacy model, there is only 1 Port device related to
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
index 9b7a01a4af04..afa9311c30d5 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1708,11 +1708,13 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 
 	mutex_lock(&cdev->lock);
 	/*
-	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
-	 * device, so if released port number doesn't match VF device number,
-	 * then reject the request with -EINVAL error code.
+	 * In the IOFS legacy model, it can't turn multiple ports into 1 VF
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

