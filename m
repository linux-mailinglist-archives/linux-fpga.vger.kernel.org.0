Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8CB2400FB
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Aug 2020 04:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHJCov (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Aug 2020 22:44:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:50123 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgHJCov (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 9 Aug 2020 22:44:51 -0400
IronPort-SDR: hoQqZv8h8dqX5xUm+ZsCFYii6BbvOKgCEqwvLFCv9bThEPVqCam2XE0B95P0ZTd7S0PxW84RyE
 FXHmYgr5fF9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="133523424"
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="133523424"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2020 19:44:50 -0700
IronPort-SDR: Oy26DasJQD+oaegknq9Gv3D04qyEIcONcY5vOzu7XfKoSBICZy7w8222EjAsX3sTZxfkjdgV2g
 vNF3kjhYlkKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="334095052"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga007.jf.intel.com with ESMTP; 09 Aug 2020 19:44:48 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com
Subject: [PATCH v4 0/4] Modularization of DFL private feature drivers
Date:   Mon, 10 Aug 2020 10:41:09 +0800
Message-Id: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset makes it possible to develop independent driver modules
for DFL private features. It also helps to leverage existing kernel
drivers to enable some IP blocks in DFL.

Patch #1: An improvement of feature id definition. The feature id will be
          used as the key field for dfl device/driver matching.
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

Xu Yilun (4):
  fpga: dfl: change data type of feature id to u16
  fpga: dfl: map feature mmio resources in their own feature drivers
  fpga: dfl: create a dfl bus type to support DFL devices
  fpga: dfl: add support for N3000 Nios private feature

 Documentation/ABI/testing/sysfs-bus-dfl            |  15 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  18 +
 Documentation/fpga/dfl-n3000-nios.rst              |  41 ++
 Documentation/fpga/index.rst                       |   1 +
 drivers/fpga/Kconfig                               |  12 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-fme-perf.c                        |   2 +-
 drivers/fpga/dfl-n3000-nios.c                      | 475 +++++++++++++++++++++
 drivers/fpga/dfl-pci.c                             |  24 +-
 drivers/fpga/dfl.c                                 | 473 ++++++++++++++++----
 drivers/fpga/dfl.h                                 | 102 ++++-
 11 files changed, 1062 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
 create mode 100644 drivers/fpga/dfl-n3000-nios.c

-- 
2.7.4

