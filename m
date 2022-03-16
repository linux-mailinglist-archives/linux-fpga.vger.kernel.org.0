Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21FD4DABA6
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Mar 2022 08:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354291AbiCPHNJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 03:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352982AbiCPHMt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 03:12:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB4F5EBC3;
        Wed, 16 Mar 2022 00:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647414696; x=1678950696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r8G3/imUc7OpFrdZEZZ+1wtrkMA8d3Hutb8kBhLqMpU=;
  b=EuCxIf2VbiGtQKxI/5ZGJKOub0NQ4f/x8lq2s5ok2SfpLQ64h52PHebi
   0mivPynWLuEs5fyB7XnAT+J2vwQi86+rQ3CIwqlG6aDa3bnIlUYmRDvmB
   qvzPEdCuOPRiK4n20uGYtZXVUZC1GQTlRt4Ye9BZdKH5SGBUC87eaoA6I
   1iad3IS+YpdDz2rgulgR/4nnaCkgiXcA9jOdF0GGAdmEqKFmpqBjaKa5J
   v2iNrtVtyG/5b1wVjTlRSjdpI1JUu/9gx+DMnsl2plLQu9EhBUfoEeYAf
   9UQN/lNIhVIt8WphkTLXXwoAWnHWFKw6puTjV/ptiIJ+okNd0704mWo2+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281289015"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281289015"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646538293"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 00:11:32 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Cc:     corbet@lwn.net, Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v6 0/6] Add OFS support for DFL driver
Date:   Wed, 16 Mar 2022 03:08:08 -0400
Message-Id: <20220316070814.1916017-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This is v6 patchset adding OFS (Open FPGA Stack) support for
DFL driver, based on v5.17-rc8. OFS is a collection of RTL
and open source software providing interface to access the
instantiated RTL easily in an FPGA. OFS leverages the DFL for
the implementation of the FPGA RTL design.

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

Changelog v5 -> v6:
   - fix documentation with Randy's comment.

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

