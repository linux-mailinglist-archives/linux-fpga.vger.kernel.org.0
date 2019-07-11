Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB4660A4
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Jul 2019 22:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfGKUao (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Jul 2019 16:30:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:56638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfGKUao (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Jul 2019 16:30:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 13:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="189625228"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2019 13:30:42 -0700
From:   thor.thayer@linux.intel.com
To:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 0/3] fpga: altera-cvp: Add Stratix10 Support
Date:   Thu, 11 Jul 2019 15:32:47 -0500
Message-Id: <1562877170-23931-1-git-send-email-thor.thayer@linux.intel.com>
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

Thor Thayer (3):
  fpga: altera-cvp: Discover Vendor Specific offset
  fpga: altera-cvp: Preparation for V2 parts.
  fpga: altera-cvp: Add Stratix10 (V2) Support

 drivers/fpga/altera-cvp.c | 322 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 253 insertions(+), 69 deletions(-)

-- 
2.7.4

