Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661EA4CB3DA
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Mar 2022 01:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiCCAe0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Mar 2022 19:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiCCAeZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Mar 2022 19:34:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF4D3206C;
        Wed,  2 Mar 2022 16:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646267616; x=1677803616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=puhGGhdgKTMBV39T07x+pJAUC5Dwf4xYKce7ErjFuPA=;
  b=QD7UO8twvQ5Av5Y6oqRu53yYELIFlsNYUyKLc2genR+5ULPqNOAWfO6U
   99z8OK9cRvUkmHvJIdh+Cs74T1Ef3OhOAddq9XOFFcC8Jc1+6lIfF4pYh
   6rzARFw7H8auwcenaVjZCZOhTFcxYFIRiXgbNlIcWjFWRPfpCaxWx9WkZ
   BM05fs12Z++8zSBjSSedHlpDoOt0ddaH/S4rHHMuDJZ6y5Vu3Dt3gqKKf
   TPsRwV6r3f6PhiWDrrR8gIwjItkhgDWCaPEABQaM/Bs5AVdxYEUhzfhO6
   YBdYYQkLYO9XI+jXbD3FA8gu5+cuRuvCA2iR0ujaBKVmVcHDxLfY+ObiC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253468950"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253468950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:33:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="686309310"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:33:31 -0800
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, corbet@lwn.net, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, ashok.raj@intel.com,
        tianfei.zhang@intel.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 1/2] Documentation: fpga: dfl: add PCI Identification documentation
Date:   Wed,  2 Mar 2022 16:35:33 -0800
Message-Id: <20220303003534.3307971-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com>
References: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
v2: Introduced in v2.
---
 Documentation/fpga/dfl.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ef9eec71f6f3..5fb2ca8e76d7 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -502,6 +502,26 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
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
+Vendor ID values. PCI Vital Product Data (VPD) can also be used for
+more granular information about the board.
+
 Location of DFLs on a PCI Device
 ================================
 The original method for finding a DFL on a PCI device assumed the start of the
-- 
2.25.1

