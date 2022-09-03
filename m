Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592175AC069
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Sep 2022 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiICRoH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 3 Sep 2022 13:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiICRnV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 3 Sep 2022 13:43:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DA958B65;
        Sat,  3 Sep 2022 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662226983; x=1693762983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dmMI3hgnJrDyySmSfUKCyzdmMyWHvL+eCHVnZB0KYmU=;
  b=m6EnxAQlxdD/1CCTgbyZpCOJW37+n7/cXRSEtOzuBLo8JghEQ+Cxa0/r
   wb8NmzYQ2xUnuWdIBdjWddziT0LtE4R8Ev0HEILGHMprlKnc3JX6BUNhj
   I9wdTAhvfMFGo2jg4XSihZTS5qbjlCaJM5Nkg1DW8JP/hBdJTV6yMJCqa
   /Hz0nHoUN2dKEblGur3xzjtdPi+lWQKC89Naw5pEPn9ted/RaDrx8PSiW
   OPqjC9zIpCrDGI21PMX49dNdX1VIScFHKnUBv3gutF8Azr/pFVn9nfo+J
   TnN3KsuxsgxyOHqLYeV3Z6IhpUBhTo/lN8psFPaHAiPKoNS0sdmBRIsML
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="279190630"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="279190630"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 10:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="674751116"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2022 10:42:39 -0700
Date:   Sun, 4 Sep 2022 01:33:15 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
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
Subject: Re: [PATCH 4/4] fpga: zynqmp: Add afi config driver
Message-ID: <YxOP2wIixSDYuS1v@yilunxu-OptiPlex-7050>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-5-nava.kishore.manne@amd.com>
 <YwoNdUPoSKKHhzxx@yilunxu-OptiPlex-7050>
 <DM6PR12MB39932285FD0EC72F1F04D8E8CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB39932285FD0EC72F1F04D8E8CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-30 at 09:19:52 +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> 	Please find my response inline.
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@intel.com>
> > Sent: Saturday, August 27, 2022 5:56 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com;
> > mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
> > p.zabel@pengutronix.de; gregkh@linuxfoundation.org;
> > ronak.jain@xilinx.com; rajan.vaja@xilinx.com;
> > abhyuday.godhasara@xilinx.com; piyush.mehta@xilinx.com;
> > lakshmi.sai.krishna.potthuri@xilinx.com; harsha.harsha@xilinx.com;
> > linus.walleij@linaro.org; nava.manne@xilinx.com;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-fpga@vger.kernel.org
> > Subject: Re: [PATCH 4/4] fpga: zynqmp: Add afi config driver
> > 
> > CAUTION: This message has originated from an External Source. Please use
> > proper judgment and caution when opening attachments, clicking links, or
> > responding to this email.
> > 
> > 
> > On 2022-08-24 at 09:25:42 +0530, Nava kishore Manne wrote:
> > > Add zynqmp AXI FIFO interface(AFI) config driver. This is useful for
> > > the configuration of the PS-PL interface on Zynq US+ MPSoC platform.
> > 
> > Please help illustrate how to use the device for FPGA reprogramming, why it
> > should be implemented as an FPGA bridge.
> > 
> > From the code I actually didn't see any operation that gates the fpga-region
> > from other part of the machine.
> > 
> 
> The Zynq UltraScale MPSoC family consists of a system-on-chip (SoC) style integrated processing system (PS)
> and a Programmable Logic (PL) unit, providing an extensible and flexible SoC solution on a single die. 
> Xilinx Zynq US+ MPSoC connect the PS to the programmable logic (PL) through the AXI port. 
> This AXI port helps to establish the data path between the PS and PL (Here AXI Interface act as a Gating between PS and PL)
> and this AXI port configuration vary from design to design.  In-order to establish the proper communication path between
> PS and PL (Full region),  the AXI port data path should be configured with proper values priories to load the full region.
> 
> Will update the description in v2.
> 
> > >
> > > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > > ---
> > >  MAINTAINERS               |   6 ++
> > >  drivers/fpga/Kconfig      |  13 +++
> > >  drivers/fpga/Makefile     |   1 +
> > >  drivers/fpga/zynqmp-afi.c | 211
> > > ++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 231 insertions(+)
> > >  create mode 100644 drivers/fpga/zynqmp-afi.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > 20ffac651214..957e753e6406 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8032,6 +8032,12 @@ F:     Documentation/fpga/
> > >  F:   drivers/fpga/
> > >  F:   include/linux/fpga/
> > >
> > > +FPGA ZYNQMP PS-PL BRIDGE DRIVER
> > > +M:   Nava kishore Manne <nava.kishore.manne@amd.com>
> > > +S:   Supported
> > > +F:   Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
> > > +F:   drivers/fpga/zynqmp-afi.c
> > > +
> > >  INTEL MAX10 BMC SECURE UPDATES
> > >  M:   Russ Weight <russell.h.weight@intel.com>
> > >  L:   linux-fpga@vger.kernel.org
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > > 6c416955da53..c08794d30fb5 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -130,6 +130,19 @@ config XILINX_PR_DECOUPLER
> > >         reconfiguration, preventing the system deadlock that can
> > >         occur if AXI transactions are interrupted by DFX.
> > >
> > > +config ZYNQMP_AFI
> > > +     tristate "Xilinx ZYNQMP AFI support"
> > > +     depends on FPGA_BRIDGE
> > > +     help
> > > +       Say Y to enable drivers to handle the PS-PL clocks configurations
> > > +       and PS-PL Bus-width. Xilinx Zynq US+ MPSoC connect the PS to the
> > > +       programmable logic (PL) through the AXI port. This AXI port helps
> > > +       to establish the data path between the PS and PL.
> > > +       In-order to establish the proper communication path between PS and
> > PL,
> > > +       the AXI port data path should be configured with the proper Bus-
> > width
> > > +       values and it will also handles the PS-PL reset signals to reset the
> > > +       PL domain.
> > 
> > Same concern, please describe its relationship to FPGA reprogramming.
> > 
> 
> Same as above.
> Will update the description in v2.
> 
> > > +
> > >  config FPGA_REGION
> > >       tristate "FPGA Region"
> > >       depends on FPGA_BRIDGE
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > > 42ae8b58abce..94cfe60972db 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -31,6 +31,7 @@ obj-$(CONFIG_FPGA_BRIDGE)           += fpga-bridge.o
> > >  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)    += altera-hps2fpga.o altera-
> > fpga2sdram.o
> > >  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)   += altera-freeze-bridge.o
> > >  obj-$(CONFIG_XILINX_PR_DECOUPLER)    += xilinx-pr-decoupler.o
> > > +obj-$(CONFIG_ZYNQMP_AFI)             += zynqmp-afi.o
> > >
> > >  # High Level Interfaces
> > >  obj-$(CONFIG_FPGA_REGION)            += fpga-region.o
> > > diff --git a/drivers/fpga/zynqmp-afi.c b/drivers/fpga/zynqmp-afi.c new
> > > file mode 100644 index 000000000000..bc975d304039
> > > --- /dev/null
> > > +++ b/drivers/fpga/zynqmp-afi.c
> > > @@ -0,0 +1,211 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2022 Xilinx, Inc.
> > > + */
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/firmware/xlnx-zynqmp.h> #include
> > > +<linux/fpga/fpga-bridge.h> #include <linux/io.h> #include
> > > +<linux/module.h> #include <linux/of.h> #include
> > > +<linux/platform_device.h> #include <linux/reset.h> #include
> > > +<linux/slab.h>
> > > +
> > > +/* Registers and special values for doing register-based operations */
> > > +#define AFI_RDCHAN_CTRL_OFFSET       0x00
> > > +#define AFI_WRCHAN_CTRL_OFFSET       0x14
> > > +#define AFI_BUSWIDTH_MASK    BIT(0)
> > > +
> > > +/**
> > > + * struct zynqmp_afi - AFI register description.
> > > + * @dev: device that owns this.
> > > + * @of_node: Device Tree overlay.
> > > + * @resets: Pointer to the reset control for ps-pl resets.
> > > + */
> > > +struct zynqmp_afi {
> > > +     struct device *dev;
> > > +     struct device_node *of_node;
> > > +     struct reset_control *resets;
> > > +};
> > > +
> > > +/**
> > > + * struct zynqmp_afi_configreg - AFI configuration registers info.
> > > + * @reg:     Name of the AFI configuration register.
> > > + * @id:              Register index value.
> > > + */
> > > +struct zynqmp_afi_configreg {
> > > +     char *reg;
> > > +     u32 id;
> > > +};
> > > +
> > > +static struct zynqmp_afi_configreg afi_cfgreg[] = {
> > > +     {.reg = "xlnx,afi-fm0-rd-bus-width",    .id = AFIFM0_RDCTRL},
> > > +     {.reg = "xlnx,afi-fm1-rd-bus-width",    .id = AFIFM1_RDCTRL},
> > > +     {.reg = "xlnx,afi-fm2-rd-bus-width",    .id = AFIFM2_RDCTRL},
> > > +     {.reg = "xlnx,afi-fm3-rd-bus-width",    .id = AFIFM3_RDCTRL},
> > > +     {.reg = "xlnx,afi-fm4-rd-bus-width",    .id = AFIFM4_RDCTRL},
> > > +     {.reg = "xlnx,afi-fm5-rd-bus-width",    .id = AFIFM5_RDCTRL},
> > > +     {.reg = "xlnx,afi-fm6-rd-bus-width",    .id = AFIFM6_RDCTRL},
> > > +     {.reg = "xlnx,afi-fm0-wr-bus-width",    .id = AFIFM0_WRCTRL},
> > > +     {.reg = "xlnx,afi-fm1-wr-bus-width",    .id = AFIFM1_WRCTRL},
> > > +     {.reg = "xlnx,afi-fm2-wr-bus-width",    .id = AFIFM2_WRCTRL},
> > > +     {.reg = "xlnx,afi-fm3-wr-bus-width",    .id = AFIFM3_WRCTRL},
> > > +     {.reg = "xlnx,afi-fm4-wr-bus-width",    .id = AFIFM4_WRCTRL},
> > > +     {.reg = "xlnx,afi-fm5-wr-bus-width",    .id = AFIFM5_WRCTRL},
> > > +     {.reg = "xlnx,afi-fm6-wr-bus-width",    .id = AFIFM6_WRCTRL},
> > > +     {.reg = "xlnx,afi-fs-ss0-bus-width",    .id = AFIFS},
> > > +     {.reg = "xlnx,afi-fs-ss2-bus-width",    .id = AFIFS_SS2},
> > > +     {}
> > > +};
> > > +
> > > +static int zynqmp_afi_config(struct zynqmp_afi *afi_data) {
> > > +     struct zynqmp_afi_configreg *cfgptr = afi_cfgreg;
> > > +     struct device_node *np = afi_data->of_node;
> > > +     u32 afi_ss0_val, afi_ss1_val, bus_width;
> > > +     int ret;
> > > +
> > > +     while (cfgptr->reg) {
> > > +             ret = of_property_read_u32(np, cfgptr->reg, &bus_width);
> > > +             if (!ret) {
> > > +                     if (cfgptr->id == AFIFS_SS2) {
> > > +                             if (bus_width == 32)
> > > +                                     ret = zynqmp_pm_afi(AFIFS_SS2,
> > > +                                                         AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL);
> > > +                             else if (bus_width == 64)
> > > +                                     ret = zynqmp_pm_afi(AFIFS_SS2,
> > > +
> > AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL);
> > > +                             else if (bus_width == 128)
> > > +                                     ret = zynqmp_pm_afi(AFIFS_SS2,
> > > +
> > AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL);
> > > +                             else
> > > +                                     return -EINVAL;
> > > +                     } else if (cfgptr->id == AFIFS) {
> > > +                             if (bus_width == 32)
> > > +                                     afi_ss0_val = AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL;
> > > +                             else if (bus_width == 64)
> > > +                                     afi_ss0_val =
> > AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL;
> > > +                             else if (bus_width == 128)
> > > +                                     afi_ss0_val =
> > AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL;
> > > +                             else
> > > +                                     return -EINVAL;
> > > +
> > > +                             ret = of_property_read_u32(np, "xlnx,afi-fs-ss1-bus-
> > width",
> > > +                                                        &bus_width);
> > > +                             if (!ret) {
> > > +                                     if (bus_width == 32)
> > > +                                             afi_ss1_val =
> > AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL;
> > > +                                     else if (bus_width == 64)
> > > +                                             afi_ss1_val =
> > AFIFS_SS1_BUS_WIDTH_64_CONFIG_VAL;
> > > +                                     else if (bus_width == 128)
> > > +                                             afi_ss1_val =
> > AFIFS_SS1_BUS_WIDTH_128_CONFIG_VAL;
> > > +                                     else
> > > +                                             return -EINVAL;
> > > +
> > > +                                     ret = zynqmp_pm_afi(AFIFS, afi_ss1_val |
> > afi_ss0_val);
> > > +                             }
> > > +                     } else {
> > > +                             if (bus_width == 32)
> > > +                                     ret = zynqmp_pm_afi(cfgptr->id,
> > > +                                                         AFIFM_BUS_WIDTH_32_CONFIG_VAL);
> > > +                             else if (bus_width == 64)
> > > +                                     ret = zynqmp_pm_afi(cfgptr->id,
> > > +                                                         AFIFM_BUS_WIDTH_64_CONFIG_VAL);
> > > +                             else if (bus_width == 128)
> > > +                                     ret = zynqmp_pm_afi(cfgptr->id,
> > > +                                                         AFIFM_BUS_WIDTH_128_CONFIG_VAL);
> > > +                             else
> > > +                                     return -EINVAL;
> > > +                     }
> > > +             }
> > > +             cfgptr++;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int zynqmp_afi_enable_set(struct fpga_bridge *bridge, bool
> > > +enable) {
> > > +     struct device_node *overlay = bridge->info->overlay;
> > > +     struct zynqmp_afi *priv = bridge->priv;
> > > +     int ret = 0;
> > > +
> > > +     if (enable) {
> > > +             reset_control_reset(priv->resets);
> > > +             return 0;
> > > +     }
> > > +
> > > +     of_node_get(overlay);
> > > +     priv->of_node =
> > > +     of_find_node_with_property(overlay,
> > > +                                "xlnx,afi-fm0-rd-bus-width");
> > 
> > I'm a little confused here. The fpga_image_info.overlay is for fpga-region, but
> > from your binding doc this property is for this afi device. You want to add
> > another overlay targeting afi dev node during reprograming?
> > 
> 
> Yes, it uses Overlay's(overlay targeting afi dev node). As I said above for design-to-design AFI configs

I have concern on it. We should limit the overlay usage only on
fpga_region, this is because we are changing the hardware in this
region during reprograming. Adding overlays for other nodes could be
easily abused, any changes could be made even not related to the fpga
region. So if any cross device configurations should be made during
reprograming, it should be initiated by fpga region driver through
normal kernel APIs.

Thanks,
Yilun

> relevant to the full region may change and these configs must be set prior to program the full region
> once this overlay integrated to the live tree the existing afi config values will be replace with the new one's
> 
> > > +     if (priv->of_node)
> > > +             ret = zynqmp_afi_config(priv);
> > > +     of_node_put(priv->of_node);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static const struct fpga_bridge_ops zynqmp_afi_br_ops = {
> > > +     .enable_set = zynqmp_afi_enable_set, };
> > > +
> > > +static const struct of_device_id zynqmp_afi_of_match[] = {
> > > +     { .compatible =  "xlnx,zynqmp-afi-fpga" },
> > > +     { },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, zynqmp_afi_of_match);
> > > +
> > > +static int zynqmp_afi_probe(struct platform_device *pdev) {
> > > +     struct device *dev = &pdev->dev;
> > > +     struct zynqmp_afi *priv;
> > > +     struct fpga_bridge *br;
> > > +
> > > +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > > +     if (!priv)
> > > +             return -ENOMEM;
> > > +
> > > +     priv->dev = dev;
> > > +
> > > +     priv->resets =
> > devm_reset_control_array_get_optional_exclusive(&pdev->dev);
> > > +     if (IS_ERR(priv->resets))
> > > +             return PTR_ERR(priv->resets);
> > > +
> > > +     br = fpga_bridge_register(dev, "Xilinx ZynqMP AFI",
> > > +                               &zynqmp_afi_br_ops, priv);
> > > +     if (IS_ERR(br)) {
> > > +             dev_err(dev, "unable to register Xilinx ZynqMP AFI");
> > 
> > Need a "\n" at the end?
> > 
> 
> Will fix.
> 
> Regards,
> Navakishore.
> 
