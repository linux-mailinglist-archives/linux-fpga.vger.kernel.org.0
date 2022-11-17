Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89D462DA42
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Nov 2022 13:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiKQMHE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Nov 2022 07:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiKQMHB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Nov 2022 07:07:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC15697E5;
        Thu, 17 Nov 2022 04:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668686820; x=1700222820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sk0KWL6T5MnhwvjeD2F65sNgllLmcjcwMqcEmpreQts=;
  b=hRR2SBCnonVDoWlGJKXjaBM5Ixv+rf1T+Bl//YJ+AlGRfaY88EtTzygR
   iTBflX8IT2RSkO3TUBozl0Z6XBO2QiT09Cstl2zao6PRBDTrJ6wbXuCcy
   7no/0EyNEBOqYjtohTtbcNNwQpvcv+kbTKWLpViAWcc8Qc7gXWOOAaO7N
   lPVfJOqM/UxVyv7TmhRGyLV/txJvtEj3vMjVmh2red1+vSnXl4dP5MvSH
   vzVWNaN5Ki0hyfaWkzR2sITuQkibxGm/zCXZdIvjRjIZvLcmLOEJLcPEY
   3lMAIMP8jCPihr8fKxTbLpCCA3ZizOltPhdykCirbBuIvSpNSdTQHT139
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="374964784"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="374964784"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:06:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968855530"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968855530"
Received: from kvehmane-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.61.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:06:35 -0800
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
Subject: [PATCH v2 00/11] intel-m10-bmc: Split BMC to core and SPI parts & add PMCI+N6000 support
Date:   Thu, 17 Nov 2022 14:05:04 +0200
Message-Id: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
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
patches prior to the actual split. This series also introduced regmap for
indirect register access generic to Intel FPGA IPs.

The current downside of the split is that there's not that much code
remaining in the core part when all the type specific definitions are
moved to the file with the relevant interface.

I'm not entirely sure if I did properly address Yilun's comment on
placement of the flash_ops related code. To me the original way which
keeps them in mfd/intel-m10-bmc-{spi,pmci}.c still seems to the best
way. If that is still not acceptable, I propose that I'll move just the
flash ops functions into intel-m10-bmc-sec-update-{spi,pmci}.c and
create sec related platform info struct to select the correct flash
ops. This would effectively be the "double split" approach I suggested
earlier (both mfd and sec have their own per interface splits, to me
the double split looks overkill but it would meet Yilun's goal of
keeping sec related code within the sec driver).

The patch set is based on top of commit dfd10332596e ("fpga:
m10bmc-sec: Fix kconfig dependencies") to avoid triggering a Kconfig
conflict.

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
  mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
  mfd: intel-m10-bmc: Rename the local variables
  mfd: intel-m10-bmc: Split into core and spi specific parts
  mfd: intel-m10-bmc: Support multiple CSR register layouts
  fpga: intel-m10-bmc: Add flash ops for sec update
  mfd: intel-m10-bmc: Downscope SPI defines & prefix with M10BMC_SPI
  regmap: indirect: Add indirect regmap support
  intel-m10-bmc: Add regmap_indirect_cfg for Intel FPGA IPs
  mfd: intel-m10-bmc: Add PMCI driver
  fpga: m10bmc-sec: Add support for N6000
  mfd: intel-m10-bmc: Change MODULE_LICENSE() to GPL

 .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
 MAINTAINERS                                   |   2 +-
 drivers/base/regmap/Kconfig                   |   3 +
 drivers/base/regmap/Makefile                  |   1 +
 drivers/base/regmap/regmap-indirect.c         | 128 +++++++
 drivers/fpga/Kconfig                          |   2 +-
 drivers/fpga/intel-m10-bmc-sec-update.c       | 149 ++++----
 drivers/hwmon/Kconfig                         |   2 +-
 drivers/mfd/Kconfig                           |  34 +-
 drivers/mfd/Makefile                          |   6 +-
 drivers/mfd/intel-m10-bmc-core.c              | 133 +++++++
 drivers/mfd/intel-m10-bmc-pmci.c              | 361 ++++++++++++++++++
 drivers/mfd/intel-m10-bmc-spi.c               | 270 +++++++++++++
 drivers/mfd/intel-m10-bmc.c                   | 238 ------------
 include/linux/mfd/intel-m10-bmc.h             | 122 +++---
 include/linux/regmap.h                        |  55 +++
 16 files changed, 1131 insertions(+), 383 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-indirect.c
 create mode 100644 drivers/mfd/intel-m10-bmc-core.c
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
 delete mode 100644 drivers/mfd/intel-m10-bmc.c

-- 
2.30.2

