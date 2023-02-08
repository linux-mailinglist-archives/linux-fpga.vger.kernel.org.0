Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5403668E996
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Feb 2023 09:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjBHIJH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Feb 2023 03:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjBHIJG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Feb 2023 03:09:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F343B677;
        Wed,  8 Feb 2023 00:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675843745; x=1707379745;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lZhIfD0pfveEaZlZV3WMOly+CQLYmFZtv7Z4zBQKRYw=;
  b=e6fRxhJHA1v46V69iSJSHhnk+cHUx2eOkKx48xEdFMj+Ht5Cq9j5SLxu
   2UsMprK0W/aslo0bpJRtSH7gDo+lmVO/soK2T81GA/2n6CiszEh+emOZw
   /C1aGz+pDtUaQmFztRSKImJ/pysBa2UIRrY/+esAwBOJdtkLHlBH0LpAw
   Rtxled/D3/9lGr/DCgXBmQblgEyCol3Heqsj9fMdqMrXIWijdZ6LK6rpQ
   sQOnng+u2AfTce2H174uFgPXYHf42R1hYC9/IHmWY0ATTb8ciBz2aEFb4
   QlUfVLzZ4l4wVr+JKm/UigfikCoar4SXt7lYx2WkKZaba0kSOn1stIJ1D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331871278"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="331871278"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:08:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="809857609"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="809857609"
Received: from jstelter-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.38.39])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:08:55 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Russ Weight <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: m10bmc-sec: Fix rsu_send_data() to return FW_UPLOAD_ERR_HW_ERROR
Date:   Wed,  8 Feb 2023 10:08:46 +0200
Message-Id: <20230208080846.10795-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

rsu_send_data() should return FW_UPLOAD_ERR_* error codes instead of
normal -Exxxx codes. Convert <0 return from ->rsu_status() to
FW_UPLOAD_ERR_HW_ERROR.

Fixes: 001a734a55d0 ("fpga: m10bmc-sec: Make rsu status type specific")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/fpga/intel-m10-bmc-sec-update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index f0acedc80182..d7e2f9f461bc 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -474,7 +474,7 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
 
 	ret = sec->ops->rsu_status(sec);
 	if (ret < 0)
-		return ret;
+		return FW_UPLOAD_ERR_HW_ERROR;
 	status = ret;
 
 	if (!rsu_status_ok(status)) {

-- 
tg: (97f5496f1624..) sec/fix-error-return-code (depends on: sec/flashops-n6000)
