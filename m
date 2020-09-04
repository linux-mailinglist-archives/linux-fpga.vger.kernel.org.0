Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C70925E465
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 01:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIDXyD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 19:54:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:64701 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgIDXxR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Sep 2020 19:53:17 -0400
IronPort-SDR: wXZzE7G/Cfs3my7w763kKgrOWbnA0VjtAJYMHaT/36iIV6xW5xxf3EOsJAu+LI6rnWmQwNiijr
 8ZDpATMneUMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219386190"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="219386190"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 16:53:15 -0700
IronPort-SDR: 7uAvyzgKfXtYLIKsTQnUbnhvYtRNTXkDlnIRQIqmSAufRqNMrgaSuZw3kV3pnSu4vTTExlNrS0
 55/i2LEGnssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="284656204"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.151.80])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 16:53:15 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 03/12] fpga: expose max10 flash update counts in sysfs
Date:   Fri,  4 Sep 2020 16:52:56 -0700
Message-Id: <20200904235305.6254-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Security Engine driver to provide a
handler to expose the flash update count for the FPGA user
image.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/intel-m10-bmc-secure.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 1f86bfb694b4..b824790e43aa 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -10,6 +10,7 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 
 struct m10bmc_sec {
@@ -99,7 +100,38 @@ SYSFS_GET_REH(bmc, BMC_REH_ADDR)
 SYSFS_GET_REH(sr, SR_REH_ADDR)
 SYSFS_GET_REH(pr, PR_REH_ADDR)
 
+#define FLASH_COUNT_SIZE 4096
+#define USER_FLASH_COUNT 0x17ffb000
+
+static int get_qspi_flash_count(struct ifpga_sec_mgr *imgr)
+{
+	struct m10bmc_sec *sec = imgr->priv;
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	unsigned int cnt, num_bits = FLASH_COUNT_SIZE * 8;
+	u8 *flash_buf;
+	int ret;
+
+	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
+	if (!flash_buf)
+		return -ENOMEM;
+
+	ret = m10bmc_raw_bulk_read(sec->m10bmc, USER_FLASH_COUNT, flash_buf,
+				   FLASH_COUNT_SIZE / stride);
+	if (ret) {
+		dev_err(sec->dev, "%s failed to read %d\n", __func__, ret);
+		goto exit_free;
+	}
+
+	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
+
+exit_free:
+	kfree(flash_buf);
+
+	return ret ? : cnt;
+}
+
 static const struct ifpga_sec_mgr_ops m10bmc_iops = {
+	.user_flash_count = get_qspi_flash_count,
 	.bmc_root_entry_hash = get_bmc_root_entry_hash,
 	.sr_root_entry_hash = get_sr_root_entry_hash,
 	.pr_root_entry_hash = get_pr_root_entry_hash,
-- 
2.17.1

