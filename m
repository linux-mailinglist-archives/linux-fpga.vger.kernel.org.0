Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73782D99F2
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 15:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgLNO2n (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 09:28:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:18186 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440054AbgLNOUx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 09:20:53 -0500
IronPort-SDR: DMVahS0+xV1edidobF7SDZ4NqzTuG/1W/plHAnXeZSXI57qgg+xVGvCqHDlYaQV2cEEuTP6pvQ
 utDYqBZdkBFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="259437985"
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="259437985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 06:19:01 -0800
IronPort-SDR: 2QF7zL8c7cGxOQ0jaYtyfgvfELwUu/Y/fCGj54qGB6fbmSUS5dTd5UEZg/iOzU+AXJ67jTrryO
 WN/Wbjp1ucaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="333456252"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2020 06:18:45 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv2 0/5] Extend Intel service layer, FPGA manager and
Date:   Mon, 14 Dec 2020 08:39:55 -0600
Message-Id: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

This is 2nd submission of Intel service layer and FPGA patches.

The customer wants to verify that a FPGA bitstream can be started properly
before saving the bitstream to the QSPI flash memory.

Bitstream authentication makes sure a signed bitstream has valid signatures.

The customer sends the bitstream via FPGA framework and overlay, the
firmware will authenticate the bitstream but not program the bitstream to
device. If the authentication passes, the bitstream will be programmed into
QSPI flash and will be expected to boot without issues.

Extend Intel service layer, FPGA manager and region drivers to support the
bitstream authentication feature.

Richard Gong (5):
  firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
  fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
  fpga: of-fpga-region: add authenticate-fpga-config property
  dt-bindings: fpga: add authenticate-fpga-config property
  fpga: stratix10-soc: extend driver for bitstream authentication

 Documentation/devicetree/bindings/fpga/fpga-region.txt |  1 +
 drivers/fpga/of-fpga-region.c                          |  3 +++
 drivers/fpga/stratix10-soc.c                           |  3 +++
 include/linux/firmware/intel/stratix10-svc-client.h    | 11 ++++++++---
 include/linux/fpga/fpga-mgr.h                          | 13 ++++++++-----
 5 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.7.4

