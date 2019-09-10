Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A4AAE373
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Sep 2019 08:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393240AbfIJGJi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Sep 2019 02:09:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:9595 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbfIJGJh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 10 Sep 2019 02:09:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 23:09:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,487,1559545200"; 
   d="scan'208";a="175206824"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2019 23:09:04 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com, gregkh@linuxfoundation.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v6 0/3] add thermal/power management features for FPGA DFL drivers
Date:   Tue, 10 Sep 2019 13:50:37 +0800
Message-Id: <1568094640-4920-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Mortiz and all,

This patchset adds thermal and power management features for FPGA DFL
drivers. Both patches are using hwmon as userspace interfaces.

As previous dfl patches have been merged, so I resubmit this one after
rebase and clean up, as dependency is resolved now.
(This patchset is generated against char-misc-next).

Please help with review to see if any comments, thank you very much!

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

 Documentation/ABI/testing/sysfs-platform-dfl-fme | 134 ++++++++
 Documentation/fpga/dfl.rst                       |  10 +
 drivers/fpga/Kconfig                             |   2 +-
 drivers/fpga/dfl-fme-main.c                      | 385 +++++++++++++++++++++++
 4 files changed, 530 insertions(+), 1 deletion(-)

-- 
1.8.3.1

