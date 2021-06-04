Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C345139B842
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Jun 2021 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFDLut (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Jun 2021 07:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhFDLus (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Jun 2021 07:50:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D69AB61414;
        Fri,  4 Jun 2021 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622807342;
        bh=PAEFa9/yoRU24iRahniGavwwCAg5tMlkqgjEBsh07iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPKCEeUlx34uB80b5ssvwR5HgkihQSnX1Tf9HebBhFqndLXNZVbZV6O0dRZrVffPZ
         JdfzpQ3UK59PqyN+3GOeqH1Xut0h8O6c3Jc0eLQ2i4P3J56tlgMPY143xF6Au0PxW7
         Xz5yNQn1MaGcpL2wbL3GX/aCjYCDokZ0SGIMS82k=
Date:   Fri, 4 Jun 2021 13:48:59 +0200
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
Subject: Re: [PATCH v7 4/4] fpga: versal-fpga: Add versal fpga manager driver
Message-ID: <YLoTK02aUs2vNt+4@kroah.com>
References: <20210604113332.1394-1-nava.manne@xilinx.com>
 <20210604113332.1394-5-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604113332.1394-5-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 04, 2021 at 05:03:32PM +0530, Nava kishore Manne wrote:
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
>               -Updated the Fpga Mgr registrations call's
>                to 5.11
>               -Fixed some minor coding issues as suggested by
>                Moritz.
> 
> Changes for v3:
>               -Rewritten the Versal fpga Kconfig contents.
> 
> Changes for v4:
>               -Rebased the changes on linux-next.
>                No functional changes.
> 
> Changes for v5:
>               -None.
> 
> Changes for v6:
>               -None.
> 
> Changes for v7:
>               -Updated driver to remove unwated priv struct dependency.
> 
>  drivers/fpga/Kconfig       |  9 ++++
>  drivers/fpga/Makefile      |  1 +
>  drivers/fpga/versal-fpga.c | 96 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
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
> index 000000000000..1bd312a31b23
> --- /dev/null
> +++ b/drivers/fpga/versal-fpga.c
> @@ -0,0 +1,96 @@
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
> +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info,
> +				      const char *buf, size_t size)
> +{
> +	return 0;

Why have this if it does nothing?

> +}
> +
> +static int versal_fpga_ops_write(struct fpga_manager *mgr,
> +				 const char *buf, size_t size)
> +{
> +	dma_addr_t dma_addr = 0;
> +	char *kbuf;
> +	int ret;
> +
> +	kbuf = dma_alloc_coherent(mgr->dev.parent, size, &dma_addr, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	memcpy(kbuf, buf, size);
> +	ret = zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
> +	dma_free_coherent(mgr->dev.parent, size, kbuf, dma_addr);
> +
> +	return ret;
> +}
> +
> +static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
> +					  struct fpga_image_info *info)
> +{
> +	return 0;

Same here, why have this at all?

> +}
> +
> +static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager *mgr)
> +{
> +	return FPGA_MGR_STATE_UNKNOWN;

Shouln't that be the default state of the fpga manager if there is no
state function callback?

This driver should just need a write and probe function, and that's it,
why make it more complex?

thanks,

greg k-h
