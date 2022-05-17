Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B575529CCE
	for <lists+linux-fpga@lfdr.de>; Tue, 17 May 2022 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbiEQIlb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 May 2022 04:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243787AbiEQIlU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 May 2022 04:41:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B33E0DE;
        Tue, 17 May 2022 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652776877; x=1684312877;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6evQhJLdtsPwWBLl9ZvCL+G/aYzA0wun6Lh5rUzCR/k=;
  b=BKZYEb1ciuYJwAZywT77sbXWuQDhrKuJX/kMQZpqd4PHGcdSeFyTX49Q
   7BurNWjfMI3pYzEtkIw8bvpQftTdW3bPOIfjdtdeRWuFOIhLKZOYybpWu
   lyMulhc/INKyfgXSq2cq7euBoMWGf4qvXPa/23GY8ZfCV74ma7flmcMzJ
   zgMNoTNAuMdrQY3x0UuIUULnl9HZH/dMiP3dFiWqsJTMnUEzn9PcyG4m5
   AUcuY3Sbzcsj5HIt2RoC8Rr4NpoALxjPqoGYh2f+MpWQvE4euGVBUH3Qw
   THTAm96D+xXGoJYjXFGXORgjIHLTZXi+wLDv7VYiKdZ/jJVnUfT2gCxxi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="251626213"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="251626213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 01:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="660517135"
Received: from pglc1026.png.intel.com ([172.30.19.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2022 01:41:14 -0700
From:   adrian.ho.yin.ng@intel.com
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
Subject: [PATCH 0/3] fpga: fpga-mgr: Add support for DebugFS for FPGA Manager Framework
Date:   Tue, 17 May 2022 16:41:08 +0800
Message-Id: <20220517084108.1516-1-adrian.ho.yin.ng@intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>

Hi,

A DebugFS for the FPGA Manager Framework is implemented which supports 
read/write functionality for the FPGA image firmware file to program for 
debugging purposes. To facilitate in usage a documentation for debugFS is 
added. A debugFS interface is extended for setting the maximum time in 
microseconds for the FPGA to go to the operating state after the region 
has been programmed.

Adrian Ng Ho Yin (1):
  fpga: Implement DebugFS for FPGA Manager Framework

Alan Tull (1):
  fpga: doc: documentation for FPGA debugfs

Matthew Gerlach (1):
  add debugfs interface for fpga config complete timeout

 Documentation/fpga/debugfs.txt  |  39 +++++++
 drivers/fpga/Kconfig            |   7 ++
 drivers/fpga/Makefile           |   1 +
 drivers/fpga/fpga-mgr-debugfs.c | 188 ++++++++++++++++++++++++++++++++
 drivers/fpga/fpga-mgr-debugfs.h |  32 ++++++
 drivers/fpga/fpga-mgr.c         |   8 ++
 include/linux/fpga/fpga-mgr.h   |   3 +
 7 files changed, 278 insertions(+)
 create mode 100644 Documentation/fpga/debugfs.txt
 create mode 100644 drivers/fpga/fpga-mgr-debugfs.c
 create mode 100644 drivers/fpga/fpga-mgr-debugfs.h

-- 
2.26.2

