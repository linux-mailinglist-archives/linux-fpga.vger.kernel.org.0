Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E683A30AA72
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 16:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBAPGw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 10:06:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:33902 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhBAPGK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Feb 2021 10:06:10 -0500
IronPort-SDR: kRHU/rf+XAHfqn6X5Im+DoJhRmUG4zRFSdI+WbqAQvPYJ9Okj7aWaZhB43arBxASI/XD/20+m5
 PFNGVCyvP8tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242214665"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="242214665"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:02:30 -0800
IronPort-SDR: 3WsIeX/Q2pmr/wZF9wkrifAuukjJmjr7IwEPyYfIUXzBlHrFIn9JkzdOUiAQFaNJZRKuTA7JYv
 c9vcSZIE7h6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="369891561"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2021 07:02:30 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv4 1/6] firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
Date:   Mon,  1 Feb 2021 09:21:54 -0600
Message-Id: <1612192919-4069-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
References: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
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

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v4: remove change at COMMAND_RECONFIG_FLAG_PARTIAL flag & add that to a
    separate commit 27ad5309c247b6bde8a098e17e9bd9b1576b7f71.
v3: no change
v2: new added
---
 include/linux/firmware/intel/stratix10-svc-client.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index f843c6a..fa9581d 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -55,8 +55,13 @@
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:
  * Set to FPGA configuration type (full or partial).
+ *
+ * COMMAND_AUTHENTICATE_BITSTREAM:
+ * Set for bitstream authentication, which makes sure a signed bitstream
+ * has valid signatures before committing it to device.
  */
 #define COMMAND_RECONFIG_FLAG_PARTIAL	0
+#define COMMAND_AUTHENTICATE_BITSTREAM	1
 
 /**
  * Timeout settings for service clients:
-- 
2.7.4

