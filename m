Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91B84C83FC
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 07:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiCAGZY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 01:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiCAGZV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 01:25:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664F870057;
        Mon, 28 Feb 2022 22:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646115877; x=1677651877;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0z+d/djRZAN/bUfCevnkgRsdQIo7+qDRoRp8ZY3kjos=;
  b=eN2eIRhvTSRfucqtst3OOi97SY60h2HD0F8UCSQJs/skP63OLtHAcxK1
   6Y1m7W4VcrgZ1iq+6J1WEUi27Tp0xvQAD3FHImfxFcvn70zy22UIlXn3i
   TvDPlCi8NPpvp63xZ4Ute7QbomjqDgXw2SYCSMBUHDm/Xos5wm+RulKoB
   nHwOQVAgPWq5P4A2U/hHWW8BBCwZB38oYfYr/Gkq2MATfoXoftNcrDVzv
   OkWWMGzMYxp3zA/C1VreZ8FadltGJI9JA1z2+qgYbQgmKupmBbO4HCE4r
   2ggf305JY4DhEKflIoVuYPhMSdiR4H6KksbIhIdaLPOaQFRyPZmnQqiDn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251900296"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="251900296"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="708941734"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 22:24:34 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3 0/5] Add OFS support for DFL driver
Date:   Tue,  1 Mar 2022 01:21:18 -0500
Message-Id: <20220301062123.818687-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This is v3 patchset adding OFS (Open FPGA stack) support for
DFL driver. OFS is a collection of RTL and open software providing
interface to access the instantiated RTL easily in FPGA. OFS
leverages the DFL for the implementation of the FPGA RTL design.

Patch 1, allows for ports without specific bar space.
Patch 2, introduces features in dfl_fpga_cdev after DFL enumeration.
On OFS, we will add more extensions or features in DFL in
future, so adding a new member "features"in dfl_fpga_cdev.
Patch 3, fixs VF creation in "Multiple VFs per PR slot" and legacy model.
Patch 4, handles dfl's starting with AFU and allows for VFs to be created.
Patch 5, adds architecture description about OFS support for DFL
in documentation.

Changelog v2 -> v3:
   - no code change, just change the name from IOFS to OFS.

Changelog v1 -> v2:
   - Introducing a new member "features" in dfl_fpga_cdev for feature
     control.
   - Adding new flag DFL_FEAT_PORT_CONNECTED_AFU for OFS legacy model.
   - Updates the documentation for the access models about AFU in OFS.
   - Drop the PCI PID patch and will send it later.

Matthew Gerlach (2):
  fpga: dfl: Allow for ports without specific bar space.
  fpga: dfl: Handle dfl's starting with AFU

Tianfei zhang (3):
  fpga: dfl: add features in dfl_fpga_cdev
  fpga: dfl: fix VF creation in OFS
  Documentation: fpga: dfl: add description of OFS

 Documentation/fpga/dfl.rst | 113 +++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl-pci.c     |  13 ++++-
 drivers/fpga/dfl.c         |  38 ++++++++-----
 drivers/fpga/dfl.h         |   6 ++
 4 files changed, 155 insertions(+), 15 deletions(-)

-- 
2.26.2

