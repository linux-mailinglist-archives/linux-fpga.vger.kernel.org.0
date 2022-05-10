Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7C4522517
	for <lists+linux-fpga@lfdr.de>; Tue, 10 May 2022 21:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiEJT4l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 May 2022 15:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiEJT4j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 May 2022 15:56:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C793BBC1;
        Tue, 10 May 2022 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652212598; x=1683748598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DX1UzVTl1Cj0r4Jb5sucgQWMsrBgIDfgw9YoQ5QoEik=;
  b=Tbm+6laACkdXQXzEIGEB404eONnytSeswWfOE7gkJEltq0/Z9taMisOc
   vwIjZwW88uiCTKn8h2J1jTj4I90Zrd1/UjzmBrmMKh0ruQ0tICtM9kcCz
   ztEP/jF00AxRtQK3zbGGctUQyk1eKBPIZiCnCOdgHvpRe/fnGyUeWbX1G
   NCd1hC4hcu2nmd6BjgshalcM5Y5ToSNUIaDo/krLeCVuHko7ETj/KNEHj
   Rd0DdqUauNARuFp881moCjAGifWlVx6dPDlAfU/ylS1BYoMOgsNhvJMhM
   aWv48bWCG0M4iczZiNSfyetqqDUGvGgs0ZapCbjuTwX+R0r0s1sgrdPj3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269624472"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="269624472"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 12:56:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="602624694"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.161.124])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 12:56:37 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v19 0/5] FPGA MAX10 BMC Secure Update Driver
Date:   Tue, 10 May 2022 12:56:30 -0700
Message-Id: <20220510195635.140722-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The MAX10 BMC Secure Update driver instantiates the new Firmware
Upload functionality of the Firmware Loader and provides the callback
functions required to support secure updates on Intel n3000 PAC
devices.  This driver is implemented as a sub-driver of the Intel MAX10
BMC mfd driver.

This driver interacts with the HW secure update engine of the FPGA
card BMC in order to transfer new FPGA and BMC images to FLASH on
the FPGA card.  Security is enforced by hardware and firmware.  The
FPGA Card BMC Secure Update driver interacts with the firmware to
initiate an update, pass in the necessary data, and collect status
on the update.

This driver provides sysfs files for displaying the flash count, the
root entry hashes (REH), and the code-signing-key (CSK) cancellation
vectors.

Changelog v18 -> v19:
  - Change "card bmc" naming back to "m10 bmc" naming to be consistent
    with the parent driver.

Changelog v17 -> v18:
  - Changed the ABI documentation for the Root Entry Hashes to specify
    string as the format for the output.
  - Updated comments, strings and config options to more consistently
    refer to the driver as the Intel FPGA Card BMC Secure Update driver.
  - Removed an instance of dev_dbg().
  - Deferred the call to firmware_upload_register() to a later patch
    where the required ops are provided.
  - Switched from MODULE_ALIAS() to MODULE_DEVICE_TABLE() in anticipation
    of additional cards to be supported by the same driver.

Changelog v16 -> v17:
  - Change m10bmc to cardbmc to reflect the fact that the future devices
    will not necessarily use the MAX10. This affects filenames, configs,
    symbol names, and the driver name.
  - Update the Date and KernelVersion for the ABI documentation to Jul 2022
    and 5.19 respectively.
  - Updated the copyright end-date to 2022 for the secure update driver.
  - Removed references to the FPGA Image Load class driver and replaced
    them with the new firmware-upload service from the firmware loader.
  - Use xarray_alloc to generate a unique number/name firmware-upload.
  - Chang the license from GPL to GPLv2 per commit bf7fbeeae6db ("module:
    Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
  - fw_upload_ops functions will return "enum fw_upload_err" data types
    instead of integer values.

Changelog v15 -> v16:
  - Use 0 instead of FPGA_IMAGE_ERR_NONE to indicate success.
  - The size alignment check was moved from the FPGA Image Load framework
    to the prepare() op.
  - Added cancel_request boolean flag to struct m10bmc_sec.
  - Moved the RSU cancellation logic from m10bmc_sec_cancel() to a new
    rsu_cancel() function.
  - The m10bmc_sec_cancel() function ONLY sets the cancel_request flag.
    The cancel_request flag is checked at the beginning of the
    m10bmc_sec_write() and m10bmc_sec_poll_complete() functions.
  - Adapt to changed prototypes for the prepare() and write() ops. The
    m10bmc_sec_write_blk() function has been renamed to
    m10bmc_sec_write().
  - Created a cleanup op, m10bmc_sec_cleanup(), to attempt to cancel an
    ongoing op during when exiting the update process.

Changelog v14 -> v15:
  - Updated the Dates and KernelVersions in the ABI documentation
  - Change driver name from "n3000bmc-secure" to "n3000bmc-sec-update".
  - Change CONFIG_FPGA_M10_BMC_SECURE to CONFIG_FPGA_M10_BMC_SEC_UPDATE.
  - Change instances of *bmc-secure to *bmc-sec-update in file name
    and symbol names.
  - Change instances of *m10bmc_secure* to *m10bmc-sec_update* in symbol
    names.
  - Adapted to changes in the FPGA Image Load framework:
    (1) All enum types (progress and errors) are now type u32
    (2) m10bmc_sec_write_blk() adds *blk_size and max_size parameters
        and uses *blk_size as provided by the caller.
    (3) m10bmc_sec_poll_complete() no long checks the driver_unload
        flag.

Changelog v13 -> v14:
  - Changed symbol and text references to reflect the renaming of the
    Security Manager Class driver to FPGA Image Load.

Changelog v12 -> v13:
  - Updated copyright to 2021
  - Updated Date and KernelVersion fields in ABI documentation
  - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
    functions instead of devm_fpga_sec_mgr_create() and
    devm_fpga_sec_mgr_register().

Changelog v11 -> v12:
  - Updated Date and KernelVersion fields in ABI documentation
  - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
    no longer has a size parameter, and the block size is determined
    in this (the lower-level) driver.

Changelog v10 -> v11:
  - Added Reviewed-by tag to patch #1

Changelog v9 -> v10:
  - Changed the path expressions in the sysfs documentation to
    replace the n3000 reference with something more generic to
    accommodate other devices that use the same driver.

Changelog v8 -> v9:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation

Changelog v7 -> v8:
  - Split out patch "mfd: intel-m10-bmc: support for MAX10 BMC Secure
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
  mfd: intel-m10-bmc: Rename n3000bmc-secure driver
  fpga: m10bmc-sec: create max10 bmc secure update
  fpga: m10bmc-sec: expose max10 flash update count
  fpga: m10bmc-sec: expose max10 canceled keys in sysfs
  fpga: m10bmc-sec: add max10 secure update functions

 .../sysfs-driver-intel-m10-bmc-sec-update     |  61 ++
 MAINTAINERS                                   |   7 +
 drivers/fpga/Kconfig                          |  12 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/intel-m10-bmc-sec-update.c       | 594 ++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c                   |   2 +-
 6 files changed, 678 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
 create mode 100644 drivers/fpga/intel-m10-bmc-sec-update.c

-- 
2.25.1

