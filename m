Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D212D99C2
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 15:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440133AbgLNOW1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 09:22:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:18186 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440125AbgLNOWS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 09:22:18 -0500
IronPort-SDR: z9sO5dsaeo7uvqV7lQ/oRZZwhNrGO30wBFQufCcrT6pMlh6n18MUPl6jo8G6E5q9feTK02lHg1
 vz9QQyzhxx4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="259437989"
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="259437989"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 06:19:02 -0800
IronPort-SDR: 1jFGHa6F3AP9kuQBrmTchb/rXJmYsBTUfRVC0NhdmYm8tpeaghk+yaEEFb43gLf6khBxk7HXfU
 58kUOS9dnFug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="333456256"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2020 06:18:46 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv2 2/5] fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
Date:   Mon, 14 Dec 2020 08:39:57 -0600
Message-Id: <1607956800-28476-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
References: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
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

