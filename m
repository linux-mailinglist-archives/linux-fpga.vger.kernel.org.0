Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC0536810
	for <lists+linux-fpga@lfdr.de>; Fri, 27 May 2022 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351043AbiE0UXs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 May 2022 16:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiE0UXp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 May 2022 16:23:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457F71D93;
        Fri, 27 May 2022 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653683025; x=1685219025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dYYzmLu/IbaGpKJJ0TgTxnBxeLbnGxsAEF/gLd0TqEw=;
  b=NtNyZjNBreEU+f3AExuhUkt4C02ebgQkpN2Pvc/MiIFvK+/GnnBADSd4
   n3FVF+n5iOyk36aXjYymy+8NkJE9f5Y+IhhuMs4qy0mCg+G5lmIw8CJxw
   by12rceCB0XUjl8VJrgqW46PjyCxDEWMzgx6U7NXw4QOnNK+iVtdoFAGk
   +rsmgSuJJSVgjoVtTO0VOh3paMUMxdNXInzQSn0bCQuRVzbBxDBDYTj2s
   smTYkoZRR7ZTZGmIcORBaS4AU0hQ8yf82wzTRzAv9IpK13HMsiRX/FhEE
   AfDfffoW2Kqg035P1xxqXrB7d2zufmBxTv3VPmkBRT3sx4CwmDLw8qzW2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274578087"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="274578087"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:23:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="678142744"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.106.48])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:23:43 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v22 1/5] mfd: intel-m10-bmc: Rename n3000bmc-secure driver
Date:   Fri, 27 May 2022 13:23:26 -0700
Message-Id: <20220527202330.839555-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527202330.839555-1-russell.h.weight@intel.com>
References: <20220527202330.839555-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

