Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0560759FDD1
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 17:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiHXPDC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Aug 2022 11:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiHXPDA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 24 Aug 2022 11:03:00 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A26901B3;
        Wed, 24 Aug 2022 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=dKKj2XiJiPISvRFKj7mprTx5FT4U88/otN6k4wC2i0Q=;
        b=eW1zmmxByi0xrwd2BEwCcEB6CbVbfghcTYN0KnbabwPbn7YLo17mR9E35Cla8KFkgJWVvTfa8u0xc
         3msfg51EwDcOwEMwhZtHkD0tOaFDQA+8+mpy5COxcs3D+X0vEGc4GNsNjEams8QcEauniJmpIaYBRP
         3qVoVCIGvZUAqx10jSYC0PKxhrZn9yt9dtLqU9BygA3KiFIiiW2macv7vCRf9uP+t4iEZQ+Wia3Ac2
         CNNx5t5pBVU7SAPP4s5k4sWMKdCq5E+5jvj63CrOsLT5grC4yY3SVuut06Ox9Xtx0cGRLUim+jlDXD
         bzQW1REZO3D7ku7bb2/2id1qdWPu3hQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000010,0.009934)], BW: [Enabled, t: (0.000016,0.000001)], RTDA: [Enabled, t: (0.078946), Hit: No, Details: v2.41.0; Id: 15.52k01o.1gb8608vv.5t; mclb], total: 0(700)
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
        Wed, 24 Aug 2022 18:02:15 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v7 0/2] Lattice sysCONFIG SPI FPGA manager
Date:   Wed, 24 Aug 2022 18:01:12 +0300
Message-Id: <20220824150114.17504-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support to the FPGA manager for programming Lattice FPGAs over slave
SPI sysCONFIG interface. ECP5 and MachXO2 are supported.

WARNING: I only have HW with ECP5, so can't vouch for the MachXO2.
	 MachXO2's support is based on existing machxo2-spi.c and
	 publicly available documentation, it's not tested on real
	 hardware.

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
  v5 -> v6:
    * ecp5-spi: lock SPI bus for exclusive usage in
      ecp5_ops_write_init(), release in ecp5_ops_write_complete()
      or on error
  v6 -> v7:
    * ecp5-spi.c -> lattice-sysconfig-spi.c. Reworked to represent
      generalized sysCONFIG port with implementations for ECP5 and
      MachXO2
    * lattice,ecp5-fpga-mgr.yaml -> lattice,sysconfig.yaml. Reworked to
      document both ECP5 and MachXO2 sysCONFIG.
    * dt-bindings: remove "Reviewed-by: Krzysztof Kozlowski" tag as doc
      was rewritten by a considerable amount.

Ivan Bornyakov (2):
  fpga: lattice-sysconfig-spi: add Lattice sysCONFIG FPGA manager
  dt-bindings: fpga: document Lattice sysCONFIG FPGA manager

 .../bindings/fpga/lattice,sysconfig.yaml      | 103 +++
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/lattice-sysconfig-spi.c          | 630 ++++++++++++++++++
 4 files changed, 741 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
 create mode 100644 drivers/fpga/lattice-sysconfig-spi.c

-- 
2.37.2


