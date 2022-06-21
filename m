Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C386552B73
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbiFUHD0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 03:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbiFUHDU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 03:03:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B264DC
        for <linux-fpga@vger.kernel.org>; Tue, 21 Jun 2022 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655794999; x=1687330999;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GfX00x0KeSwQHkEGEJw11wOTxWJrXs9cKh/8cKBSh/0=;
  b=OC8qRl78Qclufh2NaGoT1nu6rGeJ10Niu4ZfSv5pt9nb1pfrhOkC/gPQ
   bRCbtAywV0GNmQ1Ii6qeHqVyzf5RIaNIqQMGV1VuDDSa/ZZQCz7UoUvyH
   rkghkxtmR1IUgvUR8U2sFYshUIYD1cZph6y/3rwv4tRZyGJCvRt0eA+yk
   zpKtyFYaaXB0PCPmuPg93n3zOaE0CjoYLfz6Q1h4JUQPwyCGYy9i3TRZk
   497kcEVt7nX9ASqqFQBc3daeV9G1w1NfB9mba0G/LiI/7LmiUjl1KACmg
   gDjNPXmlxvQR8iuKnVWE+jxXdcJ1SN5t5/rIdjOxu5PdmjdwQgCxBinV1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="260478257"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="260478257"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 00:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="614638937"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2022 00:03:08 -0700
Date:   Tue, 21 Jun 2022 14:55:01 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for v5.20-rc1
Message-ID: <20220621065501.GA1527017@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git tags/fpga-for-5.20-rc1

for you to fetch changes up to 2df84a757d87fd62869fc401119d429735377ec5:

  fpga: altera-pr-ip: fix unsigned comparison with less than zero (2022-06-10 15:48:23 +0800)

----------------------------------------------------------------
Here is the first set of FPGA changes for 5.20-rc1

FPGA static firmware loader

- Russ's change to add support for Intel MAX10 BMC Secure
  Update driver which instantiates the new Firmware Upload
  functionality (merged on last cycle) of the Firmware
  Loader.

DFL

- keliu's change to use ida_alloc()/ida_free() instead of
  deprecated ida_simple_get()/ida_simple_remove()

ALTERA

- Marco's change to fix a "comparison with less than zero"
  warning

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Marco Pagani (1):
      fpga: altera-pr-ip: fix unsigned comparison with less than zero

Russ Weight (5):
      mfd: intel-m10-bmc: Rename n3000bmc-secure driver
      fpga: m10bmc-sec: create max10 bmc secure update
      fpga: m10bmc-sec: expose max10 flash update count
      fpga: m10bmc-sec: expose max10 canceled keys in sysfs
      fpga: m10bmc-sec: add max10 secure update functions

keliu (1):
      fpga: Directly use ida_alloc()/free()

 .../testing/sysfs-driver-intel-m10-bmc-sec-update  |  61 ++
 MAINTAINERS                                        |   7 +
 drivers/fpga/Kconfig                               |  12 +
 drivers/fpga/Makefile                              |   3 +
 drivers/fpga/altera-pr-ip-core.c                   |   2 +-
 drivers/fpga/dfl.c                                 |   4 +-
 drivers/fpga/fpga-bridge.c                         |   6 +-
 drivers/fpga/fpga-mgr.c                            |   6 +-
 drivers/fpga/fpga-region.c                         |   6 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            | 625 +++++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c                        |   2 +-
 11 files changed, 721 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
 create mode 100644 drivers/fpga/intel-m10-bmc-sec-update.c
