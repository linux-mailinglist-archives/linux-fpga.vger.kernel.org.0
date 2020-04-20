Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD551B0411
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Apr 2020 10:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDTIOa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Apr 2020 04:14:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:9276 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgDTIO3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 Apr 2020 04:14:29 -0400
IronPort-SDR: tVsAfBjzXL/DjkhvF7WeclRccF3VK6jEUXgxIDdElSOFWdm2XyVgq3PuIe+xU7hvP64M8674+f
 FP1TB8+xh0wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 01:14:29 -0700
IronPort-SDR: 928VVyrwyF4Ptd9nikDiAoRKgwJlZDO/j5DS08oRmCJ6R9wMzYDlBU9PH+FE/dN9+f2cQdaP2K
 J9zxIm41xXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="300218048"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2020 01:14:27 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v5 0/7] Add interrupt support to FPGA DFL drivers
Date:   Mon, 20 Apr 2020 16:11:36 +0800
Message-Id: <1587370303-25568-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset add interrupt support to FPGA DFL drivers.

With these patches, DFL driver will parse and assign interrupt resources
for enumerated feature devices and their sub features.

This patchset also introduces a set of APIs for user to monitor DFL
interrupts. Three sub features (DFL FME error, DFL AFU error and user
interrupt) drivers now support these APIs.

Patch #1: DFL framework change. Accept interrupt info input from DFL bus
          driver, and add interrupt parsing and assignment for feature
          sub devices.
Patch #2: DFL pci driver change, add interrupt info on DFL enumeration.
Patch #3: DFL framework change. Add helper functions for feature sub
          device drivers to handle interrupt and notify users.
Patch #4: Add interrupt support for AFU error reporting sub feature.
Patch #5: Add interrupt support for FME global error reporting sub
          feature.
Patch #6: Add interrupt support for a new sub feature, to handle user
          interrupts implemented in AFU.
Patch #7: Documentation for DFL interrupt handling.

Main changes from v1:
 - Early validating irq table for each feature in parse_feature_irq()
   in Patch #1.
 - Changes IOCTL interfaces. use DFL_FPGA_FME/PORT_XXX_GET_IRQ_NUM
   instead of DFL_FPGA_FME/PORT_XXX_GET_INFO, delete flag field for
   DFL_FPGA_FME/PORT_XXX_SET_IRQ param

Main changes from v2:
 - put parse_feature_irqs() inside create_feature_instance().
 - refines code for dfl_fpga_set_irq_triggers, delete local variable j.
 - put_user() instead of copy_to_user() for DFL_FPGA_XXX_GET_IRQ_NUM IOCTL

Main changes from v3:
 - rebased to 5.7-rc1.
 - fail the dfl enumeration when irq parsing error happens.
 - Add 2 helper functions in dfl.c to handle generic irq ioctls in feature
   drivers.

Main changes from v4:
 - Minor fixes for Hao's comments.

Xu Yilun (7):
  fpga: dfl: parse interrupt info for feature devices on enumeration
  fpga: dfl: pci: add irq info for feature devices enumeration
  fpga: dfl: introduce interrupt trigger setting API
  fpga: dfl: afu: add interrupt support for port error reporting
  fpga: dfl: fme: add interrupt support for global error reporting
  fpga: dfl: afu: add AFU interrupt support
  Documentation: fpga: dfl: add descriptions for interrupt related
    interfaces.

 Documentation/fpga/dfl.rst    |  19 +++
 drivers/fpga/dfl-afu-error.c  |  17 +++
 drivers/fpga/dfl-afu-main.c   |  32 +++++
 drivers/fpga/dfl-fme-error.c  |  18 +++
 drivers/fpga/dfl-fme-main.c   |   6 +
 drivers/fpga/dfl-pci.c        |  80 +++++++++--
 drivers/fpga/dfl.c            | 310 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h            |  57 ++++++++
 include/uapi/linux/fpga-dfl.h |  82 +++++++++++
 9 files changed, 612 insertions(+), 9 deletions(-)

-- 
2.7.4

