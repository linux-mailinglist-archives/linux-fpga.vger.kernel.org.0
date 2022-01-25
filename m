Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537FB49BC1F
	for <lists+linux-fpga@lfdr.de>; Tue, 25 Jan 2022 20:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiAYT3C (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 25 Jan 2022 14:29:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47524 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiAYT27 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 25 Jan 2022 14:28:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CCCE616A6
        for <linux-fpga@vger.kernel.org>; Tue, 25 Jan 2022 19:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A714C340E0;
        Tue, 25 Jan 2022 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643138937;
        bh=UXAD7Xmlhl2zgFcYL5ua1JLlDJ6SU/P9hPJ2090eA7U=;
        h=From:To:Cc:Subject:Date:From;
        b=fqtbfOHHJuCbMfNTGXlvbO0rn2oRh4sx9vvZNIjGaPybOKtQ8fwzS0U5llU93WOUc
         xYui8QaDODvHR+43QLGC+qvtxdoNIyHNYIZ9JcVtcStoDBavzXM+Uj67gP7AlZSxy0
         R2ZSEUZwy49ZSGvcmfJGMvVggflzC++Q50sIEvWut8G3dAhaOSYqa8TasZ1WOrs8CQ
         T6oX0+2je57LaEfpnlV+xUXuwycE3+6M5ppB10kIs2F5Exdn5uAgGL+2un4lUVeOc9
         FWq5/PFGGsIU36MH6ub84BNzFgVwl4mdR16z65Cijup+qlMuawhBBkxap984slfwJu
         x1svpbQcd4WCA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     mdf@kernel.org
Cc:     dinguyen@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCH] firmware: stratix10-svc: extend SVC driver to get the firmware version
Date:   Tue, 25 Jan 2022 13:28:53 -0600
Message-Id: <20220125192853.1956486-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Extend Intel service layer driver to get the firmware version running at
FPGA device. Therefore FPGA manager driver, one of Intel service layer
driver's client, can decide whether to handle the newly added bitstream
authentication function based on the retrieved firmware version.

Acked-by: Moritz Fischr <mdf@kernel.org>
Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c              |  9 +++++++-
 include/linux/firmware/intel/stratix10-smc.h  | 21 +++++++++++++++++--
 .../firmware/intel/stratix10-svc-client.h     |  4 ++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 29c0a616b317..4bd57a908efe 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -306,6 +306,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		break;
 	case COMMAND_RSU_RETRY:
 	case COMMAND_RSU_MAX_RETRY:
+	case COMMAND_FIRMWARE_VERSION:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
@@ -422,6 +423,11 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		case COMMAND_FIRMWARE_VERSION:
+			a0 = INTEL_SIP_SMC_FIRMWARE_VERSION;
+			a1 = 0;
+			a2 = 0;
+			break;
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -491,7 +497,8 @@ static int svc_normal_to_secure_thread(void *data)
 			 */
 			if ((pdata->command == COMMAND_RSU_RETRY) ||
 			    (pdata->command == COMMAND_RSU_MAX_RETRY) ||
-				(pdata->command == COMMAND_RSU_NOTIFY)) {
+			    (pdata->command == COMMAND_RSU_NOTIFY) ||
+			    (pdata->command == COMMAND_FIRMWARE_VERSION)) {
 				cbdata->status =
 					BIT(SVC_STATUS_NO_SUPPORT);
 				cbdata->kaddr1 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index c3e5ab014caf..aad497a9ad8b 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -321,8 +321,6 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_ECC_DBE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
 
-#endif
-
 /**
  * Request INTEL_SIP_SMC_RSU_NOTIFY
  *
@@ -404,3 +402,22 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY 18
 #define INTEL_SIP_SMC_RSU_MAX_RETRY \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
+
+/**
+ * Request INTEL_SIP_SMC_FIRMWARE_VERSION
+ *
+ * Sync call used to query the version of running firmware
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FIRMWARE_VERSION
+ * a1-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR
+ * a1 running firmware version
+ */
+#define INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION 31
+#define INTEL_SIP_SMC_FIRMWARE_VERSION \
+        INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
+
+#endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 19781b0f6429..18c1841fdb1f 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -104,6 +104,9 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
+ * is SVC_STATUS_OK or SVC_STATUS_ERROR
  */
 enum stratix10_svc_command_code {
 	COMMAND_NOOP = 0,
@@ -117,6 +120,7 @@ enum stratix10_svc_command_code {
 	COMMAND_RSU_RETRY,
 	COMMAND_RSU_MAX_RETRY,
 	COMMAND_RSU_DCMF_VERSION,
+	COMMAND_FIRMWARE_VERSION,
 };
 
 /**
-- 
2.25.1

