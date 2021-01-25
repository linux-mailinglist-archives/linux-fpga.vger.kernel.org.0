Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7420C302CBB
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Jan 2021 21:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbhAYUjx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 15:39:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:37447 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732356AbhAYUij (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 15:38:39 -0500
IronPort-SDR: HRohG92rCp1TPJyZ+59DiK4e2aXIAo24OQSbh6RQmMnDDadAyy3clGZag0VQYRXiVCwK66qiwL
 9RvqUd20IfKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177227325"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="177227325"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 12:36:44 -0800
IronPort-SDR: jRyhWK1pLPyYQCj9tv4S08VaW5dS6C030OXpAqPttf0FjVPL4rWZwxteuleM32koEB9eI8Thnz
 ai5zZ6zQXIxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="504283148"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2021 12:36:43 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv3 1/6] firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
Date:   Mon, 25 Jan 2021 14:56:23 -0600
Message-Id: <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
authentication feature. Authenticating a bitstream is to make sure a signed
bitstream has the valid signatures.

Except for the actual configuration of the device, the bitstream
authentication works the same way as FPGA configuration does. If the
authentication passes, the signed bitstream will be programmed into QSPI
flash memory and will be expected to boot without issues.

Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
aligns with the firmware settings.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v3: no change
v2: new added
---
 include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index ebc2956..7ada1f2 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -51,12 +51,17 @@
 #define SVC_STATUS_NO_SUPPORT		6
 
 /*
- * Flag bit for COMMAND_RECONFIG
+ * Flag for COMMAND_RECONFIG, in bit number
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
 
 /*
  * Timeout settings for service clients:
-- 
2.7.4

