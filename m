Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D765219A9A
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jul 2020 10:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGIIRC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Jul 2020 04:17:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:54747 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgGIIRC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 Jul 2020 04:17:02 -0400
IronPort-SDR: A3sxhHc6SCgm6RSxqC8W4Az7pL5lz+m+XErCl7KmqnN71rLEiymCjh+v14sNK54WO6fttZMDu4
 jHXRfdP0/PSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="166052439"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="166052439"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 01:17:00 -0700
IronPort-SDR: ZTMTk9gYP1YzcOfI7XRvFdTsEOEl6fGWxZdnxUFGZfWh8zl2/CEY8VgJWZ1ExCN6l5jISXPfb5
 XsELBew+cDhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="268697878"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2020 01:16:58 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [RESEND PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Date:   Thu,  9 Jul 2020 16:12:16 +0800
Message-Id: <1594282337-32125-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
References: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
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
Acked-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4a14a24..73b5153 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -285,7 +285,6 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 {
 	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
 	struct dfl_fpga_cdev *cdev = drvdata->cdev;
-	int ret = 0;
 
 	if (!num_vfs) {
 		/*
@@ -297,6 +296,8 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 		dfl_fpga_cdev_config_ports_pf(cdev);
 
 	} else {
+		int ret;
+
 		/*
 		 * before enable SRIOV, put released ports into VF access mode
 		 * first of all.
-- 
2.7.4

