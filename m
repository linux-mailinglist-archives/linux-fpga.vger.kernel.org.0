Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A2330AAA3
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 16:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhBAPLC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 10:11:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:33905 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhBAPDu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Feb 2021 10:03:50 -0500
IronPort-SDR: ibODGu0kGcNmFCIGPevd2JCQ05Kc4yGcoaxevh9wSmHMAz26hcJ4p56pZQigHQNp5MJBoP8p+b
 /spk1ol0ksig==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242214662"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="242214662"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:02:30 -0800
IronPort-SDR: B4o4R491oWUAIaTNLztu5/CK7WQp5+H0fPopXQJi4r7QgYtz1IKBgcfLPvpxH9qpjxhU4W++G/
 l9+ktH2rKT8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="369891558"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2021 07:02:29 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
Subject: [PATCHv4 0/6] Extend Intel service layer, FPGA manager and region
Date:   Mon,  1 Feb 2021 09:21:53 -0600
Message-Id: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

This is 4th submission of Intel service layer and FPGA patches.

This submission includes additional changes for Intel service layer driver
to get the firmware version running at FPGA SoC device. Then FPGA manager
driver, one of Intel service layer driver's client, can decide whether to
handle the newly added bitstream authentication function based on the
retrieved firmware version. So that we can maintain FPGA manager driver
the back compatible.

Bitstream authentication makes sure a signed bitstream has valid signatures.

The customer sends the bitstream via FPGA framework and overlay, the
firmware will authenticate the bitstream but not program the bitstream to
device. If the authentication passes, the bitstream will be programmed into
QSPI flash and will be expected to boot without issues.

Extend Intel service layer, FPGA manager and region drivers to support the
bitstream authentication feature.

Richard Gong (6):
  firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
  firmware: stratix10-svc: extend SVC driver to get the firmware version
  fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
  fpga: of-fpga-region: add authenticate-fpga-config property
  dt-bindings: fpga: add authenticate-fpga-config property
  fpga: stratix10-soc: extend driver for bitstream authentication

 .../devicetree/bindings/fpga/fpga-region.txt       |  4 ++
 drivers/firmware/stratix10-svc.c                   | 12 ++++-
 drivers/fpga/of-fpga-region.c                      | 24 ++++++---
 drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
 include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
 .../linux/firmware/intel/stratix10-svc-client.h    |  9 ++++
 include/linux/fpga/fpga-mgr.h                      |  3 ++
 7 files changed, 118 insertions(+), 17 deletions(-)

-- 
2.7.4

