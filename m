Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E98648A45
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Dec 2022 22:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiLIVpc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Dec 2022 16:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLIVpC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Dec 2022 16:45:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE913D386;
        Fri,  9 Dec 2022 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670622302; x=1702158302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TuSrvu1jx9I5ZHmEkMMea0Y8tKsaVWKLe+FE0ZgyQOc=;
  b=nGZSv+gwEgjeIptDiFQSHELWkNfMGmfN6+8A6AgGTKPfJR9cjixaVTum
   Urmz88gqvg6PC/TZtSIlVzoLQw1sPZGVIYmn6lsxpghQfFQAG+bKwgATw
   abGUF2M2aRloOkwrO1gmciyWOmzTdtNcDWOF5OPbkO22Ps90svZHl79cw
   baY6oifccWHo4MnD3vNG3ZIycj/N0bIMNTRZpiFr1iqoeSv7yuKvdXtmR
   yHb1WWt9FIRVa7+xgil5F5j9CvL/O0Exg7RUcg0weOxIUhXViyOQJer4U
   uL9iZwAw+xZ4Cgrm9K1h8OsvtISweNNvDKe0qMuczeyxnIu2568k+u513
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="300975520"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="300975520"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:45:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="711031664"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="711031664"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:44:59 -0800
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
        marpagan@redhat.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v6 0/4] Enhance definition of DFH and use enhancements for UART driver
Date:   Fri,  9 Dec 2022 13:45:19 -0800
Message-Id: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
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

 Documentation/fpga/dfl.rst         | 103 +++++++++++++
 drivers/fpga/dfl.c                 | 234 ++++++++++++++++++++++-------
 drivers/fpga/dfl.h                 |  41 +++++
 drivers/tty/serial/8250/8250_dfl.c | 154 +++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |  12 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |   4 +
 7 files changed, 498 insertions(+), 51 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

-- 
2.25.1

