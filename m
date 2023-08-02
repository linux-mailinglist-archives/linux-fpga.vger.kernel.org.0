Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF76E76C7AE
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Aug 2023 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjHBH51 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Aug 2023 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjHBH5D (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Aug 2023 03:57:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFC04C12
        for <linux-fpga@vger.kernel.org>; Wed,  2 Aug 2023 00:55:00 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RG4442xtlzrRtb;
        Wed,  2 Aug 2023 15:53:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 15:54:58 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <hao.wu@intel.com>, <trix@redhat.com>, <mdf@kernel.org>,
        <yilun.xu@intel.com>, <wangxiongfeng2@huawei.com>,
        <liwei391@huawei.com>
CC:     <linux-fpga@vger.kernel.org>
Subject: [PATCH] fpga: dfl-pci: Use pci_find_vsec_capability() to simplify the code
Date:   Wed, 2 Aug 2023 16:07:26 +0800
Message-ID: <20230802080726.178194-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PCI core add pci_find_vsec_capability() to query VSEC. We can use that
core API to simplify the code.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/fpga/dfl-pci.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 1bc04378118c..98b8fd16183e 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -156,19 +156,12 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 
 static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
 {
-	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
-	int dfl_res_off, i, bars, voff = 0;
+	u32 bir, offset, dfl_cnt, dfl_res;
+	int dfl_res_off, i, bars, voff;
 	resource_size_t start, len;
 
-	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
-		vndr_hdr = 0;
-		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
-
-		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
-		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
-			break;
-	}
-
+	voff = pci_find_vsec_capability(pcidev, PCI_VENDOR_ID_INTEL,
+					PCI_VSEC_ID_INTEL_DFLS);
 	if (!voff) {
 		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
 		return -ENODEV;
-- 
2.20.1

