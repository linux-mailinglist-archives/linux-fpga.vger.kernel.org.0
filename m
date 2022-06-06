Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770D253EB91
	for <lists+linux-fpga@lfdr.de>; Mon,  6 Jun 2022 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbiFFQA7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 6 Jun 2022 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbiFFQAr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 6 Jun 2022 12:00:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B75641E;
        Mon,  6 Jun 2022 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654531246; x=1686067246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0IH1ykR11TzVwas0925e0++/ATOCJB9c0YFkEEYV3U=;
  b=FmmEHJ2drW+WFwyFqQSAKGk2zGrKpkJOzbR1CZMJyv1WcePCYaxT7lmQ
   aon7oHct4sQ5swrwpC6ezruh42tZoo9EGat/JHzBflGaYnMJbv+PhaftL
   IytNxjzr30ip+PbG/cQI9RhoLoHKIDYolDj4RjQkjTjGWNZcKGJ7h2BRc
   4ernhr6LT+YO5g0uEk8LH5iAeP7XtaAUh+khvXmMpASvcHJRPdenRjBju
   UaXP5s1N46LCq6pM4CQU0nSjG6r4YG7F9erq+I3Vw+S60xfZvhXZRYt+k
   ZuEFxankmIxf/COHNXsFojV+ClhBId2FBTrrshpnvLjauJGd4XV5ILCAR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="302028925"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="302028925"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 09:00:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="906607942"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.255.231.138])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 09:00:34 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v23 1/5] mfd: intel-m10-bmc: Rename n3000bmc-secure driver
Date:   Mon,  6 Jun 2022 09:00:34 -0700
Message-Id: <20220606160038.846236-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606160038.846236-1-russell.h.weight@intel.com>
References: <20220606160038.846236-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The n3000bmc-secure driver has changed to n3000bmc-sec-update. Update
the name in the list of the intel-m10-bmc sub-drivers.

Tested-by: Tianfei Zhang <tianfei.zhang@intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v23:
  - Rebased for 5.19-rc1
v22:
  - Added Tested-by tag from Tianfei and Acked-by tag from Yilun.
v21:
  - No change
v20:
  - No change
v19:
  - No change
v18:
  - No change
v17:
  - This is a new patch to change in the name of the secure update
    driver.
---
 drivers/mfd/intel-m10-bmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 8db3bcf5fccc..f4d0d72573c8 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -26,7 +26,7 @@ static struct mfd_cell m10bmc_d5005_subdevs[] = {
 static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
 	{ .name = "n3000bmc-hwmon" },
 	{ .name = "n3000bmc-retimer" },
-	{ .name = "n3000bmc-secure" },
+	{ .name = "n3000bmc-sec-update" },
 };
 
 static struct mfd_cell m10bmc_n5010_subdevs[] = {
-- 
2.25.1

