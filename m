Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50C52AE97
	for <lists+linux-fpga@lfdr.de>; Mon, 27 May 2019 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfE0G1D (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 May 2019 02:27:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:4773 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfE0G1C (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 May 2019 02:27:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 23:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,518,1549958400"; 
   d="scan'208";a="178751993"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga002.fm.intel.com with ESMTP; 26 May 2019 23:26:58 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, linux-fpga@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v3 1/3] Documentation: fpga: dfl: add descriptions for thermal/power management interfaces
Date:   Mon, 27 May 2019 14:06:54 +0800
Message-Id: <1558937216-12742-2-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558937216-12742-1-git-send-email-hao.wu@intel.com>
References: <1558937216-12742-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>

This patch add introductions to thermal/power interfaces. They are
implemented as hwmon sysfs interfaces by thermal/power private
feature drivers.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 Documentation/fpga/dfl.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/fpga/dfl.txt b/Documentation/fpga/dfl.txt
index 9e912a0..d377e36 100644
--- a/Documentation/fpga/dfl.txt
+++ b/Documentation/fpga/dfl.txt
@@ -109,6 +109,15 @@ More functions are exposed through sysfs
      performance counters sysfs interfaces allow user to use different counters
      to get performance data.
 
+ Power management (dfl_fme_power hwmon)
+     power management hwmon sysfs interfaces allow user to read power management
+     information (power consumption, thresholds, threshold status, limits, etc.)
+     and and configure power thresholds for different throttling levels.
+
+ Thermal management (dfl_fme_thermal hwmon)
+     thermal management hwmon sysfs interfaces allow user to read thermal
+     management information (current temperature, thresholds, threshold status,
+     etc.).
 
 FIU - PORT
 ==========
-- 
1.8.3.1

