Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E300225E450
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 01:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgIDXx2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 19:53:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:64696 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbgIDXxY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Sep 2020 19:53:24 -0400
IronPort-SDR: QpNcjZNP9wvgadeR55Efh2M3kw9Ym1n3IJokRGpORpBp2R7s8h+EtsVxmyTwFeAjzxxw225Xqb
 P3cjMSoQJ2/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219386219"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="219386219"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 16:53:20 -0700
IronPort-SDR: EMeUMxuTkHFBA2CB9KPJpLPRA22Udhc1zLg8PlndRF++SF0ck+vTnBM1M0otE0A5MPwIUa+fGO
 taflrfMea+ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="284656595"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.151.80])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 16:53:20 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 12/12] fpga: add max10 get_hw_errinfo callback func
Date:   Fri,  4 Sep 2020 16:53:05 -0700
Message-Id: <20200904235305.6254-13-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Security Engine driver to include
a function that returns 64 bits of additional HW specific
data for errors that require additional information.
This callback function enables the hw_errinfo sysfs
node in the Intel Security Manager class driver.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/intel-m10-bmc-secure.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 4a66c2d448eb..7fb1c805f654 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -450,6 +450,30 @@ static enum ifpga_sec_err m10bmc_sec_cancel(struct ifpga_sec_mgr *imgr)
 	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
 }
 
+static u64 m10bmc_sec_hw_errinfo(struct ifpga_sec_mgr *imgr)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	u32 doorbell = 0, auth_result = 0;
+	u64 hw_errinfo = 0;
+
+	switch (imgr->err_code) {
+	case IFPGA_SEC_ERR_HW_ERROR:
+	case IFPGA_SEC_ERR_TIMEOUT:
+	case IFPGA_SEC_ERR_BUSY:
+	case IFPGA_SEC_ERR_WEAROUT:
+		if (!m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell))
+			hw_errinfo = (u64)doorbell << 32;
+
+		if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT,
+				     &auth_result))
+			hw_errinfo |= (u64)auth_result;
+
+		return hw_errinfo;
+	default:
+		return 0;
+	}
+}
+
 static const struct ifpga_sec_mgr_ops m10bmc_iops = {
 	.user_flash_count = get_qspi_flash_count,
 	.bmc_root_entry_hash = get_bmc_root_entry_hash,
@@ -467,7 +491,8 @@ static const struct ifpga_sec_mgr_ops m10bmc_iops = {
 	.prepare = m10bmc_sec_prepare,
 	.write_blk = m10bmc_sec_write_blk,
 	.poll_complete = m10bmc_sec_poll_complete,
-	.cancel = m10bmc_sec_cancel
+	.cancel = m10bmc_sec_cancel,
+	.get_hw_errinfo = m10bmc_sec_hw_errinfo
 };
 
 static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)
-- 
2.17.1

