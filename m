Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E122FC83A
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Jan 2021 03:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbhATCsr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jan 2021 21:48:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:3806 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbhATCsm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Jan 2021 21:48:42 -0500
IronPort-SDR: eJrHOSSHxl/67oEDfeIzwKH6qGi0oG9GJ27shr0Tk/MPj0WincQOPKTD15FftKxJW3u8urMjPC
 kBA91ad2ZGIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158808445"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="158808445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 18:48:02 -0800
IronPort-SDR: yYxYPxOQpryaQyX48IF100ydQciD5zkiy7sUpgE+uRpSOnl6Tcc4XUCDU1gzWsbEMk2qu3e+0M
 NKdiBODl7tzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="355871039"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 18:48:00 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v7 0/2] UIO support for dfl devices
Date:   Wed, 20 Jan 2021 10:43:24 +0800
Message-Id: <1611110606-10380-1-git-send-email-yilun.xu@intel.com>
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

Main changes from v5:
- fix the res[] zero initialization issue.
- improve the return code for probe().
- some doc improvement.

Main changes from v6:
- use platform_device_register_resndata() for pdev creation.


Xu Yilun (2):
  fpga: dfl: add the userspace I/O device support for DFL devices
  Documentation: fpga: dfl: Add description for DFL UIO support

 Documentation/fpga/dfl.rst  | 25 ++++++++++++++
 drivers/fpga/Kconfig        | 10 ++++++
 drivers/fpga/Makefile       |  1 +
 drivers/fpga/dfl-uio-pdev.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

-- 
2.7.4

