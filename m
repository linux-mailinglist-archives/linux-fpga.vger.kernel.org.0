Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC42A6A17BB
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 09:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBXIIZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 03:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXIIY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 03:08:24 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A425E09;
        Fri, 24 Feb 2023 00:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677226103; x=1708762103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tK3PjEZic4TnRDEQrMnzOsYQnpHOQ7k2HFJWHp2ltd0=;
  b=LoqUQLTt/nN7gQE02bP0bsyRjO5jiomkf+/5oCmaTdrdcPaQoBeE78kv
   vh8tZCsViquh9qKpwl3+NF2Awuberg5Fzt2eHIcbOUGdePZBj61ZCMnJ5
   VvP7DIktxxyPT7qF67X/Y7FBKOrYbOEw/yYHnt28fo9eMRLinpeKxAPtZ
   3quASQt4wyt6gyGb+YXq7c/OMn9AsT6e2aF2HPa0unf14GPf+5g4J5HZv
   pfZTa/7XNFhpK/17xgZuR2ZGvp+94xmG5sWIyjCydQXY5ao5JXmPHNxnu
   L3vJZY9XOR+krM8i+MMNvKVeVvvZMGpw9zFZrf/yUeuDc/suoHmuyy5J5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="332108176"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="332108176"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 00:08:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="736718256"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="736718256"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2023 00:08:08 -0800
Date:   Fri, 24 Feb 2023 15:57:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v1 0/6] PolarFire SoC Auto Update Support
Message-ID: <Y/ht1eHgtRrLxIhC@yilunxu-OptiPlex-7050>
References: <20230217164023.14255-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217164023.14255-1-conor@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-17 at 16:40:17 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey all,
> 
> This patchset adds support for the "Auto Update" feature on PolarFire
> SoC that allows for writing an FPGA bistream to the SPI flash connected
> to the system controller.

I haven't fully checked the patches yet, just some quick comments:

Since this feature is just to R/W the flash, and would not affect the
runtime FPGA region, I don't think an FPGA manager is actually needed.
Why not just use the MTD uAPI? There is a set of exsiting MTD uAPI &
MTD tool if I remember correctly.

Thanks,
Yilun

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
> https://patchwork.kernel.org/project/linux-riscv/list/?series=714160
> 
> The patch adding the driver depends on the soc patches earlier in the
> series, so taking both through the same tree makes sense. Depending on
> sequencing with the dependencies, me taking it through the soc tree
> (with Acks etc of course) may make the most sense.
> 
> The other caveat here I guess is that this uses debugfs to trigger the
> write, as we do not yet have a userspace for this yet!
> 
> Cheers,
> Conor.
> 
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Moritz Fischer <mdf@kernel.org>
> CC: Wu Hao <hao.wu@intel.com>
> CC: Xu Yilun <yilun.xu@intel.com>
> CC: Tom Rix <trix@redhat.com>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-fpga@vger.kernel.org
> 
> Conor Dooley (6):
>   soc: microchip: mpfs: add a prefix to rx_callback()
>   dt-bindings: soc: microchip: add a property for system controller
>     flash
>   soc: microchip: mpfs: enable access to the system controller's flash
>   soc: microchip: mpfs: add auto-update subdev to system controller
>   fpga: add PolarFire SoC Auto Update support
>   riscv: dts: microchip: add the mpfs' system controller qspi &
>     associated flash
> 
>  .../microchip,mpfs-sys-controller.yaml        |  10 +
>  .../boot/dts/microchip/mpfs-icicle-kit.dts    |  21 +
>  arch/riscv/boot/dts/microchip/mpfs.dtsi       |  24 +-
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/microchip-auto-update.c          | 495 ++++++++++++++++++
>  drivers/soc/microchip/Kconfig                 |   1 +
>  drivers/soc/microchip/mpfs-sys-controller.c   |  33 +-
>  include/soc/microchip/mpfs.h                  |   2 +
>  9 files changed, 586 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/fpga/microchip-auto-update.c
> 
> -- 
> 2.39.1
> 
