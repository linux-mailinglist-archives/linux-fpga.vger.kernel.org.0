Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888FE5B6E03
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Sep 2022 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiIMNIw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Sep 2022 09:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiIMNIw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Sep 2022 09:08:52 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CED1E3FA;
        Tue, 13 Sep 2022 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=WBz/rjXGOdhwhVARtVILBQsu7MNnXU9qJwYhGzFjpfM=;
        b=WZ7f8ttOA6ip+QYGBpxXtHfnJQCTrmEjTIEYAytPVAK/kzHj4ipnv5J6IIn/Y1LPriZ/5SZksSACk
         O+oL2UzmI9QhyGA1//5MS/UjZJbCtCmT7SVRiKXHX1ETX7FZsrIsgMR6dar2GMzX369NIteSZyW3Tn
         Ulj3QVXdIPtyUbTJTcMfcnXabZYc77gdqMcu4da3wX6IQ0wPxlT5ZnWdo9mqasCTlCZZl19H8OS1L6
         YXOuCzUTeR3KBPV/xkoYyHTcyhAlBD0ztGWf9aW8ghhhW0vmfnm4Sa97gf/eti4jr9xGdhKvVew4O6
         2O+b8SJ9whJVeO2s3SSGr/QeIQHRd4Q==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000012,0.018280)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.082283), Hit: No, Details: v2.41.0; Id: 15.52k97s.1gcrfem3c.2auhd; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 13 Sep 2022 16:08:40 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        system@metrotek.ru
Subject: [PATCH v11 0/2] Lattice sysCONFIG SPI FPGA manager
Date:   Tue, 13 Sep 2022 16:07:12 +0300
Message-Id: <20220913130714.31404-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.3
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
  v7 -> v8:
    * dt-bindings: move "program-gpios", "init-gpios" and "done-gpios"
      to top-level properties and disallow them for MachXO2 variant.
  v8 -> v9:
    * dt-bindings: "program-gpios", "init-gpios" and "done-gpios" are
      now optional for both ECP5 and MachXO2
    * lattice-sysconfig-spi.c -> sysconfig-spi.c + sysconfig.c +
      sysconfig.h
        ** reworked to be one sysCONFIG FPGA Manager rather than two
	   distinct ECP5 and MachXO2 managers
	** splitted to port type agnostic sysconfig.c and SPI-specific
	   sysconfig-spi.c
	** command transfer function moved to callback for ease of
	   adding another port type, such as I2C
  v9 -> v10:
    * split sysconfig_transfer() callback into separate command_write()
      and command_write_then_read(). There are too many transfers
      without readback.
    * add command_write_with_data() callback which performs single
      transfer of command + data. It's needed for better abstraction of
      paged bitstream write routine.
    * move sysconfig_lsc_burst_init() to bitstream_burst_write_init()
      callback to break dependence of sysconfig.c from sysconfig-spi.c
    * move sysconfig_lsc_burst_complete() to bitstream_burst_write_complete()
      callback to break dependence of sysconfig.c from sysconfig-spi.c
    * add bitstream_burst_write() to abstract fpga_manager_ops->write()
      from bus type
    * remove struct spi_device from struct sysconfig_priv, use
      to_spi_device()
    * move fpga_manager_ops initialization to sysconfig.c
  v10 -> v11:
    * rename sysconfig_lsc_burst_init() to sysconfig_spi_lsc_burst_init()
    * rename sysconfig_bitstream_burst_write() to
      sysconfig_spi_bitstream_burst_write()
    * rename sysconfig_lsc_burst_complete() to
      sysconfig_spi_lsc_burst_complete()
    * rename "ecp5-fpga-mgr" to "sysconfig-ecp5"
    * rename "machxo2-fpga-mgr" to "sysconfig-machxo2"
    * move spi_max_speed_hz from struct sysconfig_fpga_priv to
      struct sysconfig_spi_fpga_priv, which is local to sysconfig-spi.c
    * remove SPI bus unlock on write error form
      sysconfig_spi_bitstream_burst_write(), call
      sysconfig_burst_write_complete() on error in
      sysconfig_bitstream_burst_write() instead.

Ivan Bornyakov (2):
  fpga: lattice-sysconfig-spi: add Lattice sysCONFIG FPGA manager
  dt-bindings: fpga: document Lattice sysCONFIG FPGA manager

 .../bindings/fpga/lattice,sysconfig.yaml      | 102 ++++
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/sysconfig-spi.c                  | 210 +++++++
 drivers/fpga/sysconfig.c                      | 528 ++++++++++++++++++
 drivers/fpga/sysconfig.h                      |  62 ++
 6 files changed, 912 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
 create mode 100644 drivers/fpga/sysconfig-spi.c
 create mode 100644 drivers/fpga/sysconfig.c
 create mode 100644 drivers/fpga/sysconfig.h

-- 
2.37.3


