Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD3E30A216
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 07:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhBAGl5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 01:41:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:18875 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhBAFoS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Feb 2021 00:44:18 -0500
IronPort-SDR: volI8jdy5xJ4Zq9umLRaYteI5xPNsNNfCW4DBztdvTHnWFArKJ8eHO2+VDudufhI90yTJQFkVq
 gG+vXT8utdzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="177129262"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="177129262"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 21:42:43 -0800
IronPort-SDR: itu2IGicX6+7V3nM7Esr3w9v2srGIS4PpMNxcmycDOPca7ADygASEjZXgUkN4l6EIrYshqzMVS
 AcxXaC0dRDWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="368973502"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2021 21:42:37 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v10 0/2] UIO support for dfl devices
Date:   Mon,  1 Feb 2021 13:38:01 +0800
Message-Id: <1612157883-18616-1-git-send-email-yilun.xu@intel.com>
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

Main changes from v8:
- switch to add a uio driver in drivers/uio

Main changes from v9:
- add this source file in MAINTAINERS
- improve the Kconfig, add more descriptive Kconfig header, add detailed
  path for opae uio example in Kconfig.


Xu Yilun (2):
  uio: uio_dfl: add userspace i/o driver for DFL bus
  Documentation: fpga: dfl: Add description for DFL UIO support

 Documentation/fpga/dfl.rst | 23 ++++++++++++++++
 MAINTAINERS                |  1 +
 drivers/uio/Kconfig        | 17 ++++++++++++
 drivers/uio/Makefile       |  1 +
 drivers/uio/uio_dfl.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+)
 create mode 100644 drivers/uio/uio_dfl.c

-- 
2.7.4

