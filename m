Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D374E46CE
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 20:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiCVThJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 15:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiCVThI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 15:37:08 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD98A339;
        Tue, 22 Mar 2022 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=62KKeJh+q5ATM9OJzn9594acBT1Ww/JtlIqMCX8BOF0=;
        b=AlGx4T+JBIybBJ6znLE2HlvbsgUn/xr7Y8+FJMayJab0KSzR4qDCXDCAaFy9NUXBe4vzlj1np8hpg
         uNRsj5N8jO3yVMHteZzVM2PpAejsOQYn23gt9kdUxQcIY2pOxR239I/M2SZCEc2rIvXfMeFZHxIXWF
         Ckl6JpGo/yn5/kwJC6MxObcqOIyCCARKDPxK+/i1b6Uhqtvui/0Z9+SISElMRkB/4R4KNUkFFFRvdJ
         QH24Ymo1fhvPsW9hG2ns0dr8ZVPx8Ib3gr5v0MDfQRfNkXxHNqnjeXYehXWUfZo0NQn2eWTl0g+/Cj
         dABsmjBvFAsZWDPAwbWha5g82On5E9w==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000009,0.009160)], BW: [Enabled, t: (0.000022,0.000001)], RTDA: [Enabled, t: (0.064925), Hit: No, Details: v2.28.0; Id: 15.52kce3.1fupi0r7g.v96c; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 22 Mar 2022 22:35:19 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v8 0/2] Microchip Polarfire FPGA manager
Date:   Tue, 22 Mar 2022 22:15:50 +0300
Message-Id: <20220322191552.13156-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support to the FPGA manager for programming Microchip Polarfire
FPGAs over slave SPI interface with .dat formatted bitsream image.

Changelog:
  v1 -> v2: fix printk formating
  v2 -> v3:
   * replace "microsemi" with "microchip"
   * replace prefix "microsemi_fpga_" with "mpf_"
   * more sensible .compatible and .name strings
   * remove unused defines STATUS_SPI_VIOLATION and STATUS_SPI_ERROR
  v3 -> v4: fix unused variable warning
    Put 'mpf_of_ids' definition under conditional compilation, so it
    would not hang unused if CONFIG_OF is not enabled.
  v4 -> v5:
   * prefix defines with MPF_
   * mdelay() -> usleep_range()
   * formatting fixes
   * add DT bindings doc
   * rework fpga_manager_ops.write() to fpga_manager_ops.write_sg()
     We can't parse image header in write_init() because image header
     size is not known beforehand. Thus parsing need to be done in
     fpga_manager_ops.write() callback, but fpga_manager_ops.write()
     also need to be reenterable. On the other hand,
     fpga_manager_ops.write_sg() is called once. Thus, rework usage of
     write() callback to write_sg().
  v5 -> v6: fix patch applying
     I forgot to clean up unrelated local changes which lead to error on
     patch 0001-fpga-microchip-spi-add-Microchip-MPF-FPGA-manager.patch
     applying on vanilla kernel.
  v6 -> v7: fix binding doc to pass dt_binding_check
  v7 -> v8: another fix for dt_binding_check warning

Ivan Bornyakov (2):
  fpga: microchip-spi: add Microchip MPF FPGA manager
  dt-bindings: fpga: add binding doc for microchip-spi fpga mgr

 .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  44 ++
 drivers/fpga/Kconfig                          |  10 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/microchip-spi.c                  | 448 ++++++++++++++++++
 4 files changed, 503 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 create mode 100644 drivers/fpga/microchip-spi.c

-- 
2.34.1


