Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5341A6D3633
	for <lists+linux-fpga@lfdr.de>; Sun,  2 Apr 2023 10:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjDBIXL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 2 Apr 2023 04:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDBIXK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 2 Apr 2023 04:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7242F1A952;
        Sun,  2 Apr 2023 01:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0036D61084;
        Sun,  2 Apr 2023 08:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4D1C4339B;
        Sun,  2 Apr 2023 08:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680423788;
        bh=rqmI+2ncgqv8TeVA56uwwXT2fHfEv1PS7v4WdYAbJXw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=U03GhHvo77HswkSeu6SilRZCfbKYZ8VczUx+ZoWMRuVVCmcLL7PiM2mtrJaiIHLdq
         Y9NwfQGrD2kBzXRX9J0Rw0g0yzmLQwGqDxnSQFRdoraT7iv8SzFgsu4V1QXnJTSuKo
         oSGybFvAOiNCiKSWZtofVLER2qVUuckiul79YCLyRsolojJ7SltDyP5dmMrK3MM1zt
         gOSIHj4VZmx7gsuuiIoY2gUT+UDwGSXT4obZkUtSMkxgqKXQS9AjPGHJjo+UnTDHWH
         58aG/tYd+uM+1MhPM9pWdPC/YU/xIaUzssvW70fljgwKCJAiZwQyNjkYIGZTaXoZto
         w/PIi0HK2AXiw==
Date:   Sun, 02 Apr 2023 09:23:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     linux-fpga@vger.kernel.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PolarFire SoC Auto Update Support
User-Agent: K-9 Mail for Android
In-Reply-To: <ZCk2IgDjHRUlyD+t@yilunxu-OptiPlex-7050>
References: <20230331071823.956087-1-conor.dooley@microchip.com> <ZCk2IgDjHRUlyD+t@yilunxu-OptiPlex-7050>
Message-ID: <958EDDDE-B62D-4CCC-9851-0F01516D95CD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2 April 2023 09:00:34 IST, Xu Yilun <yilun=2Exu@intel=2Ecom> wrote:
>On 2023-03-31 at 08:18:16 +0100, Conor Dooley wrote:
>> Hey all,
>>=20
>> This patchset adds support for the "Auto Update" feature on PolarFire
>> SoC that allows for writing an FPGA bistream to the SPI flash connected
>> to the system controller=2E
>> On powercycle (or reboot depending on how the firmware implements the
>> openSBI SRST extension) "Auto Update" will take place, and program the
>> FPGA with the contents of the SPI flash - provided that that image is
>> valid and an actual upgrade from that already programmed!
>>=20
>> Unfortunately, this series is not really testable yet - the Engineering
>> Sample silicon on most dev boards has a bug in the QSPI controller
>> connected to the system controller's flash and cannot access it=2E
>> Pre-production and later silicon has this bug fixed=2E
>>=20
>> I previously posted an RFC about my approach in this driver, since as a
>> flash-based FPGA we are somewhat different to the existing
>> self-reprogramming drivers here=2E That RFC is here:
>> https://lore=2Ekernel=2Eorg/linux-fpga/20221121225748=2E124900-1-conor@=
kernel=2Eorg/
>>=20
>> This series depends on the following fixes:
>> https://lore=2Ekernel=2Eorg/all/d7c3ec51-8493-444a-bdec-2a30b0a15bdc@sp=
ud/
>
>Is that series already merged? If yes, just remove this line=2E
>If no, either put all of them in one series, or still make this series
>as RFC until the dependency is resolved=2E

Merged into what?
I'll be applying the dependencies tomorrow probably=2E

>
>Thanks,
>Yilun
>
>>=20
>> The patch adding the driver depends on the soc patches earlier in the
>> series, so taking both through the same tree makes sense=2E Depending o=
n
>> sequencing with the dependencies, me taking it through the soc tree
>> (with Acks etc of course) may make the most sense=2E
>>=20
>> Cheers,
>> Conor=2E
>>=20
>> Changes in v2:
>> - per Russ' suggestion, the driver has been switched to using the
>>   firmware-upload API rather than the fpga one
>> - as a result of that change, the structure of the driver has changed
>>   significantly, although most of that is reshuffling existing code
>>   around
>> - check if the upgrade is possible in probe and fail if it isn't
>> - only write the image index if it is not already set
>> - delete the now unneeded debugfs bits
>>=20
>> CC: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>> CC: Daire McNamara <daire=2Emcnamara@microchip=2Ecom>
>> CC: Rob Herring <robh+dt@kernel=2Eorg>
>> CC: Krzysztof Kozlowski <krzysztof=2Ekozlowski+dt@linaro=2Eorg>
>> CC: Moritz Fischer <mdf@kernel=2Eorg>
>> CC: Wu Hao <hao=2Ewu@intel=2Ecom>
>> CC: Xu Yilun <yilun=2Exu@intel=2Ecom>
>> CC: Tom Rix <trix@redhat=2Ecom>
>> CC; Russ Weight <russell=2Eh=2Eweight@intel=2Ecom>
>> CC: linux-riscv@lists=2Einfradead=2Eorg
>> CC: devicetree@vger=2Ekernel=2Eorg
>> CC: linux-kernel@vger=2Ekernel=2Eorg
>> CC: linux-fpga@vger=2Ekernel=2Eorg
>>=20
>> Conor Dooley (7):
>>   soc: microchip: mpfs: add a prefix to rx_callback()
>>   dt-bindings: soc: microchip: add a property for system controller
>>     flash
>>   soc: microchip: mpfs: enable access to the system controller's flash
>>   soc: microchip: mpfs: print service status in warning message
>>   soc: microchip: mpfs: add auto-update subdev to system controller
>>   fpga: add PolarFire SoC Auto Update support
>>   riscv: dts: microchip: add the mpfs' system controller qspi &
>>     associated flash
>>=20
>>  =2E=2E=2E/microchip,mpfs-sys-controller=2Eyaml        |  10 +
>>  =2E=2E=2E/boot/dts/microchip/mpfs-icicle-kit=2Edts    |  21 +
>>  arch/riscv/boot/dts/microchip/mpfs=2Edtsi       |  24 +-
>>  drivers/fpga/Kconfig                          |  11 +
>>  drivers/fpga/Makefile                         |   3 +-
>>  drivers/fpga/microchip-auto-update=2Ec          | 494 ++++++++++++++++=
++
>>  drivers/soc/microchip/Kconfig                 |   1 +
>>  drivers/soc/microchip/mpfs-sys-controller=2Ec   |  37 +-
>>  include/soc/microchip/mpfs=2Eh                  |   2 +
>>  9 files changed, 591 insertions(+), 12 deletions(-)
>>  create mode 100644 drivers/fpga/microchip-auto-update=2Ec
>>=20
>> --=20
>> 2=2E39=2E2
>>=20
