Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89D4D74C4
	for <lists+linux-fpga@lfdr.de>; Sun, 13 Mar 2022 12:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiCMK7i (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Mar 2022 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiCMK62 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Mar 2022 06:58:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7043912D083;
        Sun, 13 Mar 2022 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647169033; x=1678705033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BLFuTRhqE482sqaHRif7NDKXQY4BaFJ4C/qrheqYfJs=;
  b=IEVsMmDObpC7RVtowkc07zK5ygfZmHsKZr52pS+elcC+LcH00uC4Yi2x
   hEWKnanqBxZA8lVdZ16Gnq7D8Z8omP9VpAXslIjGO8sXu3e+CX3UkhRPm
   wd2Ug41UsJYK+Ydi4Wvj1y5Q4bTtGSofebrS75185FjQ2V0tUd8hB98EG
   SqrlojBIoNYj45EmjQZB9n3KGCgMGfjpHiiORtgroUbt80+B2/qTuU4gX
   mUGK0zvYwIfklYwJhlIjRPEyvPOYNsuTCostwMzQUvt3ws9Pjvy6Ofl71
   jHquE2RVuWAgcTqkyRR8QbUOrmVswTi8Mub5W0jpkiO1ylret3jHNGGy/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="319086324"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="319086324"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 03:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713380315"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 03:56:01 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v5 1/6] fpga: dfl: Allow ports without local bar space.
Date:   Sun, 13 Mar 2022 06:52:37 -0400
Message-Id: <20220313105242.1567774-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220313105242.1567774-1-tianfei.zhang@intel.com>
References: <20220313105242.1567774-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

In OFS, each PR slot (AFU) has one port device which include Port
control, Port user clock control and Port errors. In legacy model,
the AFU MMIO space was connected with Port device, so from port
device point of view, there is a bar space associated with this
port device. But in "Multiple VFs per PR slot" model, the AFU MMIO
space was not connected with Port device. The BarID (3bits field) in
PORTn_OFFSET register indicates which PCI bar space associated with
this port device, the value 0b111 (FME_HDR_NO_PORT_BAR) means that
no PCI bar for this port device.

---
v3: add PCI bar number checking with PCI_STD_NUM_BARS.
v2: use FME_HDR_NO_PORT_BAR instead of PCI_STD_NUM_BARS.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c | 7 +++++++
 drivers/fpga/dfl.h     | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4d68719e608f..2e9abeca3625 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -258,6 +258,13 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			if (bar >= PCI_STD_NUM_BARS ||
+			    bar == FME_HDR_NO_PORT_BAR) {
+				dev_dbg(&pcidev->dev, "skipping port without local BAR space %d\n",
+					bar);
+				continue;
+			}
+
 			start = pci_resource_start(pcidev, bar) + offset;
 			len = pci_resource_len(pcidev, bar) - offset;
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 53572c7aced0..1fd493e82dd8 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -91,6 +91,7 @@
 #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
 #define FME_HDR_BITSTREAM_ID	0x60
 #define FME_HDR_BITSTREAM_MD	0x68
+#define FME_HDR_NO_PORT_BAR	7
 
 /* FME Fab Capability Register Bitfield */
 #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric version ID */
-- 
2.26.2

