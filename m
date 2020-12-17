Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D132DCC34
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 06:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgLQFts (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 00:49:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:50404 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgLQFts (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 00:49:48 -0500
IronPort-SDR: CjVkK8LFRtrsJeMWyIMxxzUg09+CCZnqq4NVngcNu8bPeHzK12PUi5QdaO/SuIAVcWgRT+h3in
 F+dmuVD3bdVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="162244236"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="162244236"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 21:49:07 -0800
IronPort-SDR: Jr3Yygu8aUeG2ghESKk5EVZD+IGjS6eUdgEtesW03qMN1Npc27X9GoVBDDz6VVnqbtuUq1QVcd
 ZwzEHyqh8GSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="339047170"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2020 21:49:05 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v3 0/3] UIO support for dfl devices
Date:   Thu, 17 Dec 2020 13:44:38 +0800
Message-Id: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
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

Main changes from v2:
- split the match ops changes in dfl.c to an independent patch.
- move the declarations needed for dfl-uio-pdev from include/linux/dfl.h
  to driver/fpga/dfl.h
- some minor fixes.


Xu Yilun (3):
  fpga: dfl: add the match() ops for dfl driver
  fpga: dfl: add the userspace I/O device support for DFL devices
  Documentation: fpga: dfl: Add description for DFL UIO support

 Documentation/fpga/dfl.rst  |  27 +++++++++++
 drivers/fpga/Kconfig        |  10 ++++
 drivers/fpga/Makefile       |   1 +
 drivers/fpga/dfl-uio-pdev.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.c          |  22 +++++++--
 drivers/fpga/dfl.h          |   5 ++
 include/linux/dfl.h         |   3 ++
 7 files changed, 173 insertions(+), 5 deletions(-)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

-- 
2.7.4

