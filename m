Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F62B7F1A
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 15:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgKROJA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 09:09:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:44063 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKROJA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 09:09:00 -0500
IronPort-SDR: zUkKLFOiz5fcL9TTg0zHanGeoQoW03uItt6xZBX7+b93mrFCbj7y4q6eXvXJMWPsH7KgaQVpyj
 fA5TzAXML6hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158892793"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158892793"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 06:08:56 -0800
IronPort-SDR: jTLi6QCJeaDgaUI2u+X9x/hbWP8tu3ra2dRZJO7OSqgUqF4aXSVfklCwxevhKraCjrCIet7NSO
 Rl0FeT7207+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="325596862"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2020 06:08:55 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv2 1/5] firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
Date:   Wed, 18 Nov 2020 08:29:09 -0600
Message-Id: <1605709753-7800-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
authentication feature. Authenticating a bistream is to make sure a signed
bitstream has the valid signatures.

Except for the actual configuration of the device, the bitstream
authentication works the same way as FPGA configuration does. If the
authentication passes, the signed bitstream will be programmed into QSPI
flash memory and will be expected to boot without issues.

Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
aligns with the firmware settings.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: new added
---
 include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index a93d859..85463c8 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -51,12 +51,17 @@
 #define SVC_STATUS_NO_SUPPORT		6
 
 /**
- * Flag bit for COMMAND_RECONFIG
+ * Flag bit for COMMAND_RECONFIG, in bit number
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:
- * Set to FPGA configuration type (full or partial).
+ * Set for partial FPGA configuration.
+ *
+ * COMMAND_AUTHENTICATE_BITSTREAM:
+ * Set for bitstream authentication, which makes sure a signed bitstream
+ * has valid signatures before committing it to QSPI flash memory.
  */
-#define COMMAND_RECONFIG_FLAG_PARTIAL	1
+#define COMMAND_RECONFIG_FLAG_PARTIAL	0
+#define COMMAND_AUTHENTICATE_BITSTREAM	1
 
 /**
  * Timeout settings for service clients:
-- 
2.7.4

