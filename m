Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83C1717424
	for <lists+linux-fpga@lfdr.de>; Wed, 31 May 2023 05:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjEaDIq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 May 2023 23:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjEaDIp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 May 2023 23:08:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18E11C;
        Tue, 30 May 2023 20:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685502523; x=1717038523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V3cDe9f+7Mze6MfLPs/WzCyH4ERi8cL+6UprwLcnMEk=;
  b=XEmxiPTrWFkaN7P0TJrcI+phJoR7jzR0i2fd8822EOlxGR0pz9gdup87
   kmgE9qmnja4XAaHmMW+324EZY4d3Rrr9jr674jNSiYJtjKnHe3KpU9e/x
   Lm+yMr+PxSzkZqImzzVZPT+XyIvGpP5qirCEhSPEbSvtpJ5qnW+YkTAKv
   7kINQ0s6HZWOS4TO1USHNVTbZgdin9UGnA3wW459h5Vwum+1pMQnD55tb
   8TgrQ5T6gSlVsanUdRaO12359dNURUmUCqB4tY9okMGr68tuo3l9a7uNH
   rYFgbYuMGOAsvGiFI9OLJ+TJIe2Y39zWb9sdGiUXEtRhRtpQjOV/QRy0K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357505742"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357505742"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="851045452"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="851045452"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:08:41 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     hao.wu@intel.com, yilun.xu@intel.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     aaron.j.grier@intel.com, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH] uio: dfl: add vendor-specific feature id
Date:   Tue, 30 May 2023 23:07:37 -0400
Message-Id: <20230531030737.12989-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add a Device Feature List (DFL) feature id as a generic mechanism
to expose a vendor-specific FPGA IP to user space. The feature id
is intended for use with IPs that do not need any kernel services
beyond exposure to user space through the UIO DFL driver.

The feature id is used in, e.g., Intel Oak Springs Canyon IPUs
to expose various IPs to user space, e.g., Network Controller
Sideband Interface (NC-SI), BaseNIC, and VirtIO management.

Link: https://github.com/OPAE/dfl-feature-id
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/uio/uio_dfl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
index 69e93f3e7faf..6d99e5a06ae8 100644
--- a/drivers/uio/uio_dfl.c
+++ b/drivers/uio/uio_dfl.c
@@ -46,11 +46,13 @@ static int uio_dfl_probe(struct dfl_device *ddev)
 
 #define FME_FEATURE_ID_ETH_GROUP	0x10
 #define FME_FEATURE_ID_HSSI_SUBSYS	0x15
+#define FME_FEATURE_ID_VENDOR_SPECIFIC	0x23
 #define PORT_FEATURE_ID_IOPLL_USRCLK	0x14
 
 static const struct dfl_device_id uio_dfl_ids[] = {
 	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
 	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
+	{ FME_ID, FME_FEATURE_ID_VENDOR_SPECIFIC },
 	{ PORT_ID, PORT_FEATURE_ID_IOPLL_USRCLK },
 	{ }
 };
-- 
2.28.0

