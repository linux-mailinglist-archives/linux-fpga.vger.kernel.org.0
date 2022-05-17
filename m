Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143D7529CD5
	for <lists+linux-fpga@lfdr.de>; Tue, 17 May 2022 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiEQIlx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 May 2022 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbiEQIlw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 May 2022 04:41:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C343386;
        Tue, 17 May 2022 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652776912; x=1684312912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=re/TqJfiXB30NBiMpSKQEhgi6oL5bPlUI1K2WqBpPyI=;
  b=FkvIYFUHXiUo8qs49/a4zPzp1LyXe46v3vEIoITARqT0bwV27quXPLG6
   2wxcACdsyrW1Uz0Vf9pLIjt0/B2BcR+snDSnRVr0KOMlmx4OKDUuVvcZW
   tPYoNvpyQSHJuHArusgTt1nVnS2MXq6yVLLiKkiYp1Dvyk7y3gH27cct8
   nrxGahKNM7Ccilv+mzHHQDWW80uYQRLM7n/4vCS6+1GaAVXX0mzaiqtFx
   yE4FgAY0RRpJ3XrYUO7RCR8sHZ/WiOyG9bvwac9QFFWEcOVyMSrHrVfHr
   pmTdFoyWZYkClwRZYgCmq/1UqrFnjQYq6YhXFLKvrAFhjOAJZ3iaRIfrk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="251626293"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="251626293"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 01:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="626371481"
Received: from pglc1026.png.intel.com ([172.30.19.132])
  by fmsmga008.fm.intel.com with ESMTP; 17 May 2022 01:41:48 -0700
From:   adrian.ho.yin.ng@intel.com
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 3/3] add debugfs interface for fpga config complete timeout
Date:   Tue, 17 May 2022 16:41:46 +0800
Message-Id: <20220517084146.4510-1-adrian.ho.yin.ng@intel.com>
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

From: Matthew Gerlach <matthew.gerlach@intel.com>

Add debugfs interface and documentation for setting the maximum
time in microseconds for the FPGA to go to the operating
state after the region has been programmed.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 Documentation/fpga/debugfs.txt  | 6 ++++++
 drivers/fpga/fpga-mgr-debugfs.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/fpga/debugfs.txt b/Documentation/fpga/debugfs.txt
index 1b34d5460d5d..b01950f76e20 100644
--- a/Documentation/fpga/debugfs.txt
+++ b/Documentation/fpga/debugfs.txt
@@ -9,6 +9,12 @@ three files:
 
    $ echo 1 > /sys/kernel/debug/fpga_manager/fpga0/flags
 
+ - [RW] config_complete_timeout_us:	time out in microseconds to wait for
+					FPGA to go to operating state after
+					region has been programmed.
+
+   $ echo 4 > /sys/kernel/debug/fpga_manager/fpga0/config_complete_timeout_us
+
  - [RW] firmware_name:  Name of an FPGA image firmware file.  Writing initiates
                         a complete FPGA programming cycle.  Note that the image
                         file must be in a directory on the firmware search path
diff --git a/drivers/fpga/fpga-mgr-debugfs.c b/drivers/fpga/fpga-mgr-debugfs.c
index 30af59b92bf3..83b712d4eb14 100644
--- a/drivers/fpga/fpga-mgr-debugfs.c
+++ b/drivers/fpga/fpga-mgr-debugfs.c
@@ -153,8 +153,13 @@ void fpga_mgr_debugfs_add(struct fpga_manager *mgr)
 			    &fpga_mgr_image_fops);
 
 	info = &debugfs->info;
+
 	debugfs_create_u32("flags", 0600, debugfs->debugfs_dir, &info->flags);
 
+	debugfs_create_u32("config_complete_timeout_us", 0600,
+			   debugfs->debugfs_dir,
+			   &info->config_complete_timeout_us);
+
 	mgr->debugfs = debugfs;
 }
 
-- 
2.26.2

