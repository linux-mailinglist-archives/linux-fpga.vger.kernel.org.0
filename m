Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D339452DFD9
	for <lists+linux-fpga@lfdr.de>; Fri, 20 May 2022 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbiESWNe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 May 2022 18:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiESWNd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 May 2022 18:13:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A199D5BD1A;
        Thu, 19 May 2022 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652998409; x=1684534409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Yc8pzAaad5jAgvmzkFgqqjEY6itx9TSbPf2hpOdUCI=;
  b=MKfwRlPCur8knswQLbRNFzrsZIs56bJms+lcgr3E/T74KcN6jHmozhxu
   7cwqOe4MzqJQJ7+X4Nvj6frPPcsa1sHCTtSY8YqIum6zXZY2cBfvsfaZK
   UB0D7dGK36aJvw3YmH4d3xoI9jdBGjmUS85iTLrLkIjoayKELtvT12LHV
   J4BFDMmS83D5ZNTx1Cnv4rGoZ1ez1/vdCdvBv93wqClBVN8b+ncwp5nDC
   qwFFNBMFZ2pS3EUeXFyr1Q/2v6wpvsvliowFIlyiEGCZvhOkGhBcaaSDB
   w3oUnH8VM/Md2w3pGKh8SSVOmcdhQDRJjEU2agUr57y0hkqx+iN3tePrY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272097494"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272097494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:13:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743162342"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:13:29 -0700
From:   Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        tianfei.zhang@intel.com,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: [PATCH 0/3] Fix kernel-doc warnings dfl files 
Date:   Thu, 19 May 2022 15:12:46 -0700
Message-Id: <20220519221249.858873-1-basheer.ahmed.muddebihal@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixed the kernel-doc warnings in drivers/fpga/dfl.c, drivers/fpga/dfl.h
and include/linux/dfl.h. Each file commit has a list of warnings fixed. 

Basheer Ahmed Muddebihal (3):
  fpga: dfl: Fix kernel-doc warning in dfl.h for revision
  fpga: dfl: Fix kernel-doc warnings in include/linux/dfl.h
  fpga: dfl: Fix kernel-doc warnings in drivers/fpga/dfl.c

 drivers/fpga/dfl.c  | 5 +++--
 drivers/fpga/dfl.h  | 1 +
 include/linux/dfl.h | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.34.1

