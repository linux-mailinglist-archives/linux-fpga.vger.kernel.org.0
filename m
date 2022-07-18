Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1029578146
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 13:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiGRLuP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiGRLuO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 07:50:14 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356781AF32;
        Mon, 18 Jul 2022 04:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=Az4oavSHofRE1tjzEMn0br3sl3wRFVDML1JMzXfuTDA=;
        b=C3KHlEpUsVpUb/pQarZwAx8KwTF4fYNeet3f6nNr6FVV4tXjrsfR7YuLIiqKtZnIs7E/44hAcdAie
         OzAGd0YnDyFQFWpaT7wkL+yuV/1izlU6oytilUrf9OST6KdmNuuLdiHZ4fYyoYZvsRdsoUL+Ca5jp7
         C0tJy0Hf4wa0ggLwfTouPFoZI8hycmxz9REM5qUoDdevY7sOKezsqvZOKJGF3TT4Qr9QHsXas4K87l
         IrHPA5H/ZxAzwCNDSmX1/tdFSldNhQ3StjV7RMt+aP5tnwP80g1Q+CaOzQk/XsuIblmya5C5afobF9
         2KR/cjewR0WOka6i+kmJPi0AdVxSb+w==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.005318)], BW: [Enabled, t: (0.000020,0.000001)], RTDA: [Enabled, t: (0.073412), Hit: No, Details: v2.40.0; Id: 15.52k50a.1g88i9ga0.357fm; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 18 Jul 2022 14:49:55 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v3 0/2] Lattice ECP5 FPGA manager
Date:   Mon, 18 Jul 2022 14:49:26 +0300
Message-Id: <20220718114928.22092-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support to the FPGA manager for programming Lattice ECP5 FPGA over
slave SPI interface with .bit formatted uncompressed bitstream image.

ChangeLog:
  v1 -> v2:
    * remove "spi" from compatible string
    * reword description in dt-bindings doc
    * add reference to spi-peripheral-props.yaml in dt-binding doc
    * fix DTS example in dt-bindings doc: 4-spaces indentations, no
      undersores in node names.
  v2 -> v3:
    * fix typo "##size-cells" -> "#size-cells" in dt-bindings example

Ivan Bornyakov (2):
  fpga: ecp5-spi: add Lattice ECP5 FPGA manager
  dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr

 .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  |  73 +++++
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/ecp5-spi.c                       | 275 ++++++++++++++++++
 4 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
 create mode 100644 drivers/fpga/ecp5-spi.c

-- 
2.37.1


