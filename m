Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EDD606A3E
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Oct 2022 23:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJTVZ7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Oct 2022 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJTVZ6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Oct 2022 17:25:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6718058A;
        Thu, 20 Oct 2022 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666301157; x=1697837157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G4RA3fXWPYCO6YJlAhmqw1zonueFqiUc6ye2HSURtV8=;
  b=Q8CX7EOj0wKtpifLQcaU/nGuiXLDM6luqvpIgPJmS8z/fvDSfW30e7vq
   C2Tw6HB3vZBLgoa+xrJfkpNoSb/uIfHFpQfuSkwbm5jT7GX3xuXo8ugaI
   CpZRDpqoBjwjq9L9LXy0DhNUobfOlMmfmLWt3iAlvHGBume2f102TbEPl
   9/E9zgDb410Snlyp0PAkZHTYsh/jgDjgD2iG9GBV1Tf9XEr/nZE3JasJJ
   MKllmluvdcJ/8FoI1v7sfPpQly+xJtbW/TnMAPCyIZc+HwXk+tUpB15Vc
   tIZeYNySR+Rmh7PEIxdxuCuVs8FjTtEyfjDbe5X1oEcpIKXXyac9TNKIw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333412432"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="333412432"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:25:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693260670"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="693260670"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:25:55 -0700
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
Subject: [PATCH v4 1/4] Documentation: fpga: dfl: Add documentation for DFHv1
Date:   Thu, 20 Oct 2022 14:26:07 -0700
Message-Id: <20221020212610.697729-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v4: Remove marketing speak and separate v0 and v1 descriptions.
    Fix errors reported by "make htmldocs".

v3: no change

v2: s/GUILD/GUID/
    add picture
---
 Documentation/fpga/dfl.rst | 96 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 15b670926084..12365be435a8 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -561,6 +561,102 @@ new DFL feature via UIO direct access, its feature id should be added to the
 driver's id_table.
 
 
+Device Feature Header - Version 0
+===========================================
+The format of Version 0 of a Device Feature Header (DFH) is shown below::
+
+    +-----------------------------------------------------------------------+
+    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_L                             0| 0x08
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_H                             0| 0x10
+    +-----------------------------------------------------------------------+
+
+Offset 0x00
+Type - The type of DFH (e.g. FME, AFU, or private feature).
+DFH VER - The version of the DFH.
+Rsvd - Currently unused.
+EOL - Set if this DFH is the end of the Device Feature List (DFL).
+Next - The offset of the next DFH in the DFL from the start of the DFH.
+If EOL is set, Next refers to size of mmio for last feature in the list.
+ID - If Type field is 'private feature', then ID of the private feature.
+
+Offset 0x08
+GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier
+if Type is FME or AFU.
+
+Offset 0x10
+GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
+if Type is FME or AFU.
+
+
+Device Feature Header - Version 1
+===========================================
+The format of Version 1 of a Device Feature Header (DFH) is shown below::
+
+    +-----------------------------------------------------------------------+
+    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 ID 0| 0x00
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_L                             0| 0x08
+    +-----------------------------------------------------------------------+
+    |63                                 GUID_H                             0| 0x10
+    +-----------------------------------------------------------------------+
+    |63                 Address/Offset                            1|  Rel  0| 0x18
+    +-----------------------------------------------------------------------+
+    |63        Reg Size       32|Params 31|30 Group    16|15 Instance      0| 0x20
+    +-----------------------------------------------------------------------+
+    |63 Next      34|RSV33|EOP32|31 Param Version 16|15 Param ID           0| 0x28
+    +-----------------------------------------------------------------------+
+    |63                 Parameter Data                                     0| 0x30
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
+Offset 0x00
+Type - The type of DFH (e.g. FME, AFU, or private feature).
+DFH VER - The version of the DFH.
+Rsvd - Currently unused.
+EOL - Set if this DFH is the end of the Device Feature List (DFL).
+Next - The offset of the next DFH in the DFL from the start of the DFH.
+If EOL is set, Next refers to size of mmio for last feature in the list.
+ID - If Type field is 'private feature', then ID of the private feature.
+
+Offset 0x08
+GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier.
+
+Offset 0x10
+GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
+if Type is FME or AFU.
+
+Offset 0x18
+Address/Offset - If Rel bit is set, then high 63 bits of a 16 bit aligned
+absolute address for the location of the feature's registers.
+If Rel bit is clear, then the feature's registers start at the
+offset from the start of the DFH.
+
+Offset 0x20
+Reg Size - Size of feature's register set.
+Params - Set if DFH has one or more parameter blocks.
+Group - Id of group if feature is part of a group.
+Instance - Id of instance of feature within a group.
+
+Offset 0x28 if feature has parameters
+Next - High 30 bits of a 32 bit aligned offset to the next parameter block.
+If EOP set, size of last parameter.
+Param Version - Version of Param ID.
+Param ID - ID of parameter.
+
+Offset 0x30
+Parameter Data - Parameter data whose size and format is defined by version
+and ID of the parameter.
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.25.1

