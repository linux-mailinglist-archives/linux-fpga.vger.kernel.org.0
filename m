Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30C03976F7
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Jun 2021 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFAPpQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Jun 2021 11:45:16 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:43556 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAPpQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Jun 2021 11:45:16 -0400
Received: by mail-pf1-f180.google.com with SMTP id t28so1800932pfg.10;
        Tue, 01 Jun 2021 08:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8nqvdsxR+NH3rJZwNtBOf3sh1n/YKIXVAZu6aHmIR4Y=;
        b=isf5e3YmVixACO5BLt3X1F9K282sxiB5zydlVyyu+XchWQKNwApWcQQWmT7V3QnkCp
         LR1GgJeT6R/xnM4eyl7VFyz1n1m9E2mgYW+pll5HrOEstsej026qPH5nIFgLSwUZthbb
         YXBQP3gmz3vuO5aQCl2DnMIYn5i2wxrKQEoyvoN/pe4k039C3qT5cfQdlQYM/9Gno5GI
         +hJxN8Cd0AD2gswZQRH9u9FYezL66EX40ptJMnfaGUgOu/0WFEDAkztJBy2bv8v1AK8g
         3ootBqPcFZFiYEvIjGNKQEaj9oWVC6OkC8FMp1weymehooK+lNO4tKQOZfQK1yC39FZd
         9SVw==
X-Gm-Message-State: AOAM530NBrTY0I1eA2AN6U6D/AiSu9W7jltn25zy+0+EgziS/xHmdyOV
        VZsd0Gj9fThdZ86t5/vY5hU=
X-Google-Smtp-Source: ABdhPJzOW6RED4Ih2u20gVslejrorZChUDTMbBc7LmT9Bh1a5ny5bJVe4RLHtFbHEoIEnUODP0zInw==
X-Received: by 2002:a65:4109:: with SMTP id w9mr28404216pgp.24.1622562214518;
        Tue, 01 Jun 2021 08:43:34 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o27sm14771374pgb.70.2021.06.01.08.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:43:33 -0700 (PDT)
Date:   Tue, 1 Jun 2021 08:43:32 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Ravi Patel <RAVIPATE@xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: Re: [PATCH v6 4/4] fpga: versal-fpga: Add versal fpga manager driver
Message-ID: <YLZVpPgmmT0GCkBE@epycbox.lan>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
 <20210520080954.1393-5-nava.manne@xilinx.com>
 <YKYidhc25e4SIwNi@kroah.com>
 <PH0PR02MB73361AA34F762B497CFDEFB4C23E9@PH0PR02MB7336.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR02MB73361AA34F762B497CFDEFB4C23E9@PH0PR02MB7336.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 01, 2021 at 06:56:32AM +0000, Nava kishore Manne wrote:
