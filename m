Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EA666BB52
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jan 2023 11:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjAPKKJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Jan 2023 05:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjAPKJo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 16 Jan 2023 05:09:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFFEE3A0;
        Mon, 16 Jan 2023 02:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673863741; x=1705399741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UFA1eWjFYyEG05j2uQ04x1A4Em5a3L/VFZdvoAbuf1A=;
  b=UC9OcDcMxgQ/Wx+mWZBbjNZ5A4fUdgosnPQT5nvM7XE1Vxuk9eXjCppy
   eiWK8BYfQtlhxfT4e4KqHUYFDrKJ+5WARmKvBhl88Cq7VSHIb5ryEOgVL
   GsrnoE1Xb3t+JD+oRZMnCi9FqK2F7501OOi7/jZFROD7w03DRdMyW4I5A
   kPOvveh7QOb/qmf18gxDFnfVY53xgM/euILbxTsbtQLr0Ibufnca3ixjR
   2sj/27tXByP1BKmN8tFJCfWL6n9O9AaC0RgSOq9rEiC6eIo8U5wxv9wwr
   WvxbAm24i/2gzt+8oSkf1yqUJZm3GfSCih5EFa4Ii2WarpA4lT11amCfb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="326489247"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="326489247"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:09:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="832785624"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="832785624"
Received: from xsanroma-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:08:57 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 01/11] mfd: intel-m10-bmc: Add missing includes to header
Date:   Mon, 16 Jan 2023 12:08:35 +0200
Message-Id: <20230116100845.6153-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
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

linux/mfd/intel-m10-bmc.h is using:
	- pr_err(), thus include also linux/dev_printk.h
	- FIELD_GET(), this include also linux/bitfield.h
	- GENMASK(), thus include also linux/bits.h

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/mfd/intel-m10-bmc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index f0044b14136e..0d4db5d9d5af 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -7,6 +7,9 @@
 #ifndef __MFD_INTEL_M10_BMC_H
 #define __MFD_INTEL_M10_BMC_H
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
 #include <linux/regmap.h>
 
 #define M10BMC_LEGACY_BUILD_VER		0x300468
-- 
2.30.2

