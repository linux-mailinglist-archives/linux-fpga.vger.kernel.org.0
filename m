Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06F84D0030
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Mar 2022 14:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbiCGNgz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Mar 2022 08:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiCGNgy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Mar 2022 08:36:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E747D028;
        Mon,  7 Mar 2022 05:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646660160; x=1678196160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tpHQxmvMKX2tSqizOVBvt64e2xRaZ7QMOV9omiltDXk=;
  b=lUo7mn4pbLsek+7pav+bpqU/Ll4EG2Q29/RIg3Ra1j/X0+W2YDfvp2Ff
   9bDrmjCOWXKUYXNO5gj8OLXh6DBBsSWqgt9+b18YOqnd7Z17xigUQSFPF
   7SarOKghnrh66Tmc+vpZkh4fGPOy7vVhvQf8Gu5lb6szPE2sJxAF/wClK
   5NdBTTxOHHB7CLwc4WoJ4IZgABqlQcTXzuCWgCv4SQmYlPLMpEz7oaSC9
   DfFBFudqjILijBJ+V6LWu7PXPgU+gWB2Aw1Xpu2Ej0/IqhU17PRbh/L94
   omDWz4NXglAlhVZrecKamybOP6YjiGnJkc9w6hwjGGVXtqhFnjVnnhTRs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254579313"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254579313"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:36:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643246932"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 05:35:57 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4 0/6] Add OFS support for DFL driver
Date:   Mon,  7 Mar 2022 08:32:37 -0500
Message-Id: <20220307133243.1426300-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This is v4 patchset adding OFS (Open FPGA stack) support for
DFL driver, based on v5.17-rc7. OFS is a collection of RTL
and open software providing interface to access the instantiated
RTL easily in FPGA. OFS leverages the DFL for the implementation
of the FPGA RTL design.

Patch 1, allows for ports without local bar space for "multiple VFs per
PR slot" model.
Patch 2, uses some lowest bits of flags to track the port status which
the AFU was connected to port device or not.
Patch 3, checks the number of released port match the number of
VFs or not in legacy model.
Patch 4, configures port access mode for afu connected with port.
Patch 5, handles dfl's starting with AFU.
Patch 6, adds architecture description about OFS support for DFL
in documentation.

Changelog v3 -> v4:
   - change "features" to "flags" in dfl_fpga_cdev to track the status
     of port device.
   - use dfl_fpga_cdev->flags to check if it need configure the port access
     mode or not.
   - add description about access the AFU on "multiple VFs per PR slot"
     model.
Changelog v2 -> v3:
   - no code change, just change the name from IOFS to OFS.

Changelog v1 -> v2:
   - Introducing a new member "features" in dfl_fpga_cdev for feature
     control.
   - Adding new flag DFL_FEAT_PORT_CONNECTED_AFU for OFS legacy model.
   - Updates the documentation for the access models about AFU in OFS.
   - Drop the PCI PID patch and will send it later.

Matthew Gerlach (2):
  fpga: dfl: Allow ports without local bar space.
  fpga: dfl: support PF/VF starting with DFH

Tianfei zhang (4):
  fpga: dfl: tracking port conntected with AFU
  fpga: dfl: check released_port_num and num_vfs for legacy model
  fpga: dfl: configure port access mode for afu connected with port
  Documentation: fpga: dfl: add description of OFS

 Documentation/fpga/dfl.rst | 114 +++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl-pci.c     |   9 +++
 drivers/fpga/dfl.c         |  62 ++++++++++++++------
 drivers/fpga/dfl.h         |  22 +++++++
 4 files changed, 191 insertions(+), 16 deletions(-)

-- 
2.26.2

