Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E55839D9
	for <lists+linux-fpga@lfdr.de>; Thu, 28 Jul 2022 09:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiG1HuU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Jul 2022 03:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiG1HuS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Jul 2022 03:50:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41A9C5C;
        Thu, 28 Jul 2022 00:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658994616; x=1690530616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o4pnJhY7mraS2VGKVwb+l8R6wlC0HBmI1+aRG7ocfFM=;
  b=VuiGL23AEE7SQdU9CbpBC2kL6Ab44r7UgRUd2Twhjbeuk9q0FKjLnlFR
   00yBTgm0193O6Z7o442KKYRxf0qCxky0qXz4AJGzODqm77L8F/AYFbEIp
   ZOhtLo+cNh7ynXduHRHyvJwe36pK2if8iiMfEhYm90RA/VSljDAxsm0vN
   z0ijTLAvHQGw9Ou94VzXPFKH+Y0xN57r2wDaMeE3ppAFNOipLWxFiW9Fz
   pSVtHUsn53ZI/kqjVHEnaa0N3YMtbRcPE4AbIBjM7kf+riG3YGZBu2c/A
   EKnczeqTgjbrRWgVij+E56u3M1wu+Z+on2f7R9utTHNq0ycraYbGSw2W8
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="106487892"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2022 00:50:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 28 Jul 2022 00:50:07 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 28 Jul 2022 00:50:05 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fpga: microchip-spi: add missing module author entry
Date:   Thu, 28 Jul 2022 08:50:13 +0100
Message-ID: <20220728075012.3136914-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add the missing MODULE_AUTHOR entry for the Microchip spi-slave FPGA
programming driver.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/fpga/microchip-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index bd284c7b8dc9..7436976ea904 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -395,4 +395,5 @@ static struct spi_driver mpf_driver = {
 module_spi_driver(mpf_driver);
 
 MODULE_DESCRIPTION("Microchip Polarfire SPI FPGA Manager");
+MODULE_AUTHOR("Ivan Bornyakov <i.bornyakov@metrotek.ru>");
 MODULE_LICENSE("GPL");
-- 
2.36.1

