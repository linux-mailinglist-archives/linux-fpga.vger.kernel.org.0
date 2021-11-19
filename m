Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9934567B1
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 02:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhKSB7A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 20:59:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:62919 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhKSB7A (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 20:59:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="231818670"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="231818670"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 17:55:59 -0800
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="536947290"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.203.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 17:55:59 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v14 0/3] fpga: Use standard class dev_release function
Date:   Thu, 18 Nov 2021 17:55:50 -0800
Message-Id: <20211119015553.62704-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA framework has a convention of using managed resource functions
to allow parent drivers to manage the data structures allocated by the
class drivers. They use an empty *_dev_release() function to satisfy the
class driver.

This is inconsistent with linux driver model.

These changes remove the managed resource functions and populate the class
dev_release callback functions. They also merge the create() and register()
functions into a single register() or register_full() function for each of
the fpga-mgr, fpga-region, and fpga-bridge class drivers.

The new *register_full() functions accept an info data structure to provide
flexibility in passing optional parameters. The *register() functions
support the legacy parameter list for users that don't require the use of
optional parameters.

For more context, refer to this email thread:

https://marc.info/?l=linux-fpga&m=162127412218557&w=2

I turned on the configs assocated with each of the modified files, but I
must have been missing some dependencies, because not all of them compiled.
I did a run-time test specifically with the dfl-fme infrastructure. This
would have exercised the region, bridge, and fpga-mgr frameworks.

Changelog v13 -> v14:
  - Fixed typo/bug detected by kernel test robot <lkp@intel.com>: s/mgr/br/

Changelog v12 -> v13:
  - Add Acked-by tag

Changelog v11 -> v12:
  - Made the requisite changes to the new versal-fpga driver

Changelog v10 -> v11:
  - Rebased to latest linux-next
  - Resolved a single conflict in fpga-mgr.c with associated with  wrapper
    function: fpga_mgr_state(mgr)

Changelog v9 -> v10:
  - Fixed commit messages to reference register_full() instead of
    register_simple().
  - Removed the fpga_bridge_register_full() function, because there is
    not need for it yet. Updated the documentation and commit message
    accordingly.
  - Updated documentation to reference the fpga_manager_info and
    fpga_region_info structures.

Changelog v8 -> v9:
  - Cleaned up documentation for the FPGA Manager, Bridge, and Region
    register functions
  - Renamed fpga_*_register() to fpga_*_register_full()
  - Renamed fpga_*_register_simple() to fpga_*_register()
  - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
  - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()

Changelog v7 -> v8:
  - Added reviewed-by tags.
  - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
    fpga-bridge.rst, and fpga-region.rst.

Changelog v6 -> v7:
  - Update the commit messages to describe the new parameters for the
    *register() functions and to mention the *register_simple() functions.
  - Fix function prototypes in header file to rename dev to parent.
  - Make use of the PTR_ERR_OR_ZERO() macro when possible.
  - Some cleanup of comments.
  - Update function definitions/prototypes to apply const to the new info
    parameter.
  - Verify that info->br_ops is non-null in the fpga_bridge_register()
    function.
  - Verify a non-null info pointer in the fpga_region_register() function.

Changelog v5 -> v6:
  - Moved FPGA manager/bridge/region optional parameters out of the ops
    structure and back into the FPGA class driver structure.
  - Changed fpga_*_register() function parameters to accept an info data
    structure to provide flexibility in passing optional parameters.
  - Added fpga_*_register_simple() functions to support current parameters
    for users that don't require use of optional parameters.

Changelog v4 -> v5:
  - Rebased on top of recently accepted patches.
  - Removed compat_id from the fpga_mgr_register() parameter list
    and added it to the fpga_manager_ops structure. This also required
    dynamically allocating the dfl-fme-ops structure in order to add
    the appropriate compat_id.
  - Created the fpga_region_ops data structure which is optionally passed
    to fpga_region_register(). compat_id, the get_bridges() pointer, and
    the priv pointer are included in the fpga_region_ops structure.

Changelog v3 -> v4:
  - Added the compat_id parameter to fpga_mgr_register() and
    devm_fpga_mgr_register() to ensure that the compat_id is set before
    the device_register() call.
  - Added the compat_id parameter to fpga_region_register() to ensure
    that the compat_id is set before the device_register() call.
  - Modified the dfl_fpga_feature_devs_enumerate() function to restore
    the fpga_region_register() call to the correct location.

Changelog v2 -> v3:
  - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
    and fpga_region_register().
  - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
    fpga_bridge_register(), and fpga_region_register().
  - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
    of NULL.

Changelog v1 -> v2:
  - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
    class driver, adapted for the combined create/register functionality.
  - All previous callers of devm_fpga_mgr_register() will continue to call
    devm_fpga_mgr_register().
  - replaced unnecessary ternary operators in return statements with
    standard if conditions.

Russ Weight (3):
  fpga: mgr: Use standard dev_release for class driver
  fpga: bridge: Use standard dev_release for class driver
  fpga: region: Use standard dev_release for class driver

 Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
 Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
 Documentation/driver-api/fpga/fpga-region.rst |  12 +-
 drivers/fpga/altera-cvp.c                     |  12 +-
 drivers/fpga/altera-fpga2sdram.c              |  12 +-
 drivers/fpga/altera-freeze-bridge.c           |  10 +-
 drivers/fpga/altera-hps2fpga.c                |  12 +-
 drivers/fpga/altera-pr-ip-core.c              |   7 +-
 drivers/fpga/altera-ps-spi.c                  |   9 +-
 drivers/fpga/dfl-fme-br.c                     |  10 +-
 drivers/fpga/dfl-fme-mgr.c                    |  22 +-
 drivers/fpga/dfl-fme-region.c                 |  17 +-
 drivers/fpga/dfl.c                            |  12 +-
 drivers/fpga/fpga-bridge.c                    | 122 +++-------
 drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
 drivers/fpga/fpga-region.c                    | 119 ++++------
 drivers/fpga/ice40-spi.c                      |   9 +-
 drivers/fpga/machxo2-spi.c                    |   9 +-
 drivers/fpga/of-fpga-region.c                 |  10 +-
 drivers/fpga/socfpga-a10.c                    |  16 +-
 drivers/fpga/socfpga.c                        |   9 +-
 drivers/fpga/stratix10-soc.c                  |  16 +-
 drivers/fpga/ts73xx-fpga.c                    |   9 +-
 drivers/fpga/versal-fpga.c                    |   9 +-
 drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
 drivers/fpga/xilinx-spi.c                     |  11 +-
 drivers/fpga/zynq-fpga.c                      |  16 +-
 drivers/fpga/zynqmp-fpga.c                    |   9 +-
 include/linux/fpga/fpga-bridge.h              |  30 ++-
 include/linux/fpga/fpga-mgr.h                 |  62 +++--
 include/linux/fpga/fpga-region.h              |  36 ++-
 31 files changed, 386 insertions(+), 517 deletions(-)

-- 
2.25.1

