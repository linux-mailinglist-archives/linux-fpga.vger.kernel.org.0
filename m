Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85005E7A9E
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIWMWo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiIWMV6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 08:21:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E18135046;
        Fri, 23 Sep 2022 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663935450; x=1695471450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HyCYvT4MS9aixSrjDPMIu3T0VuZk0mTl3XzcDjq7QLc=;
  b=Pfin51E61Eha6ZMYr0qpf63pT4sqikWy2dx9kpPO9oXhe3TgnsiHy1kB
   UF81lhbIP8XfBCL/OUuoIrm6z0+cYZcDalKqwJcCCSTSmQSsd4wpnudaM
   7NG0R29Q7qHmoN70g6AU3c9l+3/ACgDp3umtBumXHIbYF7ZtS+T66OxSn
   0i7hPEJnr7oHJYIsc6DKNv6XH7BoVIXFTo0CXG5SToeMniHbb4HgG/o2b
   6HDpIJzXfyuR+4guEek+sHumRc725ihEORyAmm2BLDxKBKebdzsGZgOgT
   DlyMfwySP/TYEE8T+dFWLpCaccGIuPuuK4ok974MrsnA7oDeWpdsG4xgx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364595264"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="364595264"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:17:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="762597729"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:17:29 -0700
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
Subject: [PATCH v2 1/6] Documentation: fpga: dfl: Add documentation for DFHv1
Date:   Fri, 23 Sep 2022 05:17:40 -0700
Message-Id: <20220923121745.129167-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add documentation describing the extensions provided by Version
1 of the Device Feature Header (DFHv1).

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v2: s/GUILD/GUID/
    add picture
---
 Documentation/fpga/dfl.rst | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 15b670926084..7c786b75b498 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -561,6 +561,55 @@ new DFL feature via UIO direct access, its feature id should be added to the
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
+With DFHv0, not all features types contained a GUID.  DFHv1 makes the GUID standard
+across all types.
+
+With DFHv0, the register map of a given feature is located immediately following
+the DFHv0 in the memory space.  With DFHv1, the location of the feature register
+map can be specified as an offset to the DFHv1 or as an absolute address.  The DFHv1
+structure is shown below:
+
+    +-----------------------------------------------------------------------+
+    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0|
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_L                             0|
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_H                             0|
+    +-----------------------------------------------------------------------+
+    |63                 Address/Offset                            1|  Rel  0|
+    +-----------------------------------------------------------------------+
+    |63 Size of register set  32|Params 31|30 Group    16|15 Instance      0|
+    +-----------------------------------------------------------------------+
+    |63 Next parameter offset 32|31 Param Version 16|15 Param ID           0|
+    +-----------------------------------------------------------------------+
+    |63                 Parameter Data                                     0|
+    +-----------------------------------------------------------------------+
+
+                                  ...
+
+    +-----------------------------------------------------------------------+
+    |63 Next parameter offset 32|31 Param Version 16|15 Param ID           0|
+    +-----------------------------------------------------------------------+
+    |63                 Parameter Data                                     0|
+    +-----------------------------------------------------------------------+
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.25.1

