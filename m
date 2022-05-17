Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB7529CD3
	for <lists+linux-fpga@lfdr.de>; Tue, 17 May 2022 10:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbiEQIl7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 May 2022 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243745AbiEQIl6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 May 2022 04:41:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10180403E8;
        Tue, 17 May 2022 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652776917; x=1684312917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QnPlWtkqhfDOYWo6Q0LECnG3DaeXR6oPXcnQW5GxBe8=;
  b=FvAIMf6+dWpdifdeQRiY7xwu9onfgxIGsTj8NEYMnqg9tGplwFqiOjK2
   jTO5hn4tV9ktsl29fdaxNE2YRjpIrviQH0KfchnaRWpLQ6TC0FgNswmGa
   lxkDjPbI/dFMfp4/v6Tujh6VABCh5DD+yUJkXfs1PQ7KjIG4POOJULhht
   6WUn7UM47XiSPLEK1mmSjdccEV+3UGVbNzH5vn9ncpwLMv/ksTAq3/W8Y
   /HGlCBDHzQ07cqGEepp6fYHVm+t0dvN9E1JRQtYZBCfdh7U6RnHpvxig0
   Dg1KraOKg9LnXVGhlPGz1W9neosxs7NwAZNyiKJZh5o5Oveu8cLwnPulU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271235583"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271235583"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 01:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="660517186"
Received: from pglc1026.png.intel.com ([172.30.19.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2022 01:41:38 -0700
From:   adrian.ho.yin.ng@intel.com
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Tull <atull@opensource.altera.com>
Subject: [PATCH 2/3] fpga: doc: documentation for FPGA debugfs
Date:   Tue, 17 May 2022 16:41:36 +0800
Message-Id: <20220517084136.3529-1-adrian.ho.yin.ng@intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Alan Tull <atull@opensource.altera.com>

Document the DebugFS interface for the core FPGA Manager
framework.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
 Documentation/fpga/debugfs.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/fpga/debugfs.txt

diff --git a/Documentation/fpga/debugfs.txt b/Documentation/fpga/debugfs.txt
new file mode 100644
index 000000000000..1b34d5460d5d
--- /dev/null
+++ b/Documentation/fpga/debugfs.txt
@@ -0,0 +1,33 @@
+FPGA Manager DebugFS interface for FPGA reprogramming.
+
+Alan Tull 2016
+
+Each FPGA gets its own directory such as <debugfs>/fpga_manager/fpga0 and
+three files:
+
+ - [RW] flags:          flags as defined in fpga-mgr.h.  For example:
+
+   $ echo 1 > /sys/kernel/debug/fpga_manager/fpga0/flags
+
+ - [RW] firmware_name:  Name of an FPGA image firmware file.  Writing initiates
+                        a complete FPGA programming cycle.  Note that the image
+                        file must be in a directory on the firmware search path
+                        such as /lib/firmware.
+
+   $ echo image.rbf > /sys/kernel/debug/fpga_manager/fpga0/firmware_name
+
+ - [WO] image:          Raw FPGA image data.  Writing the FPGA image data will
+                        initiate a complete FPGA programming cycle.  Data must
+                        be written in one chunk, for example:
+
+   $ dd bs=10M if=./image.rbf of=/sys/kernel/debug/fpga_manager/fpga0/image
+    (where image.rbf < 10M)
+
+To program the FPGA, write the flags (if needed), then use either the
+firmware_name or image file to program.
+
+This interface does not handle bridges or loading/unloading of soft IP device
+drivers.  This makes it really easy to mess things up by doing things like
+reprogramming the hardware out from under a driver or reprogramming while a
+bridge is enabled, causing gunk to go out on a cpu bus.  It should go without
+saying that this interface is for debug only.  Not intended for production use.
-- 
2.26.2

