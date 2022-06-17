Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDD54EF21
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jun 2022 04:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379583AbiFQCHp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Jun 2022 22:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379573AbiFQCHo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 16 Jun 2022 22:07:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A61F61F;
        Thu, 16 Jun 2022 19:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655431663; x=1686967663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ApzyEuuaqntfaLHpghKAi3bl7usIGTVwvAQnSAu3KBs=;
  b=m6Ku36IZzVK9vnOWv+wj7HzAC0SKCDDl9InscPmAlFZ+89TjPuxnHFoE
   SCVOd7xaVUeg0OQGA89rjcwGTUFZpFnBf5bmCuMWq5QuwRsJ6ymseoSMj
   1AEp8Ljo906wlRPhV1GM6Z06fNVsN/MRSLsnN/k2vbQ883frZqc4jThO8
   ZDDDirHGnKSs6YVe4PvqbcDBwxQGKHcWBWv4p6tapy4t2x2H3uxs1mbHe
   +PXr3l6CDt0CbTvCOBPDlVaTFL1ajG1ZGkDWS+4wnmHHEJmp8fmQpo0nP
   Xtq+anJy3hNFzdwHq8asIyWFBzozWJzy5Xkfxf4LEBjb9OihwVjWL0b8m
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365750316"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365750316"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 19:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831831701"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 19:07:39 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2 0/4] add PMCI driver support
Date:   Thu, 16 Jun 2022 22:04:01 -0400
Message-Id: <20220617020405.128352-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PMCI(Platform Management Control Interface) is a software-visible
interface, connected to card BMC which provided telemetry and mailbox
functionalities for Intel PAC FPGA card.

Currently, intel-m10-bmc driver support Intel MAX10 BMC functions via
SPI interface. To support multiple bus interfaces, splits the common
code from intel-m10-bmc driver into intel-m10-bmc-core. On the other
hand, it leverages the regmap APIs to support Intel specific Indirect
Register Interface for register read/write on PMCI driver. 

This patchset adding a driver for the PMCI-base interface of Intel MAX10
BMC controller.

patch 1: use ddata for local variables which directly interacts with
dev_get_drvdata()/dev_set_drvdata().
patch 2: split the common code from intel-m10-bmc driver into
intel-m10-bmc-core.
patch 3: add a driver for PMCI.
patch 4: introduce a new data structure m10bmc_csr for the different
register definition of MAX10 CSRs.

v2:
  - use regmap APIs to support Intel specific Indirect Register Interface
    on PMCI driver.
  - fix compile warning reported by lkp.
  - rebased on 5.19-rc2

Tianfei Zhang (4):
  mfd: intel-m10-bmc: rename the local variables
  mfd: intel-m10-bmc: split into core and spi
  mfd: intel-m10-bmc: add PMCI driver
  mfd: intel-m10-bmc: support multiple register layouts

 .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
 drivers/mfd/Kconfig                           |  34 +++-
 drivers/mfd/Makefile                          |   6 +-
 .../{intel-m10-bmc.c => intel-m10-bmc-core.c} | 148 ++++++--------
 drivers/mfd/intel-m10-bmc-pmci.c              | 190 ++++++++++++++++++
 drivers/mfd/intel-m10-bmc-spi.c               |  83 ++++++++
 include/linux/mfd/intel-m10-bmc.h             |  43 +++-
 7 files changed, 413 insertions(+), 99 deletions(-)
 rename drivers/mfd/{intel-m10-bmc.c => intel-m10-bmc-core.c} (56%)
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c

-- 
2.26.2

