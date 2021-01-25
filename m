Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32D303387
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 05:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbhAZE6L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 23:58:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:13133 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbhAYJRV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 04:17:21 -0500
IronPort-SDR: Z0TprXzOShrv3pjnYf4/y6reX4ovBFg9+0XsemwH65fzdE4yU2r0Xn/IRwUo02weYZpRkNeoVb
 YXLVPVH7AOuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="241224924"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="241224924"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 00:53:48 -0800
IronPort-SDR: SDi71bYL6pLFDMKMp/gLPwRdDdOZIO+91gHzTlFn+GUYQSjuGZCWAzmgPcS55DpY6uaIo+Ivcb
 gXFA2NRSv67Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="471979294"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2021 00:53:46 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v9 0/2] UIO support for dfl devices
Date:   Mon, 25 Jan 2021 16:49:21 +0800
Message-Id: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
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

Before v9, we create a "uio_pdrv_genirq" platform device using DFL devices'
resources. Then we leverage the uio_pdrv_genirq driver for UIO support. It
is suggested that we implement a driver in drivers/uio that directly calls
UIO framework APIs. So we implement the uio_dfl driver in v9. The driver
now only binds the ether group feature, which has no irq. So the irq
support is not implemented yet.


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

Main changes from v5:
- fix the res[] zero initialization issue.
- improve the return code for probe().
- some doc improvement.

Main changes from v6:
- use platform_device_register_resndata() for pdev creation.

Main changes from v7:
- some doc fixes.

Main changes from v9:
- switch to add a uio driver in drivers/uio 

Xu Yilun (2):
  uio: uio_dfl: add userspace i/o driver for DFL bus
  Documentation: fpga: dfl: Add description for DFL UIO support

 Documentation/fpga/dfl.rst | 23 ++++++++++++++++
 drivers/uio/Kconfig        | 13 +++++++++
 drivers/uio/Makefile       |  1 +
 drivers/uio/uio_dfl.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 drivers/uio/uio_dfl.c

-- 
2.7.4

