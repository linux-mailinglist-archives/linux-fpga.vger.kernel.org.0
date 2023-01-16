Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4F66BB51
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jan 2023 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjAPKKG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Jan 2023 05:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAPKJm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 16 Jan 2023 05:09:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE94135BF;
        Mon, 16 Jan 2023 02:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673863736; x=1705399736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rF8woOPYasbGtMUC+IWEiTRhWC8n2o3Nz4KoM3TKkrw=;
  b=C8jplMoQ2ZbvSoWMuVkgZ1KlPh5dOjH48RjDduCU0OaSgzTCZcJyizZJ
   3+YdGoSPVSvtNpa5W/D0A2vucmyw2T1yCDP+yCYU12x/ES89WgMq6OR7k
   2106EXcabtbEtyPqKDHOwptTjyegvKLaIibq1UL1NG9B8osnRhX48hqf9
   VBB7lvlLLfKkiuw7J7hB1DLsuqoCt1kIioGRbepEg6gXynHZU7M1GfHGp
   Bj6H5JkRe6yQsd/WTjBTOwkdm4KxIX0YsSqWq/LeVNUxuuRnM213Iilet
   xhiaVVrK2U3qPLIhwt0+W6sBJc7ueeH1Mj7lDjM44g6CB4uyrZgWLKmCS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="326489240"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="326489240"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:08:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="832785608"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="832785608"
Received: from xsanroma-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:08:52 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 00/11] intel-m10-bmc: Split BMC to core and SPI parts & add PMCI+N6000 support
Date:   Mon, 16 Jan 2023 12:08:34 +0200
Message-Id: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi all,

Here are the patches for MAX 10 BMC core/SPI interface split and
addition of the PMCI interface. There are a few supporting rearrangement
patches prior to the actual split.

I had to move flash MUX control back from sec driver to PMCI because
there will be other drivers that also read flash (e.g., log driver). It
also lead to realization that the flash_mutex wasn't enough to handle
reads during an update (erase + write) but the update has to be tracked
independent of just the write itself. BMC will manage flash MUX at that
point and reads got -ETIMEDOUT in v5 when update was already in
progress but not yet doing write. In v6, the reads return -EBUSY during
an update. These changes impact the last patch of the series.

As both Yilun and Lee seemed to find it better to not put the register
defines into the .c files, I've left them into header file starting from
v6 and just renamed them such that it's more obvious the define relates
to one board type.

The patch set is based on top of 60ce26d10e58 ("fpga: m10bmc-sec: Fix
probe rollback").

v6:
- Move flash MUX control back to PMCI driver (other drivers besides
  secure update such as log driver depend on it while reading the flash)
- Track updates independent of write itself using bool flash_busy
- Return -EBUSY for flash reads during update (erase+write)
- Add type specific ops & ->rsu_status() into the sec update driver
  to handle RSU status in different registers inside the driver.
- Corrected handling of unaligned tail in bulk read
- Rename raw doorbell parameters to doorbell_reg
- Drop unnecessary PMCI telemetry reg defines
- Keep defines include/linux/mfd/intel-m10-bmc.h
- More register defines with N3000/N6000 prefix
- Define flash timeouts only once, remove the other
- Add correct includes for linux/mfd/intel-m10-bmc.h
- Simplified rename variable patch tags

v5:
- Explain flash MUX rollback path in commit message
- Fix RSU status field register location

v4:
- Use board type for naming defines & structs
- Set .reg_read/write and call devm_regmap_init() directly
- Rename indirect_bus_*() funcs to indirect_*()
- Move indirect code into intel-m10-bmc-pmci so funcs can be static
- Drop module licence  GPL v2 - GPL change

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

Ilpo Järvinen (11):
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
  fpga: m10bmc-sec: Add support for N6000

 .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
 MAINTAINERS                                   |   2 +-
 drivers/fpga/Kconfig                          |   2 +-
 drivers/fpga/intel-m10-bmc-sec-update.c       | 415 ++++++++++------
 drivers/hwmon/Kconfig                         |   2 +-
 drivers/mfd/Kconfig                           |  32 +-
 drivers/mfd/Makefile                          |   5 +-
 drivers/mfd/intel-m10-bmc-core.c              | 122 +++++
 drivers/mfd/intel-m10-bmc-pmci.c              | 455 ++++++++++++++++++
 drivers/mfd/intel-m10-bmc-spi.c               | 168 +++++++
 drivers/mfd/intel-m10-bmc.c                   | 238 ---------
 include/linux/mfd/intel-m10-bmc.h             | 205 ++++++--
 12 files changed, 1221 insertions(+), 433 deletions(-)
 create mode 100644 drivers/mfd/intel-m10-bmc-core.c
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
 delete mode 100644 drivers/mfd/intel-m10-bmc.c

-- 
2.30.2

