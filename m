Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393483AA71F
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Jun 2021 00:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFPXAB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Jun 2021 19:00:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:34926 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhFPXAA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 16 Jun 2021 19:00:00 -0400
IronPort-SDR: 74iwvKvtfN6k4Jtj7MXPuFFf//q2dilYZn25+8KPSiqhkgZCvUmge8qunCsVoov4gHRNx3HxIc
 tJ/ZC/qj6eoQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="227776751"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="227776751"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 15:57:54 -0700
IronPort-SDR: D5d1oVn9ZfNy8i67/8dYYM/me8jQYDm05JzBJ92Gzcd7VAgAacScZ5EQJrJSnohPSdJu4kmbNH
 5/pqXN8DgSzA==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="452552746"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.39.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 15:57:53 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v5 0/3] fpga: Use standard class dev_release function
Date:   Wed, 16 Jun 2021 15:57:37 -0700
Message-Id: <20210616225740.399486-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA framework has a convention of using managed resource
functions to allow parent drivers to manage the data structures
allocated by the class drivers. They use an empty *_dev_release()
function to satisfy the class driver.

This is inconsistent with linux driver model.

These changes remove the managed resource functions and populate
the class dev_release callback functions. They also merge the
create and register functions into a single register function for
each of the fpga-mgr, fpga-region, and fpga-bridge class drivers.

For more context, refer to this email thread:

https://marc.info/?l=linux-fpga&m=162127412218557&w=2

I turned on the configs assocated with each of the modified files,
but I must have been missing some dependencies, because not all
of them compiled. I did a run-time test specifically with the
dfl-fme infrastructure. This would have exercised the region,
bridge, and fpga-mgr frameworks.

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

 drivers/fpga/altera-cvp.c           |  12 +-
 drivers/fpga/altera-fpga2sdram.c    |  12 +-
 drivers/fpga/altera-freeze-bridge.c |  10 +-
 drivers/fpga/altera-hps2fpga.c      |  12 +-
 drivers/fpga/altera-pr-ip-core.c    |   8 +-
 drivers/fpga/altera-ps-spi.c        |  10 +-
 drivers/fpga/dfl-fme-br.c           |  10 +-
 drivers/fpga/dfl-fme-mgr.c          |  52 +++++----
 drivers/fpga/dfl-fme-pr.c           |   2 +-
 drivers/fpga/dfl-fme-region.c       |  32 ++++--
 drivers/fpga/dfl.c                  |  12 +-
 drivers/fpga/fpga-bridge.c          | 116 ++++----------------
 drivers/fpga/fpga-mgr.c             | 163 +++++++---------------------
 drivers/fpga/fpga-region.c          | 119 +++++---------------
 drivers/fpga/ice40-spi.c            |  10 +-
 drivers/fpga/machxo2-spi.c          |  10 +-
 drivers/fpga/of-fpga-region.c       |  14 +--
 drivers/fpga/socfpga-a10.c          |  16 +--
 drivers/fpga/socfpga.c              |  10 +-
 drivers/fpga/stratix10-soc.c        |  16 +--
 drivers/fpga/ts73xx-fpga.c          |  10 +-
 drivers/fpga/xilinx-pr-decoupler.c  |  17 +--
 drivers/fpga/xilinx-spi.c           |  12 +-
 drivers/fpga/zynq-fpga.c            |  16 +--
 drivers/fpga/zynqmp-fpga.c          |  10 +-
 include/linux/fpga/fpga-bridge.h    |  12 +-
 include/linux/fpga/fpga-mgr.h       |  43 ++++----
 include/linux/fpga/fpga-region.h    |  38 ++++---
 28 files changed, 286 insertions(+), 518 deletions(-)

-- 
2.25.1

