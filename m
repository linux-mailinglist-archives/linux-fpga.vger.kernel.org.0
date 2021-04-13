Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7335E952
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Apr 2021 00:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhDMW50 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Apr 2021 18:57:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:32275 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhDMW5Z (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 13 Apr 2021 18:57:25 -0400
IronPort-SDR: gXJYxn60sWaA8CXI/d6XGIUG6avMHdeJfljSRl14M1R4xKkG78evHP+I29q8d4dmUeRKrK3NMV
 7MxCnXkspjww==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="182028999"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="182028999"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 15:57:04 -0700
IronPort-SDR: YntJX6u7pJkd03PR56tI7/A/oJX7Xtt1vjhlaSB0JZ9EjdQ4UTTsjg6KinzO0gLjT5a7Az0I0E
 i+sI//e6xNlQ==
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="398943218"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 15:57:04 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@intel.com, broonie@kernel.org,
        linux-spi@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 0/2] spi: add BMC support for Intel D5005 card
Date:   Tue, 13 Apr 2021 15:58:33 -0700
Message-Id: <20210413225835.459662-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch set adds support for the Board Management Controller (BMC)
of an Intel D5005 card.  The BMC support requires a Device Feature
List (DFL) bus driver for the Altera SPI Master controller and hwmon
support for the sensors monitored by the BMC.

Patch 1 adds a dfl driver for the Altera SPI Master which is connected
to the board's BMC.

Patch 2 adds hwmon support for the sensors monitored by the board's BMC.
---
v2: move drivers/fpga/dfl-spi-altera.c to drivers/spi/spi-altera-dfl.c
    change variable name from m10bmc_bmc_subdevs to m10bmc_d5005_subdevs
    added Acked-by: Lee Jones

Matthew Gerlach (2):
  spi: Add DFL bus driver for Altera SPI Master
  hwmon: intel-m10-bmc-hwmon: add sensor support of Intel D5005 card

 drivers/hwmon/intel-m10-bmc-hwmon.c | 122 ++++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c         |  10 ++
 drivers/spi/Kconfig                 |   9 ++
 drivers/spi/Makefile                |   1 +
 drivers/spi/spi-altera-dfl.c        | 221 ++++++++++++++++++++++++++++++++++++
 5 files changed, 363 insertions(+)
 create mode 100644 drivers/spi/spi-altera-dfl.c

-- 
1.8.3.1

