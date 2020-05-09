Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74531CC3E2
	for <lists+linux-fpga@lfdr.de>; Sat,  9 May 2020 21:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEITFQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 9 May 2020 15:05:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33765 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEITFQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 9 May 2020 15:05:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so2152555plr.0;
        Sat, 09 May 2020 12:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kX1sYEK0EbH42tiKl1I6YuGqHEoXG61Xr2I+Gfq3swE=;
        b=POyz7Zj3c4mykfyW4YdvpQNAzRBuAomx6Xv6wRhF4unp0jh1/YM31/1skbq+PYKa4G
         Gd/W6R0ZahotpOyqlveN1k7yPpcqpdmRwkOTP2dFW1u7prMN4O0y10syp9aUyukkKcd3
         8kZBTPRj4i9xxFYbtlo04lREw2ggWXLXsrVrKHuWC+GNZ/wYgnP5qennn2rx0bhLIXTR
         jt1VAobuJGRXFNlAylF3jabcUJ4UJ9E9SDMzroWkOq/7Vk7wsAgAHvRhAMH3pQj2w+MT
         2cY8W21Wb9TPin27YL+2cVHFHLleiJjY11EOsWrRGSWSNywUXKp1YQfvchnoyt/txUkk
         T1PQ==
X-Gm-Message-State: AGi0PuaIzgYCihdNVfDkytXal++LQQd6u0LOlv5oEN9B0GdR5Lh+OCfR
        nicYVtGNJnQVNdz9lGUHO2Q=
X-Google-Smtp-Source: APiQypKSQpO2Mmp+x4Oa/l+JMrQ6UryLvjYLxmdTZxt5kSBq8vLabucL2thDZUQ+BTWgfaR9gzSCSw==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2mr7710141plx.219.1589051114192;
        Sat, 09 May 2020 12:05:14 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id p7sm4140203pgg.91.2020.05.09.12.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 12:05:13 -0700 (PDT)
Date:   Sat, 9 May 2020 12:05:12 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: Re: [PATCH 2/2] fpga: zynq: Add AFI config driver
Message-ID: <20200509190512.GB6715@epycbox.lan>
References: <1586946290-7280-1-git-send-email-nava.manne@xilinx.com>
 <1586946290-7280-2-git-send-email-nava.manne@xilinx.com>
 <20200423032854.GB2430@epycbox.lan>
 <DM6PR02MB5386D0632A60A9C056DB31E6C2A60@DM6PR02MB5386.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR02MB5386D0632A60A9C056DB31E6C2A60@DM6PR02MB5386.namprd02.prod.outlook.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Nava,

