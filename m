Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74DB648A44
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Dec 2022 22:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLIVpd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Dec 2022 16:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiLIVpE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Dec 2022 16:45:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41603D381;
        Fri,  9 Dec 2022 13:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670622303; x=1702158303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwMQmcynqENJ3y9naQPa+ubp3a09jXnV9/AxFHnqRKo=;
  b=eEyHE4BqpIBEmztxPevIm5xRhUVH7m8UPktBJ668ZE9kyvr637QJ1c9A
   FrlNKBRLvtFgCaq7E4T1eS4bIi1aYDTxrO0q/kIA5/Zw5jPvEY1Xm4QD+
   Jvw9ihpSmKuS5s9oGMIo/93zbD5CqcUJc8gZWYu+2fPj2FJcY35DSPZ2z
   vdBzR8AGQsC30EJikr3AdDuQFKugW7OZkeomckac8pO2jElOQ0tH3i3d6
   c3ACwzdKgndUTgANAB3yytAIb++0ADsp8V6pcQ2G7jkGo9HX3in0veQ0i
   yqFbutys3PUcw+F0Ipu0g/xP5HOhdXOHZj9ijMKv8Ls19W7GeiwtiLFWY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="300975530"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="300975530"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:45:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="711031688"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="711031688"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:45:00 -0800
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v6 1/4] Documentation: fpga: dfl: Add documentation for DFHv1
Date:   Fri,  9 Dec 2022 13:45:20 -0800
Message-Id: <20221209214523.3484193-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com>
References: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add documentation describing the extensions provided by Version
1 of the Device Feature Header (DFHv1).

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v5: use neested list for field descriptions
    clean up prose
    add reviewed-by and comments from Ilpo Järvinen

v4: Remove marketing speak and separate v0 and v1 descriptions.
    Fix errors reported by "make htmldocs".

v3: no change

v2: s/GUILD/GUID/
    add picture
---
 Documentation/fpga/dfl.rst | 103 +++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 15b670926084..606b4b070c33 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -561,6 +561,109 @@ new DFL feature via UIO direct access, its feature id should be added to the
 driver's id_table.
 
 
+Device Feature Header - Version 0
+===========================================
+Version 0 (DFHv0) is the original version of the Device Feature Header.
+The format of DFHv0 is shown below::
+
+    +-----------------------------------------------------------------------+
+    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_L                             0| 0x08
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_H                             0| 0x10
+    +-----------------------------------------------------------------------+
+
+- Offset 0x00
+
+  * Type - The type of DFH (e.g. FME, AFU, or private feature).
+  * DFH VER - The version of the DFH.
+  * Rsvd - Currently unused.
+  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
+  * Next - The offset of the next DFH in the DFL from the start of the DFH. If EOL is set, Next is the size of MMIO ofthe last feature in the list.
+  * ID - The ID of the feature if Type is private feature.
+
+- Offset 0x08
+
+  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier (present only if Type is FME or AFU).
+
+- Offset 0x10
+
+  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier (present only if Type is FME or AFU).
+
+
+Device Feature Header - Version 1
+===========================================
+Version 1 (DFHv1) of the Device Feature Header adds the following functionality:
+
+* Provides a standardized mechanism for features to describe parameters/capabilities to software.
+* Standardize the use of a GUID for all DFHv1 types.
+* Decouples the location of the DFH from the register space of the feature itself.
+
+The format of Version 1 of the Device Feature Header (DFH) is shown below::
+
+    +-----------------------------------------------------------------------+
+    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_L                             0| 0x08
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_H                             0| 0x10
+    +-----------------------------------------------------------------------+
+    |63                   Reg Address/Offset                      1|  Rel  0| 0x18
+    +-----------------------------------------------------------------------+
+    |63        Reg Size       32|Params 31|30 Group    16|15 Instance      0| 0x20
+    +-----------------------------------------------------------------------+
+    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID           0| 0x28
+    +-----------------------------------------------------------------------+
+    |63                 Parameter Data                                     0| 0x30
+    +-----------------------------------------------------------------------+
+
+                                  ...
+
+    +-----------------------------------------------------------------------+
+    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID           0|
+    +-----------------------------------------------------------------------+
+    |63                 Parameter Data                                     0|
+    +-----------------------------------------------------------------------+
+
+- Offset 0x00
+
+  * Type - The type of DFH (e.g. FME, AFU, or private feature).
+  * DFH VER - The version of the DFH.
+  * Rsvd - Currently unused.
+  * EOL - Set if this DFH is the end of the Device Feature List (DFL).
+  * Next - The offset of the next DFH in the DFL from the start of the DFH.
+  * ID - The ID of the feature if Type is private feature.
+
+- Offset 0x08
+
+  * GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier.
+
+- Offset 0x10
+
+  * GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier.
+
+- Offset 0x18
+
+  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 bits of a 16 bit aligned absolute address of the feature's registers. If Rel bit is clear, then the value is the offset from the start of the DFH of the feature's registers.
+
+- Offset 0x20
+
+  * Reg Size - Size of feature's register set in bytes.
+  * Params - Set if DFH has a list of parameter blocks.
+  * Group - Id of group if feature is part of a group.
+  * Instance - Id of instance of feature within a group.
+
+- Offset 0x28 if feature has parameters
+
+  * Next - Offset to the next parameter block in 8 byte words. If EOP set, size in 8 byte words of last parameter.
+  * Param Version - Version of Param ID.
+  * Param ID - ID of parameter.
+
+- Offset 0x30
+
+  * Parameter Data - Parameter data whose size and format is defined by version and ID of the parameter.
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.25.1

