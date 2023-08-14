Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D339577B5CB
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Aug 2023 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjHNJwB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Aug 2023 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjHNJvu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Aug 2023 05:51:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54265CC
        for <linux-fpga@vger.kernel.org>; Mon, 14 Aug 2023 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692006708; x=1723542708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f1MEzXakOSYUpY3IHQ0M9z2n8MZ1kR5HGSJPHra/ggk=;
  b=kZyQAoZ0p1eTuLWb1lA+DXbPxEI0KFKWP6WfYgEsOODdVTVCtpv9yA/N
   75Lgx7Ql2CrHISk9GjZ/tWfq2Lo+8f4RsAjDQgKZu8j2x4J+wGdiZq5nZ
   j7xKjjPeY/x+em+nx3owG1WUI8NYoUbF/hOcCpPT+5zNv+c+GLK9ojZbj
   eoTqXdTgzDcEpEBIB+BssOALHAgzP4oIiDJz9lXt9+9ZBi72PCBKaTWnZ
   zEwprwfirqZv+2iv07N/XNb4BKyjrfZJTKmJQ/UQisGsjcKDcOnVVhmqJ
   sS44Eg5RQvVepdzHeReXOlKc2B5XNstxFMtwCpam1BE9nsgQFsBek9WWB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="375711199"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="375711199"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 02:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="710271955"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="710271955"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2023 02:51:44 -0700
Date:   Mon, 14 Aug 2023 17:49:27 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.6-rc1
Message-ID: <ZNn4p4zpwj3iCk4u@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-rc1

for you to fetch changes up to 1a22ec09a2c1d367a43cb7f837c7a8719e7fe975:

  fpga: region: make fpga_region_class a static const structure (2023-08-11 23:04:21 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.6-rc1

- Marco's change fixes kernel-doc warnings.
- Yangtao's change converts to use devm_platform_ioremap_resource().
- Peter's change uses HWMON defined Macros for HWMON interfaces support.
- Rob's change explicitly includes correct DT includes.
- Marco's change adds KUnit tests for FPGA core.
- Xiongfeng's change converts to use pci_find_vsec_capability().
- Ivan's change makes fpga_xxx_class a static const structure.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Ivan Orlov (3):
      fpga: bridge: make fpga_bridge_class a static const structure
      fpga: fpga-mgr: make fpga_mgr_class a static const structure
      fpga: region: make fpga_region_class a static const structure

Marco Pagani (6):
      fpga: region: fix kernel-doc
      fpga: bridge: fix kernel-doc
      fpga: add an initial KUnit suite for the FPGA Manager
      fpga: add an initial KUnit suite for the FPGA Bridge
      fpga: add an initial KUnit suite for the FPGA Region
      fpga: add configuration for the FPGA KUnit test suites.

Peter Colberg (1):
      fpga: dfl: fme: use SI unit prefix macros

Rob Herring (1):
      fpga: Explicitly include correct DT includes

Xiongfeng Wang (1):
      fpga: dfl-pci: Use pci_find_vsec_capability() to simplify the code

Yangtao Li (8):
      fpga: bridge: Convert to devm_platform_ioremap_resource()
      fpga: dfl-fme-mgr: Convert to devm_platform_ioremap_resource()
      fpga: xilinx-pr-decoupler: Convert to devm_platform_ioremap_resource()
      fpga: fpga-mgr: socfpga: Convert to devm_platform_ioremap_resource()
      fpga: fpga-mgr: ts73xx: Convert to devm_platform_ioremap_resource()
      fpga: zynq-fpga: Convert to devm_platform_ioremap_resource()
      fpga: fpga-mgr: altera-pr-ip: Convert to devm_platform_ioremap_resource()
      fpga: socfpga-a10: Convert to devm_platform_ioremap_resource()

 drivers/fpga/Kconfig                  |   2 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/altera-fpga2sdram.c      |   2 +-
 drivers/fpga/altera-freeze-bridge.c   |  11 +-
 drivers/fpga/altera-pr-ip-core-plat.c |   9 +-
 drivers/fpga/dfl-fme-main.c           |  17 +-
 drivers/fpga/dfl-fme-mgr.c            |   4 +-
 drivers/fpga/dfl-pci.c                |  15 +-
 drivers/fpga/fpga-bridge.c            |  48 ++---
 drivers/fpga/fpga-mgr.c               |  25 ++-
 drivers/fpga/fpga-region.c            |  37 ++--
 drivers/fpga/microchip-spi.c          |   2 +-
 drivers/fpga/of-fpga-region.c         |   2 +
 drivers/fpga/socfpga-a10.c            |   7 +-
 drivers/fpga/socfpga.c                |   7 +-
 drivers/fpga/stratix10-soc.c          |   1 +
 drivers/fpga/tests/.kunitconfig       |   5 +
 drivers/fpga/tests/Kconfig            |  11 ++
 drivers/fpga/tests/Makefile           |   6 +
 drivers/fpga/tests/fpga-bridge-test.c | 175 ++++++++++++++++++
 drivers/fpga/tests/fpga-mgr-test.c    | 327 ++++++++++++++++++++++++++++++++++
 drivers/fpga/tests/fpga-region-test.c | 211 ++++++++++++++++++++++
 drivers/fpga/ts73xx-fpga.c            |   4 +-
 drivers/fpga/xilinx-pr-decoupler.c    |   4 +-
 drivers/fpga/zynq-fpga.c              |   4 +-
 25 files changed, 828 insertions(+), 111 deletions(-)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
 create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
 create mode 100644 drivers/fpga/tests/fpga-region-test.c
