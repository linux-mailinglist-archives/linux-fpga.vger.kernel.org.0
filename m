Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37281D5AF2
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Oct 2019 08:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfJNGBB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Oct 2019 02:01:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:8288 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfJNGBB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Oct 2019 02:01:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2019 23:01:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,294,1566889200"; 
   d="scan'208";a="396381114"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga006.fm.intel.com with ESMTP; 13 Oct 2019 23:00:59 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com, gregkh@linuxfoundation.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v7 0/3] add thermal/power management features for FPGA DFL drivers
Date:   Mon, 14 Oct 2019 13:42:00 +0800
Message-Id: <1571031723-12101-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz and all,

This patchset adds thermal and power management features for FPGA DFL
drivers. Both patches are using hwmon as userspace interfaces.

This patchset is created on top of 5.4-rc3, please help with review to see
if any comments, thank you very much!

Main changes from v6:
 - update kernel version and date in sysfs doc.

Main changes from v5:
 - rebase and clean up (remove empty uinit function) per changes in recent
   merged dfl patches.
 - update date in sysfs doc.

Main changes from v4:
 - rebase due to Documentation format change (dfl.txt -> rst).
 - clamp threshold inputs for sysfs interfaces. (patch#3)
 - update sysfs doc to add more description for ltr sysfs interfaces.
   (patch#3)

Main changes from v3:
 - use HWMON_CHANNEL_INFO.

Main changes from v2:
 - switch to standard hwmon APIs for thermal hwmon:
     temp1_alarm        --> temp1_max
     temp1_alarm_status --> temp1_max_alarm
     temp1_crit_status  --> temp1_crit_alarm
     temp1_alarm_policy --> temp1_max_policy
 - switch to standard hwmon APIs for power hwmon:
     power1_cap         --> power1_max
     power1_cap_status  --> power1_max_alarm
     power1_crit_status --> power1_crit_alarm

Wu Hao (2):
  fpga: dfl: fme: add thermal management support
  fpga: dfl: fme: add power management support

Xu Yilun (1):
  Documentation: fpga: dfl: add descriptions for thermal/power
    management interfaces

 Documentation/ABI/testing/sysfs-platform-dfl-fme | 132 ++++++++
 Documentation/fpga/dfl.rst                       |  10 +
 drivers/fpga/Kconfig                             |   2 +-
 drivers/fpga/dfl-fme-main.c                      | 385 +++++++++++++++++++++++
 4 files changed, 528 insertions(+), 1 deletion(-)

-- 
1.8.3.1

