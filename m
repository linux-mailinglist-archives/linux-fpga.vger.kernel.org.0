Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A742FF363
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Jan 2021 19:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbhAUIlc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Jan 2021 03:41:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:23355 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbhAUIkK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 21 Jan 2021 03:40:10 -0500
IronPort-SDR: 9EirF5JO0HpOKAYeRABxLlZEDmB+WpED3d4m/hrbr+dfwMmBc7wMQ0hRksFtQB44jvA5kM5o7W
 T1SLrdY0ouFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166908458"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="166908458"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 00:39:24 -0800
IronPort-SDR: hNGaiVZhrwzcezD89Yi38zIrGN3TKMza0SoVQbss1XNbns7Nmyb5HZ8hD/k6hEHm/4vLQPGxbr
 SRV6Pt6TKuPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="385215614"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2021 00:39:22 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, rdunlap@infradead.org
Subject: [PATCH v8 0/2] UIO support for dfl devices
Date:   Thu, 21 Jan 2021 16:34:43 +0800
Message-Id: <1611218085-28269-1-git-send-email-yilun.xu@intel.com>
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

Main changes from v7:
- some doc fixes.

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

