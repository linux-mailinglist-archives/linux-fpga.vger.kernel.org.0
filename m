Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C75AF423
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Sep 2022 21:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIFTEW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Sep 2022 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIFTEV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Sep 2022 15:04:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D88D3CB;
        Tue,  6 Sep 2022 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662491059; x=1694027059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=noMjuag55LUNaeVDHiaxN2eVuWfjztTAREa6cfbKFAM=;
  b=k7d5Jtbs15+bIwYtJ4rnGw0s5CfFrT5nrfNKvpHE2Tres7WVewO/mXyu
   jrBm7I2HrHgWyQVVoEfX8FuVOjWRRL0PvBFQMz2ayvXu58UDiIQipGFMr
   tf9d1jpNYS9o6Bg5Pv1aoV09Y247NslK27uXqCYNRR/iEVwgqXVzbVvbS
   FvryX1Y9tC7mfB7C2Ql2i//whXfifTr1vdpVAX3tuUMrM2VrEzzrDi2Dn
   Q9UyzMkLCat1WsPPlJ/dh+W1Xec1cxf3DXyI+eolkPMTFXaacsSp8Gp2F
   P9Dmi0121VHr+NlugoJWD+tKT8bL8s+MoCefzpzLXWgMF75+von7VNpnq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283677333"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283677333"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="789782539"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
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
Subject: [PATCH v1 0/5] Enhance definition of DFH and use enhancements for uart driver
Date:   Tue,  6 Sep 2022 12:04:21 -0700
Message-Id: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Patch 5 adds a DFL uart driver that makes use of the new features of DFHv1.

Basheer Ahmed Muddebihal (2):
  fpga: dfl: Move the DFH definitions
  fpga: dfl: Add DFHv1 Register Definitions

Matthew Gerlach (3):
  Documentation: fpga: dfl: Add documentation for DFHv1
  fpga: dfl: add generic support for MSIX interrupts
  tty: serial: 8250: add DFL bus driver for Altera 16550.

 Documentation/fpga/dfl.rst         |  24 ++++
 drivers/fpga/dfl.c                 |  59 ++++++---
 drivers/fpga/dfl.h                 |  22 +---
 drivers/tty/serial/8250/8250_dfl.c | 188 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |   9 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |  80 +++++++++++-
 7 files changed, 347 insertions(+), 36 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

-- 
2.25.1

