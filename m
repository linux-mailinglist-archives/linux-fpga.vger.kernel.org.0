Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F75287FE6
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Oct 2020 03:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgJIBOr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Oct 2020 21:14:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:13074 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgJIBOh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Oct 2020 21:14:37 -0400
IronPort-SDR: HAe3UZliHB8CZtHVwVOltxLW6gGgpon9MP2kjHVDTMkSa0zPcJImwFC0huKQ2Fnbe6lbzi83NC
 QJzHaRlsndQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="145294147"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="145294147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 18:14:32 -0700
IronPort-SDR: 8ZCqUCcjJdw6t5yCgaJA5Lg6f8xo/0cyfj/l8wsowFHnclQl54a1xQ0bJNb0MDRMcNN/aNlX4w
 UisEYafStR4Q==
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="462002379"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.33.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 18:14:32 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 6/6] fpga: m10bmc-sec: add max10 get_hw_errinfo callback func
Date:   Thu,  8 Oct 2020 18:14:23 -0700
Message-Id: <20201009011423.22741-7-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009011423.22741-1-russell.h.weight@intel.com>
References: <20201009011423.22741-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Secure Update driver to include
a function that returns 64 bits of additional HW specific
data for errors that require additional information.
This callback function enables the hw_errinfo sysfs
node in the Intel Security Manager class driver.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v3:
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
    driver"
v2:
  - Implemented HW_ERRINFO_POISON for m10bmc_sec_hw_errinfo() to
    ensure that corresponding bits are set to 1 if we are unable
    to read the doorbell or auth_result registers.
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
---
 drivers/fpga/intel-m10-bmc-secure.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 3cf5708f8b0a..70eeccaed05e 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -503,6 +503,30 @@ static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
 	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
 }
 
+#define HW_ERRINFO_POISON	GENMASK(31, 0)
+static u64 m10bmc_sec_hw_errinfo(struct fpga_sec_mgr *smgr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	u32 doorbell, auth_result;
+
+	switch (smgr->err_code) {
+	case FPGA_SEC_ERR_HW_ERROR:
+	case FPGA_SEC_ERR_TIMEOUT:
+	case FPGA_SEC_ERR_BUSY:
+	case FPGA_SEC_ERR_WEAROUT:
+		if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell))
+			doorbell = HW_ERRINFO_POISON;
+
+		if (m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT,
+				    &auth_result))
+			auth_result = HW_ERRINFO_POISON;
+
+		return (u64)doorbell << 32 | (u64)auth_result;
+	default:
+		return 0;
+	}
+}
+
 static const struct fpga_sec_mgr_ops m10bmc_sops = {
 	.user_flash_count = m10bmc_user_flash_count,
 	.bmc_root_entry_hash = m10bmc_bmc_reh,
@@ -521,6 +545,7 @@ static const struct fpga_sec_mgr_ops m10bmc_sops = {
 	.write_blk = m10bmc_sec_write_blk,
 	.poll_complete = m10bmc_sec_poll_complete,
 	.cancel = m10bmc_sec_cancel,
+	.get_hw_errinfo = m10bmc_sec_hw_errinfo,
 };
 
 static int m10bmc_secure_probe(struct platform_device *pdev)
-- 
2.17.1

