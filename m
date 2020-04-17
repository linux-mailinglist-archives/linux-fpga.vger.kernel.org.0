Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30AF1AD5E0
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Apr 2020 08:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgDQGBw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Apr 2020 02:01:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:54126 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgDQGBv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 17 Apr 2020 02:01:51 -0400
IronPort-SDR: YXBbX3P8Exyf17PXjrDl0/WT6gneLcwTB7i51FP1Zw9F5p74CCqqwZYOj6Caw4O0W1K3GIYRzK
 1LWBY35TWbrQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 23:01:51 -0700
IronPort-SDR: qs/5JrKYhI5fjKMKNid/BnUiMqTRYtpN7CI4cWdzotGHs1aG5KkPVKMMBIatdivZOOVpGG0uHk
 S8pw/ojxwjKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="272318270"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2020 23:01:48 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     will@kernel.org, mdf@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        trix@redhat.com, bhu@redhat.com, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v9 0/2] add performance reporting support to FPGA DFL drivers
Date:   Fri, 17 Apr 2020 13:39:58 +0800
Message-Id: <1587102000-18262-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi all,

This patchset adds performance reporting support for FPGA DFL drivers. It
introduces one pmu to expose userspace interfaces via standard perf API.
User could use standard perf tool to access perf events exposed via pmu.

This patchset is generated based on 5.7-rc1.

Main changes from v8:
 - rebase against 5.7-rc1.

Main changes from v7:
 - rename pmu name from "fme%d" to "dfl_fme%d".
 - monitor cpu hotplug for cpumask sysfs and update cpumask sysfs doc.
 - add extra read for 64bit counter registers to avoid 2-32bit readl issue.

Main changes from v6:
 - add a new ABI/testing/ sysfs documentation in patch #2.
 - fix a warning reported by kbuild in patch #2.

Main changes from v5:
 - use dev_ext_attribute instead of fme_perf_event_attr.
 - use is_visible function to decide which events to expose per
   hardware capability, and add event_init checking for all events.

Main changes from v4:
 - rebase and clean up.
 - update Kconfig for PERF_EVENTS dependency.

Main changes from v3:
 - add more descriptions in doc, including how to use perf tool for these
   hardware counters. (patch #1)
 - use standard perf API instead of sysfs entries. (patch #2)

Wu Hao (1):
  fpga: dfl: fme: add performance reporting support

Xu Yilun (1):
  Documentation: fpga: dfl: add description for performance reporting
    support

 .../testing/sysfs-bus-event_source-devices-dfl_fme |  104 ++
 Documentation/fpga/dfl.rst                         |   84 ++
 drivers/fpga/Kconfig                               |    2 +-
 drivers/fpga/Makefile                              |    1 +
 drivers/fpga/dfl-fme-main.c                        |    4 +
 drivers/fpga/dfl-fme-perf.c                        | 1020 ++++++++++++++++++++
 drivers/fpga/dfl-fme.h                             |    2 +
 drivers/fpga/dfl.h                                 |    2 +
 8 files changed, 1218 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
 create mode 100644 drivers/fpga/dfl-fme-perf.c

-- 
1.8.3.1

