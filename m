Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1FC62DA52
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Nov 2022 13:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiKQMJL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Nov 2022 07:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbiKQMH6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Nov 2022 07:07:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9F70A06;
        Thu, 17 Nov 2022 04:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668686878; x=1700222878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M5/55UXWk8amjuFXSeJET+jKpctM2rCu5oLSvWkwS1s=;
  b=fnjizPpqiZsPGUNQMD5ohVxwmo+vpHzI94NHXBxBekmZRZa2/1xxqUC6
   GipNh4o37CrveuNZkvDR7GP6yW7Byd1c+FTq/ed8AJFrixKtjwupYslhS
   wwyC+1GOPeUFXYGeHvmG7Bv/d59ZWVQ4BsvoPBxVHtVGKiLBRsfXuW49g
   5a30G1lkaeh6Z0LwJRQfgU7NndKJ8oRs33QIxL57P9ZTq4AqlD0ZCeqab
   JNNkxO8E820wsqHC59Udp2L3lGkAPQCNQkiUmzOK9TY3Rp8NsPtS8EiXu
   BpyFUdyrhnbl/W8o6Erq0Ea6wpN507YDeoVUsGcbcz1ByYIlmGsnoFPYB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313981464"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="313981464"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968855838"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968855838"
Received: from kvehmane-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.61.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:07:25 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/11] intel-m10-bmc: Add regmap_indirect_cfg for Intel FPGA IPs
Date:   Thu, 17 Nov 2022 14:05:12 +0200
Message-Id: <20221117120515.37807-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create the regmap_indirect_cfg with offsets and commands for Intel FPGA
IPs indirect register access.

Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/mfd/intel-m10-bmc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 200425b5b266..03ba92a68e01 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -9,6 +9,19 @@
 
 #include <linux/regmap.h>
 
+#define INTEL_M10_REGMAP_INDIRECT_CFG	\
+	.cmd_offset = 0,	\
+	.idle_cmd = 0,		\
+	.read_cmd = BIT(0),	\
+	.write_cmd = BIT(1),	\
+	.ack_offset = 0,	\
+	.ack_mask = BIT(2),	\
+	.addr_offset = 0x4,	\
+	.read_offset = 0x8,	\
+	.write_offset = 0xc,	\
+	.sleep_us = 1,		\
+	.timeout_us = 10000
+
 #define M10BMC_STAGING_SIZE		0x3800000
 
 /* Doorbell register fields */
-- 
2.30.2

