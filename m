Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CF2FAE0F
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jan 2021 01:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbhASAeM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jan 2021 19:34:12 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:40460 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbhASAeK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jan 2021 19:34:10 -0500
Received: by mail-pl1-f174.google.com with SMTP id q4so9520520plr.7;
        Mon, 18 Jan 2021 16:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7rDRopC82DR8SCQXLHu8GoZEQ0kPieDkm9TRSwV7rgQ=;
        b=JflsUfBhE6kxLUilWgzMvx8TmgDMoeaEPcWtb/s7+yrD8UQbS4/59VNRdHrq8yywAE
         vU6E1YmjfvwORiDqn/qWDtMZVHFp7q4C75sJhGyJQZBm6ESI78l+9tc8iTfQtHKek1zE
         5wuDPrH2e9agrChBp2EjnGJxuRvw7u2XXY0kNzLBRiqu7HdILxczU7v7IzEAtuklZyNh
         4S581jai0qvLaQEnEfATq1+rYHd5Ug4NA0sy0WS0zTpc/h6TIZXPzh4uvThgB0VDHeM2
         zcfBiTPsOsduOM9eYTNwJqe0pryP6Eo6ewU4yZy4OQ3gQvdxZx3tp2a57dTibToy/aNN
         wSmQ==
X-Gm-Message-State: AOAM531IaizIRcKKdMXh2MEtxX+BbUMn433MR/uJIA+d00G9cey+Mgsm
        cmeoVwIVL6jYlZ1o+vvKum8iunU5RRs=
X-Google-Smtp-Source: ABdhPJyBXIZoQqYjC0C0/6S4LO7EIwuy8qQ6NnQiHWF1V75m5VxXkjNQNn9E7wQwxr++clKqK5IfgQ==
X-Received: by 2002:a17:90a:5209:: with SMTP id v9mr2126839pjh.8.1611016409366;
        Mon, 18 Jan 2021 16:33:29 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x81sm6844446pfc.46.2021.01.18.16.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 16:33:28 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:33:26 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, robh+dt@kernel.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager driver
Message-ID: <YAYo1ksLfMMNxPuL@epycbox.lan>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
 <20210118024318.9530-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118024318.9530-3-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Nava,

