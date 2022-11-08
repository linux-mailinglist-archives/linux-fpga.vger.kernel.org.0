Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472C4621732
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 15:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiKHOpf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 09:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiKHOoc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 09:44:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F621A6;
        Tue,  8 Nov 2022 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667918671; x=1699454671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mk4FwTKpXPEVthCrmeXfry31BmjDVomdGZScwkkQgyQ=;
  b=iJTRDHkeMqgn03Vc6Dlg6jFdOiOwU1+zrhyZrnw7JA6dS0GG6pGK9qpn
   plaC7lZkBe66i9F7pWNmUnUybiuKQUxH2luB4St8lyNqBWoi13WKElsKK
   dT1H1zlkdczf1XCtEZGWYb3hiQ6mX4U9TL/b/4PYuDi8RDkm+v4taLabb
   nOPTIEkUKNtuc4a6vJWiKK6oPkmNQRvrEAFFfFgl5Mp3CFTJVPUxSgeWu
   viY2YGMiQg7bTsP2Dy8fmyv9+HXL3AuR1d3ng6cR/YA8N0fJhVEVoUWDU
   itWmvcnQ98STBHlTT1pRKIgIz+NUm8jcD2CfZPQTxVwfzeI7WwBrpHqr1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312497997"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="312497997"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:44:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="638809863"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="638809863"
Received: from ppkrause-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:43:59 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/12] intel-m10-bmc: Add regmap_indirect_cfg for Intel FPGA IPs
Date:   Tue,  8 Nov 2022 16:43:02 +0200
Message-Id: <20221108144305.45424-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create the regmap_indirect_cfg with offsets and commands for Intel FPGA
IPs indirect register access.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/mfd/intel-m10-bmc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index ed920f76d3c8..1b907c1a176f 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -15,6 +15,19 @@ enum m10bmc_type {
 	M10_N5010,
 };
 
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

