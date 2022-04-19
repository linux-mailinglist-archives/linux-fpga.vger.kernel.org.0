Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE055062B0
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 05:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbiDSDf4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Apr 2022 23:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348038AbiDSDft (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Apr 2022 23:35:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890622C10B;
        Mon, 18 Apr 2022 20:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650339188; x=1681875188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F8tCd20HCjnDQ01AY0mTAgaT8U5/W8gEUqp1jhcZGhI=;
  b=g0HmGaPa/x13id3GcxLnVzD1MPSpjaaqYOzybh/15AwFUd+aQHi6iowU
   2u3yz6uWGTbNUaas4z8GLkx9vUZW4D0FHNZXgUR9Mx/0eIA71UmvVpMvH
   NA4Egv6dZ7UsSx/E2vXY1jQBFmiRz5Lu++CBkvWLfPaxfVliXVOnt5EiE
   TAop1DKL47+RBj6A/aHqv95B/R1/rIQ51JKwf7pM2anSAhzPGMHDaInyx
   27MDLsHRdBy5Q2EoPj0bUJeYUFGSt/WNN9Ktcs+66SPtwZeDxFbJWISak
   aPDJ2ankyMcC451KMZ4iCjtUn50ldinYrlHPtZyQ8hxzMCAyq/aX2x++h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263126788"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263126788"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="726894597"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 18 Apr 2022 20:33:05 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v7 0/2] check feature type for DFL irq parsing
Date:   Mon, 18 Apr 2022 23:29:40 -0400
Message-Id: <20220419032942.427429-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch set adds an extended usage of Feature ID for DFL 
and based on 5.18-rc2. Previously the feature IDs defined are
unique, no matter which feature type. But currently we want
to extend its usage to have a per-type feature ID space.

Patch 1 adds feature type checking before parse the irq info.
Patch 2 adds link address about the Feature ID table.

v7:
  - Add reviewed-by from Matthew Gerlach and Acked-by from Hao. 
  - Change title and git commit message for patch 2. 
v6:
  - Fix documentation from Hao's comment. 
v5:
  - Fix documentation from Matthew's comment. 
v4:
  - Fix the git commit from Hao's comments.
  - Split documentation into another patch.
v3:
  - Remove "Fixes" in commit log with Hao's comment, this is a
    extension not a bug fix.
v2:
  - add DFL Feature ID Registry in documentation.

Tianfei zhang (2):
  fpga: dfl: check feature type before parse irq info
  Documentation: fpga: dfl: add link address of feature id table

 Documentation/fpga/dfl.rst |  5 +++++
 drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++----------------
 2 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.26.2

