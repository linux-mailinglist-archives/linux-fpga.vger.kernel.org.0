Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75ED2EB5E6
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Jan 2021 00:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAEXJi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Jan 2021 18:09:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:9395 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbhAEXJi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 5 Jan 2021 18:09:38 -0500
IronPort-SDR: OY6sNrnZXFMgKd71MMVaDx60MPZAIw2gfORPT0c9qjuhRvLRo9BPMpkS586SRfDeWLv4L7apdJ
 Ee4Pp838Y6DA==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="174618323"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="174618323"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 15:08:58 -0800
IronPort-SDR: Lpkm58R7Aa/LzPMYRoFJpOPH93jFdSkk5noQruMUN/dMxOaLBD9WnlGB/aFM/G7qdTvqDPy9Et
 2kP0vh0cgnVA==
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="350566799"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.23.122])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 15:08:57 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v7 0/6] Intel MAX10 BMC Secure Update Driver
Date:   Tue,  5 Jan 2021 15:08:49 -0800
Message-Id: <20210105230855.15019-1-russell.h.weight@intel.com>
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

(7 patches) https://marc.info/?l=linux-fpga&m=160988774201859&w=2

If you have an n3000 PAC card and want to test this driver, you
will also need these patches:

(6 patches) https://marc.info/?l=linux-fpga&m=160920855708582&w=2

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

Russ Weight (6):
  mfd: intel-m10-bmc: support for MAX10 BMC Secure Updates
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
 include/linux/mfd/intel-m10-bmc.h             |  85 +++
 6 files changed, 705 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
 create mode 100644 drivers/fpga/intel-m10-bmc-secure.c

-- 
2.25.1

