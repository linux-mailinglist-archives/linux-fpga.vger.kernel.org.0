Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D459574D95
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Jul 2022 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiGNM2D (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jul 2022 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbiGNM2C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 14 Jul 2022 08:28:02 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572C31FCCD;
        Thu, 14 Jul 2022 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=TTVeDdTZppuU0+270WB0rurmHSeNMZRcvP/GSlEu0HQ=;
        b=bGxgqdYUGE4fIvoeYkZ6QZaoc0mV7DQSOeeVR9K3FmZ8ZbLXPfTCGiLv6RZXDQqFqRS4l7bPVfBW8
         w0rG2cT3tK4247uR4qIl3WonQcQ99A8jUMA6r7s0AKYyT7zykTMh859KMxaZOBy31e0BEhcRIlIkLM
         gv9snTqd4Z3k4NpKmR+iMKeXoBg6Y2LLx1OuqnpuC6d1tb7AvYiiOsy4GNfQyJHm5bcCZkxGTu8jRP
         +kuwJ0oEbHD5m/rTfBW3aIBcPS4nDwO1tcIbg1OAxf+kYOSVWuW6BU1tu14ghLqnIq+MLwWux1YyNi
         +AYhYtIeGp6jhWWaK+INpZ2v4CuftHw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.004256)], BW: [Enabled, t: (0.000016,0.000001)], RTDA: [Enabled, t: (0.073446), Hit: No, Details: v2.40.0; Id: 15.52k0gr.1g7uar6kr.1oqm8; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 14 Jul 2022 15:27:20 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH 0/2] Lattice ECP5 FPGA manager
Date:   Thu, 14 Jul 2022 15:26:55 +0300
Message-Id: <20220714122657.17972-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support to the FPGA manager for programming Lattice ECP5 FPGA over
slave SPI interface with .bit formatted uncompressed bitstream image.

Ivan Bornyakov (2):
  fpga: ecp5-spi: add Lattice ECP5 FPGA manager
  dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr

 .../fpga/lattice,ecp5-spi-fpga-mgr.yaml       |  71 +++++
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/ecp5-spi.c                       | 275 ++++++++++++++++++
 4 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
 create mode 100644 drivers/fpga/ecp5-spi.c

-- 
2.37.0


