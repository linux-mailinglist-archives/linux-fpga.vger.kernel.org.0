Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E9B72BB0B
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Jun 2023 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjFLIlw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Jun 2023 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjFLIlm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 12 Jun 2023 04:41:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF9120
        for <linux-fpga@vger.kernel.org>; Mon, 12 Jun 2023 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686559301; x=1718095301;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LqCb0vI7jAWvxqE6rvq5GH8+IecEOk1GDR6lcX0Gba0=;
  b=fEG/9eCvqLJBxIGUzmkuJuF3QVNJ/pBIi7j+uffZg4OC0oY2MdWwze1o
   7atACQ3mFGedzqTuOM4vW7+/XubCR89PsV1oLGlEo/g/Jd8v1trijWEye
   kWAOEsNcKOWWN6MSfMj8q9L5CdL79SkUlyB9Er5hNwt/eFuMbyT+TWALa
   4dZaIif3ybNU0VkeI4AAkpwBFyDEp7x5U/Oug0q/QrpK5lfJsk/0hgMzB
   mF0lCm3N+KIqtWqxLmhNxq+ew/TB6kIArA+8v3ZqlG/ktq3kEFudL+skp
   zyMbWoirRPIfzUNa3QfFtxmfrAZi4JI/x04WkmCvxiGAMYkJ0RFS6iQ4t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="356866095"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="356866095"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="957926814"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="957926814"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2023 01:41:27 -0700
Date:   Tue, 13 Jun 2023 00:40:44 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.5-rc1
Message-ID: <ZIdKjGlqzcHGveTV@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.5-rc1

for you to fetch changes up to 47147d56f92ee3f575e4b457413e0f2587b40e17:

  fpga: zynq-fpga: Ensure proper xCAP interface switch (2023-06-06 19:14:19 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.5-rc1

DFL:

- Krzysztof's change constifies pointers to hwmon_channel_info

Xilinx:

- Alfonso's change ensures proper reprograming (xCAP) interface switch

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Alfonso Rodriguez (1):
      fpga: zynq-fpga: Ensure proper xCAP interface switch

Krzysztof Kozlowski (1):
      fpga: dfl-fme: constify pointers to hwmon_channel_info

 drivers/fpga/dfl-fme-main.c | 4 ++--
 drivers/fpga/zynq-fpga.c    | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)
