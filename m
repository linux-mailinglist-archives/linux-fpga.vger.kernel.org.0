Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BFC2B0B8D
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Nov 2020 18:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKLRr1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Nov 2020 12:47:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:5888 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgKLRr0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 12 Nov 2020 12:47:26 -0500
IronPort-SDR: gxJror6URQOLCCi4zraJc6B+1vRvvVEi4luDbIL3+DCklL0YTnwlq6Bc//c40JLfeuR2dwMJly
 pp3LGgvG6rWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158128461"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="158128461"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:47:25 -0800
IronPort-SDR: frS8isPJJskiIVBO+3vzhWXH+IVyBu9JlToavkLSf5RxQco4J5pYkZVITYf8aD6g/UxDSrwrFF
 oCPdeFM1MxIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="328576364"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 12 Nov 2020 09:47:24 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 1/4] fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
Date:   Thu, 12 Nov 2020 12:06:40 -0600
Message-Id: <1605204403-6663-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add FPGA_MGR_BITSTREM_AUTHENTICATION flag for FPGA bitstream
authentication.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 include/linux/fpga/fpga-mgr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 2bc3030..1d65814 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_BITSTREM_AUTHENTICATION: do FPGA bitstream authentication
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_BITSTREM_AUTHENTICATION BIT(5)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.7.4

