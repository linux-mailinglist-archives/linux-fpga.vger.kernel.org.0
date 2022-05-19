Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B354352DFE0
	for <lists+linux-fpga@lfdr.de>; Fri, 20 May 2022 00:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbiESWNg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 May 2022 18:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245411AbiESWNe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 May 2022 18:13:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F165AEEE;
        Thu, 19 May 2022 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652998413; x=1684534413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VMpRKFTZtbEhyzjMomHrBaNoBO6gZj0JVxggZnWjDKs=;
  b=iWqoyCevDSHGKNTYCwQJtvUXBoEhOQSsRleSTEtw82C2jr/vX9haEUVW
   RmZ9aHIw+tOoC8VXqDt8yTAiHyVmwxp3MWsCZtLpWYMY7KVmtmgp8sHjC
   Zk1E7dCyxbqBmPD2NKEOjZS4yhE/asdVGgJw9uzNKbCOXGBXbguZVPaUD
   Mfwwbv72aNwqDycYlAGtoBqosIy2N3mEyEab/FLdXFzoag50/5v5IvSeD
   ujFn5q6PQqLyvIHV7gYoKCGtIkB0svbVLlH0bD9HS8gl7ebq0myb/xdYD
   XxtER1jUSCc93aEzErZuLRCeUOQ0Lktkro9gY2LwcvIItxfBB5JvfbVoN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272097505"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272097505"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:13:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743162369"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:13:31 -0700
From:   Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        tianfei.zhang@intel.com,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: [PATCH 1/3] fpga: dfl: Fix kernel-doc warning in dfl.h for revision
Date:   Thu, 19 May 2022 15:12:47 -0700
Message-Id: <20220519221249.858873-2-basheer.ahmed.muddebihal@linux.intel.com>
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

Fixed the following warning:
drivers/fpga/dfl.h:255: warning: Function parameter or member 'revision' not described in 'dfl_feature'

Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
 drivers/fpga/dfl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 06cfcd5e84bb..766429e618f6 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -231,6 +231,7 @@ struct dfl_feature_irq_ctx {
  *
  * @dev: ptr to pdev of the feature device which has the sub feature.
  * @id: sub feature id.
+ * @revision: sub feature revision.
  * @resource_index: each sub feature has one mmio resource for its registers.
  *		    this index is used to find its mmio resource from the
  *		    feature dev (platform device)'s resources.
-- 
2.34.1

