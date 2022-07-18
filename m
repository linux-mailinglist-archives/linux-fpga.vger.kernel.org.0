Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7D577F82
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 12:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiGRKSY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 06:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiGRKSW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 06:18:22 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274371C10E;
        Mon, 18 Jul 2022 03:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=361GlAOjaVC6iQCp4ICBbf1IUnMKPBe4+3+rUuv8yz4=;
        b=XjoF/d7feQyf89mvadYwoLP8AT1e9YINGKvyIupzY8E4llXJrkn+QYlTChU1eQe8/HHRWG+sQlUzp
         p/Tsxde6uREQPqevRCjFEKtIZV/o5KsoGbrERW/1s2zuy1HFbqVEEkDsf8BpM3qYbANxkRD5vKRsYj
         0amc5z6RnufiFL9g650HX96YRwWD3GI7rhWiUDmQKv/jIt1qyXROD8tAWdcVAYzy8MOVwso/uVTjrr
         Qi7ovkhtn6gWECelBuFlFhpC8ZUYLw03xnEZjCuEO/pyjcVC2u69SgFFu476gRCljlIczHjOvlnizY
         iYIEjUTdtFr4FfaZ/mhP+KS2Q55tnxQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.005102)], BW: [Enabled, t: (0.000012,0.000001)], RTDA: [Enabled, t: (0.076699), Hit: No, Details: v2.40.0; Id: 15.52k88b.1g88d1606.36eq6; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 18 Jul 2022 13:18:01 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v2 0/2] Lattice ECP5 FPGA manager
Date:   Mon, 18 Jul 2022 13:17:33 +0300
Message-Id: <20220718101735.26696-1-i.bornyakov@metrotek.ru>
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


