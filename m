Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8071552B
	for <lists+linux-fpga@lfdr.de>; Tue, 30 May 2023 07:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjE3FuI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 May 2023 01:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjE3FuF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 May 2023 01:50:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA73EA
        for <linux-fpga@vger.kernel.org>; Mon, 29 May 2023 22:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425803; x=1716961803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tS8d7dm+hTnRrKEsboeLbWpMlZkVwRQPfAIpfbUZQLI=;
  b=VDAzJUuljMLfbP7FlygK0uUB0YWVOk3cGRPXNtKOLBn7OorDWDwgfYbg
   M2Bcrsvh9NUDmUaV7AsI71QMVj/FZih54WzUdWX/mMjgv78Fcoe6+ggPb
   2Ffbm38RrcCNeA2cfPp9etLciX37c+or9Kutd9CvavCt6/u7+qG1qyenG
   oLVPFSgWWXIwZFA6T/sDdElB8vQpqD+CKGFdrrELyWKjHMZ8QtUG12sTS
   rggbtHpIWmi7c1FM9fqY/8kiO1Gzv6U3/xE4ppWeEZA89qS442ySE/TQE
   MzA4RkoBcntA6ErxM9+VTL7JBIU+UApkq7bgobxqzareCMV6g5z7jhLTN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420581540"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420581540"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="952982488"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="952982488"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 29 May 2023 22:50:02 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [PATCH 1/2] MAINTAINERS: update Microchip MPF FPGA reviewers
Date:   Tue, 30 May 2023 21:49:35 +0800
Message-Id: <20230530134936.634370-2-yilun.xu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530134936.634370-1-yilun.xu@intel.com>
References: <20230530134936.634370-1-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Ivan Bornyakov <i.bornyakov@metrotek.ru>

As I'm leaving Metrotek, hand over reviewing duty of Microchip MPF FPGA
driver to Vladimir.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20230429104838.5064-2-i.bornyakov@metrotek.ru
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..495f251f984e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13827,7 +13827,7 @@ F:	drivers/tty/serial/8250/8250_pci1xxxx.c
 
 MICROCHIP POLARFIRE FPGA DRIVERS
 M:	Conor Dooley <conor.dooley@microchip.com>
-R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
+R:	Vladimir Georgiev <v.georgiev@metrotek.ru>
 L:	linux-fpga@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
-- 
2.25.1

