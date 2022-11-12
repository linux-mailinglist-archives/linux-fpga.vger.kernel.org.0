Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A0626886
	for <lists+linux-fpga@lfdr.de>; Sat, 12 Nov 2022 10:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiKLJ3q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 12 Nov 2022 04:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiKLJ3p (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 12 Nov 2022 04:29:45 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B3EDF49
        for <linux-fpga@vger.kernel.org>; Sat, 12 Nov 2022 01:29:44 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8Vdf2v5kz15MWp;
        Sat, 12 Nov 2022 17:29:26 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 17:29:42 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 17:29:42 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>
CC:     <linux-fpga@vger.kernel.org>
Subject: [PATCH] fpga: m10bmc-sec: Fix undefined reference error in m10bmc_sec_remove()
Date:   Sat, 12 Nov 2022 17:34:46 +0800
Message-ID: <20221112093446.61726-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Building with CONFIG_FW_LOADER=m && CONFIG_FW_UPLOAD=y causes
errors:

ld: drivers/fpga/intel-m10-bmc-sec-update.o: in function `m10bmc_sec_remove':
intel-m10-bmc-sec-update.c:(.text+0x25b): undefined reference to `firmware_upload_unregister'
ld: drivers/fpga/intel-m10-bmc-sec-update.o: in function `m10bmc_sec_probe':
intel-m10-bmc-sec-update.c:(.text+0x3c1): undefined reference to `firmware_upload_register'

When CONFIG_FW_LOADER is configed with module, the firmware_upload_unregister()
could not be seen in m10bmc_sec_remove(), it is controlled by CONFIG_FW_UPLOAD
that it depends CONFIG_FW_LOADER. We fix it by adding FW_LOADER in
FPGA_M10_BMC_SEC_UPDATE depends.

Fixes: 5cd339b370e2 ("fpga: m10bmc-sec: add max10 secure update functions")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 6c416955da53..cfc684e9be9a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -246,7 +246,7 @@ config FPGA_MGR_VERSAL_FPGA
 
 config FPGA_M10_BMC_SEC_UPDATE
 	tristate "Intel MAX10 BMC Secure Update driver"
-	depends on MFD_INTEL_M10_BMC && FW_UPLOAD
+	depends on MFD_INTEL_M10_BMC && FW_UPLOAD && FW_LOADER
 	help
 	  Secure update support for the Intel MAX10 board management
 	  controller.
-- 
2.25.1

