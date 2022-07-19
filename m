Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD04579860
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jul 2022 13:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiGSLYZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jul 2022 07:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiGSLYX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Jul 2022 07:24:23 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4D1EC66;
        Tue, 19 Jul 2022 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=MVGcC/DTzfP8ZGucES1+UZ9Ncni0QnWl0/Uq2QzEjHM=;
        b=HPWPWY8ZohaXc8X4cikOm9D9XVeNpckywpAY/ZxCe98IPWrnEnMjiGVMOqRotGPJqvrli5S4lo7yi
         qVrAU5OWGSXtc8tZVHHK2Lh4+b3UsehSuHcv507t0EszLxDTZw8RNoACw3rONPWH7rlFDyEVaWlKSA
         ucHiyf13YAxiHTV+dCzRy5V3ap7sI/x47GjdGzvXZ5NrB7x/yGmR3bVr+wlp2/ZsJX9uBeijFjMj/O
         dq39Eg85EYLDPv/LyLuoAyGajM8zXWYytete9ZQrmWYWz0uUn/CX/fIog1ZPJWiunx1NoFUOkFspn3
         kxvoDt1gjoZE+MHMLNX/ixX+IzBAnBg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.008705)], BW: [Enabled, t: (0.000022,0.000002)], RTDA: [Enabled, t: (0.075079), Hit: No, Details: v2.40.0; Id: 15.52kd5h.1g8b36t0c.79k; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 19 Jul 2022 14:24:04 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v5 0/2] Lattice ECP5 FPGA manager
Date:   Tue, 19 Jul 2022 14:23:33 +0300
Message-Id: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
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
  v3 -> v4:
    * dt-bindings: reword description
    * dt-bindings: revert props order
  v4 -> v5:
    * dt-bindings: remove trailing dot from title
    * dt-bindings: reword description to avoid driver reference
    * dt-bindings: add "Reviewed-by: Krzysztof Kozlowski" tag

Ivan Bornyakov (2):
  fpga: ecp5-spi: add Lattice ECP5 FPGA manager
  dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr

 .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  |  74 +++++
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/ecp5-spi.c                       | 275 ++++++++++++++++++
 4 files changed, 357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
 create mode 100644 drivers/fpga/ecp5-spi.c

-- 
2.37.1


