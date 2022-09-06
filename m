Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2593D5AF42A
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Sep 2022 21:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIFTEb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Sep 2022 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiIFTEZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Sep 2022 15:04:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA5E8E0FE;
        Tue,  6 Sep 2022 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662491061; x=1694027061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C0bQ5Vs1HjO/iAyiITtp564fOc3TDTgpVvPEYdinvec=;
  b=isyU3R09JKx6AKl5USrU0Xjhtfhn+H5Z2zWi/0pVySA+tDKJAzSGuE0s
   hsEgRS/fOdNCVhH8AQBZM8KsZccj1j05sWxZfCeKmOSQftpBxFjhqsZtB
   3K5HZ2bOB23/0an+HTQ5Mqcut3TjsEs1Ub4doKvsnGM931zhVWiaQbX3o
   MaLooMtpiL7xOFzk+ceM7qO73+5zwgCOthx09OP8C4ccbZbMsBBGyF9aY
   tQIkXF4ddtP7IyPh48l3DaseVpb8cmlCDgdasHs4f2SFwoJq8rQhZjeHw
   uEfX4mxuWWyxFnkm4AiV9Z9ZmoXyJ90zAnhSoIBHOZjy1LQdb+ESlGHvQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283677335"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283677335"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="789782542"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v1 1/5] Documentation: fpga: dfl: Add documentation for DFHv1
Date:   Tue,  6 Sep 2022 12:04:22 -0700
Message-Id: <20220906190426.3139760-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add documentation describing the extentions provided by Version
1 of the Device Feature Header (DFHv1).

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 15b670926084..31699b89781e 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -561,6 +561,30 @@ new DFL feature via UIO direct access, its feature id should be added to the
 driver's id_table.
 
 
+Extending the Device Feature Header - DFHv1
+===========================================
+The current 8 bytes of the Device Feature Header, hereafter referred to as
+to DFHv0, provide very little opportunity for the hardware to describe itself
+to software. Version 1 of the Device Feature Header (DFHv1) is being introduced
+to provide increased flexibility and extensibility to hardware designs using
+Device Feature Lists.  The list below describes some of the goals behind the
+changes in DFHv1:
+
+* Provide a standardized mechanism for features to describe
+  parameters/capabilities to software.
+* Standardize the use of a GUID for all DFHv1 types.
+* Decouple the location of the DFH from the register space of the feature itself.
+
+Modeled after PCI Capabilities, DFHv1 Parameters provide a mechanism to associate
+a list of parameter values to a particular feature.
+
+With DFHv0, not all features types contained a GUID.  DFHv1 makes the GUILD standard
+across all types.
+
+With DFHv0, the register map of a given feature is located immediately following
+the DFHv0 in the memory space.  With DFHv1, the location of the feature register
+map can be specified as an offset to the DFHv1 or as an absolute address.
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.25.1

