Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4809422BBE1
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jul 2020 04:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgGXCMh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Jul 2020 22:12:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:14547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgGXCMh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 23 Jul 2020 22:12:37 -0400
IronPort-SDR: hpAI0l9wYNUZKiTVcfQI74fRPiiqiHcJ1SuI814NooXsbRN5BPzMMaui12Ute4m2DUgropw8+9
 9zeI4h7fhuAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168780076"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="168780076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 19:12:36 -0700
IronPort-SDR: UbFl+RT4t0bfC9TcAjLypd1ZgYKzoONYilsV10El8qo/TCpZ6XuiWKvooEk/ES2W4IlWMT8NcD
 tkZjJZykwWxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="271216007"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jul 2020 19:12:35 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com
Subject: [PATCH v2 0/4] Modularization of DFL private feature drivers
Date:   Fri, 24 Jul 2020 10:09:11 +0800
Message-Id: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset makes it possible to develop independent driver modules
for DFL private features. It also helps to leverage existing kernel
drivers to enable some IP blocks in DFL.

Patch #1: An improvement of feature id definition. The feature id will be used
	  as the key field for dfl device/driver matching.
Patch #2: Release the dfl mmio regions after enumeration, so that private
	  feature drivers could request mmio region in their own drivers.
Patch #3: Introduce the dfl bus, then dfl devices could be supported by
	  independent dfl drivers.
Patch #4: An example of the dfl driver for N3000 nios private feature.


Main changes from v1:
- Add the new Patch #1, to improve the feature id definition.
- Change the dfl bus uevent format.
- Change the dfl device's sysfs name format.
- refactor dfl_dev_add()
- Add the Patch #4 as an example of the dfl driver.
- A lot of minor fixes for comments from Hao and Tom.

Xu Yilun (4):
  fpga: dfl: change data type of feature id to u16
  fpga: dfl: map feature mmio resources in their own feature drivers
  fpga: dfl: create a dfl bus type to support DFL devices
  fpga: dfl: add support for N3000 nios private feature

 Documentation/ABI/testing/sysfs-bus-dfl            |  15 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  16 +
 drivers/fpga/Kconfig                               |  12 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-fme-perf.c                        |   2 +-
 drivers/fpga/dfl-n3000-nios.c                      | 483 +++++++++++++++++++++
 drivers/fpga/dfl-pci.c                             |  24 +-
 drivers/fpga/dfl.c                                 | 464 ++++++++++++++++----
 drivers/fpga/dfl.h                                 | 101 ++++-
 9 files changed, 1017 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 drivers/fpga/dfl-n3000-nios.c

-- 
2.7.4

