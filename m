Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA26747BA0
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 04:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGECzJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Jul 2023 22:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGECzI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Jul 2023 22:55:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404510F8;
        Tue,  4 Jul 2023 19:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688525707; x=1720061707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2AHTM+ZT1V/5A9VtX7Byo3tp0kahwGhX0U+hXQPlMxc=;
  b=d78MlzQ1AmECWugz7WuuU/JzwvBPuYTAKFgQmkOXEIFFXz8ANpZU8ejW
   uskKD9aercHq4YNleMJwG99lirY1JtAORwP6hV6uPI+bZ/w3Q+4g1LA07
   Ny3ntr5NouQdjnRRpyJnYznLpzcAhfIbh1hvoKQ79diRgRRsJtfwa8j/Z
   Z5mC7DPnRK5IS6buhkmPg9mkFAJT/fhEv5C7tliOkxEGCFtU1oFYyHNks
   JW+phQ/5uHxdOfWGtSF8YClpgYgJYdi6qJd+NkpEvvzse+RQg+uBuV8Nt
   pil6iBGJK4LEnt7baY/m8wOBFiPuexgfnq5hwhwP9pOC88OPJaunbQcY5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="343567165"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="343567165"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 19:55:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="754206049"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="754206049"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 19:55:06 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com, Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH 0/2] fpga: dfl: clean up string formatting for sysfs_emit() and dev_dbg()
Date:   Tue,  4 Jul 2023 22:54:49 -0400
Message-Id: <cover.1687301688.git.peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The first patch in this series substitutes sysfs_emit() for sprintf()
and scnprintf() to format sysfs values and removes explicit casts in
favour of using the correct printk() format specifiers. The second patch
omits unneeded casts of u64 values to unsigned long long for dev_dbg().

These changes are cosmetic only; no functional changes.

Peter Colberg (2):
  fpga: dfl: use sysfs_emit() to format sysfs values
  fpga: dfl: omit unneeded casts of u64 values for dev_dbg()

 drivers/fpga/dfl-afu-dma-region.c | 14 ++++++--------
 drivers/fpga/dfl-afu-error.c      |  7 +++----
 drivers/fpga/dfl-afu-main.c       | 21 +++++++++------------
 drivers/fpga/dfl-fme-error.c      | 19 ++++++++-----------
 drivers/fpga/dfl-fme-main.c       | 26 ++++++++++----------------
 drivers/fpga/dfl-fme-mgr.c        |  5 ++---
 drivers/fpga/dfl-fme-perf.c       | 16 +++++++---------
 drivers/fpga/dfl.c                |  4 ++--
 drivers/fpga/fpga-bridge.c        |  2 +-
 drivers/fpga/fpga-mgr.c           |  4 ++--
 drivers/fpga/fpga-region.c        |  5 ++---
 11 files changed, 52 insertions(+), 71 deletions(-)

-- 
2.28.0

