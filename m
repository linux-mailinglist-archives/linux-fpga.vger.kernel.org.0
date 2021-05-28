Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1539488E
	for <lists+linux-fpga@lfdr.de>; Sat, 29 May 2021 00:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE1WNM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 May 2021 18:13:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:43021 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhE1WNM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 May 2021 18:13:12 -0400
IronPort-SDR: 3p5qlRXHjQNuIPC6Jm0Wohtv97+KeGAwsj8+HNWcYj8iYbGb9MuU3/+z44KDlv2nZcDQl1/ILZ
 nVk++dQFtdWg==
X-IronPort-AV: E=McAfee;i="6200,9189,9998"; a="288643748"
X-IronPort-AV: E=Sophos;i="5.83,231,1616482800"; 
   d="scan'208";a="288643748"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 15:11:36 -0700
IronPort-SDR: QAQluzzCyqSSuGG9ARwKpZu6aqbXQUZE6ZbttFIoq9u6whC7qQ0PbnnPAGnO/1Rh1xj+JpmT6X
 8wcHDX6C7fsg==
X-IronPort-AV: E=Sophos;i="5.83,231,1616482800"; 
   d="scan'208";a="548124229"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.50.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 15:11:33 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 0/3] fpga: Use standard class dev_release function
Date:   Fri, 28 May 2021 14:57:52 -0700
Message-Id: <20210528215755.839712-1-russell.h.weight@intel.com>
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

Changelog v3 -> v4:
  - Added the compat_id parameter to fpga_mgr_register() and
    devm_fpga_mgr_register() to ensure that the compat_id is set before
    the device_register() call.
  - Added the compat_id parameter to fpga_bridge_register() to ensure
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
 drivers/fpga/altera-pr-ip-core.c    |   9 +-
 drivers/fpga/altera-ps-spi.c        |  10 +-
 drivers/fpga/dfl-fme-br.c           |  10 +-
 drivers/fpga/dfl-fme-mgr.c          |  12 +-
 drivers/fpga/dfl-fme-region.c       |  12 +-
 drivers/fpga/dfl.c                  |  12 +-
 drivers/fpga/fpga-bridge.c          | 119 +++++---------------
 drivers/fpga/fpga-mgr.c             | 168 ++++++++--------------------
 drivers/fpga/fpga-region.c          | 106 ++++--------------
 drivers/fpga/ice40-spi.c            |  10 +-
 drivers/fpga/machxo2-spi.c          |  10 +-
 drivers/fpga/of-fpga-region.c       |  10 +-
 drivers/fpga/socfpga-a10.c          |  16 +--
 drivers/fpga/socfpga.c              |  10 +-
 drivers/fpga/stratix10-soc.c        |  15 +--
 drivers/fpga/ts73xx-fpga.c          |  10 +-
 drivers/fpga/xilinx-pr-decoupler.c  |  17 +--
 drivers/fpga/xilinx-spi.c           |  12 +-
 drivers/fpga/zynq-fpga.c            |  16 +--
 drivers/fpga/zynqmp-fpga.c          |  10 +-
 include/linux/fpga/fpga-bridge.h    |  12 +-
 include/linux/fpga/fpga-mgr.h       |  19 ++--
 include/linux/fpga/fpga-region.h    |  13 +--
 27 files changed, 210 insertions(+), 474 deletions(-)

-- 
2.25.1

