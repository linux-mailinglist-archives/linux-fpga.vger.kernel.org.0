Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F02B7F1E
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 15:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKROJC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 09:09:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:44063 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgKROJB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 09:09:01 -0500
IronPort-SDR: YhjaWQtYBjt23Pu/ecJprkCUl1kF1M6mpRPUqfRiuRttJQSiW90K7LjKvTTKCV1NpwKXtGotRU
 xkDFn0JT3v+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158892809"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158892809"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 06:09:00 -0800
IronPort-SDR: ucueP6mVYc0ts6qY3bgCufekTyY9JS9jQZvEa5x7xVA8scRHd27lSoXmV0zeb0Q2XPQSJyR6t5
 xIXZeo5kwESw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="325596896"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2020 06:08:59 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv2 2/5] fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
Date:   Wed, 18 Nov 2020 08:29:10 -0600
Message-Id: <1605709753-7800-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add FPGA_MGR_BITSTREM_AUTHENTICATION flag for FPGA bitstream
authentication, which makes sure a signed bitstream has valid signatures.

Except for the actual configuration of the device, the authentication works
the same way as FPGA configuration does. If the authentication passes, the
bitstream will be programmed into QSPI flash and will be expected to boot
without issues.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: align all FPGA_MGR_* flags
    update the commit messages
---
 include/linux/fpga/fpga-mgr.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 2bc3030..4fb3400 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_BITSTREM_AUTHENTICATION: do FPGA bitstream authentication only
  */
-#define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
-#define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
-#define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
-#define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
-#define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_PARTIAL_RECONFIG		BIT(0)
+#define FPGA_MGR_EXTERNAL_CONFIG		BIT(1)
+#define FPGA_MGR_ENCRYPTED_BITSTREAM		BIT(2)
+#define FPGA_MGR_BITSTREAM_LSB_FIRST		BIT(3)
+#define FPGA_MGR_COMPRESSED_BITSTREAM		BIT(4)
+#define FPGA_MGR_BITSTREM_AUTHENTICATION	BIT(5)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.7.4

