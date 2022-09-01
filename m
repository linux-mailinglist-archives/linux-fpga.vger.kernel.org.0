Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120EA5A93AA
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Sep 2022 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiIAJxu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Sep 2022 05:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiIAJxl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Sep 2022 05:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B90135D2A
        for <linux-fpga@vger.kernel.org>; Thu,  1 Sep 2022 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662026018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYEmHUV841CvlZE4QudDzIYRHy71sPtQh0LRtefaU4w=;
        b=b+KZp8zbOcsQgXtVay5LSIwvYRXQoea1XScJxbGyPyk3zxdV7GumMJq+HNpj6nIU8dvmmC
        WCWuWbvf3KsG8rLZW9OG5FnhrxddZysk4aLgp14FrIE2EU7fwxZESUSF9LDmcIBUxpd+uw
        0z3nCpaYcHj8za3wQlAa5kdJ78wvmPw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-421-Okq5nuPiNQin1qDg6tetIg-1; Thu, 01 Sep 2022 05:53:37 -0400
X-MC-Unique: Okq5nuPiNQin1qDg6tetIg-1
Received: by mail-qk1-f198.google.com with SMTP id bq19-20020a05620a469300b006c097741d3dso543341qkb.2
        for <linux-fpga@vger.kernel.org>; Thu, 01 Sep 2022 02:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lYEmHUV841CvlZE4QudDzIYRHy71sPtQh0LRtefaU4w=;
        b=PYKGbiDvCBZi3vmmtgck1fX4Hk5T0BvO8V4l5d00mTNWFZINI7GE155L3bL5TA4UsL
         yYPUpz9shLnMBFJ0i/ANcS15+Nav970WCwbGfvmflb+DE+sk1ItZKzrKKsLltQ6T0f0C
         tQI1vPKdmcjuOYOVhC8vhzd5EH3AQiDJF/n7M18PGI2ipBqic+Uc18BUwfohurks4tLk
         YjQ81T990OB6w1AdlHc+K23D7UfhspUMSq3znFtxgg4SzDCI3T8OvLeODk2kign2Hcb6
         TMOyoP1ue88O+bDXUF/VJk0y31D8r6sBqQKGA2lseRdDjqqbkyp0SCQ3cTVJH7RFT8Si
         TY0Q==
X-Gm-Message-State: ACgBeo0PnPHttEJUTC2O4kl+OYgyiRTYnoYdleADjSv1THEUvpJuMAPO
        yp8dysi13ewWOdKgSoZoX6ilcxl0675VQtKcl9NHdJIb7ZkW0ZyxlvV8QP6HQbgTxYECX0S6/hB
        HrpXaCFFuR4hUSgi+KgP/
X-Received: by 2002:a05:620a:4555:b0:6c0:95f4:f20f with SMTP id u21-20020a05620a455500b006c095f4f20fmr809596qkp.306.1662026017101;
        Thu, 01 Sep 2022 02:53:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4W9zSlL/ugydoqb2gVKeYxgGjYEanBqrmFRiWD0y1Qa2lG8NAtiDcnieHGjNiB3SQhl/YIyQ==
X-Received: by 2002:a05:620a:4555:b0:6c0:95f4:f20f with SMTP id u21-20020a05620a455500b006c095f4f20fmr809574qkp.306.1662026016834;
        Thu, 01 Sep 2022 02:53:36 -0700 (PDT)
Received: from [192.168.9.27] (net-2-34-27-97.cust.vodafonedsl.it. [2.34.27.97])
        by smtp.gmail.com with ESMTPSA id d9-20020ac85349000000b00344a9149da2sm9802706qto.55.2022.09.01.02.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 02:53:36 -0700 (PDT)
Message-ID: <7b4b0dfd-ecf6-0b50-ee8e-82a2014c5e9e@redhat.com>
Date:   Thu, 1 Sep 2022 11:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
From:   Marco Pagani <marpagan@redhat.com>
Subject: Re: [PATCH 4/4] fpga: zynqmp: Add afi config driver
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     "git (AMD-Xilinx)" <git@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "abhyuday.godhasara@xilinx.com" <abhyuday.godhasara@xilinx.com>,
        "piyush.mehta@xilinx.com" <piyush.mehta@xilinx.com>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-5-nava.kishore.manne@amd.com>
 <YwoNdUPoSKKHhzxx@yilunxu-OptiPlex-7050>
 <DM6PR12MB39932285FD0EC72F1F04D8E8CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <DM6PR12MB39932285FD0EC72F1F04D8E8CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Nava,