On Mon, May 04, 2020 at 11:55:23AM +0000, Nava kishore Manne wrote:
> Hi Mortiz,
> 
> Thanks for proving the comments.
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Moritz Fischer [mailto:mdf@kernel.org]
> > Sent: Thursday, April 23, 2020 8:59 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mdf@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> > fpga@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; chinnikishore369@gmail.com
> > Subject: Re: [PATCH 2/2] fpga: zynq: Add AFI config driver
> > 
> > Hi Nava,
> > 
> > On Wed, Apr 15, 2020 at 03:54:50PM +0530, Nava kishore Manne wrote:
> > > This patch Adds AFI config driver. This is useful for the PS to PL
> > > configuration for the fpga manager On zynq platform.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  drivers/fpga/Kconfig    |  8 +++++
> > >  drivers/fpga/Makefile   |  1 +
> > >  drivers/fpga/zynq-afi.c | 81
> > > +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 90 insertions(+)
> > >  create mode 100644 drivers/fpga/zynq-afi.c
> > >
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > > 474f304e..60982a0 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -214,4 +214,12 @@ config FPGA_MGR_ZYNQMP_FPGA
> > >  	  to configure the programmable logic(PL) through PS
> > >  	  on ZynqMP SoC.
> > >
> > > +config FPGA_MGR_ZYNQ_AFI_FPGA
> > > +	bool "Xilinx AFI FPGA"
> > > +	depends on FPGA_MGR_ZYNQ_FPGA
> > Curious. How does this dependency play in here?
> > > +	help
> > > +	  Zynq AFI driver support for writing to the AFI registers
> > > +	  for configuring the PS_PL interface. For some of the bitstream
> > > +	  or designs to work the PS to PL interfaces need to be configured
> > > +	  like the data bus-width etc.
> > >  endif # FPGA
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > > 312b937..d115e29 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -26,6 +26,7 @@ obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-
> > bridge.o
> > >  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-
> > fpga2sdram.o
> > >  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
> > >  obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
> > > +obj-$(CONFIG_FPGA_MGR_ZYNQ_AFI_FPGA)	+= zynq-afi.o
> > >
> > >  # High Level Interfaces
> > >  obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
> > > diff --git a/drivers/fpga/zynq-afi.c b/drivers/fpga/zynq-afi.c new
> > > file mode 100644 index 0000000..7ce0d08
> > > --- /dev/null
> > > +++ b/drivers/fpga/zynq-afi.c
> > > @@ -0,0 +1,81 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Xilinx FPGA AFI driver.
> > > + * Copyright (c) 2018 Xilinx Inc.
> > > + */
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +/* Registers and special values for doing register-based operations */
> > > +#define AFI_RDCHAN_CTRL_OFFSET	0x00
> > > +#define AFI_WRCHAN_CTRL_OFFSET	0x14
> > > +
> > > +#define AFI_BUSWIDTH_MASK	0x01
> > > +
> > > +/**
> > > + * struct afi_fpga - AFI register description
> > > + * @membase:	pointer to register struct
> > > + * @afi_width:	AFI bus width to be written
> > > + */
> > > +struct zynq_afi_fpga {
> > > +	void __iomem	*membase;
> > > +	u32		afi_width;
> > > +};
> > > +
> > > +static int zynq_afi_fpga_probe(struct platform_device *pdev) {
> > > +	struct zynq_afi_fpga *afi_fpga;
> > > +	struct resource *res;
> > > +	u32 reg_val;
> > > +	u32 val;
> > > +
> > > +	afi_fpga = devm_kzalloc(&pdev->dev, sizeof(*afi_fpga), GFP_KERNEL);
> > > +	if (!afi_fpga)
> > > +		return -ENOMEM;
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	afi_fpga->membase = devm_ioremap_resource(&pdev->dev, res);
> > > +	if (IS_ERR(afi_fpga->membase))
> > > +		return PTR_ERR(afi_fpga->membase);
> > > +
> > > +	val = device_property_read_u32(&pdev->dev, "xlnx,afi-width",
> > > +				       &afi_fpga->afi_width);
> > > +	if (val) {
> > > +		dev_err(&pdev->dev, "Fail to get the afi bus width\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	reg_val = readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > > +	reg_val &= ~AFI_BUSWIDTH_MASK;
> > > +	writel(reg_val | afi_fpga->afi_width,
> > > +	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > > +	reg_val = readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > > +	reg_val &= ~AFI_BUSWIDTH_MASK;
> > > +	writel(reg_val | afi_fpga->afi_width,
> > > +	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id zynq_afi_fpga_ids[] = {
> > > +	{ .compatible = "xlnx,zynq-afi-fpga" },
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, zynq_afi_fpga_ids);
> > > +
> > > +static struct platform_driver zynq_afi_fpga_driver = {
> > > +	.driver = {
> > > +		.name = "zynq-afi-fpga",
> > > +		.of_match_table = zynq_afi_fpga_ids,
> > > +	},
> > > +	.probe = zynq_afi_fpga_probe,
> > > +};
> > > +module_platform_driver(zynq_afi_fpga_driver);
> > > +
> > > +MODULE_DESCRIPTION("ZYNQ FPGA AFI module");
> > MODULE_AUTHOR("Nava
> > > +kishore Manne <nava.manne@xilinx.com>"); MODULE_LICENSE("GPL v2");
> > > --
> > > 2.7.4
> > >
> > 
> > It looks like all the driver does is writing two registers? How does
> > that fit into FPGA Manager as a framework. Should this maybe be eithe
> > for Zynq architecture or a Misc driver instead?
> > 
> To establish the proper communication channel between PS and PL, The AXI Interface Bus Width should be configured properly.
> For a design to design this AXI Interface Bus Width settings are vary. So for Zynq just loading the Bitstream into the PL is not sufficient
> to establish a proper communication channel between PS and PL we have to do AXI Interface Bus Width settings as per the design
> after loading the Bit file into the PL. I feel this is more relevant to the FPGA settings so I have placed this driver here.

Should this maybe be a fpga bridge driver then? From my understanding you'd change that as part of reprogramming the FPGA?

Thanks,
Moritz
