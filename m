Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103312B7F18
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 15:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgKROIz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 09:08:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:1973 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKROIz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 09:08:55 -0500
IronPort-SDR: tq6kjW9TJtTBKrH4Qxo/OhVdxm2o9FlqCMZ7GHMXCR25pk6RXgv3xyxBkmHrgj+t3TWPIOpcls
 k6zxWKF5Dr9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150389522"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150389522"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 06:08:51 -0800
IronPort-SDR: rDAz47JvlY/oah7fBlAZV7GbBompIVKcRIM752Wc5iW+VyRVbhfPYURwE5MPQiKQ2/0fwOVyG5
 QGTt5UZGBDtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="325596828"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2020 06:08:50 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv2 0/5] Extend Intel service layer, FPGA manager and region
Date:   Wed, 18 Nov 2020 08:29:08 -0600
Message-Id: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
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
  fpga: stratix10-soc: entend driver for bitstream authentication

 Documentation/devicetree/bindings/fpga/fpga-region.txt |  1 +
 drivers/fpga/of-fpga-region.c                          |  3 +++
 drivers/fpga/stratix10-soc.c                           |  3 +++
 include/linux/firmware/intel/stratix10-svc-client.h    | 11 ++++++++---
 include/linux/fpga/fpga-mgr.h                          | 13 ++++++++-----
 5 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.7.4

