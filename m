Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AFB21CF6A
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Jul 2020 08:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgGMGOT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Jul 2020 02:14:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:34487 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgGMGOT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Jul 2020 02:14:19 -0400
IronPort-SDR: YcWqGEyeUPfXmVw8iKi3blx2VKJI+FFhk1ZqRAVkw8e5BoY6Ewz8qhgqfcwbWsUurvBH6kCgWr
 BNN2Z0NZr+ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="147680037"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="147680037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 23:14:18 -0700
IronPort-SDR: cNdZNa3QY6bxf8cN8wRcPGvmPxxHMUOhnFBeH4ssm4mM9VdV6WEcai0hGrnjW4H32IQh/0wEoA
 v0lyHwNL/PGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="459177266"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2020 23:14:16 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, trix@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 0/2] Bug fixes for FPGA DFL
Date:   Mon, 13 Jul 2020 14:10:01 +0800
Message-Id: <1594620603-18029-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

2 fix patches for FPGA DFL.

v2 adds Reviewed-by of Tom. No code change.

Matthew Gerlach (1):
  fpga: dfl: fix bug in port reset handshake

Xu Yilun (1):
  fpga: dfl: pci: reduce the scope of variable 'ret'

 drivers/fpga/dfl-afu-main.c | 3 ++-
 drivers/fpga/dfl-pci.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4

