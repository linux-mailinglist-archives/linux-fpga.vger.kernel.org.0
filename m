Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79442E8633
	for <lists+linux-fpga@lfdr.de>; Sat,  2 Jan 2021 04:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbhABDS0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 1 Jan 2021 22:18:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:61870 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbhABDS0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 1 Jan 2021 22:18:26 -0500
IronPort-SDR: qjA8qy3mewSgDS1HHKS0070V6yvQngt9/oKkqLt94DG0wIXFOqx86RLfZhqbB4N6io4WHFxf+p
 b2lFpD4WH0sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="176026807"
X-IronPort-AV: E=Sophos;i="5.78,469,1599548400"; 
   d="scan'208";a="176026807"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2021 19:17:45 -0800
IronPort-SDR: 095pgWAvMhu4qR4CgL0Gfz9exizmAlKf5gStfNfX7QrJwYXKCfyP8Q0QJ62vVVhXlQ5FUxTwtT
 ZYo/z1Cbp2uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,469,1599548400"; 
   d="scan'208";a="349085227"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jan 2021 19:17:44 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v5 0/2] UIO support for dfl devices
Date:   Sat,  2 Jan 2021 11:13:00 +0800
Message-Id: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset supports some dfl device drivers written in userspace.

In the patchset v1, the "driver_override" interface should be used to bind
the DFL UIO driver to DFL devices. But there is concern that the
"driver_override" interface is not OK itself.

In v2, we use a new matching algorithem. The "driver_override" interface
is abandoned, the DFL UIO driver matches any DFL device which could not be
handled by other DFL drivers. So the DFL UIO driver could be used for new
DFL devices which are not supported by kernel. The concern is the UIO may
not be suitable as a default/generic driver for all dfl features, such as
features with multiple interrupts.

In v4, we specify each matching device in the id_table of the UIO driver,
just the same as other dfl drivers do. Now the UIO driver supports Ether
Group feature. To support more DFL features, their feature ids should be
added to the driver's id_table.


Main changes from v1:
- switch to the new matching algorithem. It matches DFL devices which could
  not be handled by other DFL drivers.
- refacor the code about device resources filling.
- add the documentation.

Main changes from v2:
- split the match ops changes in dfl.c to an independent patch.
- move the declarations needed for dfl-uio-pdev from include/linux/dfl.h
  to driver/fpga/dfl.h
- some minor fixes.

Main changes from v3:
- switch to specifying each matching device in the driver's id_table.
- refactor the irq handling code.

Main changes from v4:
- refactor the irq handling code.

Xu Yilun (2):
  fpga: dfl: add the userspace I/O device support for DFL devices
  Documentation: fpga: dfl: Add description for DFL UIO support

 Documentation/fpga/dfl.rst  | 24 ++++++++++++
 drivers/fpga/Kconfig        | 10 +++++
 drivers/fpga/Makefile       |  1 +
 drivers/fpga/dfl-uio-pdev.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

-- 
2.7.4