On Mon, Jan 18, 2021 at 08:13:18AM +0530, Nava kishore Manne wrote:
> This patch adds driver for versal fpga manager.
Nit: Add support for Xilinx Versal FPGA manager
> 
> PDI source type can be DDR, OCM, QSPI flash etc..
No idea what PDI is :)
> But driver allocates memory always from DDR, Since driver supports only
> DDR source type.
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/Kconfig       |   8 ++
>  drivers/fpga/Makefile      |   1 +
>  drivers/fpga/versal-fpga.c | 149 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 drivers/fpga/versal-fpga.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5645226ca3ce..9f779c3a6739 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -216,4 +216,12 @@ config FPGA_MGR_ZYNQMP_FPGA
>  	  to configure the programmable logic(PL) through PS
>  	  on ZynqMP SoC.
>  
> +config FPGA_MGR_VERSAL_FPGA
> +        tristate "Xilinx Versal FPGA"
> +        depends on ARCH_ZYNQMP || COMPILE_TEST
> +        help
> +          Select this option to enable FPGA manager driver support for
> +          Xilinx Versal SOC. This driver uses the versal soc firmware
> +          interface to load programmable logic(PL) images
> +          on versal soc.
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index d8e21dfc6778..40c9adb6a644 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>  
> diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
> new file mode 100644
> index 000000000000..2a42aa78b182
> --- /dev/null
> +++ b/drivers/fpga/versal-fpga.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Xilinx, Inc.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/string.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +/* Constant Definitions */
> +#define PDI_SOURCE_TYPE	0xF
> +
> +/**
> + * struct versal_fpga_priv - Private data structure
> + * @dev:	Device data structure
> + * @flags:	flags which is used to identify the PL Image type
> + */
> +struct versal_fpga_priv {
> +	struct device *dev;
> +	u32 flags;
This seems unused ... please introduce them when/if you start using
them.
> +};
> +
> +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info,
> +				      const char *buf, size_t size)
> +{
> +	struct versal_fpga_priv *priv;
> +
> +	priv = mgr->priv;
> +	priv->flags = info->flags;
? What uses this ? It seems this function could just be 'return 0' right
now.
> +
> +	return 0;
> +}
> +
> +static int versal_fpga_ops_write(struct fpga_manager *mgr,
> +				 const char *buf, size_t size)
> +{
> +	struct versal_fpga_priv *priv;
> +	dma_addr_t dma_addr = 0;
> +	char *kbuf;
> +	int ret;
> +
> +	priv = mgr->priv;
> +
> +	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	memcpy(kbuf, buf, size);
> +
> +	wmb(); /* ensure all writes are done before initiate FW call */
> +
> +	ret = zynqmp_pm_load_pdi(PDI_SOURCE_TYPE, dma_addr);
> +
> +	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
> +
> +	return ret;
> +}
> +
> +static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
> +					  struct fpga_image_info *info)
> +{
> +	return 0;
> +}
> +
> +static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager *mgr)
> +{
> +	return FPGA_MGR_STATE_OPERATING;
Is that always the case? Shouldn't that be FPGA_MGR_STATE_UNKNOWN?
> +}
> +
> +static const struct fpga_manager_ops versal_fpga_ops = {
> +	.state = versal_fpga_ops_state,
> +	.write_init = versal_fpga_ops_write_init,
> +	.write = versal_fpga_ops_write,
> +	.write_complete = versal_fpga_ops_write_complete,
> +};
> +
> +static int versal_fpga_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct versal_fpga_priv *priv;
> +	struct fpga_manager *mgr;
> +	int err, ret;
Please pick one, err or ret. 'err' seems unused?
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret < 0) {
> +		dev_err(dev, "no usable DMA configuration");
Nit: "no usable DMA configuration\n"
> +		return ret;
> +	}
> +
> +	mgr = devm_fpga_mgr_create(dev, "Xilinx Versal FPGA Manager",
> +				   &versal_fpga_ops, priv);
> +	if (!mgr)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, mgr);
> +

Replace this part:
> +	err = fpga_mgr_register(mgr);
> +	if (err) {
> +		dev_err(dev, "unable to register FPGA manager");
> +		fpga_mgr_free(mgr);
> +		return err;
> +	}

with:
	return devm_fpga_mgr_register(mgr);

I tried to get rid of the boilerplate, since every driver repeats it
(and above calling fpga_mgr_free(mgr) on a devm_fpga_mgr_create()
created FPGA manager is wrong?) :)
> +
> +	return 0;
> +}
> +

Then
> +static int versal_fpga_remove(struct platform_device *pdev)
> +{
> +	struct fpga_manager *mgr = platform_get_drvdata(pdev);
> +
> +	fpga_mgr_unregister(mgr);
> +	fpga_mgr_free(mgr);
> +
> +	return 0;
> +}
drop this since cleanup is now automatic.
> +
> +static const struct of_device_id versal_fpga_of_match[] = {
> +	{ .compatible = "xlnx,versal-fpga", },
> +	{},
> +};
> +
Nit: Drop the newline
> +MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
> +
> +static struct platform_driver versal_fpga_driver = {
> +	.probe = versal_fpga_probe,
> +	.remove = versal_fpga_remove,
> +	.driver = {
> +		.name = "versal_fpga_manager",
> +		.of_match_table = of_match_ptr(versal_fpga_of_match),
> +	},
> +};
> +
Nit: Drop the newline
> +module_platform_driver(versal_fpga_driver);
> +
> +MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
> +MODULE_AUTHOR("Appana Durga Kedareswara rao <appanad.durga.rao@xilinx.com>");
> +MODULE_DESCRIPTION("Xilinx Versal FPGA Manager");
> +MODULE_LICENSE("GPL");
> -- 
> 2.18.0
> 
Thanks,
Moritz
