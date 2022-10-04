Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF74F5F45B1
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Oct 2022 16:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJDOhT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Oct 2022 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiJDOhP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Oct 2022 10:37:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C6961B1F;
        Tue,  4 Oct 2022 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664894226; x=1696430226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Y07a6qOR/uzhewFM1S2xVDneV0ThAx4VOhUtCZe2ro=;
  b=McnmCOx7FcTnqJDjmK+z/HIG2Vb77YzkUeWo95RzXKYr5GXudZm+ptrD
   lkfowaiOW6mZMdMeKn0REYmTDPQC2vc/A+9BhGTwFuG2MT6d/hT4Vde1H
   koOtX2bP4Xpn3CvPRxqJ2sAaTHXFRZfW3us91LvS+t3L/6HXFeCoj84B1
   tVFGfpbjataZBIBzSTA82+zRfl6UsmJZAYHDmi5O9r1pYwAZZ2iJZwkdI
   00QErVxcL+PCGrDzHDb55WqxRS9SlCCqKig5hgBaIQp2MNJG4X52992Dq
   kjqxEMG+Wja0SgpLQlGCNgOStLab6AnLecwt+HGSH88cBCriMkBC0vCt0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="389215860"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="389215860"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 07:37:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="869021618"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="869021618"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 07:37:03 -0700
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
        johan@kernel.org, lukas@wunner.de
Cc:     Matthew Gerlach <matthew.gerlach@intel.com>
Subject: [PATCH v3 0/4] Enhance definition of DFH and use enhancements for uart driver
Date:   Tue,  4 Oct 2022 07:37:14 -0700
Message-Id: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
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

Patch 2 adds the definitions for DFHv1.

Patch 3 adds basic support DFHv1. It provides a generic mechanism for
describing MSIX interrupts used by a particular feature instance, and
it gets the location and size of the feature's register set from DFHv1.

Patch 4 adds a DFL uart driver that makes use of the new features of DFHv1.

Basheer Ahmed Muddebihal (1):
  fpga: dfl: Add DFHv1 Register Definitions

Matthew Gerlach (3):
  Documentation: fpga: dfl: Add documentation for DFHv1
  fpga: dfl: add basic support for DFHv1
  tty: serial: 8250: add DFL bus driver for Altera 16550.

 Documentation/fpga/dfl.rst         |  49 ++++++++
 drivers/fpga/dfl.c                 | 150 +++++++++++++++++-------
 drivers/fpga/dfl.h                 |  36 +++++-
 drivers/tty/serial/8250/8250_dfl.c | 177 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |   9 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |  33 +++++-
 7 files changed, 414 insertions(+), 41 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

-- 
2.25.1

