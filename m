Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD5C24608B
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Aug 2020 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgHQIoz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Aug 2020 04:44:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:18713 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgHQIoz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 Aug 2020 04:44:55 -0400
IronPort-SDR: rgabjZv8SN7MQJ+bWgjTE5heWDkXochQwmvMBmB9O0qFUr76CXx6Qn6TSs9QWZWRzrC0auJsj0
 vQG0P7GtYXag==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="172714574"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="172714574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 01:44:54 -0700
IronPort-SDR: 5cM4pTxsYwjSNtKYD83oXLf5sIZeqLFnVy+wYgruJvkNg7QlR3pEB1qGknk63QcvdqygLnhut+
 ziHIoHDyic3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="471350658"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2020 01:44:52 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com
Subject: [PATCH v6 0/3] Modularization of DFL private feature drivers
Date:   Mon, 17 Aug 2020 16:40:09 +0800
Message-Id: <1597653612-5064-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset makes it possible to develop independent driver modules
for DFL private features. It also helps to leverage existing kernel
drivers to enable some IP blocks in DFL.

Patch #1: Release the dfl mmio regions after enumeration, so that private
          feature drivers could request mmio region in their own drivers.
Patch #2: Introduce the dfl bus, then dfl devices could be supported by
          independent dfl drivers.
Patch #3: An example of the dfl driver for N3000 nios private feature.


Main changes from v1:
- Add the new Patch #1, to improve the feature id definition.
- Change the dfl bus uevent format.
- Change the dfl device's sysfs name format.
- refactor dfl_dev_add()
- Add the Patch #4 as an example of the dfl driver.
- A lot of minor fixes for comments from Hao and Tom.

Main changes from v2:
- Add the doc for dfl-n3000-nios driver.
- Minor fixes for comments from Tom.

Main changes from v3:
- improve the dfl devices' uevent format, 4 bits for type & 12 bits for id
- change dfl_device->type to u8
- A dedicate field in struct dfl_feature for dfl device instance.
- error out if dfl_device already exist on dfl_devs_init().
- Move the err log in regmap implementation, and delete
   n3000_nios_writel/readl(), they have nothing to wrapper now.
- Minor fixes and comments improvement.

Main changes from v4:
- The patch "fpga: dfl: change data type of feature id to u16" is already
   applied to for-next
- Unify the naming of some functions in dfl.c
- Fix the output of fec_mode sysfs inf to "no" on 10G configuration, cause
   no FEC mode could be configured for 10G.
- Change the N3000 Nios driver name from "dfl-n3000-nios" to "n3000-nios",
   and also rename some structures and functions from dfl_n3000_nios_* to
   n3000_nios_*
- Minor fixes and comments improvement.

Main changes from v5:
- Fix the output of fec_mode sysfs inf to "not supported" if in 10G,
   or the firmware version major < 3.
- The input param of dfl_devs_add() changes to
   struct dfl_feature_platform_data.
- Minor fixes and improves comments.


Xu Yilun (3):
  fpga: dfl: map feature mmio resources in their own feature drivers
  fpga: dfl: create a dfl bus type to support DFL devices
  fpga: dfl: add support for N3000 Nios private feature

 Documentation/ABI/testing/sysfs-bus-dfl            |  15 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  21 +
 Documentation/fpga/dfl-n3000-nios.rst              |  79 +++
 Documentation/fpga/index.rst                       |   1 +
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 539 +++++++++++++++++++++
 drivers/fpga/dfl-pci.c                             |  24 +-
 drivers/fpga/dfl.c                                 | 449 ++++++++++++++---
 drivers/fpga/dfl.h                                 |  93 +++-
 10 files changed, 1149 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
 create mode 100644 drivers/fpga/dfl-n3000-nios.c

-- 
2.7.4

