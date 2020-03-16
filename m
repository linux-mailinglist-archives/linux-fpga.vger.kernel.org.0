Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825C9186420
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Mar 2020 05:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgCPETO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Mar 2020 00:19:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:63079 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgCPETN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Mar 2020 00:19:13 -0400
IronPort-SDR: 0egLvg9iIzScUnDfidJ1uN41kFbuh38rmy65l/wmM/BGmjl4ekJFTO4GcSnjjvYVKsANWApK7w
 IPxnv8bBSwhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 21:19:13 -0700
IronPort-SDR: qqKhMkZR/dihWiThgsnpGuua4A2LYMZ14+qcgczyL/vFFtb+8B8fnQQxSXntmbb2vCUuqjtbas
 S3mSyA+2ssQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="417007218"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2020 21:19:12 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 0/7] Add interrupt support to FPGA DFL drivers
Date:   Mon, 16 Mar 2020 12:16:55 +0800
Message-Id: <1584332222-26652-1-git-send-email-yilun.xu@intel.com>
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

Xu Yilun (7):
  fpga: dfl: parse interrupt info for feature devices on enumeration
  fpga: dfl: pci: add irq info for feature devices enumeration
  fpga: dfl: introduce interrupt trigger setting API
  fpga: dfl: afu: add interrupt support for error reporting
  fpga: dfl: fme: add interrupt support for global error reporting
  fpga: dfl: afu: add user interrupt support
  Documentation: fpga: dfl: add descriptions for interrupt related
    interfaces.

 Documentation/fpga/dfl.rst    |  17 +++
 drivers/fpga/dfl-afu-error.c  |  64 +++++++++++
 drivers/fpga/dfl-afu-main.c   |  78 +++++++++++++
 drivers/fpga/dfl-fme-error.c  |  66 +++++++++++
 drivers/fpga/dfl-fme-main.c   |   6 +
 drivers/fpga/dfl-pci.c        |  78 +++++++++++--
 drivers/fpga/dfl.c            | 247 +++++++++++++++++++++++++++++++++++++++++-
 drivers/fpga/dfl.h            |  51 +++++++++
 include/uapi/linux/fpga-dfl.h |  75 +++++++++++++
 9 files changed, 669 insertions(+), 13 deletions(-)

-- 
2.7.4

