Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48EC33C9EE
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Mar 2021 00:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhCOXgG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 15 Mar 2021 19:36:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:41776 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhCOXfg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 15 Mar 2021 19:35:36 -0400
IronPort-SDR: 53P/labyOT6vV5CmG43njNW/+Qkrog0PgzQjpSyo4rZ/6Hjz4i358NzV5JhBqPIa9nd7F8u2Xw
 452bhWUbzoOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="188529298"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="188529298"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 16:35:35 -0700
IronPort-SDR: l6nJfMD8yYIxFDVJXUqCix6Tbq493BoBYLJ+rkhXW2q4YAh+Kv5bOKTPcb2EsJ6HQIZXnKo+Ea
 74XfK4qSTEAA==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="405346606"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.252.128.229])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 16:35:35 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v11 0/5] Intel MAX10 BMC Secure Update Driver
Date:   Mon, 15 Mar 2021 16:35:27 -0700
Message-Id: <20210315233532.387145-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The Intel MAX10 BMC Secure Update driver instantiates the FPGA
Security Manager class driver and provides the callback functions
required to support secure updates on Intel n3000 PAC devices.
This driver is implemented as a sub-driver of the Intel MAX10 BMC
mfd driver. Future instances of the MAX10 BMC will support other
devices as well (e.g. d5005) and this same MAX10 BMC Secure
Update driver will receive modifications to support that device.

This driver interacts with the HW secure update engine of the
BMC in order to transfer new FPGA and BMC images to FLASH so
that they will be automatically loaded when the FPGA card reboots.
Security is enforced by hardware and firmware. The MAX10 BMC
Secure Update driver interacts with the firmware to initiate
an update, pass in the necessary data, and collect status on
the update.

This driver provides sysfs files for displaying the flash count,
the root entry hashes (REH), and the code-signing-key (CSK)
cancellation vectors.

These patches are dependent on other patches that are under
review. If you want to apply and compile these patches on
linux-next, please apply these patches first:

(1 patch)   https://marc.info/?l=linux-kernel&m=161126987101096&w=2
(7 patches) https://marc.info/?l=linux-fpga&m=161525020621455&w=2

Changelog v10 -> v11:
  - Added Reviewed-by tag to patch #1

Changelog v9 -> v10:
  - Changed the path expressions in the sysfs documentation to
    replace the n3000 reference with something more generic to
    accomodate other devices that use the same driver.

Changelog v8 -> v9:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation

Changelog v7 -> v8:
  - Spit out patch "mfd: intel-m10-bmc: support for MAX10 BMC Secure
    Updates" and submitted it separately:
    https://marc.info/?l=linux-kernel&m=161126987101096&w=2

Changelog v6 -> v7:
  - Rebased patches for 5.11-rc2
  - Updated Date and KernelVersion in ABI documentation

Changelog v5 -> v6:
  - Added WARN_ON() prior to several calls to regmap_bulk_read()
    to assert that the (SIZE / stride) calculations did not result
    in remainders.
  - Changed the (size / stride) calculation in regmap_bulk_write()
    call to ensure that we don't write one less than intended.
  - Changed flash_count_show() parameter list to achieve
    reverse-christmas tree format.
  - Removed unnecessary call to rsu_check_complete() in
    m10bmc_sec_poll_complete() and changed while loop to
    do/while loop.
  - Initialized auth_result and doorbell to HW_ERRINFO_POISON
    in m10bmc_sec_hw_errinfo() and removed unnecessary if statements.

Changelog v4 -> v5:
  - Renamed sysfs node user_flash_count to flash_count and updated
    the sysfs documentation accordingly to more accurately descirbe
    the purpose of the count.

Changelog v3 -> v4:
  - Moved sysfs files for displaying the flash count, the root
    entry hashes (REH), and the code-signing-key (CSK) cancellation
    vectors from the FPGA Security Manager class driver to this
    driver (as they are not generic enough for the class driver).
  - Added a new ABI documentation file with informtaion about the
    new sysfs entries: sysfs-driver-intel-m10-bmc-secure
  - Updated the MAINTAINERS file to add the new ABI documentation
    file: sysfs-driver-intel-m10-bmc-secure
  - Removed unnecessary ret variable from m10bmc_secure_probe()
  - Incorporated new devm_fpga_sec_mgr_register() function into
    m10bmc_secure_probe() and removed the m10bmc_secure_remove()
    function.

Changelog v2 -> v3:
  - Changed "MAX10 BMC Security Engine driver" to "MAX10 BMC Secure
    Update driver"
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
  - Changed "_root_entry_hash" to "_reh", with a comment explaining
    what reh is.
  - Renamed get_csk_vector() to m10bmc_csk_vector()
  - Changed calling functions of functions that return "enum fpga_sec_err"
    to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)

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


Russ Weight (5):
  fpga: m10bmc-sec: create max10 bmc secure update driver
  fpga: m10bmc-sec: expose max10 flash update count
  fpga: m10bmc-sec: expose max10 canceled keys in sysfs
  fpga: m10bmc-sec: add max10 secure update functions
  fpga: m10bmc-sec: add max10 get_hw_errinfo callback func

 .../testing/sysfs-driver-intel-m10-bmc-secure |  61 ++
 MAINTAINERS                                   |   2 +
 drivers/fpga/Kconfig                          |  11 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/intel-m10-bmc-secure.c           | 543 ++++++++++++++++++
 5 files changed, 620 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
 create mode 100644 drivers/fpga/intel-m10-bmc-secure.c

-- 
2.25.1

