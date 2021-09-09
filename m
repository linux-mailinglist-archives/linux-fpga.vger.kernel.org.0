Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA46404376
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Sep 2021 04:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhIICUQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Sep 2021 22:20:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:63717 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhIICUO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 8 Sep 2021 22:20:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="218793844"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="218793844"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 19:18:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="503916517"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.194.237])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 19:18:53 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v15 0/6] FPGA Image Load (previously Security Manager)
Date:   Wed,  8 Sep 2021 19:18:40 -0700
Message-Id: <20210909021846.681121-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA Image Load class driver provides an API to upload image
files to an FPGA device. Image files are self-describing. They could
contain FPGA images, BMC images, Root Entry Hashes, or other device
specific files. It is up to the lower-level device driver and the
target device to authenticate and disposition the file data.

The n3000bmc-secure driver is the first driver to use the FPGA
Security Manager. This driver was previously submitted in the same
patch set, but was split into a separate patch set starting with v2.

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

Russ Weight (6):
  fpga: image-load: fpga image load class driver
  fpga: image-load: enable image loads
  fpga: image-load: signal eventfd when complete
  fpga: image-load: add status ioctl
  fpga: image-load: create status sysfs node
  fpga: image-load: enable cancel of image upload

 .../ABI/testing/sysfs-class-fpga-image-load   |   7 +
 Documentation/fpga/fpga-image-load.rst        |  45 ++
 Documentation/fpga/index.rst                  |   1 +
 MAINTAINERS                                   |  10 +
 drivers/fpga/Kconfig                          |  10 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/fpga-image-load.c                | 466 ++++++++++++++++++
 include/linux/fpga/fpga-image-load.h          |  67 +++
 include/uapi/linux/fpga-image-load.h          |  78 +++
 9 files changed, 687 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-image-load
 create mode 100644 Documentation/fpga/fpga-image-load.rst
 create mode 100644 drivers/fpga/fpga-image-load.c
 create mode 100644 include/linux/fpga/fpga-image-load.h
 create mode 100644 include/uapi/linux/fpga-image-load.h

-- 
2.25.1

