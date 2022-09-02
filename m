Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038135AB705
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Sep 2022 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiIBQ5R (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Sep 2022 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiIBQ5Q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Sep 2022 12:57:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808AAF4907;
        Fri,  2 Sep 2022 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662137833; x=1693673833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dh4E8aQGYs+CfKpsiSZgidtCHtHjhVFiAw4XcNKrGyI=;
  b=Uot+ZWL1gsHeWFllk+q3qKJvDd7DnHsJ22vECOvR3RcTkB9Zur2HMk1M
   xw28WKqWjb6fT/W/hHhcFTwdyJAqmjASafoOOW+W/1sS/+AAjalXmOvdF
   hwoW/ThzHXESmVcuq5R2TPRxhlXbBhEHNZ6YA/YTS1zZWsArAub1mTZtu
   m1f5gWNzT5SR2ShnSR1YDbUsTK8zBrvfK5yI2x4dfYaZ/8XZCP/qYNktG
   JsprlaphzFUwiH1Y+G3PaNnr/F8xIAPByD7pLMhB/mH6L0T42z497tYUS
   9SqhlWCwsFnfr1asTuKSYxXaig+NqXG46SrD3PCuPHA1ceWHWMISwMsLS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382321118"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382321118"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 09:57:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="646170192"
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
Subject: [PATCH v1 2/2] fpga: m10bmc-sec: d5005 bmc secure update driver
Date:   Fri,  2 Sep 2022 09:57:06 -0700
Message-Id: <20220902165706.518074-3-russell.h.weight@intel.com>
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

Add a driver name for the D5005 BMC secure update driver. Different
driver names are used for the N3000 and D5005 devices because future
changes will add conditional code based on the device type (N3000
vs D5005). This change enables D5005 secure updates of BCM images,
BMC firmware, static-region images, etc.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 72c677c910de..526c8cdd1474 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -605,6 +605,9 @@ static const struct platform_device_id intel_m10bmc_sec_ids[] = {
 	{
 		.name = "n3000bmc-sec-update",
 	},
+	{
+		.name = "d5005bmc-sec-update",
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
-- 
2.25.1

