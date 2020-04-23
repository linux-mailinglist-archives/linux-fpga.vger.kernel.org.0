Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7881B531D
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Apr 2020 05:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgDWD26 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Apr 2020 23:28:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33456 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgDWD25 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 22 Apr 2020 23:28:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id d17so2202232pgo.0;
        Wed, 22 Apr 2020 20:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9aHQgMVMcmk9+d/1S5Kv3tLB8kkTIYxTds5dyRg+eE=;
        b=UVWHaRNO6r6rarl8YmfZYOJEFbQOpBxmiNC99Z/Fa7hWaivCMZy9ZIYrZOiRGqdDxQ
         2QIUIFQzoaUX3Sg1heNr8hU/XinPHXgnQg/k43cfDwITe4tUOhJ9Ic7jCZZn8AXOuEmc
         PObiV2T9vMzq6C5EFgWF42XHy+dCvYHbMpVvjc+KD171v+eXhGWbOxnyFwlR3aO+2vRJ
         aRD/mxQXJZB7jtdvpvp1tm9oRHz5V2GaVMbCsYRfp0DmdBhk7SKdr0U/+5H4GpIeCuXZ
         ANI8f+HaZQ0IiL4Vlx0GJjT25MXyUXLbSEI23jbwupoSkx5cMFBCvxp2WB7bcdcLJDAg
         1rYQ==
X-Gm-Message-State: AGi0PuaFgqQQO4rhTUq38jhVxQIJQm/TcUv+zhmBFmqrtZjPV35OIpEL
        DQVz89NHzkf8/uYNd6agswU=
X-Google-Smtp-Source: APiQypJJMTrWfMhnTklxFhSEYE4Tj1frBEa4Zq1sFq7KuRzVD8gHe3OVKINmK9VNNnsNYqSBJQRmUw==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr2139378pge.196.1587612536594;
        Wed, 22 Apr 2020 20:28:56 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id r9sm1052111pfg.2.2020.04.22.20.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 20:28:55 -0700 (PDT)
Date:   Wed, 22 Apr 2020 20:28:54 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
Subject: Re: [PATCH 2/2] fpga: zynq: Add AFI config driver
Message-ID: <20200423032854.GB2430@epycbox.lan>
References: <1586946290-7280-1-git-send-email-nava.manne@xilinx.com>
 <1586946290-7280-2-git-send-email-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586946290-7280-2-git-send-email-nava.manne@xilinx.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Nava,

On Wed, Apr 15, 2020 at 03:54:50PM +0530, Nava kishore Manne wrote:
> This patch Adds AFI config driver. This is useful for
> the PS to PL configuration for the fpga manager On zynq
> platform.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/Kconfig    |  8 +++++
>  drivers/fpga/Makefile   |  1 +
>  drivers/fpga/zynq-afi.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/fpga/zynq-afi.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 474f304e..60982a0 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -214,4 +214,12 @@ config FPGA_MGR_ZYNQMP_FPGA
>  	  to configure the programmable logic(PL) through PS
>  	  on ZynqMP SoC.
>  
> +config FPGA_MGR_ZYNQ_AFI_FPGA
> +	bool "Xilinx AFI FPGA"
> +	depends on FPGA_MGR_ZYNQ_FPGA
Curious. How does this dependency play in here?
> +	help
> +	  Zynq AFI driver support for writing to the AFI registers
> +	  for configuring the PS_PL interface. For some of the bitstream
> +	  or designs to work the PS to PL interfaces need to be configured
> +	  like the data bus-width etc.
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 312b937..d115e29 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
>  obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
> +obj-$(CONFIG_FPGA_MGR_ZYNQ_AFI_FPGA)	+= zynq-afi.o
>  
>  # High Level Interfaces
>  obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
> diff --git a/drivers/fpga/zynq-afi.c b/drivers/fpga/zynq-afi.c
> new file mode 100644
> index 0000000..7ce0d08
> --- /dev/null
> +++ b/drivers/fpga/zynq-afi.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx FPGA AFI driver.
> + * Copyright (c) 2018 Xilinx Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +/* Registers and special values for doing register-based operations */
> +#define AFI_RDCHAN_CTRL_OFFSET	0x00
> +#define AFI_WRCHAN_CTRL_OFFSET	0x14
> +
> +#define AFI_BUSWIDTH_MASK	0x01
> +
> +/**
> + * struct afi_fpga - AFI register description
> + * @membase:	pointer to register struct
> + * @afi_width:	AFI bus width to be written
> + */
> +struct zynq_afi_fpga {
> +	void __iomem	*membase;
> +	u32		afi_width;
> +};
> +
> +static int zynq_afi_fpga_probe(struct platform_device *pdev)
> +{
> +	struct zynq_afi_fpga *afi_fpga;
> +	struct resource *res;
> +	u32 reg_val;
> +	u32 val;
> +
> +	afi_fpga = devm_kzalloc(&pdev->dev, sizeof(*afi_fpga), GFP_KERNEL);
> +	if (!afi_fpga)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	afi_fpga->membase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(afi_fpga->membase))
> +		return PTR_ERR(afi_fpga->membase);
> +
> +	val = device_property_read_u32(&pdev->dev, "xlnx,afi-width",
> +				       &afi_fpga->afi_width);
> +	if (val) {
> +		dev_err(&pdev->dev, "Fail to get the afi bus width\n");
> +		return -EINVAL;
> +	}
> +
> +	reg_val = readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> +	reg_val &= ~AFI_BUSWIDTH_MASK;
> +	writel(reg_val | afi_fpga->afi_width,
> +	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> +	reg_val = readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> +	reg_val &= ~AFI_BUSWIDTH_MASK;
> +	writel(reg_val | afi_fpga->afi_width,
> +	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id zynq_afi_fpga_ids[] = {
> +	{ .compatible = "xlnx,zynq-afi-fpga" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, zynq_afi_fpga_ids);
> +
> +static struct platform_driver zynq_afi_fpga_driver = {
> +	.driver = {
> +		.name = "zynq-afi-fpga",
> +		.of_match_table = zynq_afi_fpga_ids,
> +	},
> +	.probe = zynq_afi_fpga_probe,
> +};
> +module_platform_driver(zynq_afi_fpga_driver);
> +
> +MODULE_DESCRIPTION("ZYNQ FPGA AFI module");
> +MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 

It looks like all the driver does is writing two registers? How does
that fit into FPGA Manager as a framework. Should this maybe be eithe
for Zynq architecture or a Misc driver instead?

Is the idea here to create the device via an overlay?

Cheers,
Moritz
