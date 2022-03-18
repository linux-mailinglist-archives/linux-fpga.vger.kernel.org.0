Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B94DD385
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Mar 2022 04:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiCRDVl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiCRDVk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 23:21:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4931D19530D;
        Thu, 17 Mar 2022 20:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647573623; x=1679109623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OnTmGwB/jo8Byf97gpYrwv+AasqZzFhD6yfV0qnrtPc=;
  b=dv2JV3qN75tcBYM+fQwU5XNWpWTS90BYntAu/Y8U8kCEzbRdfYdqz45R
   TOPL7zTw6c7aNqXFwG1b8247hiI45/2CxoFrhH8YVnPphkGSI81Rw9bgO
   lkLvlc10GXnzsW/xhcjiWIezFL1iXZHpAM/Bb16hM4WJJofCdxMUJOQDZ
   KaW+iMn9p55iehjeo+WPqqB+3fEsMOpPSFA8lIZhcTs73MhMY74Mk/Y5R
   pCjKvTWthVwBRJBNkAgRfVCnuIJFJMvlNl9PPOoWMj8UJ1aMpFiZcpZ4K
   9RnUNH0B1XRimmb+9S8um7gBoa+UhQGfAPuS+iBoFR2/sFfb353+MbmxD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254592187"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="254592187"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 20:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="647292897"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 20:20:20 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, rdunlap@infradead.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4 2/2] Documentation: fpga: dfl: add description of Feature ID
Date:   Thu, 17 Mar 2022 23:16:54 -0400
Message-Id: <20220318031654.2130587-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220318031654.2130587-1-tianfei.zhang@intel.com>
References: <20220318031654.2130587-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

This patch adds the description and registration of Feature ID
in documentation.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
 Documentation/fpga/dfl.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ef9eec71f6f3..260cac3b7215 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -502,6 +502,16 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
+Individual DFL drivers are bound DFL devices based on Feature Type and Feature ID.
+The definition of Feature Type and Feature ID can be found:
+
+https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-ids.rst
+
+If you want to add a new feature ID for FPGA DFL feature device, you must use a pull
+request to register a feature ID for DFL. Here is the DFL Feature ID Registry:
+
+https://github.com/OPAE/linux-dfl-feature-id
+
 Location of DFLs on a PCI Device
 ================================
 The original method for finding a DFL on a PCI device assumed the start of the
-- 
2.26.2

