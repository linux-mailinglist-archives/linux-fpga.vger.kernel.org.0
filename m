Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531C9315924
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Feb 2021 23:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhBIWIx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Feb 2021 17:08:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:46015 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233467AbhBIWFd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Feb 2021 17:05:33 -0500
IronPort-SDR: zDvy7pULJjHNGe8P82SiOjTSuacS0b8RTypss7GG5fu7E8rVCCBdMOctw+dGrhZ/S+QdFDmbvC
 8SLQ7TnmuG6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169094285"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="169094285"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:02:10 -0800
IronPort-SDR: cbHoHuIJEvgDx0sqEVNrN17jCP0tUGGQGeRJf6P+XPjmpjulXvgffbTbB0myrTFllRAtTbufVx
 DOGXHI7DKDDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361959972"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 14:02:09 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv5 4/7] fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
Date:   Tue,  9 Feb 2021 16:20:30 -0600
Message-Id: <1612909233-13867-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
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
v5: no change
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

