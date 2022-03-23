Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85D24E4EC5
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Mar 2022 09:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbiCWI4X (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Mar 2022 04:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242938AbiCWI4V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Mar 2022 04:56:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C7B5EDFD;
        Wed, 23 Mar 2022 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648025692; x=1679561692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N5YYyV66tPIKoOXEpoly446tfaseGcfjL/6Hy4p5OI8=;
  b=YENG48Sj4r4U92+UWpV48ACPqTM6WEvU0myJby5Uqgg0q7Lpjj0H59PK
   8KR7BYMQOB+gjlA4HjK0ojiy7JN6XAnwZ2tVO/qI8SBVMvSjysDO4p6Yz
   svsiJXZ5CQ1bn12WUlUfqGcHlOzsk+Dr4eR+pXQAolv38iDYlnMKCG7xE
   rMuA5ASuCdHXbJ9RmndQiaPlbqqeSF1QMa9f5Uh07DGttw74dDYXmSvKx
   QMtvqMTQSiNoG0BBaWoVTwWmleLYI0p+pQfEPl7l1SL6sgZD2oQa6VGrQ
   6mgPvv5/5VM0qUwJ7/h+KabMFrqj8EC/VwhorKiQNmO9xZ9ph8FZ+l77y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="258010502"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="258010502"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="717315449"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2022 01:54:30 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org,
        Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v5 2/2] Documentation: fpga: dfl: add description of Feature ID
Date:   Wed, 23 Mar 2022 04:51:02 -0400
Message-Id: <20220323085102.2297964-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220323085102.2297964-1-tianfei.zhang@intel.com>
References: <20220323085102.2297964-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
v5: fix documentation from Matthew's comment.
---
 Documentation/fpga/dfl.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ef9eec71f6f3..231fe7a4d099 100644
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
+If you want to add a new feature ID for FPGA DFL feature device, you must submit a pull
+request to register a feature ID for DFL. Here is the DFL Feature ID Registry:
+
+https://github.com/OPAE/linux-dfl-feature-id
+
 Location of DFLs on a PCI Device
 ================================
 The original method for finding a DFL on a PCI device assumed the start of the
-- 
2.26.2

