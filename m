Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2324FCF82
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Apr 2022 08:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiDLG3b (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Apr 2022 02:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiDLG3a (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Apr 2022 02:29:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255B15828;
        Mon, 11 Apr 2022 23:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649744834; x=1681280834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8QDzp55a7WCEth8wc6ftiMU8vQrEl5riiXtIWJPQCQI=;
  b=dttSRCsSl7JR+cEp+rVUuY9ab8d22vfGPkDiZIWClY9RdjJlPw26XOq4
   GqKXicf6+IuIawqkRhbgDKPjwV0SMI67kfhq9ze5pxLHohE6frQ7TctzT
   WgBbiq1pDoYnlZ2dSFLZmKPLyT9JTQlqK06v2//Ii8xnAUSQGV4BYPlDp
   HgzlzzY2JMoM+eXNswbfxOMx+w8ycGsukD+eNAJ/wCpTFxlXW4sDtSW/U
   AvKI8Saz3FJ2yAXRJQn4s9SGJyxJqyF7yAXlMK3rfK6BRk3GMvSr4VwVc
   K6HlNb5KSnVZwRhCRP8ox/GkEjedOvLmQKn5Zyywx1C7TNn5j0ZfRgv76
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244171726"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="244171726"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="724306816"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2022 23:27:11 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2] uio: dfl: add HSSI feature id
Date:   Tue, 12 Apr 2022 02:23:53 -0400
Message-Id: <20220412062353.53984-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
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

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add the feature id of the OFS HSSI (High Speed Serial Interface)
subsystem to table of ids supported by the uio_dfl driver. HSSI
subsystem consists of harden/soft Ethernet MAC to support various
ethernet usages and PCS/FEC/PMA direct modes for non-ethernet usages.

We leverage the uio_dfl driver to access the HSSI subsystem on user space,
because the HSSI subsystem was designed for specific purposes and does
not fit into the standard MAC and net kernel subsystems.

The Feature ID table of DFL can be found:
https://github.com/OPAE/dfl-feature-id

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
v2: add HSSI introduction and the git repo of Feature ID table.
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

