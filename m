Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946136524C3
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Dec 2022 17:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiLTQgd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Dec 2022 11:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTQgc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 20 Dec 2022 11:36:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F0CE2;
        Tue, 20 Dec 2022 08:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671554191; x=1703090191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J2wuNdHeSU45EPYUtuNimi/LpgqhKlKjF+VILVCm8dQ=;
  b=aWPHyiPVCx+MYK6QEtqDh5rmhTn9S/hmd1bJpPlAMhllxfn6OQIBzSph
   yMiT5e7HnF3cXp3JM1SoSJKrv+OwlFyBPwJDt5SPyAcDGKeAT/WAQlDNe
   o++2z4kLA2XCVa3azjWjzYoDJKNlJTIKj9zGU7SXR8qz1SbKUxJaM5AXE
   zMyGjoO6P5XJC+T8DPFCuh8A3r3G9pfT+CZ7Ok35mE7Muby1VvvCStF79
   NDdQ/6Vk8yrixvLA+NXPsytyYXnMe0pIS2vfwdp7IMvpQCdLAn1L86wZK
   mvj8fGhy4akn7L6IIqB+OCaBOTd0+CZVDJsVu2jERa6xTg5doiSv5MHC6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="317292812"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="317292812"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 08:36:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="896528200"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="896528200"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 08:36:29 -0800
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v7 0/4] Enhance definition of DFH and use enhancements for UART driver
Date:   Tue, 20 Dec 2022 08:36:48 -0800
Message-Id: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patchset enhances the definition of the Device Feature Header (DFH) used by
the Device Feature List (DFL) bus and then uses the new enhancements in a UART
driver.

The enhancements to the DFH includes the introduction of parameter blocks.
Like PCI capabilities, the DFH parameter blocks further describe
the hardware to software. In the case of the UART, the parameter blocks
provide information for the interrupt, clock frequency, and register layout.

Duplication of code parsing of the parameter blocks in multiple DFL drivers
is a concern. Using swnodes was considered to help minimize parsing code 
duplication, but their use did not help the problem. Furthermore the highly
changeable nature of FPGAs employing the DFL bus makes the use of swnodes
inappropriate. 

Patch 1 updates the DFL documentation to describe the added functionality to DFH.

Patch 2 adds the definitions for DFHv1.

Patch 3 adds basic support for DFHv1. It adds functionality to parse parameter blocks
and adds the functionality to parse the explicit location of a feature's register set.

Patch 4 adds a DFL UART driver that makes use of the new features of DFHv1.

Basheer Ahmed Muddebihal (1):
  fpga: dfl: Add DFHv1 Register Definitions

Matthew Gerlach (3):
  Documentation: fpga: dfl: Add documentation for DFHv1
  fpga: dfl: add basic support for DFHv1
  tty: serial: 8250: add DFL bus driver for Altera 16550.

 Documentation/fpga/dfl.rst         | 112 ++++++++++++++
 drivers/fpga/dfl.c                 | 234 ++++++++++++++++++++++-------
 drivers/fpga/dfl.h                 |  41 +++++
 drivers/tty/serial/8250/8250_dfl.c | 154 +++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |  12 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |   4 +
 7 files changed, 507 insertions(+), 51 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

-- 
2.25.1

