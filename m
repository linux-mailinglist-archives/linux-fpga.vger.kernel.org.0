Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64995AE37F
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Sep 2019 08:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393309AbfIJGJq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Sep 2019 02:09:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:9595 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbfIJGJj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 10 Sep 2019 02:09:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 23:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,487,1559545200"; 
   d="scan'208";a="175206844"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2019 23:09:07 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com, gregkh@linuxfoundation.org,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v6 1/3] Documentation: fpga: dfl: add descriptions for thermal/power management interfaces
Date:   Tue, 10 Sep 2019 13:50:38 +0800
Message-Id: <1568094640-4920-2-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568094640-4920-1-git-send-email-hao.wu@intel.com>
References: <1568094640-4920-1-git-send-email-hao.wu@intel.com>
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
 Documentation/fpga/dfl.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 6fa483f..094fc8a 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -108,6 +108,16 @@ More functions are exposed through sysfs
      error reporting sysfs interfaces allow user to read errors detected by the
      hardware, and clear the logged errors.
 
+ Power management (dfl_fme_power hwmon)
+     power management hwmon sysfs interfaces allow user to read power management
+     information (power consumption, thresholds, threshold status, limits, etc.)
+     and configure power thresholds for different throttling levels.
+
+ Thermal management (dfl_fme_thermal hwmon)
+     thermal management hwmon sysfs interfaces allow user to read thermal
+     management information (current temperature, thresholds, threshold status,
+     etc.).
+
 
 FIU - PORT
 ==========
-- 
1.8.3.1

