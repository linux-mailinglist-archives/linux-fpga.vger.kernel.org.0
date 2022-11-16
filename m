Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2818F62C261
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Nov 2022 16:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKPPVH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Nov 2022 10:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiKPPUq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Nov 2022 10:20:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E64C27B
        for <linux-fpga@vger.kernel.org>; Wed, 16 Nov 2022 07:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668612038; x=1700148038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xe4bDuA2hmeutqSkXTlKHiqEOVfTc55CS5zBcgnlEkI=;
  b=gMy7imKMMFfJfy8JUYDbUlEwzO/9QQZDTsv7sho2N11mJ/vJR179fWTy
   NJKOKPoLALnyjAWw+BhEtd2V8A0eb4E5z55vM5jgE4HNBDOA+CaFaDBTi
   shUqut7Ifyfli8QdqXapYA7NE1vg1wjd3ApnTrjD2wd/MsNKD+Ik25nVJ
   jthSQjnLQzlleteVIPQZG+EQmb9SZWTFGqUbNv73RIkZ1e4Oi2zplvCmd
   4dOp2tbK/8DVGcpJ/DTOoV5KYDQaSKGbowXM7VsxOFVQSui7Zafefx+Hy
   E6fKj09cfd+BijyrYCSo4fD232VNRAEM+56Y4B+8BOFSDHJMNb58UFvyJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="374702115"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374702115"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 07:20:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="781798404"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="781798404"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2022 07:20:36 -0800
Date:   Wed, 16 Nov 2022 23:11:10 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.1-final
Message-ID: <Y3T9jtqxT3Nja1Rk@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.1-final

for you to fetch changes up to dfd10332596ef11ceafd29c4e21b4117be423fc4:

  fpga: m10bmc-sec: Fix kconfig dependencies (2022-11-15 21:46:58 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.1-final

Intel m10 bmc secure update

- Russ's change fixes Kconfig dependencies

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-6.1 branch)

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Russ Weight (1):
      fpga: m10bmc-sec: Fix kconfig dependencies

 drivers/fpga/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
