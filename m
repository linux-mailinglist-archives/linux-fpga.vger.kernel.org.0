Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3727776E
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgIXRHX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 13:07:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:17522 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXRHX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Sep 2020 13:07:23 -0400
IronPort-SDR: SfbKEbsCiRoTNqaScPZEv0AwclT0PPsAYPrejYHDjNZgWe0SnckAaA4j0N2rTbqYvMwsNONaBp
 Ln9HVh/mq+qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="222866196"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="222866196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 10:04:47 -0700
IronPort-SDR: +724SjG3N8mCQLuXz3S4NWKHdva+H9XvGhiCXqrkmsyX3ztFXnNkcxsm/vWSgXm4OP6Yli+KxQ
 AY+Y2Jg7RdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="511697020"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2020 10:04:44 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v3 0/5] add DFL bus support to MODULE_DEVICE_TABLE()
Date:   Fri, 25 Sep 2020 00:59:56 +0800
Message-Id: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I will refactor the code for dfl-n3000-nios driver, so just sent the
fpga-dfl bus code this time. fpga-dfl-emif driver could be the first
use case for fpga-dfl bus.

Main changes from v1:
- A new patch (Patch #3) to fix the description.
- Rename the dfl-bus.h to dfl.h
- Updated the MAINTAINERS under FPGA DFL DRIVERS.
- Improve comments and minor fixes.

Main changes from v2:
- Change the bus name from "dfl" to "fpga-dfl", also rename related
  variables, functions ...
- Changes the data type of fpga_dfl_device_id.type from u8 to u16
- Explicitly defines the values of enum fpga_dfl_id_type
- Delete the comments for the valid bits of type & feature_id
- changes MODALIAS format for fpga dfl devices


Xu Yilun (5):
  fpga: dfl: rename the bus type "dfl" to "fpga-dfl"
  fpga: dfl: fix the definitions of type & feature_id for dfl devices
  fpga: dfl: move fpga_dfl_device_id to mod_devicetable.h
  fpga: dfl: add fpga dfl bus support to MODULE_DEVICE_TABLE()
  fpga: dfl: move fpga dfl bus related APIs to include/linux/fpga/dfl.h

 Documentation/ABI/testing/sysfs-bus-dfl      |  15 --
 Documentation/ABI/testing/sysfs-bus-fpga-dfl |  15 ++
 MAINTAINERS                                  |   3 +-
 drivers/fpga/dfl.c                           | 256 ++++++++++++++-------------
 drivers/fpga/dfl.h                           |  89 +---------
 include/linux/fpga/dfl.h                     |  87 +++++++++
 include/linux/mod_devicetable.h              |  12 ++
 scripts/mod/devicetable-offsets.c            |   4 +
 scripts/mod/file2alias.c                     |  13 ++
 9 files changed, 265 insertions(+), 229 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
 create mode 100644 Documentation/ABI/testing/sysfs-bus-fpga-dfl
 create mode 100644 include/linux/fpga/dfl.h

-- 
2.7.4

