Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A190B16B96A
	for <lists+linux-fpga@lfdr.de>; Tue, 25 Feb 2020 07:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgBYGJM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 25 Feb 2020 01:09:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:13719 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYGJM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 25 Feb 2020 01:09:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 22:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="230054572"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga007.fm.intel.com with ESMTP; 24 Feb 2020 22:09:10 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH] fpga: dfl: pci: fix return value of cci_pci_sriov_configure
Date:   Tue, 25 Feb 2020 14:07:18 +0800
Message-Id: <1582610838-7019-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

pci_driver.sriov_configure should return negative value on error and
number of enabled VFs on success. But now the driver returns 0 on
success. The sriov configure still works but will cause a warning
message:

  XX VFs requested; only 0 enabled

This patch changes the return value accordingly.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 89ca292..5387550 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -248,11 +248,13 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 			return ret;
 
 		ret = pci_enable_sriov(pcidev, num_vfs);
-		if (ret)
+		if (ret) {
 			dfl_fpga_cdev_config_ports_pf(cdev);
+			return ret;
+		}
 	}
 
-	return ret;
+	return num_vfs;
 }
 
 static void cci_pci_remove(struct pci_dev *pcidev)
-- 
2.7.4

