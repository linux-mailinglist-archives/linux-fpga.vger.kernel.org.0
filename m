Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F304F640430
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Dec 2022 11:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiLBKIw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Dec 2022 05:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiLBKIw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Dec 2022 05:08:52 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF6ACBA7D;
        Fri,  2 Dec 2022 02:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669975731; x=1701511731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NxYiaduJKfMfDy2qsU7/1Hyuil+gA5dXqapI71cBH8U=;
  b=RgjpMZYagQ3EyZzwY5USSg06PjPM4Px6EJrba8mo/xOG9Po8KLTSM05l
   ZNGqR9Edu0pwGBUA/DVUhvBKFHgfbXlxXKyAUFRARs7OpnYgD6DHZR9ZM
   JBB+PnLsV/LCTOQlsNvvIuFsPuxuc4ZEzAhLwXO90Dq1jgD1UC+FJaF2y
   4W7tkferAz6y5QY/b7HmD5sMDi7RtKQ+UvLuXHZ4FQkoJcdIOcQVeqSgq
   ZkYYLA3Qqz8ZHiq0iCzgwzr+gW5xvGXSSJSdVWr40fG12g6ZQqogI0vR1
   3IZotT1S4UrBkwIuZ3Nk705CqBY1rQZ8IHSLgkmZUN9Bf0ZQYevNjuSsi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342859625"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="342859625"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 02:08:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="622649453"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="622649453"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 02:08:46 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/9] intel-m10-bmc: Split BMC to core and SPI parts & add PMCI+N6000 support
Date:   Fri,  2 Dec 2022 12:08:32 +0200
Message-Id: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi all,

Here are the patches for MAX 10 BMC core/SPI interface split and
addition of the PMCI interface. There are a few supporting rearrangement
patches prior to the actual split. In this version, the indirect register
access became part of the BMC PMCI module.

The current downside of the split is that there's not that much code
remaining in the core part when all the type specific definitions are
moved to the file with the relevant interface.

The patch set is based on top of the "fpga: m10bmc-sec: Fix probe
rollback" and commit dfd10332596e ("fpga: m10bmc-sec: Fix kconfig
dependencies") to avoid triggering conflicts.

v3:
- Move regmap indirect into BMC PMCI module
	- Get rid of "generalization" of cmd offsets and values, back to v1 #defines
	- Tweak Kconfig & Makefile
	- Rename intel-m10-bmc-pmci to intel-m10-bmc-pmci-main
- Rework sec update read/write paths
	- Sec update driver code effectively uses the SPI side code from v2
	- Rename m10bmc_sec_write() to m10bmc_sec_fw_write()
	- Rename flash_ops to flash_bulk_ops and make them optional
	- Move flash MUX and flash_mutex handling into sec update driver
	- Prevent simultaneous flash bulk write & read using flash_mutex
	- Keep M10BMC_STAGING_BASE in header (now used in the sec update code)
- Rebased on top of leak fix "fpga: m10bmc-sec: Fix probe rollback"

v2:
- Drop type from mfd side, the platform info takes care of differentation
- Explain introducing ->info to struct m10bmc in commit message (belongs logically there)
- Intro PMCI better
- Improve naming
        - Rename M10BMC_PMCI_FLASH_CTRL to M10BMC_PMCI_FLASH_MUX_CTRL
        - Use m10bmc_pmci/M10BMC_PMCI prefix consistently
        - Use M10BMC_SPI prefix for SPI related defines
        - Newly added stuff gets m10bmc_spi prefix
- Removed dev from struct m10bmc_pmci_device
- Rename "n_offset" variable to "offset" in PMCI flash ops
- Always issue idle command in regmap indirect to clear RD/WR/ACK bits
- Handle stride misaligned sizes in flash read/write ops

Ilpo Järvinen (9):
  mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
  mfd: intel-m10-bmc: Rename the local variables
  mfd: intel-m10-bmc: Split into core and spi specific parts
  mfd: intel-m10-bmc: Support multiple CSR register layouts
  fpga: intel-m10-bmc: Rework flash read/write
  mfd: intel-m10-bmc: Downscope SPI defines & prefix with M10BMC_SPI
  mfd: intel-m10-bmc: Add PMCI driver
  fpga: m10bmc-sec: Add support for N6000
  mfd: intel-m10-bmc: Change MODULE_LICENSE() to GPL

 .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
 MAINTAINERS                                   |   2 +-
 drivers/fpga/Kconfig                          |   2 +-
 drivers/fpga/intel-m10-bmc-sec-update.c       | 273 +++++++++++-----
 drivers/hwmon/Kconfig                         |   2 +-
 drivers/mfd/Kconfig                           |  32 +-
 drivers/mfd/Makefile                          |   6 +-
 drivers/mfd/intel-m10-bmc-core.c              | 133 ++++++++
 drivers/mfd/intel-m10-bmc-pmci-indirect.c     | 133 ++++++++
 drivers/mfd/intel-m10-bmc-pmci-main.c         | 292 ++++++++++++++++++
 drivers/mfd/intel-m10-bmc-spi.c               | 205 ++++++++++++
 drivers/mfd/intel-m10-bmc.c                   | 238 --------------
 include/linux/mfd/intel-m10-bmc.h             | 130 +++++---
 13 files changed, 1072 insertions(+), 384 deletions(-)
 create mode 100644 drivers/mfd/intel-m10-bmc-core.c
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci-indirect.c
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci-main.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
 delete mode 100644 drivers/mfd/intel-m10-bmc.c

-- 
2.30.2

