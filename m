Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7709C30AA9F
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 16:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhBAPLA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 10:11:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:33931 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhBAPEA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Feb 2021 10:04:00 -0500
IronPort-SDR: E0FLsjojSzS9M617j7D5VNPdrkyCnrB4gIO9ax4yLMq9vahepIhouUfU6bwKC1yj2Wd0s3MS8w
 pqbyZDulhRPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242214675"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="242214675"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:02:31 -0800
IronPort-SDR: 2ARkCyIwXa+X+eu0ld0ayvFlJlLt0OEvdfW1qzsXICfxmEdOvOLHRoS6SnwNqwLD/1sGy7L9ui
 w/nn0OxQTjEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="369891571"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2021 07:02:31 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv4 3/6] fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
Date:   Mon,  1 Feb 2021 09:21:56 -0600
Message-Id: <1612192919-4069-4-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
References: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add FPGA_MGR_BITSTREAM_AUTHENTICATE flag for FPGA bitstream
authentication, which makes sure a signed bitstream has valid signatures.

Except for the actual configuration of the device, the authentication works
the same way as FPGA configuration does. If the authentication passes, the
bitstream will be programmed into QSPI flash and will be expected to boot
without issues.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v4: s/FPGA_MGR_BITSTREM_AUTHENTICATION/FPGA_MGR_BITSTREAM_AUTHENTICATE
v3: no change
v2: align all FPGA_MGR_* flags
    update the commit messages
---
 include/linux/fpga/fpga-mgr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 2bc3030..a81b3a7 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_BITSTREAM_AUTHENTICATE: do FPGA bitstream authentication only
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_BITSTREAM_AUTHENTICATE	BIT(5)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.7.4

