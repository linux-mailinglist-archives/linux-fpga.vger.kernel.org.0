Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72650EE57
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Apr 2022 03:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiDZBzm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiDZBzl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 21:55:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF926971D
        for <linux-fpga@vger.kernel.org>; Mon, 25 Apr 2022 18:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650937955; x=1682473955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TDz4zBZmetKcoDKXQAga+hxYyuMn8MKYiIj7OBR7HYs=;
  b=ex3xPvJ4eSc9wm8R+DYMiWgD+K8ZFT1zhwUp9Vh1JmTwG0dF/3/eJnof
   +nyn17AJI1Ipc1lBXLnNdbVJANOoeJPxlhLZOUbWCqlEG/l8tCwDwCWzK
   VhImCPDxl+b468d5SFLoGL4Z3YJC1oruj4MdTq2Uj1cZO6X9ImjG3bPuA
   g0OK5/9JQfUd1+Gfz2exrQYxJ/Vo6MP28z0OtZFhXDDUzBkvzTVVTiqt5
   mxl6dkfnKG2vKSh/xPWVzUSZ0pkEYcKOIu/rKcMtmix3iAQFxsfxJu2kN
   6ZgvvRhMzbtuTKpIcFjX0wRjpOXCC4+TeTiLd3pqhio5Z/u1mvbcEj8Mo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290560258"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="290560258"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 18:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="730006060"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 18:52:33 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3] fpga: dfl: Allow Port to be linked to FME's DFL
Date:   Mon, 25 Apr 2022 21:49:07 -0400
Message-Id: <20220426014907.570292-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are not
connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack device),
PORT DFLs are connected to FME DFL directly, so we don't need to search
PORT DFLs via PORTn_OFFSET again. If BAR value of PORTn_OFFSET is 0x7
(FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for that
port. If BAR value is invalid, return -EINVAL.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
v3: remove dev_dbg and use goto instead of break.
v2: return -EINVAL if bar number invalid.
---
 drivers/fpga/dfl-pci.c | 10 ++++++++++
 drivers/fpga/dfl.h     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 86ed9e4223d3..dac45f96c326 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -263,6 +263,15 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			if (bar == FME_PORT_OFST_BAR_SKIP) {
+				continue;
+			} else if (bar >= PCI_STD_NUM_BARS) {
+				dev_err(&pcidev->dev, "bad BAR %d for port %d\n",
+					bar, i);
+				ret = -EINVAL;
+				goto unmap_exit;
+			}
+
 			start = pci_resource_start(pcidev, bar) + offset;
 			len = pci_resource_len(pcidev, bar) - offset;
 
@@ -277,6 +286,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 		ret = -ENODEV;
 	}
 
+unmap_exit:
 	/* release I/O mappings for next step enumeration */
 	pcim_iounmap_regions(pcidev, BIT(0));
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 53572c7aced0..e0f0abfbeb8c 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -91,6 +91,7 @@
 #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
 #define FME_HDR_BITSTREAM_ID	0x60
 #define FME_HDR_BITSTREAM_MD	0x68
+#define FME_PORT_OFST_BAR_SKIP	7
 
 /* FME Fab Capability Register Bitfield */
 #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric version ID */
-- 
2.26.2

