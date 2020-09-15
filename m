Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1F269C90
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 05:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIODc2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 23:32:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:64033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgIODc2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Sep 2020 23:32:28 -0400
IronPort-SDR: /Ff7Sc/2bAMfuFL28DUZnfXGPOCtrvHJofIWhL+lTr+gtO/4/oUfQ80CxImNwwezSyyrKJm9ve
 c8TiUFWwWHUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="244026443"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="244026443"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 20:32:26 -0700
IronPort-SDR: kgHvH0nwnQ+JiW06ax7Jyzv9UWdWRdiaBpic9eRw2HuNDzQTCp7Ql2kUhNUFJ6PWreu1yehA+3
 A1Xwv+DpM8iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="482596385"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2020 20:32:24 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 0/4] add DFL bus support to MODULE_DEVICE_TABLE()
Date:   Tue, 15 Sep 2020 11:27:49 +0800
Message-Id: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Patch #1 and #2 add dfl bus support to MODULE_DEVICE_TABLE(), so that
dfl driver modules could be auto-loaded when dfl devices are added.

Patch #3 is a fix of the description of fields in struct dfl_device.

Patch #4 moves the dfl bus APIs to a new header file in the public
folder so that scattered dfl device drivers could include the common
dfl bus APIs.

Main changes from v1:
- A new patch (Patch #3) to fix the description.
- Rename the dfl-bus.h to dfl.h
- Updated the MAINTAINERS under FPGA DFL DRIVERS.
- Improve comments and minor fixes.

Xu Yilun (4):
  fpga: dfl: move dfl_device_id to mod_devicetable.h
  dfl: add dfl bus support to MODULE_DEVICE_TABLE()
  fpga: dfl: fix the comments of type & feature_id fields
  fpga: dfl: move dfl bus related APIs to include/linux/fpga/dfl.h

 MAINTAINERS                       |  1 +
 drivers/fpga/dfl-n3000-nios.c     |  3 +-
 drivers/fpga/dfl.c                |  1 +
 drivers/fpga/dfl.h                | 85 +-------------------------------------
 include/linux/fpga/dfl.h          | 86 +++++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h   | 12 ++++++
 scripts/mod/devicetable-offsets.c |  4 ++
 scripts/mod/file2alias.c          | 17 ++++++++
 8 files changed, 123 insertions(+), 86 deletions(-)
 create mode 100644 include/linux/fpga/dfl.h

-- 
2.7.4

