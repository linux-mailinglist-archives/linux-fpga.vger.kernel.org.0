Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C457B56
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Jun 2019 07:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfF0F0m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Jun 2019 01:26:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:36381 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfF0F0m (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 Jun 2019 01:26:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 22:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="183367034"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jun 2019 22:26:40 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, gregkh@linuxfoundation.org,
        atull@kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v4 1/2] Documentation: fpga: dfl: add description for performance reporting support
Date:   Thu, 27 Jun 2019 13:09:54 +0800
Message-Id: <1561612195-6081-2-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561612195-6081-1-git-send-email-hao.wu@intel.com>
References: <1561612195-6081-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>

This patch adds description for performance reporting support for
Device Feature List (DFL) based FPGA.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 Documentation/fpga/dfl.txt | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/fpga/dfl.txt b/Documentation/fpga/dfl.txt
index 652917f..6acd1b5 100644
--- a/Documentation/fpga/dfl.txt
+++ b/Documentation/fpga/dfl.txt
@@ -115,6 +115,11 @@ More functions are exposed through sysfs
      management information (current temperature, thresholds, threshold status,
      etc.).
 
+ Performance reporting
+     performance counters are exposed through perf PMU APIs. Standard perf tool
+     can be used to monitor all available perf events. Please see performance
+     counter section below for more detailed information.
+
 
 FIU - PORT
 ==========
@@ -368,6 +373,84 @@ The device nodes used for ioctl() or mmap() can be referenced through:
 	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
 
 
+Performance Counters
+====================
+Performance reporting is one private feature implemented in FME. It could
+supports several independent, system-wide, device counter sets in hardware to
+monitor and count for performance events, including "basic", "cache", "fabric",
+"vtd" and "vtd_sip" counters. Users could use standard perf tool to monitor
+FPGA cache hit/miss rate, transaction number, interface clock counter of AFU
+and other FPGA performance events.
+
+Different FPGA devices may have different counter sets, it depends on hardware
+implementation. e.g. some discrete FPGA cards don't have any cache. User could
+use "perf list" to check which perf events are supported by target hardware.
+
+In order to allow user to use standard perf API to access these performance
+counters, driver creates a perf PMU, and related sysfs interfaces in
+/sys/bus/event_source/devices/fme* to describe available perf events and
+configuration options.
+
+The "format" directory describes the format of the config field of struct
+perf_event_attr. There are 3 bitfields for config, "evtype" defines which type
+the perf event belongs to. "event" is the identity of the event within its
+category. "portid" is introduced to decide counters set to monitor on FPGA
+overall data or a specific port.
+
+The "events" directory describes the configuration templates for all available
+events which can be used with perf tool directly. For example, fab_mmio_read
+has the configuration "event=0x06,evtype=0x02,portid=0xff", which shows this
+event belongs to fabric type (0x02), the local event id is 0x06 and it is for
+overall monitoring (portid=0xff).
+
+Example usage of perf can be:
+
+$# perf list |grep fme
+
+ fme0/fab_mmio_read/                              [Kernel PMU event]
+<...>
+ fme0/fab_port_mmio_read,portid=?/                [Kernel PMU event]
+<...>
+
+$# perf stat -a -e fme0/fab_mmio_read/ <command>
+or
+$# perf stat -a -e fme0/event=0x06,evtype=0x02,portid=0xff/ <command>
+or
+$# perf stat -a -e fme0/config=0xff2006/ <command>
+
+Another example, fab_port_mmio_read monitors mmio read of a specific port. So
+its configuration template is "event=0x06,evtype=0x01,portid=?". The portid
+should be explicitly set.
+
+Its usage of perf can be:
+
+$# perf stat -a -e fme0/fab_port_mmio_read,portid=0x0/ <command>
+or
+$# perf stat -a -e fme0/event=0x06,evtype=0x02,portid=0x0/ <command>
+or
+$# perf stat -a -e fme0/config=0x2006/ <command>
+
+Please note for fabric counters, overall perf events (fab_*) and port perf
+events (fab_port_*) actually share one set of counters in hardware, so it can't
+monitor both at the same time. If this set of counters is configured to monitor
+overall data, then per port perf data is not supported. See below example.
+
+$# perf stat -e fme0/fab_mmio_read/,fme0/fab_port_mmio_write,\
+                                                    portid=0/ sleep 1
+
+ Performance counter stats for 'system wide':
+
+                 3      fme0/fab_mmio_read/
+   <not supported>      fme0/fab_port_mmio_write,portid=0x0/
+
+       1.001750904 seconds time elapsed
+
+The driver also provides a "cpumask" sysfs attribute, which always shows fixed
+value cpu0 as all perf events are from system-wide counters on FPGA device.
+
+The current driver does not support sampling. So "perf record" is unsupported.
+
+
 Add new FIUs support
 ====================
 It's possible that developers made some new function blocks (FIUs) under this
-- 
1.8.3.1

