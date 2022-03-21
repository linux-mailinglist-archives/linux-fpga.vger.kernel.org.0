Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7594E2314
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Mar 2022 10:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbiCUJOm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Mar 2022 05:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345725AbiCUJOi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Mar 2022 05:14:38 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C6822536;
        Mon, 21 Mar 2022 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=kwm1/K+GoiGCtITPF5P1uygRjlMoM0iA7fuVQFLC+T8=;
        b=hZnUrkiRYEar6Gdusyb6BAJgCjfnMYQGim3sFznl5Ir/WYr8l3LBprSB1Wp3mA1aWPoNaHpHoHZeU
         2/XUA4QjXaIEQx9l75cjvUp7paVAHuXdHYLbYE21LPkfCBpao0v8Z/yXEJ03Ex4HL7J3jASZLekK4f
         RumJZzMAO07ZGCEQBc/z1650U9gY3TYbygmtmvZ6j/lMz8CVXgLiXvj8OQvpn0E3qD2OsPZmkVCplM
         inxNo1Ks+0nPuG9BJ2JDf3tkk3gCiDq7dtiZeMOBMngonMnLg8e+z5Xcb348pE7tMvkdHo0TU04O3y
         Kbi8lH0Qu1kF2GejJsAj3Jv4SSd1jJQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000008,0.007924)], BW: [Enabled, t: (0.000021,0.000002)], RTDA: [Enabled, t: (0.077207), Hit: No, Details: v2.28.0; Id: 15.52kce3.1fuls0elk.3s8m; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 21 Mar 2022 12:12:55 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] Microchip Polarfire FPGA manager
Date:   Mon, 21 Mar 2022 11:53:40 +0300
Message-Id: <20220321085342.22228-1-i.bornyakov@metrotek.ru>
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

Ivan Bornyakov (2):
  fpga: microchip-spi: add Microchip MPF FPGA manager
  dt-bindings: fpga: add binding doc for microchip-spi fpga mgr

 .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  32 ++
 drivers/fpga/Kconfig                          |  10 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/microchip-spi.c                  | 448 ++++++++++++++++++
 4 files changed, 491 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 create mode 100644 drivers/fpga/microchip-spi.c

-- 
2.34.1


