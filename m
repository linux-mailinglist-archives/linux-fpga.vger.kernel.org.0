Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD66B20A
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Jul 2019 00:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbfGPWqI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Jul 2019 18:46:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:57961 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388105AbfGPWqH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Jul 2019 18:46:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 15:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,271,1559545200"; 
   d="scan'208";a="158276145"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2019 15:46:06 -0700
From:   thor.thayer@linux.intel.com
To:     mdf@kernel.org, richard.gong@linux.intel.com, agust@denx.de
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv2 0/3] fpga: altera-cvp: Add Stratix10 Support
Date:   Tue, 16 Jul 2019 17:48:04 -0500
Message-Id: <1563317287-18834-1-git-send-email-thor.thayer@linux.intel.com>
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

Thor Thayer (3):
  fpga: altera-cvp: Discover Vendor Specific offset
  fpga: altera-cvp: Preparation for V2 parts.
  fpga: altera-cvp: Add Stratix10 (V2) Support

 drivers/fpga/altera-cvp.c | 326 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 255 insertions(+), 71 deletions(-)

-- 
2.7.4

