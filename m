Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0038866B1F5
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Jan 2023 16:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjAOPO2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Jan 2023 10:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjAOPOU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Jan 2023 10:14:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2011041E;
        Sun, 15 Jan 2023 07:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673795653; x=1705331653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+iOufPRgopYuYmLXRsJEiPulQI4xkelEme+NJan0C7s=;
  b=g7Md2yfx8ltlvtAyJu5MsgZNB2nSp7x/khwi2OvQS1VVeQQvoXS4Z0Js
   y2OrZGb+LANIhRliBYvrcj3GM4xU5GU4+xoXnMlYZZG9+i5lbhoG26Iat
   6Noxx4eJ5n8Bm0sjlqRJLb52iz8Hqm/ShdSJC8YVe+d6L+XnsetArit2d
   XW8Rpz6vDhzoc+TOdgPTm1L1K4QB236YjU9IJewDiw1eKqYKCZhpzMe9M
   JjHwIouEub602iIhrTP/hBbyAuYP2MXNwAYusKJouJtME847CLJG8f9df
   R8OEvTyylSr/LJn/3X3t33bWNdELmU9W1W2HaIIhZj6I4HDqqPaeN8+/u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="386648428"
X-IronPort-AV: E=Sophos;i="5.97,218,1669104000"; 
   d="scan'208";a="386648428"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 07:14:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="722047868"
X-IronPort-AV: E=Sophos;i="5.97,218,1669104000"; 
   d="scan'208";a="722047868"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 07:14:12 -0800
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
Subject: [PATCH v11 0/4] Enhance definition of DFH and use enhancements for UART driver
Date:   Sun, 15 Jan 2023 07:14:43 -0800
Message-Id: <20230115151447.1353428-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

 Documentation/fpga/dfl.rst         | 119 ++++++++++++++
 drivers/fpga/dfl.c                 | 245 +++++++++++++++++++++++------
 drivers/fpga/dfl.h                 |  43 +++++
 drivers/tty/serial/8250/8250_dfl.c | 167 ++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |  12 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |   8 +
 7 files changed, 544 insertions(+), 51 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

-- 
2.25.1

