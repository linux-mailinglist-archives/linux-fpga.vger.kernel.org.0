Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9566A33977A
	for <lists+linux-fpga@lfdr.de>; Fri, 12 Mar 2021 20:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhCLTg4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 12 Mar 2021 14:36:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:44156 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234236AbhCLTg2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 12 Mar 2021 14:36:28 -0500
IronPort-SDR: gyceshfzzzdXt8I7rjbSC4bSLGJCCvoeB0CZqRVo7ByIbUGlBq92nkkh4xJLn5PUANP8hvzEZS
 T/m4BCNNx22g==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168796319"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="168796319"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 11:36:28 -0800
IronPort-SDR: AXXRLLvEKXcClPKEoA8tf3GszEvhMuOCrKLFNnosMhc3pZgIlSBjczl/PAFsvvkWNLQFDzjGdU
 8lyjnIXAHSBQ==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="510426171"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.51.149])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 11:36:28 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v10 5/5] fpga: m10bmc-sec: add max10 get_hw_errinfo callback func
Date:   Fri, 12 Mar 2021 11:36:23 -0800
Message-Id: <20210312193623.326306-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312193623.326306-1-russell.h.weight@intel.com>
References: <20210312193623.326306-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
v10:
  - No change
v9:
  - No change
v8:
  - Previously patch 6/6, otherwise no change
v7:
  - No change
v6:
  - Initialized auth_result and doorbell to HW_ERRINFO_POISON
    in m10bmc_sec_hw_errinfo() and removed unnecessary if statements.
v5:
  - No change
v4:
  - No change
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
 drivers/fpga/intel-m10-bmc-secure.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index a290fcc4df4a..3a049c98cf43 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -476,11 +476,33 @@ static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
 	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
 }
 
+#define HW_ERRINFO_POISON	GENMASK(31, 0)
+static u64 m10bmc_sec_hw_errinfo(struct fpga_sec_mgr *smgr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	u32 auth_result = HW_ERRINFO_POISON;
+	u32 doorbell = HW_ERRINFO_POISON;
+
+	switch (smgr->err_code) {
+	case FPGA_SEC_ERR_HW_ERROR:
+	case FPGA_SEC_ERR_TIMEOUT:
+	case FPGA_SEC_ERR_BUSY:
+	case FPGA_SEC_ERR_WEAROUT:
+		m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+		m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result);
+
+		return (u64)doorbell << 32 | (u64)auth_result;
+	default:
+		return 0;
+	}
+}
+
 static const struct fpga_sec_mgr_ops m10bmc_sops = {
 	.prepare = m10bmc_sec_prepare,
 	.write_blk = m10bmc_sec_write_blk,
 	.poll_complete = m10bmc_sec_poll_complete,
 	.cancel = m10bmc_sec_cancel,
+	.get_hw_errinfo = m10bmc_sec_hw_errinfo,
 };
 
 static int m10bmc_secure_probe(struct platform_device *pdev)
-- 
2.25.1

