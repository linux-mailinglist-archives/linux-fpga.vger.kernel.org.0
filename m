Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DC05A1326
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiHYOOo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbiHYOO2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC905AA4EF
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-0002wH-1V; Thu, 25 Aug 2022 16:14:16 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcd-001umh-0C; Thu, 25 Aug 2022 16:14:15 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcb-005xw1-RL; Thu, 25 Aug 2022 16:14:13 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de
Subject: [PATCH 00/16] Add support for Lattice MachXO2 programming via I2C
Date:   Thu, 25 Aug 2022 16:13:27 +0200
Message-Id: <20220825141343.1375690-1-j.zink@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jzi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Lattice MachXO2 FPGAs have internal configuration flash which can be
reprogrammed over different interfaces. The former driver implementation
supported programming via SPI, this patch series adds programming via
I2C.

The first 4 patches convert the MachXO2 Slave binding from textual
format to YAML and add additional features like different flash areas to
be erased upon a programming cycle, a GPIO which can be used to
explicitely initialize the programming sequence, and finally I2C as
additional programming interface.

The following 10 patches clean up and refactor the previous machxo2-spi
driver code, extract functionalities common to both spi and i2c
programming interfaces as a preparation, add additional flash areas to
be erased and signalling for start of the programming sequence via gpio.

Since the original driver did not yield enough time to erase machxo2
variants with large flash memory, a variation of erase timeout handling
is added with another patch, introducing a more datasheet conformant way
of dealing with large flash sizes due to larger LUT counts.

The final patch adds the I2C bus as an additional interface for
programming.

Johannes Zink (15):
  dt-bindings: fpga: convert Lattice MachXO2 Slave binding to YAML
  dt-bindings: fpga: machxo2-slave: add erasure properties
  dt-bindings: fpga: machxo2-slave: add pin for program sequence init
  dt-bindings: fpga: machxo2-slave: add lattice,machxo2-slave-i2c
    compatible
  fpga: machxo2-spi: remove #ifdef DEBUG
  fpga: machxo2-spi: factor out status check for readability
  fpga: machxo2-spi: fix big-endianness incompatibility
  fpga: machxo2-spi: simplify with spi_sync_transfer()
  fpga: machxo2-spi: simplify spi write commands
  fpga: machxo2-spi: prepare extraction of common code
  fpga: machxo2: move non-spi-related functionality to common code
  fpga: machxo2: improve status register dump
  fpga: machxo2: add optional additional flash areas to be erased
  fpga: machxo2: add program initialization signalling via gpio
  fpga: machxo2: extend erase timeout for machxo2 FPGA

Peter Jensen (1):
  fpga: machxo2: add configuration over i2c

 .../bindings/fpga/lattice,machxo2-slave.yaml  |  80 ++++
 .../bindings/fpga/lattice-machxo2-spi.txt     |  29 --
 drivers/fpga/Kconfig                          |  14 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/machxo2-common.c                 | 392 ++++++++++++++++++
 drivers/fpga/machxo2-common.h                 |  43 ++
 drivers/fpga/machxo2-i2c.c                    | 137 ++++++
 drivers/fpga/machxo2-spi.c                    | 366 ++--------------
 8 files changed, 712 insertions(+), 351 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
 delete mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 drivers/fpga/machxo2-common.c
 create mode 100644 drivers/fpga/machxo2-common.h
 create mode 100644 drivers/fpga/machxo2-i2c.c

-- 
2.30.2

