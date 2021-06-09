Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13593A08A4
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 02:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhFIAv3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 20:51:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:53669 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhFIAv0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 8 Jun 2021 20:51:26 -0400
IronPort-SDR: 6Zih0x04lZLbEcEWEH2yOWtPkMWk3qmkjGtF6joK9CNF2Mb7oEIwigBcDrHcQ4rAbFzgdLl3fi
 JKyQU9CAhwvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201954212"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="201954212"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:49:29 -0700
IronPort-SDR: EoapYh7Mvgj3KX82Citd5a+nXd/FWgNpyxV3qaLi1CIzAWm/IxocqZIi0NSBpnN2Vt5umyKryp
 KxppFNGre+1g==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="449747470"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.100.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:49:29 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 0/5] fpga: Populate dev_release functions
Date:   Tue,  8 Jun 2021 17:49:20 -0700
Message-Id: <20210609004925.238044-1-russell.h.weight@intel.com>
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

Russ Weight (5):
  fpga: mgr: Use standard dev_release for class driver
  fpga: altera-pr-ip: Remove fpga_mgr_unregister() call
  fpga: stratix10-soc: Add missing fpga_mgr_free() call
  fpga: bridge: Use standard dev_release for class driver
  fpga: region: Use standard dev_release for class driver

 drivers/fpga/altera-pr-ip-core.c |  4 ---
 drivers/fpga/fpga-bridge.c       | 48 +++++++++++++--------------
 drivers/fpga/fpga-mgr.c          | 57 +++++++++++++++-----------------
 drivers/fpga/fpga-region.c       | 46 +++++++++++++-------------
 drivers/fpga/stratix10-soc.c     |  1 +
 5 files changed, 74 insertions(+), 82 deletions(-)

-- 
2.25.1

