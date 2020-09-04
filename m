Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E354A25E44C
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 01:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIDXxP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 19:53:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:64693 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgIDXxP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Sep 2020 19:53:15 -0400
IronPort-SDR: mIccJCGemNXxJw/qt86/DaS0mejKUhY9YM6/TkhWpi1XYdTdF/H8jWrSNYRsooJStckFfABpAI
 I6CUJX/wPeqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219386181"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="219386181"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 16:53:14 -0700
IronPort-SDR: 7dpd2GJU632sDJcF50/Cxcbw+ivDO5YjBmChaWhWOlZsdsDphgEG780RbM+zvKcJiL3oSC3iP4
 Mhx9VQZXA/mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="284656168"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.151.80])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 16:53:13 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
Date:   Fri,  4 Sep 2020 16:52:53 -0700
Message-Id: <20200904235305.6254-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


These patches depend on the patchset: "add regmap-spi-avmm & Intel
Max10 BMC chip support" which is currently under review.

           --------------------------------------------------

This patchset introduces the Intel Security Manager class driver
for managing secure updates on Intel FPGA Cards. It also provides
the n3000bmc-secure mfd sub-driver for the MAX10 BMC for the n3000
Programmable Acceleration Cards (PAC). The n3000bmc-secure driver
is implemented using the Intel Security Manager class driver.

The Intel Security Manager class driver provides a common API for
user-space tools to manage updates for Secure FPGA devices. Device
drivers that instantiate the Intel Security Manager class driver will
interact with the HW secure update engine in order to transfer
new FPGA and BMC images to FLASH so that they will be automatically
loaded when the FPGA card reboots.

The API consists of sysfs nodes and supports the following functions:

(1) Instantiate and monitor a secure update
(2) Display security information including: Root Entry Hashes (REH),
    Cancelled Code Signing Keys (CSK), and flash update counts for
    both BMC and FPGA images.

Secure updates make use of the request_firmware framework, which
requires that image files are accessible under /lib/firmware. A request
for a secure update returns immediately, while the update itself
proceeds in the context of a kernel worker thread. Sysfs files provide
a means for monitoring the progress of a secure update and for
retrieving error information in the event of a failure.

The n3000bmc-secure driver instantiates the Intel Security Manager
class driver and provides the callback functions required to support
secure updates on Intel n3000 PAC devices.

Russ Weight (12):
  fpga: fpga security manager class driver
  fpga: create intel max10 bmc security engine
  fpga: expose max10 flash update counts in sysfs
  fpga: expose max10 canceled keys in sysfs
  fpga: enable secure updates
  fpga: add max10 secure update functions
  fpga: expose sec-mgr update status
  fpga: expose sec-mgr update errors
  fpga: expose sec-mgr update size
  fpga: enable sec-mgr update cancel
  fpga: expose hardware error info in sysfs
  fpga: add max10 get_hw_errinfo callback func

 .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 151 ++++
 MAINTAINERS                                   |   8 +
 drivers/fpga/Kconfig                          |  20 +
 drivers/fpga/Makefile                         |   6 +
 drivers/fpga/ifpga-sec-mgr.c                  | 669 ++++++++++++++++++
 drivers/fpga/intel-m10-bmc-secure.c           | 557 +++++++++++++++
 include/linux/fpga/ifpga-sec-mgr.h            | 201 ++++++
 include/linux/mfd/intel-m10-bmc.h             | 116 +++
 8 files changed, 1728 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
 create mode 100644 drivers/fpga/ifpga-sec-mgr.c
 create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
 create mode 100644 include/linux/fpga/ifpga-sec-mgr.h

-- 
2.17.1

