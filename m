Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638ED156E5C
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Feb 2020 05:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBJEJb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Feb 2020 23:09:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:30804 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgBJEJb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 9 Feb 2020 23:09:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 20:09:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,423,1574150400"; 
   d="scan'208";a="251069331"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2020 20:09:27 -0800
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, will@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v7 0/2] add performance reporting support to FPGA DFL drivers
Date:   Mon, 10 Feb 2020 11:47:47 +0800
Message-Id: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi all,

This patchset adds performance reporting support for FPGA DFL drivers. It
introduces one pmu to expose userspace interfaces via standard perf API.
User could use standard perf tool to access perf events exposed via pmu.

This patchset is generated based on 5.6-rc1.

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

 .../ABI/testing/sysfs-bus-event_source-devices-fme | 105 +++
 Documentation/fpga/dfl.rst                         |  83 ++
 drivers/fpga/Kconfig                               |   2 +-
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/dfl-fme-main.c                        |   4 +
 drivers/fpga/dfl-fme-perf.c                        | 943 +++++++++++++++++++++
 drivers/fpga/dfl-fme.h                             |   2 +
 drivers/fpga/dfl.h                                 |   2 +
 8 files changed, 1141 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-fme
 create mode 100644 drivers/fpga/dfl-fme-perf.c

-- 
1.8.3.1

