Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F712EB5B8
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Jan 2021 00:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbhAEXAM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Jan 2021 18:00:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:53702 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731729AbhAEXAL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 5 Jan 2021 18:00:11 -0500
IronPort-SDR: HsXeDvmemOf6YWe9zmMZoNuV8s6IV7TMVdoPOm/yEQ2TtdOTYh1Q3RGkgCKd0N2I9ZZTeHLUQO
 Z4IbU4AC5ZVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="164893368"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="164893368"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 14:59:30 -0800
IronPort-SDR: 2SlrSV5yb01ciS4JCb2f6OqcT+FgEZ/tINj2zSdSKcqF04x7neWQ8ob7KS6UJfiuOZuaNQeb0Z
 SVkpIEUmjgfQ==
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="346432417"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.23.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 14:59:30 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v9 0/7] FPGA Security Manager Class Driver
Date:   Tue,  5 Jan 2021 14:59:17 -0800
Message-Id: <20210105225924.14573-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA Security Manager class driver provides a common
API for user-space tools to manage updates for secure FPGA
devices. Device drivers that instantiate the FPGA Security
Manager class driver will interact with a HW secure update
engine in order to transfer new FPGA and BMC images to FLASH so
that they will be automatically loaded when the FPGA card reboots.

A significant difference between the FPGA Manager and the FPGA 
Security Manager is that the FPGA Manager does a live update (Partial
Reconfiguration) to a device whereas the FPGA Security Manager
updates the FLASH images for the Static Region and the BMC so that
they will be loaded the next time the FPGA card boots. Security is
enforced by hardware and firmware. The security manager interacts
with the firmware to initiate an update, pass in the necessary data,
and collect status on the update.

The n3000bmc-secure driver is the first driver to use the FPGA
Security Manager. This driver was previously submitted in the same
patch set, but has been split out into a separate patch set starting
with V2. Future devices will also make use of this common API for
secure updates.

In addition to managing secure updates of the FPGA and BMC images,
the FPGA Security Manager update process may also be used to
program root entry hashes and cancellation keys for the FPGA static
region, the FPGA partial reconfiguration region, and the BMC.
The image files are self-describing, and contain a header describing
the image type.

Secure updates make use of the request_firmware framework, which
requires that image files are accessible under /lib/firmware. A request
for a secure update returns immediately, while the update itself
proceeds in the context of a kernel worker thread. Sysfs files provide
a means for monitoring the progress of a secure update and for
retrieving error information in the event of a failure.

The API includes a "name" sysfs file to export the name of the parent
driver. It also includes an "update" sub-directory containing files that
that can be used to instantiate and monitor a secure update.

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
    flash count, root entry hashes, and code-signing-key cancelation
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

Russ Weight (7):
  fpga: sec-mgr: fpga security manager class driver
  fpga: sec-mgr: enable secure updates
  fpga: sec-mgr: expose sec-mgr update status
  fpga: sec-mgr: expose sec-mgr update errors
  fpga: sec-mgr: expose sec-mgr update size
  fpga: sec-mgr: enable cancel of secure update
  fpga: sec-mgr: expose hardware error info

 .../ABI/testing/sysfs-class-fpga-sec-mgr      |  81 +++
 Documentation/fpga/fpga-sec-mgr.rst           |  44 ++
 Documentation/fpga/index.rst                  |   1 +
 MAINTAINERS                                   |   9 +
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/fpga-sec-mgr.c                   | 652 ++++++++++++++++++
 include/linux/fpga/fpga-sec-mgr.h             | 100 +++
 8 files changed, 899 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
 create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
 create mode 100644 drivers/fpga/fpga-sec-mgr.c
 create mode 100644 include/linux/fpga/fpga-sec-mgr.h

-- 
2.25.1

