Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469F26D361D
	for <lists+linux-fpga@lfdr.de>; Sun,  2 Apr 2023 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjDBIMT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 2 Apr 2023 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBIMS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 2 Apr 2023 04:12:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C66EB7E;
        Sun,  2 Apr 2023 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680423137; x=1711959137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vJzYzObt+0tswbNIyNBkxTex9FQdktq8tuwEvNZt8w8=;
  b=h35jMJO6lghJNWfxHwKKdL5AYmS5rnQ1Ei3cmUnlZtSzHfvCff1sHp1K
   AdoYYDoVl8kE1ox8wFfScz3tH3i8ZaWZLdtptesYMaUcrUN+ZuQmeXZAH
   m12+GGRj29LnHh3Xf8H+Lo/Q9RCVQEc8KAbXn3ByLHSGwj6cyTmL5STUy
   m4javTMFjoEWLAbUM9io30SKQMbW5+AomzkZOsSqYLW0IH4Vwz0nspgK8
   4rBGZv5gpNMnCBlO4jyo1HK7mN8NmgY+tRnv4QEqwjcbUY9P3cYcb22s8
   joFjNQ/OAW0FINvIlXBsiuBhF30JwHKmtsGuU2z5MNYUjMDTT47BRiCa+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="340444910"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="340444910"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 01:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="931673352"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="931673352"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2023 01:12:14 -0700
Date:   Sun, 2 Apr 2023 16:00:34 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-fpga@vger.kernel.org, conor@kernel.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PolarFire SoC Auto Update Support
Message-ID: <ZCk2IgDjHRUlyD+t@yilunxu-OptiPlex-7050>
References: <20230331071823.956087-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331071823.956087-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-31 at 08:18:16 +0100, Conor Dooley wrote:
> Hey all,
> 
> This patchset adds support for the "Auto Update" feature on PolarFire
> SoC that allows for writing an FPGA bistream to the SPI flash connected
> to the system controller.
> On powercycle (or reboot depending on how the firmware implements the
> openSBI SRST extension) "Auto Update" will take place, and program the
> FPGA with the contents of the SPI flash - provided that that image is
> valid and an actual upgrade from that already programmed!
> 
> Unfortunately, this series is not really testable yet - the Engineering
> Sample silicon on most dev boards has a bug in the QSPI controller
> connected to the system controller's flash and cannot access it.
> Pre-production and later silicon has this bug fixed.
> 
> I previously posted an RFC about my approach in this driver, since as a
> flash-based FPGA we are somewhat different to the existing
> self-reprogramming drivers here. That RFC is here:
> https://lore.kernel.org/linux-fpga/20221121225748.124900-1-conor@kernel.org/
> 
> This series depends on the following fixes:
> https://lore.kernel.org/all/d7c3ec51-8493-444a-bdec-2a30b0a15bdc@spud/

Is that series already merged? If yes, just remove this line.
If no, either put all of them in one series, or still make this series
as RFC until the dependency is resolved.

Thanks,
Yilun

> 
> The patch adding the driver depends on the soc patches earlier in the
> series, so taking both through the same tree makes sense. Depending on
> sequencing with the dependencies, me taking it through the soc tree
> (with Acks etc of course) may make the most sense.
> 
> Cheers,
> Conor.
> 
> Changes in v2:
> - per Russ' suggestion, the driver has been switched to using the
>   firmware-upload API rather than the fpga one
> - as a result of that change, the structure of the driver has changed
>   significantly, although most of that is reshuffling existing code
>   around
> - check if the upgrade is possible in probe and fail if it isn't
> - only write the image index if it is not already set
> - delete the now unneeded debugfs bits
> 
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Moritz Fischer <mdf@kernel.org>
> CC: Wu Hao <hao.wu@intel.com>
> CC: Xu Yilun <yilun.xu@intel.com>
> CC: Tom Rix <trix@redhat.com>
> CC; Russ Weight <russell.h.weight@intel.com>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-fpga@vger.kernel.org
> 
> Conor Dooley (7):
>   soc: microchip: mpfs: add a prefix to rx_callback()
>   dt-bindings: soc: microchip: add a property for system controller
>     flash
>   soc: microchip: mpfs: enable access to the system controller's flash
>   soc: microchip: mpfs: print service status in warning message
>   soc: microchip: mpfs: add auto-update subdev to system controller
>   fpga: add PolarFire SoC Auto Update support
>   riscv: dts: microchip: add the mpfs' system controller qspi &
>     associated flash
> 
>  .../microchip,mpfs-sys-controller.yaml        |  10 +
>  .../boot/dts/microchip/mpfs-icicle-kit.dts    |  21 +
>  arch/riscv/boot/dts/microchip/mpfs.dtsi       |  24 +-
>  drivers/fpga/Kconfig                          |  11 +
>  drivers/fpga/Makefile                         |   3 +-
>  drivers/fpga/microchip-auto-update.c          | 494 ++++++++++++++++++
>  drivers/soc/microchip/Kconfig                 |   1 +
>  drivers/soc/microchip/mpfs-sys-controller.c   |  37 +-
>  include/soc/microchip/mpfs.h                  |   2 +
>  9 files changed, 591 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/fpga/microchip-auto-update.c
> 
> -- 
> 2.39.2
> 
