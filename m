Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1512F94F43
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Aug 2019 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfHSUqS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Aug 2019 16:46:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:38630 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfHSUqS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Aug 2019 16:46:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 13:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="202443670"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2019 13:46:17 -0700
From:   thor.thayer@linux.intel.com
To:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [RESEND PATCHv4 0/3] fpga: altera-cvp: Add Stratix10 Support
Date:   Mon, 19 Aug 2019 15:48:05 -0500
Message-Id: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Newer versions (V2) of Altera/Intel FPGAs CvP have different PCI
Vendor Specific Capability offsets than the older (V1) Altera/FPGAs.

Most of the CvP registers and their bitfields remain the same
between both the older parts and the newer parts.

This patchset implements changes to discover the Vendor Specific
Capability offset and then add Stratix10 CvP support.

V2 Changes:
  Remove inline designator from abstraction functions.
  Reverse Christmas Tree format for local variables
  Remove redundant mask from credit calculation
  Add commment for the delay(1) function in wait_for_credit()

V3 Changes
  Return int instead of void for abstraction functions
  Check the return code from read in altera_cvp_chk_error()
  Move reset of current_credit_byte to clear_state().
  Check return codes of read/writes in added functions.

V4 Changes
  Rename delta_credit to space
  Simplify wait for credit do-while loop.
  Change from udelay() to usleep_range()
  Use min() to find length to send
  Remove NULL initialization from private structure
  Use #define for Version1 offsets
  Change current_credit_byte to u32 sent_packets.
  Changes to Kconfig title and description to support Stratix10.

Thor Thayer (3):
  fpga: altera-cvp: Discover Vendor Specific offset
  fpga: altera-cvp: Preparation for V2 parts.
  fpga: altera-cvp: Add Stratix10 (V2) Support

 drivers/fpga/Kconfig      |   6 +-
 drivers/fpga/altera-cvp.c | 339 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 271 insertions(+), 74 deletions(-)

-- 
2.7.4

