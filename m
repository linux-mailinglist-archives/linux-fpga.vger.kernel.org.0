Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D25596A5
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jun 2022 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiFXJ0N (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Jun 2022 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiFXJ0M (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Jun 2022 05:26:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECBD6F497;
        Fri, 24 Jun 2022 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656062771; x=1687598771;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E/GySULo37Ar3Xncr9YN3XGQnakEB5I73ayBapdgEJc=;
  b=VS95e71fSoz8V/VRJTm4tLx2YXDorXkJTnnDmzWStUqD5jfo5t3FylaT
   h+235GhKWPPG5v7dLH71wUQS2jrjnf79i60f+8SVS0GiQccsuQLsWxrX6
   q59m3/6PbGpEpMS6G6XdUQeVd2XF90PaD89RlPyeI8AECwOYbbEhJrKlV
   Uai5+WPhdIWkRDHLGLKXrSX9F+AdIL3o2DIIksdhB0CpUXiPqTzsO6M0i
   j1QBg7ndW7pOQLwY/r+dPgf78vakOSiKaP1NBhsXtq1yJ7mddzn7Qz4YP
   BSC/wJdxS7+ZQ+F5e5js7KkU7KQ4iGiU5PH53cbvcU5ewZK5n9hT/Kb0Q
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261389178"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="261389178"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 02:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="691454931"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2022 02:26:08 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3 0/3] add PMCI driver support
Date:   Fri, 24 Jun 2022 05:22:26 -0400
Message-Id: <20220624092229.45854-1-tianfei.zhang@intel.com>
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
interface, connected to card BMC which provided basic register
access functionality from host to Card BMC. This pmci-bmc driver
leverages the regmap APIs to support Intel specific Indirect
Register Interface for register read/write on PMCI driver. 

This patchset adding a driver for the PMCI-base interface of Intel
MAX10 BMC controller.

patch 1: use ddata for local variables which directly interacts with
dev_get_drvdata()/dev_set_drvdata().
patch 2: add a driver for PMCI.
patch 3: introduce a new member in intel_m10bmc for the different
base register address of MAX10 CSRs.

v3:
  - create a new intel-m10-bmc-pmci driver, and discard the bmc-core
    file which adds in v2.
  - create a new file for sysfs-driver-intel-m10-bmc-pmci ABI.
  - remove the regmap_access_table
  - introduce a new member "base" in intel_m10bmc for different base
    register address.
  - rebased on 5.19-rc3
v2:
  - use regmap APIs to support Intel specific Indirect Register Interface
    on PMCI driver.
  - fix compile warning reported by lkp.
  - rebased on 5.19-rc2

Tianfei Zhang (3):
  mfd: intel-m10-bmc: rename the local variables
  mfd: intel-m10-bmc: add PMCI driver
  mfd: intel-m10-bmc: support different BMC base register address

 .../testing/sysfs-driver-intel-m10-bmc-pmci   |  36 +++
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel-m10-bmc-pmci.c              | 278 ++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c                   |  11 +-
 include/linux/mfd/intel-m10-bmc.h             |  12 +-
 6 files changed, 342 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c

-- 
2.26.2

