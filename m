Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E343C4F80D5
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Apr 2022 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbiDGNkQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Apr 2022 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiDGNkO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Apr 2022 09:40:14 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB44D7522F;
        Thu,  7 Apr 2022 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=8xUY+6z0XGg4FC1jk7TlBzJSYvpUJMRLP9Xa5YtemiU=;
        b=U1pyT7hZfk7dG7ZtOMSE//6Ao5/Nqog+vbGZawaRtg6t6k7SMmr5zWUL36MQKpoNcsL4tvQ5BV+eI
         WCGbEg2+6IR1W6NPv13IIJwE4g3u85kEThSlWzbOJU5JsMzuuCo/TGxywjW/wzjpP4GXN0giPuOfN+
         VJqT7BuKmj5SBMMY7ts12swj6itCj+KUvxEPEB/6CMIQ61yDYB8WWUuTqjmwfTdjSv5br9QlaaibpY
         M7dzOMYZJgkN0tA6UmnRLcNC2Ic9+nukNRLqbXPv5G+00fXSvekdXRCF2+wxblcHQ1PVXZaEg21sCi
         dBphaB3uheTGxKOjAiGn+9nNLvcpwgA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000007,0.009301)], BW: [Enabled, t: (0.000019,0.000001)], RTDA: [Enabled, t: (0.075250), Hit: No, Details: v2.34.0; Id: 15.52kd6l.1g023tfl4.d7qj; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 7 Apr 2022 16:37:39 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 0/3] Microchip Polarfire FPGA manager
Date:   Thu,  7 Apr 2022 16:36:55 +0300
Message-Id: <20220407133658.15699-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.25.1
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
  v8 -> v9:
   * add another patch to support bitstream offset in FPGA image buffer
   * rework fpga_manager_ops.write_sg() back to fpga_manager_ops.write()
   * move image header parsing from write() to write_init()

Ivan Bornyakov (3):
  fpga: fpga-mgr: support bitstream offset in image buffer
  fpga: microchip-spi: add Microchip MPF FPGA manager
  dt-bindings: fpga: add binding doc for microchip-spi fpga mgr

 .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  44 ++
 drivers/fpga/Kconfig                          |  10 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/fpga-mgr.c                       |  48 ++-
 drivers/fpga/microchip-spi.c                  | 379 ++++++++++++++++++
 include/linux/fpga/fpga-mgr.h                 |   5 +
 6 files changed, 479 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 create mode 100644 drivers/fpga/microchip-spi.c

-- 
2.25.1


