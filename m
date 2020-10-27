Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E029A7D2
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Oct 2020 10:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509909AbgJ0J2a (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Oct 2020 05:28:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:61920 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509890AbgJ0J2a (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Oct 2020 05:28:30 -0400
IronPort-SDR: fQTKYMViqBHZBEL0SiQXhxUoUrgn7tOA+K8ZcrMfTFHWKUvV07HmUneWNj4dAD2cGXlPsQ+YMc
 nGRpXf1d09Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="229687692"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="229687692"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 02:28:29 -0700
IronPort-SDR: TMVM2qPXbk7VDF/uDowBu/tRSOEHu+QP1cEVizTvVAt+5jpPd+EWfqL/MVG3WI+dJvsKLunb95
 kuRqIIrKFrRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="468233683"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2020 02:28:27 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v11 0/2] add DFL bus support to MODULE_DEVICE_TABLE()
Date:   Tue, 27 Oct 2020 17:22:59 +0800
Message-Id: <1603790581-4487-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

First four patches for DFL driver autoloading is already merged into
Moritz's for-next. These are the remaining 2 patches.


Main changes from v1:
- A new patch (Patch #3) to fix the description.
- Rename the dfl-bus.h to dfl.h
- Updated the MAINTAINERS under FPGA DFL DRIVERS.
- Improve comments and minor fixes.

Main changes from v2:
- Change the bus name from "dfl" to "fpga-dfl", also rename related
  variables, functions ...
- Changes the data type of fpga_dfl_device_id.type from u8 to u16
- Explicitly defines the values of enum fpga_dfl_id_type
- Delete the comments for the valid bits of type & feature_id
- changes MODALIAS format for fpga dfl devices

Main changes from v3:
- Change the bus name back to "dfl".
- Add 2 patches (#5, 6) for dfl drivers.
- Delete the retimer FEC mode configuration via module_parameter for
  Patch #5
- Merge the patch "Make m10_n3000_info static" (https://lore.kernel.org/linux-fpga/52d8411e-13d8-1e91-756d-131802f5f445@huawei.com/T/#t)
  into Patch #5
- Add static prefix for emif attributes macro for Patch #6

Main changes from v9:
- Add the description for struct dfl_device_id in mod_devicetable.h
- Move the dfl.h from include/linux/fpga to include/linux
- some code refactor and minor fixes for dfl-n3000-nios

Main changes from v10:
- use sysfs_emit instead of sprintf for both patches
- rebase to 5.10-rc1

Xu Yilun (2):
  fpga: dfl: add support for N3000 Nios private feature
  memory: dfl-emif: add the DFL EMIF private feature driver

 .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
 MAINTAINERS                                        |   2 +-
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   2 +
 drivers/memory/dfl-emif.c                          | 207 ++++++++
 9 files changed, 892 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 drivers/fpga/dfl-n3000-nios.c
 create mode 100644 drivers/memory/dfl-emif.c

-- 
2.7.4

