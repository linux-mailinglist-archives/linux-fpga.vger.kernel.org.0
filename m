Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF62365E8C
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Apr 2021 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhDTR0o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Apr 2021 13:26:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:7203 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233141AbhDTR0n (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Apr 2021 13:26:43 -0400
IronPort-SDR: Z+ATFwTB2/uOA9KSEKyIkixCiTTK53IKSHdMWoAjJuPWTRQeAQef6VegYK6PwrTLNhcmYLzcxz
 sdZ4nvrlNFmw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195107727"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="195107727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 10:26:11 -0700
IronPort-SDR: KNMRWjGS+12WxeI0yq5GQZwuxcu3JyTCGaepSnAqDMAukITru09Lfa8hUwE23W+FpwAJM3Eeps
 O5p3Lq2ib4Hw==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="420544380"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 10:26:11 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com,
        russell.h.weight@intel.com, mdf@kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port entries
Date:   Tue, 20 Apr 2021 10:27:40 -0700
Message-Id: <20210420172740.707259-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Gracefully ignore misconfigured port entries encountered in
incorrect FPGA images.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl-pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index b44523e..660d3b6 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -212,6 +212,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	int port_num, bar, i, ret = 0;
 	resource_size_t start, len;
 	void __iomem *base;
+	int bars = 0;
 	u32 offset;
 	u64 v;
 
@@ -228,6 +229,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	if (dfl_feature_is_fme(base)) {
 		start = pci_resource_start(pcidev, 0);
 		len = pci_resource_len(pcidev, 0);
+		bars |= BIT(0);
 
 		dfl_fpga_enum_info_add_dfl(info, start, len);
 
@@ -253,9 +255,21 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			if (bars & BIT(bar)) {
+				dev_warn(&pcidev->dev, "skipping bad port BAR %d\n", bar);
+				continue;
+			}
+
 			start = pci_resource_start(pcidev, bar) + offset;
-			len = pci_resource_len(pcidev, bar) - offset;
+			len = pci_resource_len(pcidev, bar);
+			if (offset >= len) {
+				dev_warn(&pcidev->dev, "bad port offset %u >= %pa\n",
+					 offset, &len);
+				continue;
+			}
 
+			len -= offset;
+			bars |= BIT(bar);
 			dfl_fpga_enum_info_add_dfl(info, start, len);
 		}
 	} else if (dfl_feature_is_port(base)) {
-- 
1.8.3.1

