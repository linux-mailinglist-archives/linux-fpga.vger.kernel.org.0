Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB9621717
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 15:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiKHOnT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 09:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiKHOnS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 09:43:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17229368;
        Tue,  8 Nov 2022 06:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667918597; x=1699454597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ltk9PcCFgML5mXI5MbJjN0UtH9fCC+uUjFk5ymEpff4=;
  b=Cz7Ei/AjT+BRlqA0dwr6OVE8wZMsAk/0md3Bk5SkEFrjr3Uy2lyil3On
   AZTMOufQzp8Osr1ka1es0bds1Kgv1SkLkUgazs6QSXbw+yPdFXqEesFVz
   CZnTE4JcsriDnY0tbjzMudM1ThsfJ1haaxdKk7liyF3KA3zRtT0SFIK1D
   Vo/E6lnfk6He3J8tjZI5JtJaN1F0jU3zhNdSPAJWrKv4fc4k3ruuv0Gmo
   Nz5u61l2ENwoVfRvOL1/kOvvmmk940DAH3loqGDVdayr+i7QU5bFDVBFm
   6ywpIcjqRZ5rnm7qenbp7EOnwGw61wKm9uubhkJEiSUyfepMDLJgQFku9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="374979511"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="374979511"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:43:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="638809638"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="638809638"
Received: from ppkrause-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:43:13 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/12] intel-m10-bmc: Split BMC to core and SPI parts & add PMCI+N6000 support
Date:   Tue,  8 Nov 2022 16:42:53 +0200
Message-Id: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
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

Ilpo Järvinen (12):
  mfd: intel-m10-bmc: Move m10bmc_type to header
  mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
  mfd: intel-m10-bmc: Rename the local variables
  mfd: intel-m10-bmc: Split into core and spi specific parts
  mfd: intel-m10-bmc: Support multiple CSR register layouts
  fpga: intel-m10-bmc: Add flash ops for sec update
  mfd: intel-m10-bmc: Downscope SPI related defines
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
 drivers/mfd/intel-m10-bmc-pmci.c              | 339 ++++++++++++++++++
 drivers/mfd/intel-m10-bmc-spi.c               | 262 ++++++++++++++
 drivers/mfd/intel-m10-bmc.c                   | 238 ------------
 include/linux/mfd/intel-m10-bmc.h             | 131 ++++---
 include/linux/regmap.h                        |  55 +++
 16 files changed, 1110 insertions(+), 383 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-indirect.c
 create mode 100644 drivers/mfd/intel-m10-bmc-core.c
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
 delete mode 100644 drivers/mfd/intel-m10-bmc.c

-- 
2.30.2

