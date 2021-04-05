Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605ED35497B
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 01:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbhDEXvw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Apr 2021 19:51:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:3167 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237959AbhDEXvv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Apr 2021 19:51:51 -0400
IronPort-SDR: 3PiC3Q1BqzAnX9l+ioYr8f+irSufRX9oZ6iy3WrL3m2jwucqIbZqcq2o4ItIKNby1Hm6kkoWrP
 r0Wi9iiaX+Ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180076752"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="180076752"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 16:51:44 -0700
IronPort-SDR: dgYBW02VXqY6yw5ZcJrIYtpM4qG804xhzlIqER0n/48rsVw7K0iHOhhaKPKNQkqzRgI7Aqfw7p
 bfoDYFbGX8QQ==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="414501829"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 16:51:43 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@linux.intel.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 0/3] fpga: dfl: add support for Intel D5005 card
Date:   Mon,  5 Apr 2021 16:52:58 -0700
Message-Id: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch set adds basic support for the Intel D5005 card to the
dfl driver framework.

Patch 1 adds the PCIe device id of the D5005 to the dfl-pci id table.

Patch 2 adds a dfl driver for the Altera SPI Master which is connected
to the board's BMC.

Patch 3 adds hwmon support for the sensors monitored by the board's BMC.

Matthew Gerlach (2):
  fpga: dfl: Add DFL bus driver for Altera SPI Master
  hwmon: intel-m10-bmc-hwmon: add sensor support of Intel D5005 card

Russ Weight (1):
  fpga: dfl: pci: add DID for D5005 PAC cards

 drivers/fpga/Kconfig                |   9 ++
 drivers/fpga/Makefile               |   1 +
 drivers/fpga/dfl-pci.c              |  18 +--
 drivers/fpga/dfl-spi-altera.c       | 221 ++++++++++++++++++++++++++++++++++++
 drivers/hwmon/intel-m10-bmc-hwmon.c | 122 ++++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c         |  10 ++
 6 files changed, 374 insertions(+), 7 deletions(-)
 create mode 100644 drivers/fpga/dfl-spi-altera.c

-- 
1.8.3.1

