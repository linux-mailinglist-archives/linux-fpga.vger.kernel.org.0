Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A416315920
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Feb 2021 23:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhBIWIL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Feb 2021 17:08:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:52949 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233459AbhBIWFd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Feb 2021 17:05:33 -0500
IronPort-SDR: IxQEQPumU7EI6B4Tm9zM/3C/NhjINmYZHxi8uT/wwVMahyMTLSZftQkBR0Dn37gdnjh+WFsT2g
 tlU7Ap90G9nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="179410819"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="179410819"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:02:09 -0800
IronPort-SDR: P8rcy11YrNR50DbGuM3XiLkdEJR4D92OSOwzmc1bP8va8Nnd79Uzz65qga7zDiHr0oxPUTl8fq
 iX4cZw6R5pXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361959959"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 14:02:07 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv5 0/7]  Extend Intel service layer, FPGA manager and region
Date:   Tue,  9 Feb 2021 16:20:26 -0600
Message-Id: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

This is 5th submission of Intel service layer and FPGA patches, which
includes the missing standalone patch in the 4th submission.

This submission includes additional changes for Intel service layer driver
to get the firmware version running at FPGA SoC device. Then FPGA manager
driver, one of Intel service layer driver's client, can decide whether to
handle the newly added bitstream authentication function based on the
retrieved firmware version. So that we can maintain FPGA manager driver
the back compatible.

Bitstream authentication makes sure a signed bitstream has valid
signatures.

The customer sends the bitstream via FPGA framework and overlay, the
firmware will authenticate the bitstream but not program the bitstream to
device. If the authentication passes, the bitstream will be programmed into
QSPI flash and will be expected to boot without issues.

Extend Intel service layer, FPGA manager and region drivers to support the
bitstream authentication feature. 

Richard Gong (7):
  firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
  firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
  firmware: stratix10-svc: extend SVC driver to get the firmware version
  fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
  fpga: of-fpga-region: add authenticate-fpga-config property
  dt-bindings: fpga: add authenticate-fpga-config property
  fpga: stratix10-soc: extend driver for bitstream authentication

 .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
 drivers/firmware/stratix10-svc.c                   | 12 ++++-
 drivers/fpga/of-fpga-region.c                      | 24 ++++++---
 drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
 include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
 .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
 include/linux/fpga/fpga-mgr.h                      |  3 ++
 7 files changed, 125 insertions(+), 18 deletions(-)

-- 
2.7.4

