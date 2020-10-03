Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1512282000
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Oct 2020 03:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJCBYU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Oct 2020 21:24:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:5543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJCBYU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Oct 2020 21:24:20 -0400
IronPort-SDR: SrdP3G9JneM5WsksLQ/v31DVvlTq1seRCUD/T2Ms1KIYqUHJuaGK7x8ThG/DG0ZDAOaRkmBtpz
 2ulnHQaAWZsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="162363104"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="162363104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:18 -0700
IronPort-SDR: DP5/+FkK2lecpZs26tCYQLPeWOYP3dZvK3rSUM7ln5/LgdX1LWOHc7p3sPftj07E5rT5QUZN4R
 epOTsafe2kyA==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="516097849"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.5.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:17 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 0/6] Intel MAX10 BMC Security Engine Driver
Date:   Fri,  2 Oct 2020 18:24:06 -0700
Message-Id: <20201003012412.16831-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

These patches were previously submitted as part of a larger V1
patch set under the title "FPGA Security Manager Class Driver".

The Intel MAX10 BMC Security Engine driver instantiates the Intel
Security Manager class driver and provides the callback functions
required to support secure updates on Intel n3000 PAC devices.
This driver is implemented as a sub-driver of the Intel MAX10 BMC
mfd driver. Future instances of the MAX10 BMC will support other
devices as well (e.g. d5005) and this same MAX10 BMC Security
Engine driver will receive modifications to support that device.

This driver interacts with the HW secure update engine of the
BMC in order to transfer new FPGA and BMC images to FLASH so
that they will be automatically loaded when the FPGA card reboots.
Security is enforced by hardware and firmware. The MAX10 BMC
Security Engine driver interacts with the firmware to initiate
an update, pass in the necessary data, and collect status on
the update.

This driver passes operation call-back functions to the Intel
FPGA Security Manager Class Driver to support the following
functions:

(1) Instantiate and monitor a secure update
(2) Display security information including: Root Entry Hashes (REH),
    Cancelled Code Signing Keys (CSK), and flash update counts for
    both BMC and FPGA images.

These patches are dependent on other patches that are under
review. If you want to apply these patches on linux-next,
please apply these patches first, in the following order:

(1 patch)   https://marc.info/?l=linux-fpga&m=159782339732362&w=2
(4 patches) https://marc.info/?l=linux-fpga&m=160014074806950&w=2
(7 patches) https://marc.info/?l=linux-fpga&m=160167824311379&w=2

Changelog v1 -> v2:
  - These patches were previously submitted as part of a larger V1
    patch set under the title "Intel FPGA Security Manager Class Driver".
  - Grouped all changes to include/linux/mfd/intel-m10-bmc.h into a
    single patch: "mfd: intel-m10-bmc: support for MAX10 BMC Security
    Engine".
  - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
  - Adapted to changes in the Intel FPGA Security Manager by splitting
    the single call to ifpga_sec_mgr_register() into two function
    calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
  - Replaced small function-creation macros for explicit function
    declarations.
  - Bug fix for the get_csk_vector() function to properly apply the
    stride variable in calls to m10bmc_raw_bulk_read().
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
  - Implemented HW_ERRINFO_POISON for m10bmc_sec_hw_errinfo() to
    ensure that corresponding bits are set to 1 if we are unable
    to read the doorbell or auth_result registers.
  - Added comments and additional code cleanup per V1 review.

Russ Weight (6):
  mfd: intel-m10-bmc: support for MAX10 BMC Security Engine
  fpga: m10bmc-sec: create max10 bmc security engine
  fpga: m10bmc-sec: expose max10 flash update counts
  fpga: m10bmc-sec: expose max10 canceled keys in sysfs
  fpga: m10bmc-sec: add max10 secure update functions
  fpga: m10bmc-sec: add max10 get_hw_errinfo callback func

 MAINTAINERS                         |   1 +
 drivers/fpga/Kconfig                |  11 +
 drivers/fpga/Makefile               |   3 +
 drivers/fpga/intel-m10-bmc-secure.c | 591 ++++++++++++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h   | 134 +++++++
 5 files changed, 740 insertions(+)
 create mode 100644 drivers/fpga/intel-m10-bmc-secure.c

-- 
2.17.1

