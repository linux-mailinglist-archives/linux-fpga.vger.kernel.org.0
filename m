Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7959133C9F0
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Mar 2021 00:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhCOXgI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 15 Mar 2021 19:36:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:41776 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231775AbhCOXfi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 15 Mar 2021 19:35:38 -0400
IronPort-SDR: FbpVKuTP3BVj3tHOlhimf6X3bcNOMGxvxaND306yMBFYmPG6GBjZFd3BGZWxwQkarTu5Cmbjwv
 VAeklHwNBrJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="188529304"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="188529304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 16:35:38 -0700
IronPort-SDR: 4fjEspWGJ5rdy2IIbRzJ1w7oiVrBt9gwg9nmFC3lZfVy2XKEZfVlTJbOCpyau6xGmvKuXSfWFF
 hx3COKdR/Jsw==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="405346628"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.252.128.229])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 16:35:37 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v11 5/5] fpga: m10bmc-sec: add max10 get_hw_errinfo callback func
Date:   Mon, 15 Mar 2021 16:35:32 -0700
Message-Id: <20210315233532.387145-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315233532.387145-1-russell.h.weight@intel.com>
References: <20210315233532.387145-1-russell.h.weight@intel.com>
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
v11:
  - No change
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

