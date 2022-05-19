Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F352DFE1
	for <lists+linux-fpga@lfdr.de>; Fri, 20 May 2022 00:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbiESWNh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 May 2022 18:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245425AbiESWNg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 May 2022 18:13:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F12EAD2A;
        Thu, 19 May 2022 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652998415; x=1684534415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LSWyhoO1Ig77aYyVHyGbxNkD/urdHpbw8i03bIc1n70=;
  b=NR748dOIU4a02iLsDy16AY42tQZqXE7aSXywzwXayOZOq8gp+r19UhY6
   CTXvCR9XzxeqQKiHjFdZEmQQKdAxUQtMgy+DLtNAONfTiDNuvCKYM93jo
   FVbR+U3KADVfmNjT5dKTWmrBmKdWf4CLqoC42ZgAFBjh4fApTDsmimOha
   jxZZWrPqNjqFtDP7ThnvePgs7UcQ5z6HuTZ0sDSya9LG+rfmVfW0HPHbN
   xpaTK4k0rOJY4SjkkoubCE9I+4wFIYR04bhzRGFwb4DIJJZoXZdmY6fho
   5NmCh9/sRk6MWBdAhFWM3nSDEDVWOdehyqZcEvxfX3/IllyzUCU5I3acX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272097523"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272097523"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:13:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743162385"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:13:34 -0700
From:   Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        tianfei.zhang@intel.com,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: [PATCH 3/3] fpga: dfl: Fix kernel-doc warnings in drivers/fpga/dfl.c
Date:   Thu, 19 May 2022 15:12:49 -0700
Message-Id: <20220519221249.858873-4-basheer.ahmed.muddebihal@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519221249.858873-1-basheer.ahmed.muddebihal@linux.intel.com>
References: <20220519221249.858873-1-basheer.ahmed.muddebihal@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixed the following warnings:
drivers/fpga/dfl.c:54: warning: cannot understand function prototype: 'struct dfl_dev_info '
drivers/fpga/dfl.c:74: warning: cannot understand function prototype: 'struct dfl_chardev_info '
drivers/fpga/dfl.c:725: warning: Function parameter or member 'revision' not described in 'dfl_feature_info'

Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
 drivers/fpga/dfl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 6bff39ff21a0..4086cabd25b0 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -45,7 +45,7 @@ static const char *dfl_pdata_key_strings[DFL_ID_MAX] = {
 };
 
 /**
- * dfl_dev_info - dfl feature device information.
+ * struct dfl_dev_info - dfl feature device information.
  * @name: name string of the feature platform device.
  * @dfh_id: id value in Device Feature Header (DFH) register by DFL spec.
  * @id: idr id of the feature dev.
@@ -67,7 +67,7 @@ static struct dfl_dev_info dfl_devs[] = {
 };
 
 /**
- * dfl_chardev_info - chardev information of dfl feature device
+ * struct dfl_chardev_info - chardev information of dfl feature device
  * @name: nmae string of the char device.
  * @devt: devt of the char device.
  */
@@ -708,6 +708,7 @@ struct build_feature_devs_info {
  * struct dfl_feature_info - sub feature info collected during feature dev build
  *
  * @fid: id of this sub feature.
+ * @revision: revision of this sub feature.
  * @mmio_res: mmio resource of this sub feature.
  * @ioaddr: mapped base address of mmio resource.
  * @node: node in sub_features linked list.
-- 
2.34.1

