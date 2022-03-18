Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B815D4DD386
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Mar 2022 04:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiCRDVh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 23:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiCRDVg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 23:21:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5BD19530D;
        Thu, 17 Mar 2022 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647573617; x=1679109617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oQO5wErIlCM9YnkPEAv4OFlanCveA22VgbUuXCD6i5o=;
  b=j6rz93JfgHmaFCakYhWeL2KUN75XeaCnyAwNC+FfE6N2lqJQDanq5Oe4
   +ysDspZtgXyYox4J3iTxM/e7QUeLiRW+F+mAlOky/BIhdOzjpwNdsVvE3
   7z2liGSsI8e3KA1DXdc0ed1hJK0QUFY26pfGchCxohVbEz+/Jt31NJ/eR
   mRJ6PbxShkRr98G0HYwsZ+rL53wIzGbmuBqKDpD22P9z5vH2O/ZJwLnpZ
   kj4OvkGNgC6F0BoOmweFDPvhhRVc42Q9w/RGqsaYacbzaJCz4aXwSCnJF
   f+jaNE8VuatmTc0YRpuPSTmQUgm7TE2oJTTiqzqtTr9HIpNgxJLiTOMRz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254592177"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="254592177"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 20:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="647292884"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 20:20:14 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, rdunlap@infradead.org
Cc:     corbet@lwn.net, Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4 0/2] check feature type for DFL irq parsing
Date:   Thu, 17 Mar 2022 23:16:52 -0400
Message-Id: <20220318031654.2130587-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch set adds an extended usage of Feature ID for DFL.
Previously the feature IDs defined are unique, no matter
which feature type. But currently we want to extend its
usage to have a per-type feature ID space.

Patch 1 adds feature type checking before parse the irq info.
Patch 2 adds description about the Feature ID.

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
  Documentation: fpga: dfl: add description of Feature ID

 Documentation/fpga/dfl.rst | 10 ++++++++++
 drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++----------------
 2 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.26.2

