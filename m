Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9B2AFF66
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Nov 2020 06:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgKLFqt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Nov 2020 00:46:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:12576 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKLFqs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 12 Nov 2020 00:46:48 -0500
IronPort-SDR: 9cAOnGnBIWUN5qQQ1BJf9PWv+CHQWVzYK3hbqbQt79Tqp1O16fTfh2i8saNwbjmpFiNUgUp8/w
 gYNaV6SfkwbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="169477667"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="169477667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 21:46:47 -0800
IronPort-SDR: 3BjhBd5kV9TnEUf/I1O2BUi9x9dBcGwrpc4B+YR0RCTpK/COPib3PNll1lf8ikjUJ3P1IPpV49
 76ZF531OWHLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="328367937"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2020 21:46:44 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v13 0/6] add DFL bus support to MODULE_DEVICE_TABLE()
Date:   Thu, 12 Nov 2020 13:42:33 +0800
Message-Id: <1605159759-3439-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

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

Main changes from v11:
- Fix the type of driver_data from unsigned long to kernel_ulong_t
- Fixed up header guards to match filename by Moritz
- move the MODULE_DEVICE_TABLE() right after its definition

Main changes from v12:
- For patch #5, fix the wrong use of logical'||', should use '|'

Xu Yilun (6):
  fpga: dfl: fix the definitions of type & feature_id for dfl devices
  fpga: dfl: move dfl_device_id to mod_devicetable.h
  fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
  fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
  fpga: dfl: add support for N3000 Nios private feature
  memory: dfl-emif: add the DFL EMIF private feature driver

 .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
 MAINTAINERS                                        |   3 +-
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
 drivers/fpga/dfl.c                                 |   4 +-
 drivers/fpga/dfl.h                                 |  85 +--
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   2 +
 drivers/memory/dfl-emif.c                          | 207 ++++++++
 include/linux/dfl.h                                |  86 +++
 include/linux/mod_devicetable.h                    |  24 +
 scripts/mod/devicetable-offsets.c                  |   4 +
 scripts/mod/file2alias.c                           |  13 +
 15 files changed, 1023 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 drivers/fpga/dfl-n3000-nios.c
 create mode 100644 drivers/memory/dfl-emif.c
 create mode 100644 include/linux/dfl.h

-- 
2.7.4

