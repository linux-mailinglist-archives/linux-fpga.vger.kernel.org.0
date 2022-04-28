Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE039513F22
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Apr 2022 01:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiD1XlB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Apr 2022 19:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiD1XlB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Apr 2022 19:41:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684CA1B7B6;
        Thu, 28 Apr 2022 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651189065; x=1682725065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cGEuwaA6N6P8dDLHOsOgTzM60EaSGdSR+iVJMOvcUYE=;
  b=UQblcDnFgGpnmqDTmcn915z+NLMTxLSttz6gl+NZl/uHw8TulRO6IHh3
   rXK66LGPW1aFKB1CLNvYqMQ0gWGujK47jPk+psqn9FcHrf66YFBvY4yq2
   RnvRBwYYkVLbpjCjX+n1CY6i9WnbyILpORuqd6euFG9q5CuyoAaDHSB8j
   9s+ul9YcABn/W83EIOoZ8GlOlGJOSvzE1t1OM/eTgAW6pMxWNwkuMQ5oY
   CXpmQhZm5gnCFra06XgbsEgA1X8aAc6Xbcn3dl01tov8G763zzUqQ1owi
   VSmL2JSm6n8lRaD5TuYQDsqaG+NYB2F+MM4bMlg4cbUWI369hWogQMj5K
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265987662"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="265987662"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:37:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="731766366"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.153.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:37:43 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v17 1/5] mfd: intel-m10-bmc: Rename n3000bmc-secure driver
Date:   Thu, 28 Apr 2022 16:37:28 -0700
Message-Id: <20220428233732.189425-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428233732.189425-1-russell.h.weight@intel.com>
References: <20220428233732.189425-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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

