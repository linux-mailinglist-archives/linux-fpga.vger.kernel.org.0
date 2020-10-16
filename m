Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2880F28FE07
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Oct 2020 08:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391793AbgJPGHk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Oct 2020 02:07:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:40084 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390603AbgJPGHk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Oct 2020 02:07:40 -0400
IronPort-SDR: 2tg3TQ4+aVjNYuNJIJo/cEhIcNka7SaGcsGqW3DBReEBy2sVWqSalpnjRW/p/lMzV1u87S1xN1
 LxIiRnZ6IOvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="163917489"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="163917489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 23:07:39 -0700
IronPort-SDR: SbbUAAUATLePr7e/0XbkWqAkiOeIHxeCHar/uXW6fHF75/ENJRqBiwe0RRRoXfsUf9jkZvCuyw
 ZAbqy/B+XFuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="464576870"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 15 Oct 2020 23:07:36 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH 0/2] UIO support for dfl devices
Date:   Fri, 16 Oct 2020 14:02:29 +0800
Message-Id: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset supports some dfl device drivers written in userspace.

The usage is like:

 # echo dfl_dev.1 > /sys/bus/dfl/drivers/<kernel driver>/unbind
 # echo dfl-uio-pdev > /sys/bus/dfl/devices/dfl_dev.1/driver_override
 # echo dfl_dev.1 > /sys/bus/dfl/drivers_probe


Xu Yilun (2):
  fpga: dfl: add driver_override support
  fpga: dfl: add the userspace I/O device support for DFL devices

 Documentation/ABI/testing/sysfs-bus-dfl | 28 +++++++++--
 drivers/fpga/Kconfig                    | 10 ++++
 drivers/fpga/Makefile                   |  1 +
 drivers/fpga/dfl-uio-pdev.c             | 83 +++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.c                      | 54 ++++++++++++++++++++-
 include/linux/dfl.h                     |  2 +
 6 files changed, 173 insertions(+), 5 deletions(-)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

-- 
2.7.4