On 2022-08-30 11:19, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> 	Please find my response inline.
> 
>> -----Original Message-----
>> From: Xu Yilun <yilun.xu@intel.com>
>> Sent: Saturday, August 27, 2022 5:56 PM
>> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
>> Cc: git (AMD-Xilinx) <git@amd.com>; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com;
>> mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
>> p.zabel@pengutronix.de; gregkh@linuxfoundation.org;
>> ronak.jain@xilinx.com; rajan.vaja@xilinx.com;
>> abhyuday.godhasara@xilinx.com; piyush.mehta@xilinx.com;
>> lakshmi.sai.krishna.potthuri@xilinx.com; harsha.harsha@xilinx.com;
>> linus.walleij@linaro.org; nava.manne@xilinx.com;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; linux-fpga@vger.kernel.org
>> Subject: Re: [PATCH 4/4] fpga: zynqmp: Add afi config driver
>>
>> CAUTION: This message has originated from an External Source. Please use
>> proper judgment and caution when opening attachments, clicking links, or
>> responding to this email.
>>
>>
>> On 2022-08-24 at 09:25:42 +0530, Nava kishore Manne wrote:
>>> Add zynqmp AXI FIFO interface(AFI) config driver. This is useful for
>>> the configuration of the PS-PL interface on Zynq US+ MPSoC platform.
>>
>> Please help illustrate how to use the device for FPGA reprogramming, why it
>> should be implemented as an FPGA bridge.
>>
>> From the code I actually didn't see any operation that gates the fpga-region
>> from other part of the machine.
>>
> 
> The Zynq UltraScale MPSoC family consists of a system-on-chip (SoC) style integrated processing system (PS)
> and a Programmable Logic (PL) unit, providing an extensible and flexible SoC solution on a single die. 
> Xilinx Zynq US+ MPSoC connect the PS to the programmable logic (PL) through the AXI port. 
> This AXI port helps to establish the data path between the PS and PL (Here AXI Interface act as a Gating between PS and PL)
> and this AXI port configuration vary from design to design.  In-order to establish the proper communication path between
> PS and PL (Full region),  the AXI port data path should be configured with proper values priories to load the full region.
> 
> Will update the description in v2.

Are you implementing your AFI driver as a Bridge because you want to
change the configuration of the AXI HP interfaces exported by the PS
every time you reconfigure the full fabric?

I understand the need to change the configuration of the PS-PL
interface at each full reconfiguration to ensure that the parameters
of the AXI ports exported by the PS (like the widths of data read
and write channels) matches the configuration of the master AXI ports
exported by the PL design. However, it seems to me that performing this
configuration doesn't fit the role of the FPGA Bridge, whose sole
responsibility should be gating the Region's interface during
reconfiguration.

I think this need could be addressed by adding a new component to the
FPGA subsystem called "FPGA Adapter". The Adapter will be an optional
component associated with a Region like a Bridge. It will be responsible
for changing the configuration of its Region's static interface
(or PS/HPS/DRAM interface for the full FPGA) to match the interface
exported by the specific reconfigurable module (or full static design).
Moreover, besides bus-level properties like address/data width and
protocol conversion, the Adapter could also be used to configure
system-level properties. For instance, the designer may use it to change
the memory access policy for the specific reconfigurable module if it
uses bus mastering.

