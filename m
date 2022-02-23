Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D46E4C15C9
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Feb 2022 15:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbiBWOuE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Feb 2022 09:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241833AbiBWOt7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Feb 2022 09:49:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AABB7C4F;
        Wed, 23 Feb 2022 06:49:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C95DB8202D;
        Wed, 23 Feb 2022 14:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361D9C340EB;
        Wed, 23 Feb 2022 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645627756;
        bh=gxAGo4b0v57N7jVzornWJEyiwfV55DHPGKrZBE3s430=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axMEMzkR1V0+qAYfRXDphDj+k6YfoU3TFdrtuIaMZnv8PihvBYjn3fWuS51lnrEjL
         0aCGuObKaoMF2tsQ9hBslDh7EkWuIOfHSA/ZKqa60AdRI+TpblTV+OrV7SFyvBRgIg
         PhA55khY/Yyp9dhtY0YODpSIrw4K1cifdnr7bz4sd2aymHZEPT3Cf4wI7GF1js7wdC
         Wq/AbZuU2vac3rH2nFhxAqT2BCU0jZ7P/rFdkJXCR+Z1GcfvruVlrtiB2bDgMADlpI
         CqCpqeTtd7Ny2iHO+tBKy2i9/7kgrggSlTPorvrm6HMGRFmaS+47BWLgcfIkZG7sZ8
         GPh3EV5CPbYpw==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Richard Gong <richard.gong@intel.com>,
        Moritz Fischr <mdf@kernel.org>
Subject: [PATCH 2/2] firmware: stratix10-svc: extend SVC driver to get the firmware version
Date:   Wed, 23 Feb 2022 08:49:08 -0600
Message-Id: <20220223144908.399522-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223144908.399522-1-dinguyen@kernel.org>
References: <20220223144908.399522-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Extend Intel service layer driver to get the firmware version running at
FPGA device. Therefore FPGA manager driver, one of Intel service layer
driver's client, can decide whether to handle the newly added bitstream
authentication function based on the retrieved firmware version.

Link: https://lore.kernel.org/lkml/1617114785-22211-2-git-send-email-richard.gong@linux.intel.com
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

