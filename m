Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8375C415472
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Sep 2021 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhIWAMw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Sep 2021 20:12:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:12010 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232944AbhIWAMv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 22 Sep 2021 20:12:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223376115"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="223376115"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:11:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="653478219"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.87.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:11:19 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v16 0/5] FPGA Image Load (previously Security Manager)
Date:   Wed, 22 Sep 2021 17:10:51 -0700
Message-Id: <20210923001056.282790-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA Image Load framework provides an API to upload image
files to an FPGA device. Image files are self-describing. They could
contain FPGA images, BMC images, Root Entry Hashes, or other device
specific files. It is up to the lower-level device driver and the
target device to authenticate and disposition the file data.

The n3000bmc-sec-update driver is the first driver to use the FPGA Image
Load Framework. This driver was previously submitted in the same patch
set, but was split into a separate patch set starting with v2.

Changelog v15 -> v16:
 - Remove previous patch #5: fpga: image-load: create status sysfs node
 - Change device name from "fpga_image%d" to "fpga_image_load%d"
 - Shift from "Driver" terminology to "Framework" in comments and
   documentation
 - Some cleanup of documentation for the FPGA_IMAGE_LOAD_WRITE IOCTL.
 - Rename lops to ops for structure member and local variables
 - Change the write_blk() definition to pass in *blk_size (a pointer to
   a default block size of WRITE_BLOCK_SIZE=0x4000) and max_size (the
   the maximum block size to stay within the limit of the data buffer).
   The write_blk() op may use the default *blk_size or modify it to a
   more optimal number for the given device, subject to the max_size limit.
 - All enum values for progress and errors are changed to macros, because
   they are included in the uapi header. This is done to maintain consistency
   amongst the DFL related IOCTL header files. All references to the enum
   types are changed to u32.
 - Bail out early in fpga_image_do_load() if imgld->driver_unload is true.
 - Add a call to cond_resched() in the write_blk() loop to ensure that
   we yield to higher priority tasks during long data transfers.
 - Switch to the system_unbound_wq to enable calls to cond_resched().
 - Switch from test_and_set_bit() to atomic_cmpxchg() to manage
   imgld->opened.
 - Change fpga_image_load_release() cancel an ongoing image upload when
   possible and to block when cancellation is not possible.
 - Remove the completion object, imgld->update_done, in favor of calling
   flush_work(&imgld->work);

Changelog v14 -> v15:
 - Changed the driver name from FPGA Security Manager to FPGA Image Load
 - Changed file, symbol, and config names to reflect the new driver name
 - Rewrote documentation.
 - Removed all sysfs files except for "status", which has moved to the
   parent directory.
 - Implemented FPGA_IMAGE_LOAD_WRITE, FPGA_IMAGE_LOAD_STATUS, and
   FPGA_IMAGE_LOAD_CANCEL IOCTLs to initiate, monitor, and cancel image
   uploads.
 - Fixed some error return values in fpga_image_load_register()
 - Added an eventfd which is signalled upon completion of an image load.
 - Minor changes to locking to accommodate the FPGA_IMAGE_LOAD_STATUS IOCTL
 - Removed signed-off/reviewed-by tags. Please resend as appropriate.

Changelog v13 -> v14:
 - Dropped the patch: fpga: sec-mgr: expose hardware error info
 - Updated copyrights to 2021
 - Updated ABI documentation date and kernel version
 - Removed the name sysfs entry from the class driver
 - Use xa_alloc() instead of ida_simple_get()
 - Rename dev to parent for parent devices
 - Remove fpga_sec_mgr_create(), devm_fpga_sec_mgr_create(), and
   fpga_sec_mgr_free() functions and update the fpga_sec_mgr_register()
   function to both create and register a new security manager.
 - Populate the fpga_sec_mgr_dev_release() function.
 - Added MAINTAINERS reference for
   Documentation/ABI/testing/sysfs-class-fpga-sec-mgr

Changelog v12 -> v13:
  - Change "if (count == 0 || " to "if (!count || "
  - Improve error message: "Attempt to register without all required ops\n"
  - Change set_error() to fpga_sec_set_error()
  - Change set_hw_errinfo() to fpga_sec_set_hw_errinfo()

