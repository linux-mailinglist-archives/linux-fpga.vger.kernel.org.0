Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA236D186C
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Mar 2023 09:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCaHSz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 31 Mar 2023 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjCaHSx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 31 Mar 2023 03:18:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615EAAF08;
        Fri, 31 Mar 2023 00:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680247126; x=1711783126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=admgRHBqiFlgszn7eKUdyOKDiJrJarBBjh/92wZzpo8=;
  b=WQyCHxjkrkP+h9DtaocHVu5vPDQN6eTK8ECqqWSKnHkq6EAKp+TYE8jU
   uvrhoTKWWNNlx9MTxMUtshRdVstJaahAJtbe3uhSveULb0V5mC6DgflL8
   BP1x4Vp1SfBzl9a2EtWTOdnIJqjSBbfrIg6UMWr9NVXlU29agj5pD1+Pb
   3WjZ0kadkOfm6NvwW7PMX12rdT9n6PAVgtwAYnPbMM+WuuwZQsEgJaa1S
   hD6BtHj7M9ekXktPIYFo9XcgbHKxyglOM79aI7pHue0f9uKfGEA0409ws
   2NzKPcaLx16Xcfi9BHI6tcJcbR86OseYKPTry+lJvdvQhGOwxCP5IquoC
   w==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="scan'208";a="218823289"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 00:18:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 00:18:43 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 00:18:41 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-fpga@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7] PolarFire SoC Auto Update Support
Date:   Fri, 31 Mar 2023 08:18:16 +0100
Message-ID: <20230331071823.956087-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3495; i=conor.dooley@microchip.com; h=from:subject; bh=admgRHBqiFlgszn7eKUdyOKDiJrJarBBjh/92wZzpo8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClqnZYe/vKO79U8tFX0/79wTjwUZ/yYac9WjcvSdTOU9MJi Tut0lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCIvnRkZdtwQ/D43rPTb81dP3qfL+2 8t2fLweeW0h6qzRCSVtu6LkmD4HxcklPTpHs/SG+fntUe46vg9/Ftrc6zHZ9orJx77lWcLuQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hey all,

This patchset adds support for the "Auto Update" feature on PolarFire
SoC that allows for writing an FPGA bistream to the SPI flash connected
to the system controller.
On powercycle (or reboot depending on how the firmware implements the
openSBI SRST extension) "Auto Update" will take place, and program the
FPGA with the contents of the SPI flash - provided that that image is
valid and an actual upgrade from that already programmed!

Unfortunately, this series is not really testable yet - the Engineering
Sample silicon on most dev boards has a bug in the QSPI controller
connected to the system controller's flash and cannot access it.
Pre-production and later silicon has this bug fixed.

I previously posted an RFC about my approach in this driver, since as a
flash-based FPGA we are somewhat different to the existing
self-reprogramming drivers here. That RFC is here:
https://lore.kernel.org/linux-fpga/20221121225748.124900-1-conor@kernel.org/

This series depends on the following fixes:
https://lore.kernel.org/all/d7c3ec51-8493-444a-bdec-2a30b0a15bdc@spud/

The patch adding the driver depends on the soc patches earlier in the
series, so taking both through the same tree makes sense. Depending on
sequencing with the dependencies, me taking it through the soc tree
(with Acks etc of course) may make the most sense.

Cheers,
Conor.

Changes in v2:
- per Russ' suggestion, the driver has been switched to using the
  firmware-upload API rather than the fpga one
- as a result of that change, the structure of the driver has changed
  significantly, although most of that is reshuffling existing code
  around
- check if the upgrade is possible in probe and fail if it isn't
- only write the image index if it is not already set
- delete the now unneeded debugfs bits

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Moritz Fischer <mdf@kernel.org>
CC: Wu Hao <hao.wu@intel.com>
CC: Xu Yilun <yilun.xu@intel.com>
CC: Tom Rix <trix@redhat.com>
CC; Russ Weight <russell.h.weight@intel.com>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-fpga@vger.kernel.org

Conor Dooley (7):
  soc: microchip: mpfs: add a prefix to rx_callback()
  dt-bindings: soc: microchip: add a property for system controller
    flash
  soc: microchip: mpfs: enable access to the system controller's flash
  soc: microchip: mpfs: print service status in warning message
  soc: microchip: mpfs: add auto-update subdev to system controller
  fpga: add PolarFire SoC Auto Update support
  riscv: dts: microchip: add the mpfs' system controller qspi &
    associated flash

 .../microchip,mpfs-sys-controller.yaml        |  10 +
 .../boot/dts/microchip/mpfs-icicle-kit.dts    |  21 +
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  24 +-
 drivers/fpga/Kconfig                          |  11 +
 drivers/fpga/Makefile                         |   3 +-
 drivers/fpga/microchip-auto-update.c          | 494 ++++++++++++++++++
 drivers/soc/microchip/Kconfig                 |   1 +
 drivers/soc/microchip/mpfs-sys-controller.c   |  37 +-
 include/soc/microchip/mpfs.h                  |   2 +
 9 files changed, 591 insertions(+), 12 deletions(-)
 create mode 100644 drivers/fpga/microchip-auto-update.c

-- 
2.39.2

