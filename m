Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84BE28ED83
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Oct 2020 09:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgJOHVr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Oct 2020 03:21:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:36090 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgJOHVo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Oct 2020 03:21:44 -0400
IronPort-SDR: 9aPL7KCXpOiiS4NSJTVY1QsBZ7osy16G2p+ixZFb4jN4hh4DFYMXRGf0J5C/qsRF7c0ClIfYwK
 87CKB00ibOaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="166344269"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="166344269"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 00:21:43 -0700
IronPort-SDR: xGHhHI41xz1cTqP9navgwRABNt3JcGOwnKy2Dgq4syOh1ePa2sFauPFuJLX8B8JaWzJDXEb5UZ
 j96IqdBWkWLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="531145047"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2020 00:21:39 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v10 0/6] add DFL bus support to MODULE_DEVICE_TABLE()
Date:   Thu, 15 Oct 2020 15:16:27 +0800
Message-Id: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Patch #1 is a fix of the fields in struct dfl_device & dfl_device_id.

Patch #2, 3, 4 add dfl bus support to MODULE_DEVICE_TABLE(), they also
move the necessary definitions in head file to public folders so that
scatter dfl drivers could use them.

Patch #5 is the dfl driver for N3000 Nios private feature, this is the
first use case of dfl bus.

Patch #6 is the dfl driver for DFL EMIF private feature.


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

