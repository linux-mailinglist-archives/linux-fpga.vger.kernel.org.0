Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125016D1884
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Mar 2023 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCaHVT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 31 Mar 2023 03:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjCaHTF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 31 Mar 2023 03:19:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220E01A474;
        Fri, 31 Mar 2023 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680247139; x=1711783139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BW0Pnq9/Vd1o+EMO1M/RplcR1FECtWKGt07fea6vdfo=;
  b=s5K8pGKj7p9OUMGnnCZen0wHlvdqOTjZZOJ6Zf5j8N/hmV/TSbj81AM3
   02DaE7B8IbiQhAYzEQwfqOUSszGNEDIfwwZ8Nu2XpsW46JqMd1QkGcwxL
   LjE+XdBcRcoPbSE9bquY775zZV9ThBjnaZ+j2h66ILJVCgYdKHewcPUa7
   LuDRv8/fH9UwMcfeFUIRoeU3Vh+DDZzYLFIIhgC/NkxOqgTN/swNzM4+f
   oRgLQd/l1hLQuv/LIeeKjASnhpYiB3DKYknb731rBrrZWlh71JnrKZ1B0
   GNGF6UDlJD5t0Rvb5RpoUx8AJnRCoPkQuOEDtdq632eSoEREIi7XaOwFE
   g==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="scan'208";a="204349769"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 00:18:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 00:18:54 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 00:18:51 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-fpga@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/7] soc: microchip: mpfs: print service status in warning message
Date:   Fri, 31 Mar 2023 08:18:20 +0100
Message-ID: <20230331071823.956087-5-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331071823.956087-1-conor.dooley@microchip.com>
References: <20230331071823.956087-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; i=conor.dooley@microchip.com; h=from:subject; bh=BW0Pnq9/Vd1o+EMO1M/RplcR1FECtWKGt07fea6vdfo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClqnZZlMzbP5rgQfePkXPbN1oVRPcVZNYser3BuEjnxlm3D yeeeHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjID39Ghpv3Gv/w53jzFs5gfyzuxC B38asJS2xr0cytzTOnFR1Xc2L4Kxp3VXXZtpyervZvJyU/rN+xfuqazb7HCg+L5S+qieR/xAMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Now that resp_status is set for failed services, print the status in the
error path's warning.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 5270630c52bf..1b7680e05cc0 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -66,7 +66,9 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
 	 */
 	if (!wait_for_completion_timeout(&sys_controller->c, timeout)) {
 		ret = -EBADMSG;
-		dev_warn(sys_controller->client.dev, "MPFS sys controller service failed\n");
+		dev_warn(sys_controller->client.dev,
+			 "MPFS sys controller service failed with status: %d\n",
+			 msg->response->resp_status);
 	} else {
 		ret = 0;
 	}
-- 
2.39.2

