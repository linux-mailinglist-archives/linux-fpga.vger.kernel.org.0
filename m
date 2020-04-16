Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449C41AB61F
	for <lists+linux-fpga@lfdr.de>; Thu, 16 Apr 2020 05:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbgDPDO5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Apr 2020 23:14:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:45062 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389912AbgDPDOx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Apr 2020 23:14:53 -0400
IronPort-SDR: d5dHlkifhnTjJsAgs7Q+lkOfDb7BEzhxhNgz+hYeUojNVXZ08gRFQyl11a65sbn7YkOV/nY1H0
 FWsX17WTJFyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 20:14:53 -0700
IronPort-SDR: uDnLVJKv88DpbSZzFNJz4QBuz4G1YKI3QyZK4Z5+UWCOE0RNk4p8np7ypZKqwzCBTY/T6QfZy1
 e1iA+IfKKdfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="454164527"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 20:14:51 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Date:   Thu, 16 Apr 2020 11:11:51 +0800
Message-Id: <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This is to fix lkp cppcheck warnings:

 drivers/fpga/dfl-pci.c:230:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
    int ret = 0;
        ^

 drivers/fpga/dfl-pci.c:230:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
    int ret = 0;
            ^

Fixes: 3c2760b78f90 ("fpga: dfl: pci: fix return value of cci_pci_sriov_configure")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 5387550..a78c409 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -227,7 +227,6 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 {
 	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
 	struct dfl_fpga_cdev *cdev = drvdata->cdev;
-	int ret = 0;
 
 	if (!num_vfs) {
 		/*
@@ -239,6 +238,8 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 		dfl_fpga_cdev_config_ports_pf(cdev);
 
 	} else {
+		int ret;
+
 		/*
 		 * before enable SRIOV, put released ports into VF access mode
 		 * first of all.
-- 
2.7.4

