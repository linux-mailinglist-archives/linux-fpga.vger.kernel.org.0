Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF562B0B8B
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Nov 2020 18:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgKLRrU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Nov 2020 12:47:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:7821 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgKLRrT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 12 Nov 2020 12:47:19 -0500
IronPort-SDR: UOooDaYy+WgPX2/Tu5Wv8gMoCRk7YVsaL1bY8jPiwZILd995TjibhA9knWP9daPNtXaj59YZv5
 3NdwURvI3fqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="234511112"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="234511112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:47:18 -0800
IronPort-SDR: 5TwHwwuvw421vzXGl6Lo7NoReekZv1Mvk0TMHhT+kJOgTAo1+SCit21/UI2dOjPHcoZFchrUOV
 TJ8hB4dwwLnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="328576324"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 12 Nov 2020 09:47:17 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 0/4] Extend FPGA manager and region drivers for
Date:   Thu, 12 Nov 2020 12:06:39 -0600
Message-Id: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

The customer wants to verify that a FPGA bitstream can be started properly
before saving the bitstream to the QSPI flash memory.

The customer sends the bitstream via FPGA framework and overlay, the
firmware will authenticate the bitstream but not program the bitstream to
device. If the authentication passes, the bitstream will be programmed into
QSPI flash and will be expected to boot without issues.

Extend FPGA manager and region drivers to support the bitstream
authentication feature.

Richard Gong (4):
  fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
  fpga: of-fpga-region: add authenticate-fpga-config property
  dt-bindings: fpga: add authenticate-fpga-config property
  fpga: stratix10-soc: entend driver for bitstream authentication

 Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
 drivers/fpga/of-fpga-region.c                          | 3 +++
 drivers/fpga/stratix10-soc.c                           | 5 ++++-
 include/linux/fpga/fpga-mgr.h                          | 3 +++
 4 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.7.4

