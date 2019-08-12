Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA1989589
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Aug 2019 05:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHLDHr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Aug 2019 23:07:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:12631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfHLDHq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Aug 2019 23:07:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 20:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,375,1559545200"; 
   d="scan'208";a="199987451"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2019 20:07:44 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v5 0/9] FPGA DFL updates
Date:   Mon, 12 Aug 2019 10:49:55 +0800
Message-Id: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

This is v5 patchset which adds more features to FPGA DFL. Marjor changes
against v4 are sysfs related code rework to address comments on v4.

Please help to take a look. Thanks!

Main changes from v4:
  - convert code to use dev_groups for sysfs entries (#2, #3, #4, #6, #8).
  - clean up for empty init function after remove sysfs add/remove (#1).
  - introduce is_visible for sysfs groups (#3, #4, #6, #8).
  - remove revision sysfs entries (#4, #6, #8).
  - improve naming on shared functions (#5).
  - reorganize sysfs entries for port and fme error reporting (#6, #8).

Main changes from v3:
  - drop avx512 partail reconfiguration patch for now.
  - split dfl_fpga_cdev_config_port to 2 functions *_release/assign_port
    (#1).
  - split __dfl_fpga_cdev_config_port_vf into 2 functions with locking
    added (#2).
  - improve description in sysfs doc to avoid misunderstanding (#3).
  - switch to boolean in sysfs entry store function (#3).
  - remove dev_dbg in init/uinit callback function (#7, #9, #11).
  - remove uinit callback which does does nothing (#8, #9)

Main changes from v2:
  - update kernel version/date in sysfs doc (patch #4, #5, #8, #10, #11).
  - add back Documentation patch (patch #12).

Main changes from v1:
  - remove DRV/MODULE_VERSION modifications. (patch #1, #3, #4, #6)
  - remove argsz from new ioctls. (patch #2)
  - replace sysfs_create/remove_* with device_add/remove_* for sysfs entries.
    (patch #5, #8, #11)

Wu Hao (9):
  fpga: dfl: make init callback optional
  fpga: dfl: fme: convert platform_driver to use dev_groups
  fpga: dfl: afu: convert platform_driver to use dev_groups
  fpga: dfl: afu: add userclock sysfs interfaces.
  fpga: dfl: afu: expose __afu_port_enable/disable function.
  fpga: dfl: afu: add error reporting support.
  fpga: dfl: afu: add STP (SignalTap) support
  fpga: dfl: fme: add global error reporting support
  Documentation: fpga: dfl: add descriptions for virtualization and new
    interfaces.

 Documentation/ABI/testing/sysfs-platform-dfl-fme  |  62 ++++
 Documentation/ABI/testing/sysfs-platform-dfl-port |  53 ++++
 Documentation/fpga/dfl.rst                        | 105 +++++++
 drivers/fpga/Makefile                             |   3 +-
 drivers/fpga/dfl-afu-error.c                      | 230 ++++++++++++++
 drivers/fpga/dfl-afu-main.c                       | 230 +++++++++++---
 drivers/fpga/dfl-afu.h                            |   9 +
 drivers/fpga/dfl-fme-error.c                      | 359 ++++++++++++++++++++++
 drivers/fpga/dfl-fme-main.c                       |  42 +--
 drivers/fpga/dfl-fme.h                            |   3 +
 drivers/fpga/dfl.c                                |  10 +-
 drivers/fpga/dfl.h                                |   9 +
 12 files changed, 1041 insertions(+), 74 deletions(-)
 create mode 100644 drivers/fpga/dfl-afu-error.c
 create mode 100644 drivers/fpga/dfl-fme-error.c

-- 
1.8.3.1

