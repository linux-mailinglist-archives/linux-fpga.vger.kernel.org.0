Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768F475247
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2019 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbfGYPPH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Jul 2019 11:15:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:22444 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbfGYPPH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 25 Jul 2019 11:15:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 08:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="345467993"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 25 Jul 2019 08:15:01 -0700
From:   thor.thayer@linux.intel.com
To:     mdf@kernel.org, richard.gong@linux.intel.com, agust@denx.de
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv3 0/3] fpga: altera-cvp: Add Stratix10 Support
Date:   Thu, 25 Jul 2019 10:16:45 -0500
Message-Id: <1564067808-21173-1-git-send-email-thor.thayer@linux.intel.com>
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

Thor Thayer (3):
  fpga: altera-cvp: Discover Vendor Specific offset
  fpga: altera-cvp: Preparation for V2 parts.
  fpga: altera-cvp: Add Stratix10 (V2) Support

 drivers/fpga/altera-cvp.c | 348 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 277 insertions(+), 71 deletions(-)

-- 
2.7.4

