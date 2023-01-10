Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063C166364A
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Jan 2023 01:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbjAJAaA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 19:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjAJA35 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 19:29:57 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F03E0E6;
        Mon,  9 Jan 2023 16:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673310596; x=1704846596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NObn6stZidq+7SmPoutFtJ/EZSc2Sfj2qbCIi9/idig=;
  b=XpxmB1FWubz11FE9wKTi2Snuix9IuvFZwENu1XlwIaK4ggj1qfdS2DMo
   N1smhxXdtZHAItbmamr6RN6PFI0JVrl2gKbFJaRetnDNUWsQRuIQC3wx+
   KrsQJqhtG7xzni6njqh//xSX1UCQeWpjsI245XWYlfjKdApDVb7eFqsmc
   Lmvj1Xn8h1pWdjLbb/Q+DZTSKJo9QY0zhpDlHix6YJICV74Sp3NPtArmG
   p+sKCkH8ipN9XO9jX9fQNzYkcCMSk9vqpZsjKBK5n1q6QUqjdB8WMUoLR
   09eGoIbJU0tAh7iLkitnf5i/3ecM0SqA5G0Ecb9ULyvpSIVHdmIovNOq4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324265537"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324265537"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 16:29:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="687381575"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="687381575"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 16:29:53 -0800
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
        marpagan@redhat.com, bagasdotme@gmail.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v10 1/4] Documentation: fpga: dfl: Add documentation for DFHv1
Date:   Mon,  9 Jan 2023 16:30:26 -0800
Message-Id: <20230110003029.806022-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110003029.806022-1-matthew.gerlach@linux.intel.com>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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
Reviewed-by: Tom Rix <trix@redhat.com>
---
v10: ad Rb Tom Rix

v9: move DFH definitions to after the Overview
    fix name of feature revision field
    clarify next field in DFH

v8: fix section titles

v7: shorten long lines and wording suggestions by bagasdotme@gmail.com

v6: no change

v5: use nested list for field descriptions
    clean up prose
    add reviewed-by and comments from Ilpo Järvinen

v4: Remove marketing speak and separate v0 and v1 descriptions.
    Fix errors reported by "make htmldocs".

v3: no change

v2: s/GUILD/GUID/
    add picture
---
 Documentation/fpga/dfl.rst | 117 +++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 15b670926084..7e015249785b 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -75,6 +75,123 @@ convenient for software to locate each feature by walking through this list,
 and can be implemented in register regions of any FPGA device.
 
 
+Device Feature Header - Version 0
+=================================
+Version 0 (DFHv0) is the original version of the Device Feature Header.
+The format of DFHv0 is shown below::
+
+    +-----------------------------------------------------------------------+
+    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 REV 12|11 ID 0| 0x00
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
+  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
+  * Next - The offset in bytes of the next DFH in the DFL from the DFH start,
+    and the start of a DFH must be aligned to an 8 byte boundary.
+    If EOL is set, Next is the size of MMIO of the last feature in the list.
+  * REV - The revision of the feature associated with this header.
+  * ID - The feature ID if Type is private feature.
+
+- Offset 0x08
+
+  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identifier
+    (present only if Type is FME or AFU).
+
+- Offset 0x10
+
+  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identifier
+    (present only if Type is FME or AFU).
+
+
+Device Feature Header - Version 1
+=================================
+Version 1 (DFHv1) of the Device Feature Header adds the following functionality:
+
+* Provides a standardized mechanism for features to describe
+  parameters/capabilities to software.
+* Standardize the use of a GUID for all DFHv1 types.
+* Decouples the DFH location from the register space of the feature itself.
+
+The format of Version 1 of the Device Feature Header (DFH) is shown below::
+
+    +-----------------------------------------------------------------------+
+    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 REV 12|11 ID 0| 0x00
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
+  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
+  * Next - The offset in bytes of the next DFH in the DFL from the DFH start,
+    and the start of a DFH must be aligned to an 8 byte boundary.
+    If EOL is set, Next is the size of MMIO of the last feature in the list.
+  * REV - The revision of the feature associated with this header.
+  * ID - The feature ID if Type is private feature.
+
+- Offset 0x08
+
+  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identifier.
+
+- Offset 0x10
+
+  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identifier.
+
+- Offset 0x18
+
+  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 bits
+    of a 16-bit aligned absolute address of the feature's registers. Otherwise
+    the value is the offset from the start of the DFH of the feature's registers.
+
+- Offset 0x20
+
+  * Reg Size - Size of feature's register set in bytes.
+  * Params - Set if DFH has a list of parameter blocks.
+  * Group - Id of group if feature is part of a group.
+  * Instance - Id of feature instance within a group.
+
+- Offset 0x28 if feature has parameters
+
+  * Next - Offset to the next parameter block in 8 byte words. If EOP set,
+    size in 8 byte words of last parameter.
+  * Param Version - Version of Param ID.
+  * Param ID - ID of parameter.
+
+- Offset 0x30
+
+  * Parameter Data - Parameter data whose size and format is defined by
+    version and ID of the parameter.
+
+
 FIU - FME (FPGA Management Engine)
 ==================================
 The FPGA Management Engine performs reconfiguration and other infrastructure
-- 
2.25.1

