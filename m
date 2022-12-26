Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ACF656479
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 19:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLZSBs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 13:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiLZR7v (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 12:59:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CE62AD0;
        Mon, 26 Dec 2022 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672077590; x=1703613590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=atB+m9nZUOA11+fDBKwFKqkPPS5EI/yLNQe6Thmj/QY=;
  b=jGyWo1QdR8UOCezxN1baUwgECbPOplHuSAMmfInp+k1RKuj1dYZAr3px
   wq8yBWCfGqgBL+3FCQR3KPwJVd985m3Tu1WR58rGwqgvghtBuH1lP5kLl
   P8lI2VVIY7OHes30Xk01007VxyApUMurnfaXG+jhLtj3y/lolu65tXXdP
   7aLjA6NvpgFsfLN5H5HnsK5K7AwjB37Qwl/uikOvvbFkh/Wtn+aR6QEK/
   GdgWIZwrM9KFyFtbYUihbruBtp60A3oyUjOIRI07U0W5GQY7QNApdRHPe
   h7foS3AgvsrBL1fxSKmlbn9v0zI8pmENDAnDUbR3aAGKxZHFliV32SAYO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322571021"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="322571021"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:59:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="654810144"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="654810144"
Received: from ptelkov-mobl2.ccr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:59:45 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 07/10] fpga: m10bmc-sec: Create helpers for rsu status/progress checks
Date:   Mon, 26 Dec 2022 19:58:46 +0200
Message-Id: <20221226175849.13056-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
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

RSU_STAT_* and RSU_PROG_* checks are done in more than one place in the sec
update code. Move the checks into new helper functions.

No function changes intended.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 59 +++++++++++++------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 9922027856a4..6e58a463619c 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -257,6 +257,28 @@ static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
 		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
 }
 
+static bool rsu_status_ok(u32 status)
+{
+	return (status == RSU_STAT_NORMAL ||
+		status == RSU_STAT_NIOS_OK ||
+		status == RSU_STAT_USER_OK ||
+		status == RSU_STAT_FACTORY_OK);
+}
+
+static bool rsu_progress_done(u32 progress)
+{
+	return (progress == RSU_PROG_IDLE ||
+		progress == RSU_PROG_RSU_DONE);
+}
+
+static bool rsu_progress_busy(u32 progress)
+{
+	return (progress == RSU_PROG_AUTHENTICATING ||
+		progress == RSU_PROG_COPYING ||
+		progress == RSU_PROG_UPDATE_CANCEL ||
+		progress == RSU_PROG_PROGRAM_KEY_HASH);
+}
+
 static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
 {
 	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
@@ -267,8 +289,7 @@ static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
-	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
-	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
+	if (!rsu_progress_done(rsu_prog(doorbell))) {
 		log_error_regs(sec, doorbell);
 		return FW_UPLOAD_ERR_BUSY;
 	}
@@ -288,7 +309,7 @@ static inline bool rsu_start_done(u32 doorbell)
 		return true;
 
 	progress = rsu_prog(doorbell);
-	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
+	if (!rsu_progress_done(progress))
 		return true;
 
 	return false;
@@ -397,13 +418,7 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
 		return FW_UPLOAD_ERR_RW_ERROR;
 	}
 
-	switch (rsu_stat(doorbell)) {
-	case RSU_STAT_NORMAL:
-	case RSU_STAT_NIOS_OK:
-	case RSU_STAT_USER_OK:
-	case RSU_STAT_FACTORY_OK:
-		break;
-	default:
+	if (!rsu_status_ok(rsu_stat(doorbell))) {
 		log_error_regs(sec, doorbell);
 		return FW_UPLOAD_ERR_HW_ERROR;
 	}
@@ -418,28 +433,16 @@ static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
 	if (m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, doorbell))
 		return -EIO;
 
-	switch (rsu_stat(*doorbell)) {
-	case RSU_STAT_NORMAL:
-	case RSU_STAT_NIOS_OK:
-	case RSU_STAT_USER_OK:
-	case RSU_STAT_FACTORY_OK:
-		break;
-	default:
+	if (!rsu_status_ok(rsu_stat(*doorbell)))
 		return -EINVAL;
-	}
 
-	switch (rsu_prog(*doorbell)) {
-	case RSU_PROG_IDLE:
-	case RSU_PROG_RSU_DONE:
+	if (rsu_progress_done(rsu_prog(*doorbell)))
 		return 0;
-	case RSU_PROG_AUTHENTICATING:
-	case RSU_PROG_COPYING:
-	case RSU_PROG_UPDATE_CANCEL:
-	case RSU_PROG_PROGRAM_KEY_HASH:
+
+	if (rsu_progress_busy(rsu_prog(*doorbell)))
 		return -EAGAIN;
-	default:
-		return -EINVAL;
-	}
+
+	return -EINVAL;
 }
 
 static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
-- 
2.30.2

