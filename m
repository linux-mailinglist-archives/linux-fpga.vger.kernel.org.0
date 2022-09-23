Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C57C5E7A9D
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiIWMWl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiIWMV6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 08:21:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53E2135040;
        Fri, 23 Sep 2022 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663935449; x=1695471449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Jla0i8CgmTHTT8ljPUhB6fAmRb8N/rW8rradd5CdTw=;
  b=Ox1484cd9lP+E3iMVoynEqAaTi8ac5RzOBHZVZkUaeSo6pTjnKlmbqJh
   lYxviqJhEyE6q4InZe+pmUUiyUgE4AXjraCid13MH1iDMYwRCvtNg3Uwv
   D+NMlgf7e5Ti7CDAChRxuufT7cd3nNVu98u+shq54EApaTiPRObqhICdo
   Ix3Zm+EMRsySVFqbFgUlMcizRs3yxKFamAQ5c0imR+nX6BlAe48hPrRdK
   acaU9WWk631vHJQv1HA3PpvI6bCaTJC7Tfer5HhY9FivKNp3Y2f5F/Qo6
   8/UEu0Vn4h3G6LAeEPnmU/9q2lG+GI/ZcHo+C+h3xXRxoSVrie2O3aIaB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364595261"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="364595261"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:17:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="762597725"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:17:29 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Cc:     Matthew Gerlach <matthew.gerlach@intel.com>
Subject: [PATCH v2 0/6] Enhance definition of DFH and use enhancements for uart driver
Date:   Fri, 23 Sep 2022 05:17:39 -0700
Message-Id: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Patch 2 moves some of the DFH definitions to include/linux/dfl.h so that
they can be accessed by drivers outside of drivers/fpga.

Patch 3 adds the definitions for DFHv1.

Patch 4 defines and uses a DFHv1 parameter to provide a generic mechanism for
describing MSIX interrupts used by a particular feature instance.

Patch 5 gets the location and size of the feature's register set from DFHv1.

Patch 6 adds a DFL uart driver that makes use of the new features of DFHv1.

Basheer Ahmed Muddebihal (2):
  fpga: dfl: Move the DFH definitions
  fpga: dfl: Add DFHv1 Register Definitions

Matthew Gerlach (4):
  Documentation: fpga: dfl: Add documentation for DFHv1
  fpga: dfl: add generic support for MSIX interrupts
  fpga: dfl: parse the location of the feature's registers from DFHv1
  tty: serial: 8250: add DFL bus driver for Altera 16550.

 Documentation/fpga/dfl.rst         |  49 ++++++++
 drivers/fpga/dfl-afu-main.c        |   4 +-
 drivers/fpga/dfl.c                 |  88 ++++++++++++--
 drivers/fpga/dfl.h                 |  24 +---
 drivers/tty/serial/8250/8250_dfl.c | 177 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |   9 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |  79 ++++++++++++-
 8 files changed, 402 insertions(+), 29 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

-- 
2.25.1

