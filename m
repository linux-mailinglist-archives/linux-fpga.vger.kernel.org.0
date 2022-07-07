Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E300A56A6A1
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jul 2022 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiGGPGE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Jul 2022 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiGGPGE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Jul 2022 11:06:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86A2CC95;
        Thu,  7 Jul 2022 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657206361; x=1688742361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CrpFJ3qke73+HBHXj84EjjyVEgOV3qTgLdGG3MWtg2E=;
  b=i2UzJGloJv/hlNhL+zE/wpmQmk5Pf9Lhax3ii9m/v3SUgT2wM5T6mdzZ
   cf9bx04xlosxtLRIW9vS+wDV30ZnLu+vtOIygt/YxIFVsIfraa3dv76mA
   4/Clk0rFKdmPCV+vR1clGeAaQL8k+ugybT5HhEBCooQNRKZ+H5NAb8xmi
   H5KQ8u4jTy0f8Br7Dn3KlgIsA5iY6+cCEaVmg5kSrvwpflO1C0NRegjeU
   IpKCGTKYgBkeuBb6Q4MYO1DHCZr9/yQYAk5wGZB1SstK1lenlRy1Yx0LC
   IQ852KBvZo9D56QAztbV/ccg76AWGn5doWB0g8lVnS32WBr7PaTxNKXer
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="263829560"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="263829560"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 08:05:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="720546764"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 08:05:56 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, corbet@lwn.net, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 0/2] Add PCIE device IDs for Intel DFL cards
Date:   Thu,  7 Jul 2022 08:05:47 -0700
Message-Id: <20220707150549.265621-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch set adds the PCIE device IDs for Intel cards with Device Feature
Lists (DFL) to the pci_dev_table for the dfl-pci driver.  This patch set
was separated for clarity from a larger patch set submitted by
tianfei.zhang@intel.com.

Patch 1 adds documentation about identifying PCIE FPGA cards
with Device Feature Lists (DFL).

Patch 2 adds the device ids to the pci_dev_table for the dfl-pci driver.

Matthew Gerlach (2):
  Documentation: fpga: dfl: add PCI Identification documentation
  fpga: dfl-pci: Add IDs for Intel N6000, N6001 and C6100 cards

 Documentation/fpga/dfl.rst | 21 +++++++++++++++++++++
 drivers/fpga/dfl-pci.c     | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.25.1

