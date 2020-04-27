Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF831B94F1
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Apr 2020 03:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgD0B2l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 26 Apr 2020 21:28:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:7235 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgD0B2l (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 26 Apr 2020 21:28:41 -0400
IronPort-SDR: sdfhW7e5DVaNfpK9ALhIw1kR1t9/vGKWZOdL7/qyRGp5dcNla9wonJP4Bvsl9MRba38gl5bJMc
 Tq3aedzKVzOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 18:28:40 -0700
IronPort-SDR: jhm8ZNG/VEGtwVKT4QNRNsKMaqzmn7DEYKZUp+4A3ZUQvdUU4zZbBrIoloGIrKsFg7C900ps5B
 3EVmfHEu8MsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,321,1583222400"; 
   d="scan'208";a="257060223"
Received: from hao-dev.bj.intel.com ([10.238.157.66])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2020 18:28:21 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     will@kernel.org, mdf@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        trix@redhat.com, bhu@redhat.com, rdunlap@infradead.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v10 0/2] add performance reporting support to FPGA DFL drivers
Date:   Mon, 27 Apr 2020 09:06:21 +0800
Message-Id: <1587949583-12058-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi all,

This patchset adds performance reporting support for FPGA DFL drivers. It
introduces one pmu to expose userspace interfaces via standard perf API.
User could use standard perf tool to access perf events exposed via pmu.


Main changes from v9:
 - fix Randy's comments on documentation in patch #1.

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

