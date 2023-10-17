Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443D17CC6F2
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Oct 2023 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbjJQPCN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Oct 2023 11:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343644AbjJQPCM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 Oct 2023 11:02:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B649F0
        for <linux-fpga@vger.kernel.org>; Tue, 17 Oct 2023 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697554931; x=1729090931;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ys7o5zFW0EmY2khd07AhUXnZe9JleFOyc+f9QMD00X0=;
  b=O5OTz6dz6gDh3GDAHh9d661rrdIkZiq4r1k0jcEBuh27ymX4m+ktAG06
   cGMhto2QRysEVWcBPO0VpEER0qBYEoi+wCMGIiUlpuxgSlcBJmTwfRbDd
   YPJac4cMsnTRVNvENKA78rjBmqHQti+VjEEF/Yhj7sSo3kfdWjheMOqOn
   zZTf9Of1bSzKMn/r2b0DTY7eXJowXKmRiivVsACm47xJCtDte//w9bX7M
   VA5oKnGY+mwwU/7EyI2nCj4DNErDCLUXJ/dWWRH5+5UEhtvVTHku46bE0
   V3Cp2C7BsFwLtPt8Xek6BTW704ivXxF2l55Kq2QlySorGyES7AXTB8Wxz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383026172"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="383026172"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="4116321"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 17 Oct 2023 08:01:32 -0700
Date:   Tue, 17 Oct 2023 23:00:22 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@linux.intel.com, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.6-final
Message-ID: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-final

for you to fetch changes up to 6a935361500a21ef11a82814ee66fc58e59813f7:

  fpga: Fix memory leak for fpga_region_test_class_find() (2023-10-12 12:59:29 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.6-final

FPGA KUnit test:

- Marco's change fixes null-ptr-deref when try_module_get()
- Jinjie's change fixes a memory leak issue

Intel m10 bmc secure update:

- Maintainer change from Russ Weight to Peter Colberg

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our fixes branch)

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Jinjie Ruan (1):
      fpga: Fix memory leak for fpga_region_test_class_find()

Marco Pagani (4):
      fpga: add helpers for the FPGA KUnit test suites.
      fpga: add a platform driver to the FPGA Manager test suite
      fpga: add a platform driver to the FPGA Bridge test suite
      fpga: add a platform driver to the FPGA Region test suite

Russ Weight (1):
      fpga: m10bmc-sec: Change contact for secure update driver

 .../testing/sysfs-driver-intel-m10-bmc-sec-update  | 14 +++++------
 MAINTAINERS                                        |  2 +-
 drivers/fpga/tests/fpga-bridge-test.c              | 18 +++++++++++++-
 drivers/fpga/tests/fpga-mgr-test.c                 | 18 +++++++++++++-
 drivers/fpga/tests/fpga-region-test.c              | 28 +++++++++++++++++----
 drivers/fpga/tests/fpga-test-helpers.h             | 29 ++++++++++++++++++++++
 6 files changed, 94 insertions(+), 15 deletions(-)
 create mode 100644 drivers/fpga/tests/fpga-test-helpers.h