Changelog v11 -> v12:
  - Updated Date and KernelVersion fields in ABI documentation
  - Removed size parameter from write_blk() op - it is now up to
    the lower-level driver to determine the appropriate size and
    to update smgr->remaining_size accordingly.
  - Changed syntax of sec_mgr_prog_str[] and sec_mgr_err_str array definitions
    from:
	"idle",			/* FPGA_SEC_PROG_IDLE */
    to:
	[FPGA_SEC_PROG_IDLE]	    = "idle",

Changelog v10 -> v11:
  - Fixed a spelling error in a comment
  - Initialize smgr->err_code and smgr->progress explicitly in
    fpga_sec_mgr_create() instead of accepting the default 0 value.

Changelog v9 -> v10:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation

Changelog v8 -> v9:
  - Rebased patches for 5.11-rc2
  - Updated Date and KernelVersion in ABI documentation

Changelog v7 -> v8:
  - Fixed grammatical error in Documentation/fpga/fpga-sec-mgr.rst

Changelog v6 -> v7:
  - Changed dates in documentation file to December 2020
  - Changed filename_store() to use kmemdup_nul() instead of
    kstrndup() and changed the count to not assume a line-return.

Changelog v5 -> v6:
  - Removed sysfs support and documentation for the display of the
    flash count, root entry hashes, and code-signing-key cancellation
    vectors from the class driver. This information can vary by device
    and will instead be displayed by the device-specific parent driver.

Changelog v4 -> v5:
  - Added the devm_fpga_sec_mgr_unregister() function, following recent
    changes to the fpga_manager() implementation.
  - Changed most of the *_show() functions to use sysfs_emit()
    instead of sprintf(
  - When checking the return values for functions of type enum
    fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0

Changelog v3 -> v4:
  - This driver is generic enough that it could be used for non Intel
    FPGA devices. Changed from "Intel FPGA Security Manager" to FPGA
    Security Manager" and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
    Note that this also affects some filenames.

Changelog v2 -> v3:
  - Use dev_err() to report invalid progress in sec_progress()
  - Use dev_err() to report invalid error code in sec_error()
  - Modified sysfs handler check in check_sysfs_handler() to make
    it more readable.
  - Removed unnecessary "goto done"
  - Added a comment to explain imgr->driver_unload in
    ifpga_sec_mgr_unregister()

Changelog v1 -> v2:
  - Separated out the MAX10 BMC Security Engine to be submitted in
    a separate patch-set.
  - Bumped documentation dates and versions
  - Split ifpga_sec_mgr_register() into create() and register() functions
  - Added devm_ifpga_sec_mgr_create()
  - Added Documentation/fpga/ifpga-sec-mgr.rst 
  - Changed progress state "read_file" to "reading"
  - Added sec_error() function (similar to sec_progress())
  - Removed references to bmc_flash_count & smbus_flash_count (not supported)
  - Removed typedefs for imgr ops
  - Removed explicit value assignments in enums
  - Other minor code cleanup per review comments 

Russ Weight (5):
  fpga: image-load: fpga image load class driver
  fpga: image-load: enable image uploads
  fpga: image-load: signal eventfd when complete
  fpga: image-load: add status ioctl
  fpga: image-load: enable cancel of image upload

 Documentation/fpga/fpga-image-load.rst |  48 +++
 Documentation/fpga/index.rst           |   1 +
 MAINTAINERS                            |   9 +
 drivers/fpga/Kconfig                   |  10 +
 drivers/fpga/Makefile                  |   3 +
 drivers/fpga/fpga-image-load.c         | 456 +++++++++++++++++++++++++
 include/linux/fpga/fpga-image-load.h   |  68 ++++
 include/uapi/linux/fpga-image-load.h   |  75 ++++
 8 files changed, 670 insertions(+)
 create mode 100644 Documentation/fpga/fpga-image-load.rst
 create mode 100644 drivers/fpga/fpga-image-load.c
 create mode 100644 include/linux/fpga/fpga-image-load.h
 create mode 100644 include/uapi/linux/fpga-image-load.h

-- 
2.25.1

