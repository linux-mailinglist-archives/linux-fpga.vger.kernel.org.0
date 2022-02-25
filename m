Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003B74C3C3D
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Feb 2022 04:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiBYDNp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Feb 2022 22:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBYDNo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Feb 2022 22:13:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93464BE8;
        Thu, 24 Feb 2022 19:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645758793; x=1677294793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eue+oUcpUjQ1aiaVWgYLbzCGLiuuI90oSMfd5QhnL5Y=;
  b=gEIC+QRLKzvHdaJ2yanMhqY/Di6HKp+3XKOr/7VuQV7qtJAInnx+yCiS
   0HlHfe+q0lftmlcomnC9fx/y2um6sOqv+RvHKtEZknVLraHBj1wFPGRCN
   uSAJ3PE26EFAmRs8c9BtJla1m1TFBGsMkS/qWqF8k5EqjWk4fACszC4oU
   9YVcGdhia1iMy8bRp+LbCJLV72JW0tgC9fTgLOX9PFfJ3jDY1FhN5W427
   FjpjAOQjwSuM5jUS7y3PIyV07rBBQSEHLwNrH0Wfnf7XYN0wR2W/L3Qwm
   WRecrH5bt8oMwju1J5sksLUy0WgPZdXdXY1J9NqFCy9wTbDR8atvrjud8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252602975"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="252602975"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:13:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="684512419"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 19:13:10 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2 0/5] Add Intel OFS support for DFL driver
Date:   Thu, 24 Feb 2022 22:09:57 -0500
Message-Id: <20220225031002.261264-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This is v2 patchset adding IOFS (Intel Open FPGA stack) support for
DFL driver. IOFS is Intel's version of a common core set of
RTL to allow customers to easily interface to logic and IP
on the FPGA. IOFS leverages the DFL for the implementation of
the FPGA RTL design.

Patch 1, allows for ports without specific bar space.
Patch 2, introduces features in dfl_fpga_cdev after DFL enumeration.
On IOFS, we will add more extensions or features in DFL in
future, so adding a new member "features"in dfl_fpga_cdev.
Patch 3, fixs VF creation in "Multiple VFs per PR slot" and legacy model.
Patch 4, handles dfl's starting with AFU and allows for VFs to be created.
Patch 5, adds architecture description about IOFS support for DFL
in documentation.

Changelog v1 -> v2:
   - Introducing a new member "features" in dfl_fpga_cdev for feature
     control.
   - Adding new flag DFL_FEAT_PORT_CONNECTED_AFU for IOFS legacy model.
   - Updates the documentation for the access models about AFU in IOFS.
   - Drop the PCI PID patch and will send it later.

Matthew Gerlach (2):
  fpga: dfl: Allow for ports without specific bar space.
  fpga: dfl: Handle dfl's starting with AFU

Tianfei zhang (3):
  fpga: dfl: add features in dfl_fpga_cdev
  fpga: dfl: fix VF creation in IOFS
  Documentation: fpga: dfl: add description of IOFS

 Documentation/fpga/dfl.rst | 113 +++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl-pci.c     |  13 ++++-
 drivers/fpga/dfl.c         |  38 ++++++++-----
 drivers/fpga/dfl.h         |   6 ++
 4 files changed, 155 insertions(+), 15 deletions(-)

-- 
2.26.2

