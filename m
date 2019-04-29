Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34BB0DF11
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Apr 2019 11:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfD2JOG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Apr 2019 05:14:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:32623 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfD2JMi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 29 Apr 2019 05:12:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 02:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="165988173"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2019 02:12:34 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 00/18] add new features for FPGA DFL drivers
Date:   Mon, 29 Apr 2019 16:55:33 +0800
Message-Id: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset adds more features support for FPGA Device Feature List
(DFL) drivers, including PR enhancement, virtualization support based
on PCIe SRIOV, private features to Port, private features to FME, and
enhancement to DFL framework. Please refer to details in below list.

Main changes from v1:
 - split the clean up code in a separated patch (patch #2)
 - add cpu_feature_enabled check for AVX512 code (patch #4)
 - improve sysfs return values and also sysfs doc (patch #12 #17)
 - create a hwmon for thermal management sysfs interfaces (patch #15)
 - create a hwmon for power management sysfs interfaces (patch #16)
 - update docmentation according to above changes (patch #5)
 - improve sysfs doc for performance reporting support (patch #18)

Wu Hao (18):
  fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register address.
  fpga: dfl: fme: remove copy_to_user() in ioctl for PR
  fpga: dfl: fme: align PR buffer size per PR datawidth
  fpga: dfl: fme: support 512bit data width PR
  Documentation: fpga: dfl: add descriptions for virtualization and new
    interfaces.
  fpga: dfl: fme: add DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
  fpga: dfl: pci: enable SRIOV support.
  fpga: dfl: afu: add AFU state related sysfs interfaces
  fpga: dfl: afu: add userclock sysfs interfaces.
  fpga: dfl: add id_table for dfl private feature driver
  fpga: dfl: afu: export __port_enable/disable function.
  fpga: dfl: afu: add error reporting support.
  fpga: dfl: afu: add STP (SignalTap) support
  fpga: dfl: fme: add capability sysfs interfaces
  fpga: dfl: fme: add thermal management support
  fpga: dfl: fme: add power management support
  fpga: dfl: fme: add global error reporting support
  fpga: dfl: fme: add performance reporting support

 Documentation/ABI/testing/sysfs-platform-dfl-fme  | 322 ++++++++
 Documentation/ABI/testing/sysfs-platform-dfl-port | 104 +++
 Documentation/fpga/dfl.txt                        | 114 +++
 drivers/fpga/Kconfig                              |   2 +-
 drivers/fpga/Makefile                             |   4 +-
 drivers/fpga/dfl-afu-error.c                      | 225 +++++
 drivers/fpga/dfl-afu-main.c                       | 335 +++++++-
 drivers/fpga/dfl-afu.h                            |   7 +
 drivers/fpga/dfl-fme-error.c                      | 385 +++++++++
 drivers/fpga/dfl-fme-main.c                       | 583 ++++++++++++-
 drivers/fpga/dfl-fme-mgr.c                        | 117 ++-
 drivers/fpga/dfl-fme-perf.c                       | 950 ++++++++++++++++++++++
 drivers/fpga/dfl-fme-pr.c                         |  65 +-
 drivers/fpga/dfl-fme.h                            |   9 +-
 drivers/fpga/dfl-pci.c                            |  40 +
 drivers/fpga/dfl.c                                | 170 +++-
 drivers/fpga/dfl.h                                |  56 +-
 include/uapi/linux/fpga-dfl.h                     |  32 +
 18 files changed, 3439 insertions(+), 81 deletions(-)
 create mode 100644 drivers/fpga/dfl-afu-error.c
 create mode 100644 drivers/fpga/dfl-fme-error.c
 create mode 100644 drivers/fpga/dfl-fme-perf.c

-- 
1.8.3.1

