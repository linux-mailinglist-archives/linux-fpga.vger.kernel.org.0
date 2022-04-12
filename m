Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A840C4FCF68
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Apr 2022 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348615AbiDLGWn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Apr 2022 02:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDLGWm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Apr 2022 02:22:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7685D3526B;
        Mon, 11 Apr 2022 23:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649744426; x=1681280426;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xVwq96NU+9P18WRzXaQ9uEZDEAysmbq89Znj5FrauRk=;
  b=aWQrXMePWeI7wcwv79FOihuqlxfcsVAuQPd57IVUSQfdXhPOedh5yb7+
   8eagaBfTChD1a+IansgZD+Je2B3KX1FkcoCV6FnMI66Oe0SSqTLf5JHP/
   p1+MOUdyOWdIra4UBZt6VcKiNo0hJ91DyJJ0NFp5LOsFshqtkz3p4qKDi
   31lLCuPOIgSSOtwgJY/hRu7fwZ8wQuygQHHuwHywcQk63k+ZEhBUkCCgv
   v3b3icgnAqdIvYcqd0QscDjwf9+V7VKbF5sbiKNcPbci06yvY8zeqw71F
   4LV0jkuwka+B/gksZnjX1iyoeyMaH/gbOlf+f3rzenzZnTNALQ8R5jqxR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262467178"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262467178"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="724305368"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2022 23:20:23 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, rdunlap@infradead.org
Cc:     corbet@lwn.net, Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v6 0/2] check feature type for DFL irq parsing
Date:   Tue, 12 Apr 2022 02:17:03 -0400
Message-Id: <20220412061705.53721-1-tianfei.zhang@intel.com>
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

This patch set adds an extended usage of Feature ID for DFL 
and based on 5.18-rc2. Previously the feature IDs defined are
unique, no matter which feature type. But currently we want
to extend its usage to have a per-type feature ID space.

Patch 1 adds feature type checking before parse the irq info.
Patch 2 adds description about the Feature ID.

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
  Documentation: fpga: dfl: add description of feature ids

Tianfei zhang (2):
  fpga: dfl: check feature type before parse irq info
  Documentation: fpga: dfl: add description of feature ids

 Documentation/fpga/dfl.rst |  5 +++++
 drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++----------------
 2 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.26.2

