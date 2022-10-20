Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09AA606A3F
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Oct 2022 23:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJTVZ7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Oct 2022 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJTVZ5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Oct 2022 17:25:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A09117E23B;
        Thu, 20 Oct 2022 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666301156; x=1697837156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U1DYLh1b+Wg7DObvnlquUyu7vJlxjG15w2qXKEefn3s=;
  b=RTpYZTuJS9JpHLhxzdQwvlx1YQoDAi2Vg83pWoRkv7KOowfbrSwV7dJu
   IvG3sCHdQJTd+E93ZA8aA3aWj9fuxdrMdm9nnpqt0MOTJ1HJu6/wICLt1
   erYIf5/PRpCRqEFsij0hBhW+f1Zw8mPrdlJ0tL5+Gupfgi5SG9Pds9cef
   uZwA1M0gzQZCplpt4ZwHPDdzRDl+nYcRqzS/wnihqwnzvzHDky61VbN8b
   C5ett6Q9tChnxnXm7IsNP0EXFbDuPOJe/nqs8XElFF7H8rVrXdEZsNUQ/
   5CnmGy/54RJ/AQN9upK9Wm/7iD7UF4XZ1L4BqZUU3ovOGgWQWAJG+oHUZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333412429"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="333412429"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:25:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693260664"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="693260664"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:25:55 -0700
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
Cc:     Matthew Gerlach <matthew.gerlach@intel.com>
Subject: [PATCH v4 0/4] Enhance definition of DFH and use enhancements for uart driver
Date:   Thu, 20 Oct 2022 14:26:06 -0700
Message-Id: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@intel.com>

This patchset enhances the definition of the Device Feature Header (DFH) used by
the Device Feature List (DFL) bus and then uses the new enhancements in a uart
driver.

Patch 1 updates the DFL documentation to provide the motivation behind the 
enhancements to the definition of the DFH.

Patch 2 adds the definitions for DFHv1.

Patch 3 adds basic support DFHv1. It provides a generic mechanism for
describing MSIX interrupts used by a particular feature instance, and
it gets the location and size of the feature's register set from DFHv1.

Patch 4 adds a DFL uart driver that makes use of the new features of DFHv1.

Basheer Ahmed Muddebihal (1):
  fpga: dfl: Add DFHv1 Register Definitions

Matthew Gerlach (3):
  Documentation: fpga: dfl: Add documentation for DFHv1
  fpga: dfl: add basic support DFHv1
  tty: serial: 8250: add DFL bus driver for Altera 16550.

 Documentation/fpga/dfl.rst         |  96 ++++++++++++
 drivers/fpga/dfl.c                 | 234 +++++++++++++++++++++++------
 drivers/fpga/dfl.h                 |  38 +++++
 drivers/tty/serial/8250/8250_dfl.c | 149 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |  12 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |  15 ++
 7 files changed, 496 insertions(+), 49 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

-- 
2.25.1

