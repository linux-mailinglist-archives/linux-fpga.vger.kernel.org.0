Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A714867F8DD
	for <lists+linux-fpga@lfdr.de>; Sat, 28 Jan 2023 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjA1OxG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Jan 2023 09:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjA1OxF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 Jan 2023 09:53:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9431CACC
        for <linux-fpga@vger.kernel.org>; Sat, 28 Jan 2023 06:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674917580; x=1706453580;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iiyFrGYf3kLjw7dUsfqYUFJZ3H0Y4kvQmaj/YmbYtZM=;
  b=H8nvJmgHhVTxJ7TuRX3+XcnzuM07IRagVQDVS5UiJugtIG8rPacqSJj1
   LBo+xEpisZgZGkwMXkKQG+TYhvBRX1JAp3zitJfEk029f/sUeozn7pt+/
   sYgSIqZQTvUZDuYsHzmwqWh2p2P9M5P7C8WTPz9hZ9yBu7owZnP5jQweU
   fvof3IPliRKpgooURFKc5Gy/Z4094LONS0ZcElSQK3AbvtUyknj7hhvM2
   udRNGMibLalad+evgr4rCN7LJfb+TkYJDv+uzhr7hVTujELTSaMJzVqjb
   6Akd4CaCcTTTgzfNB1M9MTTviLzPbTUtg0Dtnvngm/J9XcU8KJ89hNjRw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="329424475"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="329424475"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 06:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="732186178"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="732186178"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2023 06:52:54 -0800
Date:   Sat, 28 Jan 2023 22:42:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.2 final
Message-ID: <Y9U0TASyMnHzbDtp@yilunxu-OptiPlex-7050>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.2-final

for you to fetch changes up to 60ce26d10e5850f33cc76fce52f5377045e75a15:

  fpga: m10bmc-sec: Fix probe rollback (2022-12-30 10:49:52 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.2-final

stratix10-soc:

- Zheng's change fixes return value check

Intel m10 bmc secure update:

- Ilpo's change fixes probe rollback

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-6.2 branch)

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Ilpo Järvinen (1):
      fpga: m10bmc-sec: Fix probe rollback

Zheng Yongjun (1):
      fpga: stratix10-soc: Fix return value check in s10_ops_write_init()

 drivers/fpga/intel-m10-bmc-sec-update.c | 17 ++++++++++++-----
 drivers/fpga/stratix10-soc.c            |  4 ++--
 2 files changed, 14 insertions(+), 7 deletions(-)
