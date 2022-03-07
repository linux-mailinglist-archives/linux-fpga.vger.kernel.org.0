Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BDF4D002F
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Mar 2022 14:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiCGNg6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Mar 2022 08:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiCGNg5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Mar 2022 08:36:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1001E7D028;
        Mon,  7 Mar 2022 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646660164; x=1678196164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BLFuTRhqE482sqaHRif7NDKXQY4BaFJ4C/qrheqYfJs=;
  b=DKGH1rOHgXM2f/HffUjWErhNHIQ6CwFMPrq4fLo4PY4LBeqES2WKGMDE
   mg24eL2jYbomtF+dzNh22Nsx8LdP3VdL/ktdkhZ6lSXm+lRxmFSbUSTfF
   okH/lRXk8RoC+lUTqxXJnt+2sWtU7hc29/yTH5otS7I5EyKkcwh9rCg1h
   /xNXXMvM1JRFpERis8VaQcAJ+6WAce+8kEjiyRTwy3HYqqg9YIiYDDrP4
   dQZqAUcPXNws5PLarKRGsw7w/NH5AFoygyn4GHBd8GeaZqGjsJOIhcarq
   z58IsqeBRPJS/DiR/Ad09t5rKTIplINJQOODdFrduDBSTAaJd4L6irlIU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254579324"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254579324"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:36:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643246949"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 05:36:00 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4 1/6] fpga: dfl: Allow ports without local bar space.
Date:   Mon,  7 Mar 2022 08:32:38 -0500
Message-Id: <20220307133243.1426300-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220307133243.1426300-1-tianfei.zhang@intel.com>
References: <20220307133243.1426300-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

