Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BC7663648
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Jan 2023 01:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjAJA34 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 19:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjAJA3z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 19:29:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC713E0CE;
        Mon,  9 Jan 2023 16:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673310594; x=1704846594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WkdfgZxzNh8MTB9VLy6eNylsSALpzw0WgKG1HPdLwjk=;
  b=Y8+JWceDxb3sGW5gJXiFbeiS1FJPqedsG3uK4mD6lq7vA58LQufIKeW+
   j0bBPtSmG0ZSTZnAXahTtvHwKsiB+zZRjD1fIfmaFGMwq9iHgoNUSGb7s
   Z8ElVWIosMGzy8Vvx7o8rDmuOHBgADZxXBRPeWfP75fvOb7LjCdCz+PYl
   nBNR/EyLe5uwpNjUXo9wqXx0MHLQZeUOJLEnq9PXbRk42t/8xlYjqBPQH
   V9MYbBZE3Tr+m0baB2y/1cJ0Z60IN715bpuMJdlCBjgsTw8poA0rUb9yV
   MbNkaPuH7wxP6mUXC4TvMaqIjaPOKqzYHvQ+5I25v0JvjOmhCGIDtRkuz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324265522"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324265522"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 16:29:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="687381572"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="687381572"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 16:29:53 -0800
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
Subject: [PATCH v10 0/4] Enhance definition of DFH and use enhancements for UART driver
Date:   Mon,  9 Jan 2023 16:30:25 -0800
Message-Id: <20230110003029.806022-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

 Documentation/fpga/dfl.rst         | 117 ++++++++++++++
 drivers/fpga/dfl.c                 | 245 +++++++++++++++++++++++------
 drivers/fpga/dfl.h                 |  43 +++++
 drivers/tty/serial/8250/8250_dfl.c | 167 ++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |  12 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |   8 +
 7 files changed, 542 insertions(+), 51 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

-- 
2.25.1

