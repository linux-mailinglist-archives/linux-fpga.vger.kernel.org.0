Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B464CCB1
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Dec 2022 15:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiLNOua (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Dec 2022 09:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiLNOu3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 14 Dec 2022 09:50:29 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA42F3;
        Wed, 14 Dec 2022 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671029429; x=1702565429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XTkX6HcEGJ1UBW6COm+l+2Y+4S1QKisQtPhX0zyA/4c=;
  b=ajJ3KAk6t0Lpca42PuzNnOzTw8LloHU1gZ6WSgaULN61VsIwuuajU6zA
   muAg/w6iKjhtSVfFAHZTGeotfS7/cZwylnTZYOKqWRe0B/9P7oip5PYPj
   jrj5ir1hTV7XOIOoLAWsesylMjl//iseGVYJ7dq1J3Z9OsHc7FA9wzbxe
   DPdQv27d/HWaxOS+uShFpeDElNLVTblHrfUAt+RMb6pOzNo3K81+kRd9i
   T2WY4YTTJ92aDZbXJ1U/SseatWtYsPRORW3ZOSZWrstA3ONksCDIFfE9v
   relQmzwbvYkar6NKpB48LGKA06ONgab+aaGQkLhHFNyPShPBPi5wY+pn6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="320278599"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="320278599"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 06:50:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="977856375"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="977856375"
Received: from pnasahl-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.61.89])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 06:50:11 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Russ Weight <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Marco Pagani <marpagan@redhat.com>
Subject: [PATCH v2 1/1] fpga: m10bmc-sec: Fix probe rollback
Date:   Wed, 14 Dec 2022 16:49:52 +0200
Message-Id: <20221214144952.8392-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Handle probe error rollbacks properly to avoid leaks.

Fixes: 5cd339b370e2 ("fpga: m10bmc-sec: add max10 secure update functions")
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Marco Pagani <marpagan@redhat.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
I don't know if the previous one fell through cracks so resending this.

v2:
- Resending v1 with Marco's Rev-by

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

