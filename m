Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5153F48C
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jun 2022 05:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiFGDcH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 6 Jun 2022 23:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiFGDcF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 6 Jun 2022 23:32:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7675C84A2E;
        Mon,  6 Jun 2022 20:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654572723; x=1686108723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FlfFuJPfDCgEk9BHZDV3l495VN37Iz2NFADpr3d2/vs=;
  b=LLwXSUJN3TKv5TmLNfoe8At3v6WXpy5zcwVCAopubnZwkakYKMw7vl9c
   uOcAu1dGTsPwi/w3ojXwK/ERdGj2hzaaOXdRAiYk8luhvsJ1yZs+AbHIF
   S213C1AH6KSdO8EG9ymT357WfjiVSmvhK+0w/hMa1BPgIEltWYaC7JSRk
   fHutI2wwoQ5yY/tIeZWOjXtrDwz5RXdhenSgX47MVpH6EHfLfJT7mHAaJ
   HYxmZRZjnCIhva9/1WaBROMm0XC8BuCxAFWIa1Fp3SG+3LNgkjyRb0zb2
   hvjMn3VtjIPJZdy4F/+Nkiuk9Zb4fVupSJV/RK93Y+8bRsy8D+rERQbDM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="337908369"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="337908369"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 20:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="826161214"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2022 20:32:00 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 0/4] mfd: add PMCI driver support
Date:   Mon,  6 Jun 2022 23:28:29 -0400
Message-Id: <20220607032833.3482-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PMCI(Platform Management Control Interface) is a software-visible
interface, conneted to card BMC which provided telemetry and mailbox
functionalities for Intel PAC FPGA card.

Currently, intel-m10-bmc driver support Intel MAX10 BMC functions via
SPI interface. To support multiple bus interfaces, splits the common
code from intel-m10-bmc driver into intel-m10-bmc-core.

This patchset adding a driver for the PMCI-base interface of Intel MAX10
BMC controller.

patch 1: use ddata for local variables which directly interacts with
dev_get_drvdata()/dev_set_drvdata().
patch 2: split the common code from intel-m10-bmc driver into
intel-m10-bmc-core.
patch 3: add a driver for PMCI.
patch 4: introduce a new data structure m10bmc_csr for the different
register definition of MAX10 CSRs.

Tianfei Zhang (4):
  mfd: intel-m10-bmc: rename the local variables
  mfd: intel-m10-bmc: split into core and spi
  mfd: intel-m10-bmc: add PMCI driver
  mfd: intel-m10-bmc: support multiple register layouts

 .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
 drivers/mfd/Kconfig                           |  34 +++-
 drivers/mfd/Makefile                          |   6 +-
 .../{intel-m10-bmc.c => intel-m10-bmc-core.c} | 152 ++++++++----------
 drivers/mfd/intel-m10-bmc-pmci.c              |  88 ++++++++++
 drivers/mfd/intel-m10-bmc-spi.c               |  83 ++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  43 ++++-
 7 files changed, 315 insertions(+), 99 deletions(-)
 rename drivers/mfd/{intel-m10-bmc.c => intel-m10-bmc-core.c} (56%)
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
 create mode 100644 drivers/mfd/intel-m10-bmc-spi.c

-- 
2.26.2

