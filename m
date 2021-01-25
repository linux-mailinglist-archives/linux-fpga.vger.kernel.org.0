Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9592302CC4
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Jan 2021 21:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbhAYUj4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 15:39:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:37450 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732357AbhAYUij (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 15:38:39 -0500
IronPort-SDR: xnKOzKHeLTAjwnNVg+Z9C9lyJa2Y1QsYuaNQY9ThUG4KciJM4+1raGvpawUcfv+6jY8F4k83Ja
 +bjT9onit5VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177227322"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="177227322"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 12:36:44 -0800
IronPort-SDR: MVCtqYm5vl8XbbMD+fKVdYFBpcIMRgpQPOABLUhI2XFv4WIWSzZZlKEofCsI0B651MICJHLjdT
 AxhGBJHCBajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="504283142"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2021 12:36:42 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv3 0/6] [PATCHv3 0/6] Extend Intel service layer, FPGA manager and region
Date:   Mon, 25 Jan 2021 14:56:22 -0600
Message-Id: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

This is 3rd submission of Intel service layer and FPGA patches.

This submission include additional changes for Intel service layer driver
to get the firmware version running at FPGA SoC device. Then FPGA manager
driver, one of Intel service layer driver's client, can decide whether to
handle the newly added bitstream authentication function based on the
retrieved firmware version. So that we can maintain FPGA manager driver
the back compatible.

The customer wants to verify that a FPGA bitstream can be started properly
before saving the bitstream to the QSPI flash memory.

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
  fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
  fpga: of-fpga-region: add authenticate-fpga-config property
  dt-bindings: fpga: add authenticate-fpga-config property
  fpga: stratix10-soc: extend driver for bitstream authentication

 .../devicetree/bindings/fpga/fpga-region.txt       |  1 +
 drivers/firmware/stratix10-svc.c                   | 12 ++++-
 drivers/fpga/of-fpga-region.c                      |  3 ++
 drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
 include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
 .../linux/firmware/intel/stratix10-svc-client.h    | 15 ++++--
 include/linux/fpga/fpga-mgr.h                      | 13 +++--
 7 files changed, 109 insertions(+), 18 deletions(-)

-- 
2.7.4

