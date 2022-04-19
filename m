Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D8F5062D4
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 05:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348049AbiDSDg2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Apr 2022 23:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347785AbiDSDfy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Apr 2022 23:35:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9D02C101;
        Mon, 18 Apr 2022 20:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650339193; x=1681875193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W23DCLYQ68O2n2PfrWEfo1lugGZFa89xsWZWgCH61n0=;
  b=XGD7C/TfT71SUq4sj8KkIcPoTCBU3E2pFn7g9tqQup1aYZhhfpscHy8B
   RBRCNFbH1XZayAnmh7LMJ8ADg+cE75Fg5eh5T+uzYZmWLbFcuapY196I/
   AbAXKEp9M+lL0gwum/PF2TiUVLFWAHOrOLfwEAqm2F4xu4pagtqJ1N/2z
   BLtVFouhe2Bgo1kICuyNkDfG3AQTR1pE9NxEgaFa75HSI8Y/okAfN2CAx
   YyXXq13YUSdgdPfruYsaVTFuNrYBBJP/ldLuH0cJW9cZHltoG5gHzvF3t
   kT8NqjCAh/wb2dImAYZr0q7YqoPgNoGKk15SLXiCA8xqssF80y6sWynub
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263126796"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263126796"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="726894624"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 18 Apr 2022 20:33:10 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v7 2/2] Documentation: fpga: dfl: add link address of feature id table
Date:   Mon, 18 Apr 2022 23:29:42 -0400
Message-Id: <20220419032942.427429-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220419032942.427429-1-tianfei.zhang@intel.com>
References: <20220419032942.427429-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

This patch adds the link address of feature id table in documentation.

Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
v7:
  - change the title and git commit message.
  - add Reviewed by from Matthew Gerlach.
v6: fix documentation from Hao's comment.
v5: fix documentation from Matthew's comment.
---
 Documentation/fpga/dfl.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ef9eec71f6f3..15b670926084 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -502,6 +502,11 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
+Please refer to below link to existing feature id table and guide for new feature
+ids application.
+https://github.com/OPAE/dfl-feature-id
+
+
 Location of DFLs on a PCI Device
 ================================
 The original method for finding a DFL on a PCI device assumed the start of the
-- 
2.26.2

