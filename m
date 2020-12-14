Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD02D9212
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 04:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438378AbgLNDlt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Dec 2020 22:41:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:46083 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgLNDlm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 13 Dec 2020 22:41:42 -0500
IronPort-SDR: p1QKkcJXgXsslXXLzLYEpXNgfZNb2Dm9TivSBfjN652S0ChF3NZH2wzJu4KhB3hhugbKkJdlLu
 M1QcJYCFazYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="161700349"
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="161700349"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 19:40:42 -0800
IronPort-SDR: Q0PNYYqksMTlZh/UWU4lYUnXXPgjZHF+4DmbWubbWOf7IC5bO4Jxs/BGfPHUXGTTTIQYmBHFLF
 7ztQF4Z8SUxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="331722939"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2020 19:40:40 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v2 0/2] UIO support for dfl devices
Date:   Mon, 14 Dec 2020 11:36:19 +0800
Message-Id: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset supports some dfl device drivers written in userspace.

In the patchset v1, the "driver_override" interface should be used to bind
the DFL UIO driver to DFL devices. But there is concern that the
"driver_override" interface is not OK itself. So in v2, we use a new
matching algorithem. The "driver_override" interface is abandoned, the DFL
UIO driver matches any DFL device which could not be handled by other DFL
drivers. So the DFL UIO driver could be used for new DFL devices which are
not supported by kernel, also it will not impact the devices which are
already got supported.

Main changes from v1:
- switch to the new matching algorithem. It matches DFL devices which could
  not be handled by other DFL drivers.
- refacor the code about device resources filling.
- add the documentation.


Xu Yilun (2):
  fpga: dfl: add the userspace I/O device support for DFL devices
  Documentation: fpga: dfl: Add description for DFL UIO support

 Documentation/fpga/dfl.rst  |  23 ++++++++++
 drivers/fpga/Kconfig        |  10 ++++
 drivers/fpga/Makefile       |   1 +
 drivers/fpga/dfl-uio-pdev.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.c          |  22 +++++++--
 include/linux/dfl.h         |   7 +++
 6 files changed, 166 insertions(+), 5 deletions(-)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

-- 
2.7.4

