Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B6D31595D
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Feb 2021 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhBIWXg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Feb 2021 17:23:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:52949 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234011AbhBIWMW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Feb 2021 17:12:22 -0500
IronPort-SDR: 8Yrd+R1pb2oyo6NpJSC8ykK+V6lp+hGtU28JHsFKo8U6m1x0Mo8ZpDYDgz6zH8yKdwB/haAJBJ
 McNj/dzznOug==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="179410821"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="179410821"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:02:09 -0800
IronPort-SDR: IobREpte7zoxLd3slRu2m4nXV56tL+TGgISHjV4iU1StFtc7e3Kj+V3H6/7XY88dvvzSaim/r6
 CkPQgkNUGeqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361959962"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 14:02:08 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv5 2/7] firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
Date:   Tue,  9 Feb 2021 16:20:28 -0600
Message-Id: <1612909233-13867-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
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
v5: no change
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