> Hi Greg,
> 
> 	Thanks for providing the review comments.
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, May 20, 2021 2:19 PM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>;
> > mdf@kernel.org; trix@redhat.com; arnd@arndb.de; Rajan Vaja
> > <RAJANV@xilinx.com>; Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>;
> > Tejas Patel <tejasp@xlnx.xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > Potthuri <lakshmis@xilinx.com>; Ravi Patel <RAVIPATE@xilinx.com>;
> > iwamatsu@nigauri.org; Jiaying Liang <jliang@xilinx.com>;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-fpga@vger.kernel.org; git <git@xilinx.com>;
> > chinnikishore369@gmail.com; Appana Durga Kedareswara Rao
> > <appanad@xilinx.com>
> > Subject: Re: [PATCH v6 4/4] fpga: versal-fpga: Add versal fpga manager driver
> > 
> > On Thu, May 20, 2021 at 01:39:54PM +0530, Nava kishore Manne wrote:
> > > Add support for Xilinx Versal FPGA manager.
> > >
> > > PDI source type can be DDR, OCM, QSPI flash etc..
> > > But driver allocates memory always from DDR, Since driver supports
> > > only DDR source type.
> > >
> > > Signed-off-by: Appana Durga Kedareswara rao
> > > <appana.durga.rao@xilinx.com>
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > Reviewed-by: Moritz Fischer <mdf@kernel.org>
> > > ---
> > > Changes for v2:
> > >                 -Updated the Fpga Mgr registrations call's
> > >                  to 5.11
> > >                 -Fixed some minor coding issues as suggested by
> > >                  Moritz.
> > > Changes for v3:
> > >                 -Rewritten the Versal fpga Kconfig contents.
> > > Changes for v4:
> > >                 -Rebased the changes on linux-next.
> > >                  No functional changes.
> > > Changes for v5:
> > >                 -None.
> > > Changes for v6:
> > >                 -None.
> > >
> > >  drivers/fpga/Kconfig       |   9 +++
> > >  drivers/fpga/Makefile      |   1 +
> > >  drivers/fpga/versal-fpga.c | 117
> > > +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 127 insertions(+)
> > >  create mode 100644 drivers/fpga/versal-fpga.c
> > >
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > > 33e15058d0dc..92c20b92357a 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -234,4 +234,13 @@ config FPGA_MGR_ZYNQMP_FPGA
> > >  	  to configure the programmable logic(PL) through PS
> > >  	  on ZynqMP SoC.
> > >
> > > +config FPGA_MGR_VERSAL_FPGA
> > > +	tristate "Xilinx Versal FPGA"
> > > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > > +	help
> > > +	  Select this option to enable FPGA manager driver support for
> > > +	  Xilinx Versal SoC. This driver uses the firmware interface to
> > > +	  configure the programmable logic(PL).
> > > +
> > > +	  To compile this as a module, choose M here.
> > >  endif # FPGA
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > > 18dc9885883a..0bff783d1b61 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+=
> > ts73xx-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
> > >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> > > +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
> > >  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
> > >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
> > >
> > > diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
> > > new file mode 100644 index 000000000000..5744e44f981d
> > > --- /dev/null
> > > +++ b/drivers/fpga/versal-fpga.c
> > > @@ -0,0 +1,117 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2019-2021 Xilinx, Inc.
> > > + */
> > > +
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/fpga/fpga-mgr.h>
> > > +#include <linux/io.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/string.h>
> > > +#include <linux/firmware/xlnx-zynqmp.h>
> > > +
> > > +/**
> > > + * struct versal_fpga_priv - Private data structure
> > > + * @dev:	Device data structure
> > > + */
> > > +struct versal_fpga_priv {
> > > +	struct device *dev;
> > > +};
> > 
> > Don't you have this pointer already?  What device is this exactly and why
> > does it differ from the structure it currently lives in?
> > 
> Agree, this struct is not needed.
> Will fix this issue in v7.
> 
> > > +
> > > +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> > > +				      struct fpga_image_info *info,
> > > +				      const char *buf, size_t size) {
> > > +	return 0;
> > > +}
> > 
> > If you don't need this, why include it?
> > 
> 
> Agree this empty API is not needed.
> It's a limitation with the framework and this needs to fixed in the fpga_manager core.
> Will address this generic issue in a different series.

I was working on a series to clean this up anyways :)
>  
> > > +
> > > +static int versal_fpga_ops_write(struct fpga_manager *mgr,
> > > +				 const char *buf, size_t size)
> > > +{
> > > +	struct versal_fpga_priv *priv;
> > > +	dma_addr_t dma_addr = 0;
> > > +	char *kbuf;
> > > +	int ret;
> > > +
> > > +	priv = mgr->priv;
> > > +
> > > +	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr,
> > GFP_KERNEL);
> > > +	if (!kbuf)
> > > +		return -ENOMEM;
> > > +
> > > +	memcpy(kbuf, buf, size);
> > > +
> > > +	wmb(); /* ensure all writes are done before initiate FW call */
> > 
> > What "writes"?  The memcpy above?  Are you _SURE_ that really is correct
> > here?  This feels wrong.
> > 
> 
> Will fix in v7.
> 
> > > +
> > > +	ret = zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
> > 
> > If this needs some sort of barrier, shouldn't it be in this call?
> > 
> 
> Will fix in v7.
> 
> > > +
> > > +	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
> > > +					  struct fpga_image_info *info)
> > > +{
> > > +	return 0;
> > > +}
> > 
> > Again, why have it if it does nothing?
> > 
> 
> Same as above.
> 
> > > +
> > > +static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager
> > > +*mgr) {
> > > +	return FPGA_MGR_STATE_UNKNOWN;
> > > +}
> > 
> > Again, is this needed?  If so, then the fpga_manager core needs to be fixed
> > up :)
> >
> 
> Same as above.
> 
> > > +static const struct fpga_manager_ops versal_fpga_ops = {
> > > +	.state = versal_fpga_ops_state,
> > > +	.write_init = versal_fpga_ops_write_init,
> > > +	.write = versal_fpga_ops_write,
> > > +	.write_complete = versal_fpga_ops_write_complete, };
> > > +
> > > +static int versal_fpga_probe(struct platform_device *pdev) {
> > > +	struct device *dev = &pdev->dev;
> > > +	struct versal_fpga_priv *priv;
> > > +	struct fpga_manager *mgr;
> > > +	int ret;
> > > +
> > > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	priv->dev = dev;
> > 
> > You save a pointer to a reference counted structure, without incrementing
> > the reference count.  What could go wrong?  :)
> > 
> > You are getting lucky here, but as stated above, why do you need this
> > pointer?
> > 
> 
> Will fix in v7.
> 
> Regards,
> Navakishore.

- Moritz
