Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C4281E6E
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Oct 2020 00:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgJBWhP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Oct 2020 18:37:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:19237 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJBWhP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Oct 2020 18:37:15 -0400
IronPort-SDR: JeHEowA+U/sIFgLlmCYOatzqV+6hqz7qvoB6kH+0HKQHcYBJK7NtKFNfFXPTHAb+l53+WW/4Qk
 9h2X9cmJpeQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160415294"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="160415294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 15:37:12 -0700
IronPort-SDR: LLUcT0V5OpeuBqtmi4nDRoY/o/AXYVYk+inBwJfgnWy0bOqD4NBCBDToyhdYpPAjsjzBdOg8Mu
 PDiJPkjSaXmw==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="510808738"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.5.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 15:37:11 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 0/7] Intel FPGA Security Manager Class Driver
Date:   Fri,  2 Oct 2020 15:36:54 -0700
Message-Id: <20201002223701.1317-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The Intel FPGA Security Manager class driver provides a common
API for user-space tools to manage updates for secure Intel FPGA
devices. Device drivers that instantiate the Intel Security
Manager class driver will interact with a HW secure update
engine in order to transfer new FPGA and BMC images to FLASH so
that they will be automatically loaded when the FPGA card reboots.

A significant difference between the FPGA Manager and the Intel FPGA 
Security Manager is that the FPGA Manager does a live update (Partial
Reconfiguration) to a device whereas the Intel FPGA Security Manager
updates the FLASH images for the Static Region and the BMC so that
they will be loaded the next time the FPGA card boots. Security is
enforced by hardware and firmware. The security manager interacts
with the firmware to initiate an update, pass in the necessary data,
and collect status on the update.

The n3000bmc-secure driver is the first driver to use the Intel FPG
Security Manager. This driver was previously submittied in the same
patch set, but has been split out in to a separate patch set for V2.
Follow-on Intel devices will also make use of this common API for
secure updates.

In addition to managing secure updates of the FPGA and BMC images,
the Intel FPGA Security Manager update process may also used to
program root entry hashes and cancellation keys for the FPGA static
region, the FPGA partial reconfiguration region, and the BMC.

Secure updates make use of the request_firmware framework, which
requires that image files are accessible under /lib/firmware. A request
for a secure update returns immediately, while the update itself
proceeds in the context of a kernel worker thread. Sysfs files provide
a means for monitoring the progress of a secure update and for
retrieving error information in the event of a failure.

The API consists of sysfs nodes and supports the following functions:

(1) Instantiate and monitor a secure update
(2) Display security information including: Root Entry Hashes (REH),
    Cancelled Code Signing Keys (CSK), and flash update counts for
    both BMC and FPGA images.

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
  fpga: sec-mgr: intel fpga security manager class driver
  fpga: sec-mgr: enable secure updates
  fpga: sec-mgr: expose sec-mgr update status
  fpga: sec-mgr: expose sec-mgr update errors
  fpga: sec-mgr: expose sec-mgr update size
  fpga: sec-mgr: enable cancel of secure update
  fpga: sec-mgr: expose hardware error info

 .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 143 ++++
 Documentation/fpga/ifpga-sec-mgr.rst          |  50 ++
 Documentation/fpga/index.rst                  |   1 +
 MAINTAINERS                                   |   9 +
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/ifpga-sec-mgr.c                  | 781 ++++++++++++++++++
 include/linux/fpga/ifpga-sec-mgr.h            | 137 +++
 8 files changed, 1133 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
 create mode 100644 Documentation/fpga/ifpga-sec-mgr.rst
 create mode 100644 drivers/fpga/ifpga-sec-mgr.c
 create mode 100644 include/linux/fpga/ifpga-sec-mgr.h

-- 
2.17.1

