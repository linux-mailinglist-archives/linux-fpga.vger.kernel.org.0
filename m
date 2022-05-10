Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D2352251F
	for <lists+linux-fpga@lfdr.de>; Tue, 10 May 2022 21:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiEJT5y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 May 2022 15:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiEJT4k (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 May 2022 15:56:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B653BF88;
        Tue, 10 May 2022 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652212599; x=1683748599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xcUIrCOexCSlpiNcLLv6z/aoQN0sgjplY818BxH/tTw=;
  b=G+HZ5iBrNmATB70fD5JVKAkzOBDhCO/B36CzpKd7JnbWyWyNu4NFzWCf
   9dqPZYuxHEn6+ZGtV8zdICxso4kTAFtoikFBjiagfX4GqIsOdP37y9qZ7
   /LqNabnZrJH8bGgvCPTqse0w0dMKh7PPa37vxg0bChU6S4NnTVspSxFtl
   8OtDOC4qICIqaCeuAc2dRe6Z94AwMClrm2t4lixE3pD3Z/iMC/O9OlfAb
   u3diiw7B2e/+pFP484Xb17B/5UgvUK6CmT3GI2wLPJrgj9Mv7jQWEJjhO
   mp5ccDzWuKGUP7q7ZfWxnfaGFeRzqhTxtLQOLsqV7APe4wkuB1e/90SMK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269624476"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="269624476"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 12:56:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="602624698"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.161.124])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 12:56:38 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v19 1/5] mfd: intel-m10-bmc: Rename n3000bmc-secure driver
Date:   Tue, 10 May 2022 12:56:31 -0700
Message-Id: <20220510195635.140722-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510195635.140722-1-russell.h.weight@intel.com>
References: <20220510195635.140722-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The n3000bmc-secure driver has changed to n3000bmc-sec-update. Update
the name in the list of the intel-m10-bmc sub-drivers.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
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

