Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712CB4FCF6A
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Apr 2022 08:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiDLGWv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Apr 2022 02:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348717AbiDLGWs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Apr 2022 02:22:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5EB35269;
        Mon, 11 Apr 2022 23:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649744431; x=1681280431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G4Lt3wBCTT7QSmLNG6ZTrcPlmED6Oyz7Z88Eirf/rlc=;
  b=LZaQQZ+KP/tlxKWmEVfI7aX/m7hikzpRYH6Z8R7OWlC2FXdvVOqlg4Vf
   vPSnjMjT+kp8Ssf3OyAAUiz1g/23J3u78pBIW3yP8keuYdsHasV0E5ExE
   xCxmyBQ6xTOMZEsMgUD8lBXgy+WHvn+88CI7qgH8FbFce8odHDiHI6KjY
   Af9ciy1if6Dwily6FbLH0LWPp4XyAFWIrzFgRgfVWDqqe79qXUcFutxdK
   DTugQl6mLCh5mpkvu1OAkUyvbwaYArlBLI4aHiQry7mXcVJrucGrFq4p3
   Y+BCeMJF0sIf1ZnknnLsnJ1N+R9HLN0mlBSsYfkrE5LQd7uFP0kyRmegg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262467203"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262467203"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="724305400"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2022 23:20:28 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, rdunlap@infradead.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v6 2/2] Documentation: fpga: dfl: add description of feature ids
Date:   Tue, 12 Apr 2022 02:17:05 -0400
Message-Id: <20220412061705.53721-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220412061705.53721-1-tianfei.zhang@intel.com>
References: <20220412061705.53721-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

This patch adds the description of feature id table in documentation.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
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