> 
>>>
>>> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
>>> ---
>>>  MAINTAINERS               |   6 ++
>>>  drivers/fpga/Kconfig      |  13 +++
>>>  drivers/fpga/Makefile     |   1 +
>>>  drivers/fpga/zynqmp-afi.c | 211
>>> ++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 231 insertions(+)
>>>  create mode 100644 drivers/fpga/zynqmp-afi.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS index
>>> 20ffac651214..957e753e6406 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -8032,6 +8032,12 @@ F:     Documentation/fpga/
>>>  F:   drivers/fpga/
>>>  F:   include/linux/fpga/
>>>
>>> +FPGA ZYNQMP PS-PL BRIDGE DRIVER
>>> +M:   Nava kishore Manne <nava.kishore.manne@amd.com>
>>> +S:   Supported
>>> +F:   Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
>>> +F:   drivers/fpga/zynqmp-afi.c
>>> +
>>>  INTEL MAX10 BMC SECURE UPDATES
>>>  M:   Russ Weight <russell.h.weight@intel.com>
>>>  L:   linux-fpga@vger.kernel.org
>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
>>> 6c416955da53..c08794d30fb5 100644
>>> --- a/drivers/fpga/Kconfig
>>> +++ b/drivers/fpga/Kconfig
>>> @@ -130,6 +130,19 @@ config XILINX_PR_DECOUPLER
>>>         reconfiguration, preventing the system deadlock that can
>>>         occur if AXI transactions are interrupted by DFX.
>>>
>>> +config ZYNQMP_AFI
>>> +     tristate "Xilinx ZYNQMP AFI support"
>>> +     depends on FPGA_BRIDGE
>>> +     help
>>> +       Say Y to enable drivers to handle the PS-PL clocks configurations
>>> +       and PS-PL Bus-width. Xilinx Zynq US+ MPSoC connect the PS to the
>>> +       programmable logic (PL) through the AXI port. This AXI port helps
>>> +       to establish the data path between the PS and PL.
>>> +       In-order to establish the proper communication path between PS and
>> PL,
>>> +       the AXI port data path should be configured with the proper Bus-
>> width
>>> +       values and it will also handles the PS-PL reset signals to reset the
>>> +       PL domain.
>>
>> Same concern, please describe its relationship to FPGA reprogramming.
>>
> 
> Same as above.
> Will update the description in v2.
> 
>>> +
>>>  config FPGA_REGION
>>>       tristate "FPGA Region"
>>>       depends on FPGA_BRIDGE
>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
>>> 42ae8b58abce..94cfe60972db 100644
>>> --- a/drivers/fpga/Makefile
>>> +++ b/drivers/fpga/Makefile
>>> @@ -31,6 +31,7 @@ obj-$(CONFIG_FPGA_BRIDGE)           += fpga-bridge.o
>>>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)    += altera-hps2fpga.o altera-
>> fpga2sdram.o
>>>  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)   += altera-freeze-bridge.o
>>>  obj-$(CONFIG_XILINX_PR_DECOUPLER)    += xilinx-pr-decoupler.o
>>> +obj-$(CONFIG_ZYNQMP_AFI)             += zynqmp-afi.o
>>>
>>>  # High Level Interfaces
>>>  obj-$(CONFIG_FPGA_REGION)            += fpga-region.o
>>> diff --git a/drivers/fpga/zynqmp-afi.c b/drivers/fpga/zynqmp-afi.c new
>>> file mode 100644 index 000000000000..bc975d304039
>>> --- /dev/null
>>> +++ b/drivers/fpga/zynqmp-afi.c
>>> @@ -0,0 +1,211 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2022 Xilinx, Inc.
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/firmware/xlnx-zynqmp.h> #include
>>> +<linux/fpga/fpga-bridge.h> #include <linux/io.h> #include
>>> +<linux/module.h> #include <linux/of.h> #include
>>> +<linux/platform_device.h> #include <linux/reset.h> #include
>>> +<linux/slab.h>
>>> +
>>> +/* Registers and special values for doing register-based operations */
>>> +#define AFI_RDCHAN_CTRL_OFFSET       0x00
>>> +#define AFI_WRCHAN_CTRL_OFFSET       0x14
>>> +#define AFI_BUSWIDTH_MASK    BIT(0)
>>> +
>>> +/**
>>> + * struct zynqmp_afi - AFI register description.
>>> + * @dev: device that owns this.
>>> + * @of_node: Device Tree overlay.
>>> + * @resets: Pointer to the reset control for ps-pl resets.
>>> + */
>>> +struct zynqmp_afi {
>>> +     struct device *dev;
>>> +     struct device_node *of_node;
>>> +     struct reset_control *resets;
>>> +};
>>> +
>>> +/**
>>> + * struct zynqmp_afi_configreg - AFI configuration registers info.
>>> + * @reg:     Name of the AFI configuration register.
>>> + * @id:              Register index value.
>>> + */
>>> +struct zynqmp_afi_configreg {
>>> +     char *reg;
>>> +     u32 id;
>>> +};
>>> +
>>> +static struct zynqmp_afi_configreg afi_cfgreg[] = {
>>> +     {.reg = "xlnx,afi-fm0-rd-bus-width",    .id = AFIFM0_RDCTRL},
>>> +     {.reg = "xlnx,afi-fm1-rd-bus-width",    .id = AFIFM1_RDCTRL},
>>> +     {.reg = "xlnx,afi-fm2-rd-bus-width",    .id = AFIFM2_RDCTRL},
>>> +     {.reg = "xlnx,afi-fm3-rd-bus-width",    .id = AFIFM3_RDCTRL},
>>> +     {.reg = "xlnx,afi-fm4-rd-bus-width",    .id = AFIFM4_RDCTRL},
>>> +     {.reg = "xlnx,afi-fm5-rd-bus-width",    .id = AFIFM5_RDCTRL},
>>> +     {.reg = "xlnx,afi-fm6-rd-bus-width",    .id = AFIFM6_RDCTRL},
>>> +     {.reg = "xlnx,afi-fm0-wr-bus-width",    .id = AFIFM0_WRCTRL},
>>> +     {.reg = "xlnx,afi-fm1-wr-bus-width",    .id = AFIFM1_WRCTRL},
>>> +     {.reg = "xlnx,afi-fm2-wr-bus-width",    .id = AFIFM2_WRCTRL},
>>> +     {.reg = "xlnx,afi-fm3-wr-bus-width",    .id = AFIFM3_WRCTRL},
>>> +     {.reg = "xlnx,afi-fm4-wr-bus-width",    .id = AFIFM4_WRCTRL},
>>> +     {.reg = "xlnx,afi-fm5-wr-bus-width",    .id = AFIFM5_WRCTRL},
>>> +     {.reg = "xlnx,afi-fm6-wr-bus-width",    .id = AFIFM6_WRCTRL},
>>> +     {.reg = "xlnx,afi-fs-ss0-bus-width",    .id = AFIFS},
>>> +     {.reg = "xlnx,afi-fs-ss2-bus-width",    .id = AFIFS_SS2},
>>> +     {}
>>> +};
>>> +
>>> +static int zynqmp_afi_config(struct zynqmp_afi *afi_data) {
>>> +     struct zynqmp_afi_configreg *cfgptr = afi_cfgreg;
>>> +     struct device_node *np = afi_data->of_node;
>>> +     u32 afi_ss0_val, afi_ss1_val, bus_width;
>>> +     int ret;
>>> +
>>> +     while (cfgptr->reg) {
>>> +             ret = of_property_read_u32(np, cfgptr->reg, &bus_width);
>>> +             if (!ret) {
>>> +                     if (cfgptr->id == AFIFS_SS2) {
>>> +                             if (bus_width == 32)
>>> +                                     ret = zynqmp_pm_afi(AFIFS_SS2,
>>> +                                                         AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL);
>>> +                             else if (bus_width == 64)
>>> +                                     ret = zynqmp_pm_afi(AFIFS_SS2,
>>> +
>> AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL);
>>> +                             else if (bus_width == 128)
>>> +                                     ret = zynqmp_pm_afi(AFIFS_SS2,
>>> +
>> AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL);
>>> +                             else
>>> +                                     return -EINVAL;
>>> +                     } else if (cfgptr->id == AFIFS) {
>>> +                             if (bus_width == 32)
>>> +                                     afi_ss0_val = AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL;
>>> +                             else if (bus_width == 64)
>>> +                                     afi_ss0_val =
>> AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL;
>>> +                             else if (bus_width == 128)
>>> +                                     afi_ss0_val =
>> AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL;
>>> +                             else
>>> +                                     return -EINVAL;
>>> +
>>> +                             ret = of_property_read_u32(np, "xlnx,afi-fs-ss1-bus-
>> width",
>>> +                                                        &bus_width);
>>> +                             if (!ret) {
>>> +                                     if (bus_width == 32)
>>> +                                             afi_ss1_val =
>> AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL;
>>> +                                     else if (bus_width == 64)
>>> +                                             afi_ss1_val =
>> AFIFS_SS1_BUS_WIDTH_64_CONFIG_VAL;
>>> +                                     else if (bus_width == 128)
>>> +                                             afi_ss1_val =
>> AFIFS_SS1_BUS_WIDTH_128_CONFIG_VAL;
>>> +                                     else
>>> +                                             return -EINVAL;
>>> +
>>> +                                     ret = zynqmp_pm_afi(AFIFS, afi_ss1_val |
>> afi_ss0_val);
>>> +                             }
>>> +                     } else {
>>> +                             if (bus_width == 32)
>>> +                                     ret = zynqmp_pm_afi(cfgptr->id,
>>> +                                                         AFIFM_BUS_WIDTH_32_CONFIG_VAL);
>>> +                             else if (bus_width == 64)
>>> +                                     ret = zynqmp_pm_afi(cfgptr->id,
>>> +                                                         AFIFM_BUS_WIDTH_64_CONFIG_VAL);
>>> +                             else if (bus_width == 128)
>>> +                                     ret = zynqmp_pm_afi(cfgptr->id,
>>> +                                                         AFIFM_BUS_WIDTH_128_CONFIG_VAL);
>>> +                             else
>>> +                                     return -EINVAL;
>>> +                     }
>>> +             }
>>> +             cfgptr++;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int zynqmp_afi_enable_set(struct fpga_bridge *bridge, bool
>>> +enable) {
>>> +     struct device_node *overlay = bridge->info->overlay;
>>> +     struct zynqmp_afi *priv = bridge->priv;
>>> +     int ret = 0;
>>> +
>>> +     if (enable) {
>>> +             reset_control_reset(priv->resets);
>>> +             return 0;
>>> +     }
>>> +
>>> +     of_node_get(overlay);
>>> +     priv->of_node =
>>> +     of_find_node_with_property(overlay,
>>> +                                "xlnx,afi-fm0-rd-bus-width");
>>
>> I'm a little confused here. The fpga_image_info.overlay is for fpga-region, but
>> from your binding doc this property is for this afi device. You want to add
>> another overlay targeting afi dev node during reprograming?
>>
> 
> Yes, it uses Overlay's(overlay targeting afi dev node). As I said above for design-to-design AFI configs
> relevant to the full region may change and these configs must be set prior to program the full region
> once this overlay integrated to the live tree the existing afi config values will be replace with the new one's
> 
>>> +     if (priv->of_node)
>>> +             ret = zynqmp_afi_config(priv);
>>> +     of_node_put(priv->of_node);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static const struct fpga_bridge_ops zynqmp_afi_br_ops = {
>>> +     .enable_set = zynqmp_afi_enable_set, };
>>> +
>>> +static const struct of_device_id zynqmp_afi_of_match[] = {
>>> +     { .compatible =  "xlnx,zynqmp-afi-fpga" },
>>> +     { },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, zynqmp_afi_of_match);
>>> +
>>> +static int zynqmp_afi_probe(struct platform_device *pdev) {
>>> +     struct device *dev = &pdev->dev;
>>> +     struct zynqmp_afi *priv;
>>> +     struct fpga_bridge *br;
>>> +
>>> +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>> +     if (!priv)
>>> +             return -ENOMEM;
>>> +
>>> +     priv->dev = dev;
>>> +
>>> +     priv->resets =
>> devm_reset_control_array_get_optional_exclusive(&pdev->dev);
>>> +     if (IS_ERR(priv->resets))
>>> +             return PTR_ERR(priv->resets);
>>> +
>>> +     br = fpga_bridge_register(dev, "Xilinx ZynqMP AFI",
>>> +                               &zynqmp_afi_br_ops, priv);
>>> +     if (IS_ERR(br)) {
>>> +             dev_err(dev, "unable to register Xilinx ZynqMP AFI");
>>
>> Need a "\n" at the end?
>>
> 
> Will fix.
> 
> Regards,
> Navakishore.
> 

Thanks,
Marco

