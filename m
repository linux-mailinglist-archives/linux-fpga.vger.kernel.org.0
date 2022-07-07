Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E156A69E
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jul 2022 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiGGPGF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Jul 2022 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiGGPGE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Jul 2022 11:06:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D42CE18;
        Thu,  7 Jul 2022 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657206363; x=1688742363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZ0BWW4FNporw+N2/TPIK78vgSMWbl0guvMfrLNNuMI=;
  b=VoFeuB4F/za8npkY2kyKeG+fnRaDdq8Q1irWfQvA2UKk5jEKQ5FX/TT5
   sThivoUtp/YM8vcEAzekxvsOqv7VNnR4ZeXjV2KrCoeQlTv53c3EYf7XL
   ALMvu/wkHKhOAJj9C0W6ZQSyZ5ZVUav4lDQ1p3UY7sHiEM35AhUJCDVUn
   Q1nLj8rMtzGlxIi4Y26P2MmmngO8ZkFqyxezNmFl6uvFIEWPaAcREc3lH
   X6K9BcnbXp6CVABzcD7xqzy8Zm60u2DzkJCuiQkmVUtuc/pFOQTEVu7fT
   9YODwcG4Uenos3iyjBySl23U30zueXSiti5o80WwdjSs4WGJmL+B7+mRA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="263829562"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="263829562"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 08:05:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="720546767"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 08:05:56 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, corbet@lwn.net, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 1/2] Documentation: fpga: dfl: add PCI Identification documentation
Date:   Thu,  7 Jul 2022 08:05:48 -0700
Message-Id: <20220707150549.265621-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707150549.265621-1-matthew.gerlach@linux.intel.com>
References: <20220707150549.265621-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add documentation on identifying FPGA based PCI cards prompted
by discussion on the linux-fpga@vger.kernel.org mailing list.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3: Add url to page tracking PCI ID information for DFL based cards.

v2: Introduced in v2.
---
 Documentation/fpga/dfl.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 15b670926084..5144775b860a 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -507,6 +507,27 @@ ids application.
 https://github.com/OPAE/dfl-feature-id
 
 
+PCI Device Identification
+================================
+Since FPGA based PCI cards can be reconfigured to a perform a completely
+new function at runtime, properly identifying such cards and binding the
+correct driver can be challenging. In many use cases, deployed FPGA based
+PCI cards are essentially static and the PCI Product ID and Vendor ID pair
+is sufficient to identify the card.  The DFL framework helps with the
+dynamic case of deployed FPGA cards changing at run time by providing
+more detailed information about card discoverable at runtime.
+
+At one level, the DFL on a PCI card describes the function of the card.
+However, the same DFL could be instantiated on different physical cards.
+Conversely, different DFLs could be instantiated on the same physical card.
+Practical management of a cloud containing a heterogeneous set of such cards
+requires a PCI level of card identification. While the PCI Product ID and
+Vendor ID may be sufficient to bind the dfl-pci driver, it is expected
+that FPGA PCI cards would advertise suitable Subsystem ID and Subsystem
+Vendor ID values. Further PCI Product, Vendor, and Subsystem id tracking
+can be found at https://github.com/OPAE/dfl-feature-id/blob/main/dfl-pci-ids.rst.
+
+
 Location of DFLs on a PCI Device
 ================================
 The original method for finding a DFL on a PCI device assumed the start of the
-- 
2.25.1

