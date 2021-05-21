Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D47738D1BD
	for <lists+linux-fpga@lfdr.de>; Sat, 22 May 2021 01:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhEUXBe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 21 May 2021 19:01:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:20212 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhEUXBd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 21 May 2021 19:01:33 -0400
IronPort-SDR: QFHXHs5UOxORpFKyl/qsNsb4kIRLP+TUzPxPXNiuhvS2cSnvZA+GgXSYyf1suhYu5W8L2d+SmW
 V6smtmgactyA==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201301375"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201301375"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 16:00:10 -0700
IronPort-SDR: gRoRRbWgvbpZ0IodGSYaFFMwIY6+aI73+GrMSf4dAKXbKGKZhpa++lXf97c9vTBRss6yncibYj
 +JxeChDxncBA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="613408174"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.115.175])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 16:00:08 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 0/3] fpga: Use standard class dev_release function
Date:   Fri, 21 May 2021 16:00:02 -0700
Message-Id: <20210521230005.663650-1-russell.h.weight@intel.com>
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

 drivers/fpga/altera-cvp.c           |  12 +--
 drivers/fpga/altera-fpga2sdram.c    |  12 +--
 drivers/fpga/altera-freeze-bridge.c |  10 +-
 drivers/fpga/altera-hps2fpga.c      |  12 +--
 drivers/fpga/altera-pr-ip-core.c    |   8 +-
 drivers/fpga/altera-ps-spi.c        |  10 +-
 drivers/fpga/dfl-fme-br.c           |  10 +-
 drivers/fpga/dfl-fme-mgr.c          |  10 +-
 drivers/fpga/dfl-fme-region.c       |  10 +-
 drivers/fpga/dfl.c                  |  10 +-
 drivers/fpga/fpga-bridge.c          | 113 ++++----------------
 drivers/fpga/fpga-mgr.c             | 159 +++++++---------------------
 drivers/fpga/fpga-region.c          |  97 +++--------------
 drivers/fpga/ice40-spi.c            |  10 +-
 drivers/fpga/machxo2-spi.c          |  10 +-
 drivers/fpga/of-fpga-region.c       |  10 +-
 drivers/fpga/socfpga-a10.c          |  16 ++-
 drivers/fpga/socfpga.c              |  10 +-
 drivers/fpga/stratix10-soc.c        |  15 +--
 drivers/fpga/ts73xx-fpga.c          |  10 +-
 drivers/fpga/xilinx-pr-decoupler.c  |  17 ++-
 drivers/fpga/xilinx-spi.c           |  12 +--
 drivers/fpga/zynq-fpga.c            |  16 ++-
 drivers/fpga/zynqmp-fpga.c          |  10 +-
 include/linux/fpga/fpga-bridge.h    |  12 +--
 include/linux/fpga/fpga-mgr.h       |  17 ++-
 include/linux/fpga/fpga-region.h    |  12 +--
 27 files changed, 185 insertions(+), 465 deletions(-)

-- 
2.25.1

