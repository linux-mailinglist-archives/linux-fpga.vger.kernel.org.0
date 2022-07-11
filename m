Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AC356D4F9
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jul 2022 08:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiGKGtO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jul 2022 02:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGKGtN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 11 Jul 2022 02:49:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E533A6144
        for <linux-fpga@vger.kernel.org>; Sun, 10 Jul 2022 23:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657522153; x=1689058153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v0IKpX3K37IckwoBZ1hAPAifhHCS5ec3OJYjiM6ENEA=;
  b=X1Oz1EuXbazA/C2ByZV1PtWhMfvNyJBrhdEIHYy+93LHizcS8KYsrblP
   tjHDseRslW3oIg4wlkRSdc4BJSDWTEElaU88DhLQZWjMtg52RQU7p/g0+
   oMm22DW8W6zGHvDcadCFtaUKgjfBdfUa/icjz3mGZjaUnsBrIDZfyYxQA
   Vt/rPhIO/ABcMbQokvSxQU5EwD56YWuXGIAOI13GpEg0GhtJv/FLS14wo
   1bAGAet0wLUiZK2g74X08KoHCgGjvnfYnHyIU0u/hfnKYb+utVB5aA5g+
   l0cR0tOjUweGhKI2kgW9DYskkPRcww3vZTveqHd5hKJY4LJjo7RBCf6zl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="346276107"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="346276107"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 23:49:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="544895561"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 10 Jul 2022 23:49:11 -0700
Date:   Mon, 11 Jul 2022 14:40:43 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager late changes for 5.20-rc1
Message-ID: <20220711064043.GA4044494@yilunxu-OptiPlex-7050>
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

The following changes since commit 2df84a757d87fd62869fc401119d429735377ec5:

  fpga: altera-pr-ip: fix unsigned comparison with less than zero (2022-06-10 15:48:23 +0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-late-for-5.20-rc1

for you to fetch changes up to ee794221a6f66d054beb1cbc151d8de4083e634e:

  fpga: fpga-mgr: Fix spelling mistake "bitsream" -> "bitstream" (2022-06-29 15:18:18 +0800)

----------------------------------------------------------------
Here is the second set of FPGA changes for 5.20-rc1

FPGA Manager core:
- Ivan's change to support image offset and data size setting for
reprograming. A parse_header() callback is introduced for drivers to
specify these info.
- Colin's immediate spelling fix for Ivan's patch.

Microchip:
- Ivan's change to add Microchip MPF FPGA manager driver. And MAINTAINERS
entry added for the driver.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Colin Ian King (1):
      fpga: fpga-mgr: Fix spelling mistake "bitsream" -> "bitstream"

Ivan Bornyakov (5):
      fpga: fpga-mgr: support bitstream offset in image buffer
      docs: fpga: mgr: document parse_header() callback
      fpga: microchip-spi: add Microchip MPF FPGA manager
      dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
      MAINTAINERS: add Microchip PolarFire FPGA drivers entry

 .../bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml  |  44 +++
 Documentation/driver-api/fpga/fpga-mgr.rst         |  27 +-
 MAINTAINERS                                        |   8 +
 drivers/fpga/Kconfig                               |   8 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/fpga-mgr.c                            | 223 ++++++++++--
 drivers/fpga/microchip-spi.c                       | 398 +++++++++++++++++++++
 include/linux/fpga/fpga-mgr.h                      |  24 +-
 8 files changed, 700 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 create mode 100644 drivers/fpga/microchip-spi.c
