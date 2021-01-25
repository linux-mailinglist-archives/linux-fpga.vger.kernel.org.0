Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE68302CBE
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Jan 2021 21:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbhAYUkI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 15:40:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:37450 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbhAYUkC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 15:40:02 -0500
IronPort-SDR: eF4TcA/8GTYNMm/TI3WOoSt+ZeojIgTsMI8RXDSqQqrqHPNdeaZrJbzqjGC/1zOXj2UTYzrRft
 qE1pyuWOZoGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177227335"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="177227335"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 12:36:46 -0800
IronPort-SDR: LqLrI3N3hSiEwC23c1vNn/ga97P9MrdbfToR7aFK1wDZFiw0E2fdaUzlRFLw9PuK6QvWDw35nv
 oRUUAwu0gL5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="504283170"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2021 12:36:45 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv3 3/6] fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
Date:   Mon, 25 Jan 2021 14:56:25 -0600
Message-Id: <1611608188-25621-4-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
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
v3: no change
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

