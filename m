Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF129710CF
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Jul 2019 07:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfGWFJ4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Jul 2019 01:09:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:1853 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731849AbfGWFJz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 23 Jul 2019 01:09:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 22:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,297,1559545200"; 
   d="scan'208";a="196992280"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jul 2019 22:09:54 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v3 00/12] FPGA DFL updates
Date:   Tue, 23 Jul 2019 12:51:23 +0800
Message-Id: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg

This is v3 patchset which adds more features to FPGA DFL. This patchset
is made on top of patch[1] and 5.3-rc1 tree. Documentation patch for DFL
is added back to this patchset

Main changes from v2:
  - update kernel version/date in sysfs doc (patch #4, #5, #8, #10, #11).
  - add back Documentation patch (patch #12).

Main changes from v1:
  - remove DRV/MODULE_VERSION modifications. (patch #1, #3, #4, #6)
  - remove argsz from new ioctls. (patch #2)
  - replace sysfs_create/remove_* with device_add/remove_* for sysfs entries.
    (patch #5, #8, #11)

[1] [PATCH] fpga: dfl: use driver core functions, not sysfs ones.
    https://lkml.org/lkml/2019/7/4/36

Wu Hao (12):
  fpga: dfl: fme: support 512bit data width PR
  fpga: dfl: fme: add DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
  fpga: dfl: pci: enable SRIOV support.
  fpga: dfl: afu: add AFU state related sysfs interfaces
  fpga: dfl: afu: add userclock sysfs interfaces.
  fpga: dfl: add id_table for dfl private feature driver
  fpga: dfl: afu: export __port_enable/disable function.
  fpga: dfl: afu: add error reporting support.
  fpga: dfl: afu: add STP (SignalTap) support
  fpga: dfl: fme: add capability sysfs interfaces
  fpga: dfl: fme: add global error reporting support
  Documentation: fpga: dfl: add descriptions for virtualization and new
    interfaces.

 Documentation/ABI/testing/sysfs-platform-dfl-fme  |  98 ++++++
 Documentation/ABI/testing/sysfs-platform-dfl-port | 104 ++++++
 Documentation/fpga/dfl.rst                        | 105 ++++++
 drivers/fpga/Makefile                             |   3 +-
 drivers/fpga/dfl-afu-error.c                      | 225 +++++++++++++
 drivers/fpga/dfl-afu-main.c                       | 328 +++++++++++++++++-
 drivers/fpga/dfl-afu.h                            |   7 +
 drivers/fpga/dfl-fme-error.c                      | 385 ++++++++++++++++++++++
 drivers/fpga/dfl-fme-main.c                       |  93 +++++-
 drivers/fpga/dfl-fme-mgr.c                        | 110 ++++++-
 drivers/fpga/dfl-fme-pr.c                         |  50 ++-
 drivers/fpga/dfl-fme.h                            |   7 +-
 drivers/fpga/dfl-pci.c                            |  39 +++
 drivers/fpga/dfl.c                                | 166 +++++++++-
 drivers/fpga/dfl.h                                |  54 ++-
 include/uapi/linux/fpga-dfl.h                     |  19 ++
 16 files changed, 1722 insertions(+), 71 deletions(-)
 create mode 100644 drivers/fpga/dfl-afu-error.c
 create mode 100644 drivers/fpga/dfl-fme-error.c

-- 
1.8.3.1

