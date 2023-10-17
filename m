Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C967CC72A
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Oct 2023 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjJQPM0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Oct 2023 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjJQPMZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 Oct 2023 11:12:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC3892
        for <linux-fpga@vger.kernel.org>; Tue, 17 Oct 2023 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697555544; x=1729091544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B6qafHAeGogumzdHlSxS1tRPOXTa3hvQnV/px+HOv8k=;
  b=mHMDkapdiBPwV5PrP85KjgLvFv+NcTAkjnPCynOrnE604kMlCu6Fy5sl
   YDPWto4kzj8H8VrfVj8eMNeFo9FbihxG86YOiaGHhhDoCstjuAZ1n8zND
   p2cmSHM/ZgYF/CkuflniI+EUoAz1iRjHSs+YLjtCa2gI1iTQEyO4WaFIZ
   FpcX2O9LTygwApbAPSthXyBZ4vX4YmsSPw2WIAPBP7RT7wUlxV1FoCKs6
   ZZagv674JU6gwI98kce3T01IFalrbXBW5AYuJhv6GPo7zRk0Lu2rdQkmv
   8XwMGLzSh6YP3qDlVQQBPbto24rqUtHgciTub0bIjy2Ua+oZl8KSyjem0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="416887601"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="416887601"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785511563"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="785511563"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 08:12:21 -0700
Date:   Tue, 17 Oct 2023 23:11:18 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@linux.intel.com, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.7-rc1
Message-ID: <ZS6kFqfbqbR5mdO+@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.7-rc1

for you to fetch changes up to d79eed22ba97c3031b2ef86f8b7ed0be2da5667d:

  fpga: versal: Add support for 44-bit DMA operations (2023-10-16 10:32:00 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.7-rc1

- Rob's change uses device_get_match_data/spi_get_device_match_data() to
get the driver match data for several drivers.
- Nava's change sets 44-bit DMA mask for versal fpga.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Nava kishore Manne (1):
      fpga: versal: Add support for 44-bit DMA operations

Rob Herring (2):
      fpga: Use device_get_match_data()
      fpga: altera-ps-spi: Use spi_get_device_match_data()

 drivers/fpga/altera-hps2fpga.c     | 12 +++-------
 drivers/fpga/altera-ps-spi.c       | 46 +++++---------------------------------
 drivers/fpga/versal-fpga.c         |  2 +-
 drivers/fpga/xilinx-pr-decoupler.c | 17 +++++---------
 4 files changed, 15 insertions(+), 62 deletions(-)
