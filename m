Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2246E63D173
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Nov 2022 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiK3JML (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Nov 2022 04:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiK3JMK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Nov 2022 04:12:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E3C48750;
        Wed, 30 Nov 2022 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669799529; x=1701335529;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=py1SBMBVVU48iDA5LU0KMlUzrgX30r8T7STfDBWamSk=;
  b=l2+4CYAt/r4oKkttAJ3g2Bl76Iroez1Fto4d/z7V1QBF3pYeXFb85kE6
   IOw8DjWF1bKT5xq4qUZoRkEFSEhA9xvc2YY+EWctHtqzNmJyQuLIHKh8C
   oU0tM4jQy+p7GmSW6RDCI3S/5eicr9ftqzYa/Y8QMrZ/oSobjys9RCl9T
   m2xgySTRlNNyn6ot4+UtzwtrndMPVTlqT8Tiw1UFgJT0FMevzTG12DXwC
   kcovDjcyIgQBFMsRF/EmBNqa2cd7Jrr0sgqyv2oFMeG/Gbb8ja+nX3wzD
   vdGx5BPp2Y6dS/oJ8VEVMrqkCC7Fmcy7lkotV3q6nB4nFfPLEQ5Magk2r
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="316499267"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="316499267"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 01:12:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="750261351"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="750261351"
Received: from cignatx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.51.239])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 01:12:06 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Russ Weight <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 1/1] fpga: m10bmc-sec: Fix probe rollback
Date:   Wed, 30 Nov 2022 11:11:58 +0200
Message-Id: <20221130091158.4732-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Handle probe error rollbacks properly to avoid leaks.

Fixes: 5cd339b370e2 ("fpga: m10bmc-sec: add max10 secure update functions")
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 79d48852825e..03f1bd81c434 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -574,20 +574,27 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
 	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
 			sec->fw_name_id);
 	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
-	if (!sec->fw_name)
-		return -ENOMEM;
+	if (!sec->fw_name) {
+		ret = -ENOMEM;
+		goto fw_name_fail;
+	}
 
 	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
 				       &m10bmc_ops, sec);
 	if (IS_ERR(fwl)) {
 		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
-		kfree(sec->fw_name);
-		xa_erase(&fw_upload_xa, sec->fw_name_id);
-		return PTR_ERR(fwl);
+		ret = PTR_ERR(fwl);
+		goto fw_uploader_fail;
 	}
 
 	sec->fwl = fwl;
 	return 0;
+
+fw_uploader_fail:
+	kfree(sec->fw_name);
+fw_name_fail:
+	xa_erase(&fw_upload_xa, sec->fw_name_id);
+	return ret;
 }
 
 static int m10bmc_sec_remove(struct platform_device *pdev)
-- 
2.30.2

