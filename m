Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F9F67FE2C
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Jan 2023 11:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjA2K24 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 Jan 2023 05:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjA2K2z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 Jan 2023 05:28:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB55521A26
        for <linux-fpga@vger.kernel.org>; Sun, 29 Jan 2023 02:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674988134; x=1706524134;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nvPknIP+1J9Tk/lYl7r+0QQzjyIzCyiINMqVuLc7spM=;
  b=bpgloEwJHVEYLgVsYYGsVPNrKh1yI1DD7LNQ4pjDQo1cboBhTii01iBr
   LTle0RqVhAleUMv33h2y6MVHI2MuE+6JZe2AzONitJBFg/CqhpYkoLRN0
   4gfg+2lImYCnOXQValYH3Ib50HLdj1y1dDHOmHEbvmpTaML3uwZimJ3zi
   wcB+HilFnjKf9DyX0eXCYXVlAwEbYGboAmzswUwPXer+Il7UcZpKDzeKq
   +JGK2jtSeNYOqkI3zqZhwYSnqtMLrqtIY58h+60+6aIwI9exVFl3MfoGT
   OUqMxSh2VrElLVRfyZRovtXBoB14FDPB/zDao8vJYaNhJNQbOHNlnLwkx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="329511077"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="329511077"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 02:28:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909163808"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="909163808"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2023 02:28:52 -0800
Date:   Sun, 29 Jan 2023 18:18:16 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.3-rc1
Message-ID: <Y9ZH6EhbFCRvoFXx@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-v6.3-rc1

for you to fetch changes up to 9d18515e4a2b9d3828b6d64087feeeed3aa1cf65:

  Merge tag 'ib-mfd-fpga-hwmon-v6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd into for-fpga-v6.3-rc1 (2023-01-29 00:34:59 +0800)

My first time trying to resolve conflict and merge another branch for
upstream, not sure if it's correct. See from Documentation that merging
a sibling tree should usually be avoided, but I assume merging a topic
tree should be OK?

----------------------------------------------------------------
FPGA Manager changes for 6.3-rc1

Microchip:

- Ivan's reliability improvements for Microchip Polarfire FPGA

FPGA DFL doc:

- Randy and Yilun's kernel doc fixes.
  The 2 patches, "fpga: dfl: more kernel-doc corrections" &
  "fpga: dfl: kernel-doc corrections" conflicts with Matthew's FPGA
  patch "fpga: dfl: add basic support for DFHv1" on tty-next. Yilun
  resolved the conflicts on:
  --branch for-next https://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git/
  On that branch, Matthew's patch is applied first then kernel doc fixes
  follow.

Intel m10 bmc MFD & sub devices:

- Lee's topic branch merged, to support new BMC board type with new
  PMCI interface to host, as well as its new sub devices.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Ilpo Järvinen (10):
      mfd: intel-m10-bmc: Add missing includes to header
      mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
      mfd: intel-m10-bmc: Rename the local variables
      mfd: intel-m10-bmc: Split into core and spi specific parts
      mfd: intel-m10-bmc: Support multiple CSR register layouts
      fpga: intel-m10-bmc: Rework flash read/write
      mfd: intel-m10-bmc: Prefix register defines with M10BMC_N3000
      fpga: m10bmc-sec: Create helpers for rsu status/progress checks
      fpga: m10bmc-sec: Make rsu status type specific
      mfd: intel-m10-bmc: Add PMCI driver

Ivan Bornyakov (3):
      fpga: microchip-spi: move SPI I/O buffers out of stack
      fpga: microchip-spi: rewrite status polling in a time measurable way
      fpga: microchip-spi: separate data frame write routine

Marco Pagani (1):
      fpga: bridge: return errors in the show() method of the "state" attribute

Randy Dunlap (1):
      fpga: dfl: kernel-doc corrections

Xu Yilun (2):
      fpga: dfl: more kernel-doc corrections
      Merge tag 'ib-mfd-fpga-hwmon-v6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd into for-fpga-v6.3-rc1

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |   8 +-
 MAINTAINERS                                        |   2 +-
 drivers/fpga/Kconfig                               |   2 +-
 drivers/fpga/dfl-afu-region.c                      |   1 +
 drivers/fpga/dfl-afu.h                             |   2 +-
 drivers/fpga/dfl-fme-perf.c                        |   2 +-
 drivers/fpga/dfl-fme-pr.c                          |   4 +-
 drivers/fpga/dfl-fme-pr.h                          |   2 +-
 drivers/fpga/dfl.c                                 |   5 +-
 drivers/fpga/dfl.h                                 |   1 +
 drivers/fpga/fpga-bridge.c                         |  11 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            | 364 +++++++++++++--------
 drivers/fpga/microchip-spi.c                       | 145 ++++----
 drivers/hwmon/Kconfig                              |   2 +-
 drivers/mfd/Kconfig                                |  32 +-
 drivers/mfd/Makefile                               |   5 +-
 drivers/mfd/intel-m10-bmc-core.c                   | 122 +++++++
 drivers/mfd/intel-m10-bmc-pmci.c                   | 219 +++++++++++++
 drivers/mfd/intel-m10-bmc-spi.c                    | 168 ++++++++++
 drivers/mfd/intel-m10-bmc.c                        | 238 --------------
 include/linux/mfd/intel-m10-bmc.h                  | 154 ++++++---
 21 files changed, 984 insertions(+), 505 deletions(-)
 create mode 100644 drivers/mfd/intel-m10-bmc-core.c
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
 delete mode 100644 drivers/mfd/intel-m10-bmc.c
