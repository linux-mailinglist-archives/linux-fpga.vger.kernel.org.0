Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1910B5BC2A0
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Sep 2022 07:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiISF4e (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Sep 2022 01:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiISF4d (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 19 Sep 2022 01:56:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21415FDB
        for <linux-fpga@vger.kernel.org>; Sun, 18 Sep 2022 22:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663566992; x=1695102992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GJXFw29eWRKnxdF9G+vrBCCpZPpJoWynp+VSCcqwBek=;
  b=XD/Y2268RVvj7ffBzol2gWGV27fkX1qudjoQ4wEgroObmMdBH5YafII2
   utwz9+hVOM3mX6ilNINdIJwCaJCPoTdGYHJItVRMcdW+jahC8nZ3GFLyF
   R91mZFRig6a7HPqCicNy66xHKHrxzWJuy6XTHBGChBv5+Lzlvh110ceU6
   qtmyTiZpRZ/tT+jHDNfAgPatXmBwpA918oGg4WHiIYHJLOZDp1ovFIBoA
   VwIY/3FtN3g4FHYT8wPtf38D4OIgWHMSE/N1jLkI0Bm0z8JFOdMKtHQCd
   4l0yrNUNrjRxtLNfTWHG1Xuqbs6PtaMv7Q05Mb/O6Sy32x/NsJODgrT7N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="296903016"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="296903016"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 22:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="569511032"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2022 22:56:30 -0700
Date:   Mon, 19 Sep 2022 13:46:50 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.1-rc1
Message-ID: <YygCSm7btA1pkKdk@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.1-rc1

for you to fetch changes up to 562d0bf2cab80810fa50a1f109a6bdb61c25efc2:

  fpga: m10bmc-sec: d5005 bmc secure update driver (2022-09-11 15:36:35 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.1-rc1

DFL

- Matthew's change adds new device IDs supported by DFL.
- Dan's change uses array_size() for memory allocation to prevent
potential overflow

Microchip

- Conor's change adds MODULE_AUTHOR entry for microchip-spi driver
- Krzysztof's change refines dt-bindings

Intel m10 bmc secure update

- Russ's change adds new device ID supported by the driver

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Conor Dooley (1):
      fpga: microchip-spi: add missing module author entry

Dan Carpenter (1):
      fpga: prevent integer overflow in dfl_feature_ioctl_set_irq()

Krzysztof Kozlowski (1):
      dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: use spi-peripheral-props.yaml

Matthew Gerlach (1):
      fpga: dfl-pci: Add IDs for Intel N6000, N6001 and C6100 cards

Russ Weight (1):
      fpga: m10bmc-sec: d5005 bmc secure update driver

 .../bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml      |  7 ++++---
 drivers/fpga/dfl-pci.c                                 | 18 ++++++++++++++++++
 drivers/fpga/dfl.c                                     |  2 +-
 drivers/fpga/intel-m10-bmc-sec-update.c                |  3 +++
 drivers/fpga/microchip-spi.c                           |  1 +
 5 files changed, 27 insertions(+), 4 deletions(-)
