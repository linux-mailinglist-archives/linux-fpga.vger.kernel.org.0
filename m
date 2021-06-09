Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9613A1FDA
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhFIWQc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 18:16:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:22619 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhFIWQc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 18:16:32 -0400
IronPort-SDR: 777KI1wEZMDr7oxaxYj1JIztjpkkJYKPI8Hgh+caA34GHdZnTsvjzm2hbVH4sTVjx9Y/zX1eZx
 hvBoxr4yepFA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192496199"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192496199"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:14:36 -0700
IronPort-SDR: ttnncI97L8gVHkR2zaFnqmQj+eDhTue+DO9OhtwhPfMRUHVqsbdZ4UPdIf8M6ndDzroI7kUT6r
 tofEm0SuibZQ==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="477095291"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.20.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:14:35 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 0/8] fpga: Populate dev_release functions
Date:   Wed,  9 Jun 2021 15:11:27 -0700
Message-Id: <20210609221135.261837-1-russell.h.weight@intel.com>
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

This is a complete re-do of the previous patch set entitled
"fpga: Use standard class dev_release function". These changes populate the
class dev_release callback functions while maintaining the current API.
Additional changes are made to maintain consistency with the driver model.

For more context on these changes, refer to this email thread:

https://marc.info/?l=linux-fpga&m=162127412218557&w=2

Changelog v1 -> v2:
  - Moved the renaming of "dev" to "parent" into a separate patch each for
    fpga-mgr, fpga-bridge, fpga-region.
  - Restored the call to fpga_mgr_free() in devm_*_mgr_release() instead of 
    changing it to put_device().
  - Replaced patch "fpga: altera-pr-ip: Remove function alt_pr_unregister"
    with "fpga: altera-pr-ip: Remove function alt_pr_unregister". This patch
    removes the alt_pr_unregister() function altogether, instead of just
    removing portions of it.

Russ Weight (8):
  fpga: altera-pr-ip: Remove function alt_pr_unregister
  fpga: stratix10-soc: Add missing fpga_mgr_free() call
  fpga: mgr: Rename dev to parent for parent device
  fpga: bridge: Rename dev to parent for parent device
  fpga: region: Rename dev to parent for parent device
  fpga: mgr: Use standard dev_release for class driver
  fpga: bridge: Use standard dev_release for class driver
  fpga: region: Use standard dev_release for class driver

 drivers/fpga/altera-pr-ip-core.c       | 10 -----
 drivers/fpga/fpga-bridge.c             | 46 ++++++++++-----------
 drivers/fpga/fpga-mgr.c                | 55 ++++++++++++--------------
 drivers/fpga/fpga-region.c             | 44 ++++++++++-----------
 drivers/fpga/stratix10-soc.c           |  1 +
 include/linux/fpga/altera-pr-ip-core.h |  1 -
 6 files changed, 71 insertions(+), 86 deletions(-)

-- 
2.25.1

