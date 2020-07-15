Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3722046B
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Jul 2020 07:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGOFmg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Jul 2020 01:42:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:59036 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgGOFmf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Jul 2020 01:42:35 -0400
IronPort-SDR: j30qBen6rp4W/ZSJL6fXbaDBZACwlIR9L8FMfNuKn5JGauI2cvhp1gHrwwKudOHqr5HvV/yyGv
 jCnt4+RJ4bZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="129175726"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="129175726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 22:42:35 -0700
IronPort-SDR: LsY75dTaKeuCKdo7bNj+1lToG1MwuAvyocHY0K/TZ3dCT5bfCgEJueQfZfhiw6Wl4AJiU/1Mpl
 I6FX41M4Rw+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="485604280"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2020 22:42:33 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 0/2] Modularization of DFL private feature drivers
Date:   Wed, 15 Jul 2020 13:38:16 +0800
Message-Id: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset makes it possible to develop independent driver modules
for DFL private features. It also helps to leverage existing kernel
drivers to enable some IP blocks in DFL.

Xu Yilun (2):
  fpga: dfl: map feature mmio resources in their own feature drivers
  fpga: dfl: create a dfl bus type to support DFL devices

 Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
 drivers/fpga/dfl-pci.c                  |  21 +-
 drivers/fpga/dfl.c                      | 435 +++++++++++++++++++++++++++-----
 drivers/fpga/dfl.h                      |  91 ++++++-
 4 files changed, 492 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl

-- 
2.7.4

