Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2C05F8514
	for <lists+linux-fpga@lfdr.de>; Sat,  8 Oct 2022 13:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiJHLml (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 8 Oct 2022 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJHLmj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 8 Oct 2022 07:42:39 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A04476F9;
        Sat,  8 Oct 2022 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=ZTU/Y9oerBPaX90dkCUQBDDvgMa5WzjvoEElFllihFs=;
        b=cfPq88tBNBjOV7fvSQXW6NrvS+p7skjOSQHYKa6ZgRAxpnRZSBWWaOaoYtPeVpkJLKmfDdW+2Yh83
         FybP+eiY8JB6nrwfVSuUI6uCLIXyvwD/l/l/25dR3k8E9Ar+pLAQBTdGgFeUMkPDC3FWA7kclmIdk/
         wJ7QEDx5lCYU+IMWOfTwkeEq41MUjEVEqN9hUkjclP7AkmOO62FCvVXRVwjnoMJ0/c+5Zz/eI6+cGz
         bhc69jjiabTpInqkmXDB4OvRyqUu2r2j6TL6o1F0cT91cdG8HGOz0/X7SYlvYY7SzhAuGlQ94PYZcj
         dukl7oT+zQWwilQlLS3fAbOYbsRM+gg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000017,0.026032)], BW: [Enabled, t: (0.000024,0.000001)], RTDA: [Enabled, t: (0.152781), Hit: No, Details: v2.42.0; Id: 15.52k59h.1germemks.2lhje; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([92.100.86.33])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sat, 8 Oct 2022 14:42:24 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <brnkv.i1@gmail.com>, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: [PATCH v15 0/2] Lattice sysCONFIG SPI FPGA manager
Date:   Sat,  8 Oct 2022 14:14:17 +0300
Message-Id: <20221008111419.21245-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Ivan Bornyakov <brnkv.i1@gmail.com>

Add support to the FPGA manager for programming Lattice ECP5 FPGA over
slave SPI sysCONFIG interface.

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
  v11 -> v12:
    * build sysconfig core as separate module to prevent duplication of
      common code segments across different binaries
    * rename sysconfig.c to lattice-sysconfig.c
    * rename sysconfig.h to lattice-sysconfig.h
    * rename sysconfig-spi.c to lattice-sysconfig-spi.c
    * rename sysconfig_spi_cmd_write_then_read() to
      sysconfig_spi_cmd_read()
    * rename command_write_then_read() callback to command_read()
    * rename sysconfig_cmd_write_then_read() to sysconfig_cmd_read()
    * rename sysconfig_spi_lsc_burst_init() to
      sysconfig_spi_bitstream_burst_init()
    * rename sysconfig_spi_lsc_burst_complete() to
      sysconfig_spi_bitstream_burst_complete()
    * remove excessive !spi check from sysconfig_spi_cmd_write(),
      sysconfig_spi_cmd_read(), sysconfig_spi_bitstream_burst_init(),
      sysconfig_spi_bitstream_burst_write() and
      sysconfig_spi_bitstream_burst_complete()
    * drop MachXO2 support
        ** drop struct sysconfig_fpga_priv
        ** drop paged write
        ** drop command_write_with_data() and friends
        ** drop ISC_PROGRAM_DONE routine
        ** drop refresh from sysconfig_isc_finish()
        ** sysconfig_isc_erase() only erase SRAM
	** drop MachXO2 mentions from DT bindings doc
  v12 -> v13:
    * use device_get_match_data() instead of of_device_get_match_data()
      and drop of_device.h inclusion
    * in polling routines use time_before(jiffies, timeout) instead of
      retries count
    * add usleep_range() to gpio polling routine
    * check fail status of command in more pronounced way
    * check definition of sysconfig_priv callbacks at probe
    * (BIT(23) | BIT(24) | BIT(25)) -> GENMASK(25, 23)
  v13 -> v14:
    * return -ETIMEDOUT instead of -EBUSY from sysconfig_poll_busy() to
      align with sysconfig_poll_gpio()
  v14 -> v15:
    * move sysCONFIG commands from stack to heap, as spi-summary doc
      says: "I/O buffers use the usual Linux rules, and must be
      DMA-safe. [...] Don't use the stack, or anything that's declared
      "static"."
        ** add u8 cmd_tx_buf[4] and u8 cmd_rx_buf[4] to
	   struct sysconfig_priv
	** copy commands to cmd_tx_buf before sending to the device
	** use cmd_rx_buf for commands readback
	** change command_write() and command_read() signatures, as
	   command buffers are now embedded to sysconfig_priv
	** combine sysconfig_read_busy() with sysconfig_poll_busy() to
	   avoid same memcpy in the loop

Ivan Bornyakov (2):
  fpga: lattice-sysconfig-spi: add Lattice sysCONFIG FPGA manager
  dt-bindings: fpga: document Lattice sysCONFIG FPGA manager

 .../bindings/fpga/lattice,sysconfig.yaml      |  81 ++++
 drivers/fpga/Kconfig                          |  11 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/lattice-sysconfig-spi.c          | 151 +++++++
 drivers/fpga/lattice-sysconfig.c              | 425 ++++++++++++++++++
 drivers/fpga/lattice-sysconfig.h              |  42 ++
 6 files changed, 712 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
 create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
 create mode 100644 drivers/fpga/lattice-sysconfig.c
 create mode 100644 drivers/fpga/lattice-sysconfig.h

-- 
2.35.1


