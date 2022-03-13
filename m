Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D304D74CC
	for <lists+linux-fpga@lfdr.de>; Sun, 13 Mar 2022 12:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiCMK7n (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Mar 2022 06:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiCMK61 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Mar 2022 06:58:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901E652D9;
        Sun, 13 Mar 2022 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647169030; x=1678705030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hh5XhMuAq7bi0Dfz6t0Sx5ZQABmWKx2Mj51uf6kYWPo=;
  b=eMdS3f1GnANJ8CU/vpiKOoA2suJ9WsUYkUF30CeCjK0MDqIExhgXRfI1
   i01VAIKJu9oYw0KBwSd0VQrFx3SAdVSRXUoUjlej2fxD2ShvUOgLFhUP3
   7/zgcE80WQoOfknJJR5DgLLFMMVct8RDHxLP6tvdLkxbh59l5VIxP91DJ
   jg/iVRwz9cTGzCtZ+/EKLCgy6uAGJOfeGhAj3X2oGxKRN2YuFEvJ5qx+M
   bRdDTkYnb/RLD76CJXTXo1yFyTgNe4OKAW1ggZVDvqrFgCNpPSQTuhCnH
   RHB1becPk5AgT8lxE8CkQjS7hvivM0L6Fr937I+lhMvj7t8F/S9BwTeny
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="319086322"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="319086322"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 03:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713380308"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 03:55:58 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v5 0/6] Add OFS support for DFL driver
Date:   Sun, 13 Mar 2022 06:52:36 -0400
Message-Id: <20220313105242.1567774-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This is v5 patchset adding OFS (Open FPGA Stack) support for
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

Changelog v4 -> v5:
   - fix documentation with Matthew and Randy's comment.

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

