Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3967438A01A
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 10:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhETIuV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 04:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhETIuS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 04:50:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F29561244;
        Thu, 20 May 2021 08:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621500536;
        bh=MtLvufPCTN8q/1o45ANjRCEMkTxznK6fKZwgjXsAMi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D138oCKE8iwobQsABqTqqRUhZX50iyyZy+Zj6+Jcni313tCnMVpDxzYTTqZ/UzeOJ
         0e47vVoBfuiC0glko6Rr6BXu9sA9tYYsztZO3GhmjktHxmGM153GNwo7Aj2yOGLj8E
         wE/NGnUHFjJelEClVnCFgV65ga1IfJU7sRRxFJKA=
Date:   Thu, 20 May 2021 10:48:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com, mdf@kernel.org,
        trix@redhat.com, arnd@arndb.de, rajan.vaja@xilinx.com,
        amit.sunil.dhamne@xilinx.com, tejas.patel@xilinx.com,
        zou_wei@huawei.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        ravi.patel@xilinx.com, iwamatsu@nigauri.org,
        wendy.liang@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH v6 4/4] fpga: versal-fpga: Add versal fpga manager driver
Message-ID: <YKYidhc25e4SIwNi@kroah.com>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
 <20210520080954.1393-5-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520080954.1393-5-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 20, 2021 at 01:39:54PM +0530, Nava kishore Manne wrote:
> Add support for Xilinx Versal FPGA manager.
> 
> PDI source type can be DDR, OCM, QSPI flash etc..
> But driver allocates memory always from DDR, Since driver supports only
> DDR source type.
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> Changes for v2:
>                 -Updated the Fpga Mgr registrations call's
>                  to 5.11
>                 -Fixed some minor coding issues as suggested by
>                  Moritz.
> Changes for v3:
>                 -Rewritten the Versal fpga Kconfig contents.
> Changes for v4:
>                 -Rebased the changes on linux-next.
>                  No functional changes.
> Changes for v5:
>                 -None.
> Changes for v6:
>                 -None.
> 
>  drivers/fpga/Kconfig       |   9 +++
>  drivers/fpga/Makefile      |   1 +
>  drivers/fpga/versal-fpga.c | 117 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 drivers/fpga/versal-fpga.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 33e15058d0dc..92c20b92357a 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -234,4 +234,13 @@ config FPGA_MGR_ZYNQMP_FPGA
>  	  to configure the programmable logic(PL) through PS
>  	  on ZynqMP SoC.
>  
> +config FPGA_MGR_VERSAL_FPGA
> +	tristate "Xilinx Versal FPGA"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	help
> +	  Select this option to enable FPGA manager driver support for
> +	  Xilinx Versal SoC. This driver uses the firmware interface to
> +	  configure the programmable logic(PL).
> +
> +	  To compile this as a module, choose M here.
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 18dc9885883a..0bff783d1b61 100644
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
> index 000000000000..5744e44f981d
> --- /dev/null
> +++ b/drivers/fpga/versal-fpga.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019-2021 Xilinx, Inc.
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
> +/**
> + * struct versal_fpga_priv - Private data structure
> + * @dev:	Device data structure
> + */
> +struct versal_fpga_priv {
> +	struct device *dev;
> +};

Don't you have this pointer already?  What device is this exactly and
why does it differ from the structure it currently lives in?

> +
> +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info,
> +				      const char *buf, size_t size)
> +{
> +	return 0;
> +}

If you don't need this, why include it?

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

What "writes"?  The memcpy above?  Are you _SURE_ that really is correct
here?  This feels wrong.

> +
> +	ret = zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);

If this needs some sort of barrier, shouldn't it be in this call?

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

Again, why have it if it does nothing?

> +
> +static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager *mgr)
> +{
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}

Again, is this needed?  If so, then the fpga_manager core needs to be
fixed up :)

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
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;

You save a pointer to a reference counted structure, without
incrementing the reference count.  What could go wrong?  :)

You are getting lucky here, but as stated above, why do you need this
pointer?

thanks,

greg k-h
