Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B45AB704
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Sep 2022 18:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiIBQ5O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Sep 2022 12:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbiIBQ5N (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Sep 2022 12:57:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A78F4C95;
        Fri,  2 Sep 2022 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662137831; x=1693673831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxGFKQIjRYT7HeHuS+aWbe74kowwL4uam1S+XQg+9Us=;
  b=QtO20zrkvd1mMF78OhG9CVFa8OjwS/brlzceje7p/adZmyJQMJWNoGEZ
   thY9RElBRY4HmN7FkDlZBx27HPEMQDcdcBg4djya2vbdnKxy4WluBrD01
   BgXW1HSwKuCyiaoJcEzgpq5S+k+STuSeslCDSHgHf4eGjJVd0hUpsTTqx
   Qkvbn+iUty5DOkctCkqLUq/HHhl67C4HuxPGMGaFGPfmTVoOyMiKSf8Dz
   /KgpPwJ42naeZrfkW6Ks7+w6vCz1qYVKwUzwOQzMU/Iqj7cZPRnRe/N2/
   01HbMDgOIGhqAolsAZS2Bl/Jsba3+n8cgOczyk2fLfInBIckLqpQNLgii
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382321115"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382321115"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 09:57:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="646170189"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.55.214])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 09:57:10 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, lee@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, marpagan@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 1/2] mfd: intel-m10-bmc: add d5005 bmc secure update driver
Date:   Fri,  2 Sep 2022 09:57:05 -0700
Message-Id: <20220902165706.518074-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902165706.518074-1-russell.h.weight@intel.com>
References: <20220902165706.518074-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add the D5005 BMC secure update driver to the MAX10 BMC driver
for D5005 devices.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/mfd/intel-m10-bmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index f4d0d72573c8..7e3319e5b22f 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -21,6 +21,7 @@ enum m10bmc_type {
 
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
 	{ .name = "d5005bmc-hwmon" },
+	{ .name = "d5005bmc-sec-update" }
 };
 
 static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
-- 
2.25.1

