Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C911F3066B1
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 22:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhA0VrZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jan 2021 16:47:25 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:39407 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhA0VpU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 27 Jan 2021 16:45:20 -0500
Received: by mail-pg1-f182.google.com with SMTP id o63so2525486pgo.6;
        Wed, 27 Jan 2021 13:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDeIXSgOSJgnWPOCqP8Nrlw9FK+O7v245RBGBzoO0fM=;
        b=regp5yJ5MwmANSrdy8u5pc5vwci3LyyH1hpNtRc5WKdguWZWIaYCOmlr+BvB3Ms7IQ
         k10t3pTVVHjPfpYPNi/rr09A6qg5td1z3AKyJ6seCWHxH55ZeoL/M5qMoZH5+ATL/CpN
         q9smpYfT88fi2Uh0bc4Hn9+cE+usK0eC23APfhVVNZlwleL7oFXd3s9vMMzWGAfyLM6d
         NTCI+nt0cGGn6MMP3OHRvUAK8h1X1avS6992pJytfr3qhd+eTFwYwyMpVBVat1py1nFt
         0bCMyUw3tUHV+8XuqOicrPNC7/3+T6FerXfaUF16i/qcWhjdFdpvY4b/reXX/oVUxeCF
         4sOQ==
X-Gm-Message-State: AOAM5305Fdimu3c0LfSSKY3C+ako3mNFD6VTy7FR6mC8wV+1ISm4/A3/
        V/8Sv7UpF23naThOQEv7OEk=
X-Google-Smtp-Source: ABdhPJzAzr7HT6QMuvbPgDdb7aSVlTEiXldcET/CZ3C8NtvJ+FDQAbpXlqRbiHozJwVNR1nwXjxisA==
X-Received: by 2002:a62:8f96:0:b029:1b7:75a9:a8b7 with SMTP id n144-20020a628f960000b02901b775a9a8b7mr12984299pfd.28.1611783879399;
        Wed, 27 Jan 2021 13:44:39 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id p128sm451816pfp.210.2021.01.27.13.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 13:44:38 -0800 (PST)
Date:   Wed, 27 Jan 2021 13:44:37 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Nava kishore Manne <navam@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager driver
Message-ID: <YBHexYg/Bw1U7LQm@epycbox.lan>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
 <20210118024318.9530-3-nava.manne@xilinx.com>
 <YAYo1ksLfMMNxPuL@epycbox.lan>
 <MWHPR02MB26239A3F539DE8E053D512D5C2A09@MWHPR02MB2623.namprd02.prod.outlook.com>
 <YAyyU9dybSdmOAQL@epycbox.lan>
 <MWHPR02MB26231DAF3A8E2A65EF25A4C3C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
 <5ae6d181-3258-a877-23c5-6ba81c40b10a@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae6d181-3258-a877-23c5-6ba81c40b10a@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jan 27, 2021 at 10:16:32AM +0100, Michal Simek wrote:
> Hi
> 
> On 1/27/21 9:57 AM, Nava kishore Manne wrote:
> > Hi Moritz,
> > 
> > 	Please find my response inline.
> > 
> >> -----Original Message-----
> >> From: Moritz Fischer <mdf@kernel.org>
> >> Sent: Sunday, January 24, 2021 5:04 AM
> >> To: Nava kishore Manne <navam@xilinx.com>
> >> Cc: Moritz Fischer <mdf@kernel.org>; trix@redhat.com;
> >> robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> >> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> >> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> >> <git@xilinx.com>; chinnikishore369@gmail.com; Appana Durga Kedareswara
> >> Rao <appanad@xilinx.com>
> >> Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager driver
> >>
> >> Hi Nava,
> >>
> >> On Fri, Jan 22, 2021 at 10:34:15AM +0000, Nava kishore Manne wrote:
> >>> Hi Moritz,
> >>>
> >>> 	Thanks for the review.
> >>> Please find my response inline.
> >>>
> >>>> -----Original Message-----
> >>>> From: Moritz Fischer <mdf@kernel.org>
> >>>> Sent: Tuesday, January 19, 2021 6:03 AM
> >>>> To: Nava kishore Manne <navam@xilinx.com>
> >>>> Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal
> >>>> Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> >>>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> >>>> linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> >>>> chinnikishore369@gmail.com; Appana Durga Kedareswara Rao
> >>>> <appanad@xilinx.com>
> >>>> Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager
> >>>> driver
> >>>>
> >>>> Hi Nava,
> >>>>
> >>>> On Mon, Jan 18, 2021 at 08:13:18AM +0530, Nava kishore Manne wrote:
> >>>>> This patch adds driver for versal fpga manager.
> >>>> Nit: Add support for Xilinx Versal FPGA manager
> >>>
> >>> Will fix in v2.
> >>>
> >>>>>
> >>>>> PDI source type can be DDR, OCM, QSPI flash etc..
> >>>> No idea what PDI is :)
> >>>
> >>> Programmable device image (PDI).
> >>> This file is generated by Xilinx Vivado tool and it contains configuration data
> >> objects.
> >>>
> >>>>> But driver allocates memory always from DDR, Since driver supports
> >>>>> only DDR source type.
> >>>>>
> >>>>> Signed-off-by: Appana Durga Kedareswara rao
> >>>>> <appana.durga.rao@xilinx.com>
> >>>>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> >>>>> ---
> >>>>>  drivers/fpga/Kconfig       |   8 ++
> >>>>>  drivers/fpga/Makefile      |   1 +
> >>>>>  drivers/fpga/versal-fpga.c | 149
> >>>>> +++++++++++++++++++++++++++++++++++++
> >>>>>  3 files changed, 158 insertions(+)  create mode 100644
> >>>>> drivers/fpga/versal-fpga.c
> >>>>>
> >>>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> >>>>> 5645226ca3ce..9f779c3a6739 100644
> >>>>> --- a/drivers/fpga/Kconfig
> >>>>> +++ b/drivers/fpga/Kconfig
> >>>>> @@ -216,4 +216,12 @@ config FPGA_MGR_ZYNQMP_FPGA
> >>>>>  	  to configure the programmable logic(PL) through PS
> >>>>>  	  on ZynqMP SoC.
> >>>>>
> >>>>> +config FPGA_MGR_VERSAL_FPGA
> >>>>> +        tristate "Xilinx Versal FPGA"
> >>>>> +        depends on ARCH_ZYNQMP || COMPILE_TEST
> >>>>> +        help
> >>>>> +          Select this option to enable FPGA manager driver support for
> >>>>> +          Xilinx Versal SOC. This driver uses the versal soc firmware
> >>>>> +          interface to load programmable logic(PL) images
> >>>>> +          on versal soc.
> >>>>>  endif # FPGA
> >>>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> >>>>> d8e21dfc6778..40c9adb6a644 100644
> >>>>> --- a/drivers/fpga/Makefile
> >>>>> +++ b/drivers/fpga/Makefile
> >>>>> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+=
> >>>> ts73xx-fpga.o
> >>>>>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
> >>>>>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> >>>>>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> >>>>> +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
> >>>>>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
> >>>>>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
> >>>>>
> >>>>> diff --git a/drivers/fpga/versal-fpga.c
> >>>>> b/drivers/fpga/versal-fpga.c new file mode 100644 index
> >>>>> 000000000000..2a42aa78b182
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/fpga/versal-fpga.c
> >>>>> @@ -0,0 +1,149 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0+
> >>>>> +/*
> >>>>> + * Copyright (C) 2021 Xilinx, Inc.
> >>>>> + */
> >>>>> +
> >>>>> +#include <linux/dma-mapping.h>
> >>>>> +#include <linux/fpga/fpga-mgr.h>
> >>>>> +#include <linux/io.h>
> >>>>> +#include <linux/kernel.h>
> >>>>> +#include <linux/module.h>
> >>>>> +#include <linux/of_address.h>
> >>>>> +#include <linux/string.h>
> >>>>> +#include <linux/firmware/xlnx-zynqmp.h>
> >>>>> +
> >>>>> +/* Constant Definitions */
> >>>>> +#define PDI_SOURCE_TYPE	0xF
> >>>>> +
> >>>>> +/**
> >>>>> + * struct versal_fpga_priv - Private data structure
> >>>>> + * @dev:	Device data structure
> >>>>> + * @flags:	flags which is used to identify the PL Image type
> >>>>> + */
> >>>>> +struct versal_fpga_priv {
> >>>>> +	struct device *dev;
> >>>>> +	u32 flags;
> >>>> This seems unused ... please introduce them when/if you start using
> >> them.
> >>>
> >>> Will fix in v2.
> >>>
> >>>>> +};
> >>>>> +
> >>>>> +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> >>>>> +				      struct fpga_image_info *info,
> >>>>> +				      const char *buf, size_t size) {
> >>>>> +	struct versal_fpga_priv *priv;
> >>>>> +
> >>>>> +	priv = mgr->priv;
> >>>>> +	priv->flags = info->flags;
> >>>> ? What uses this ? It seems this function could just be 'return 0' right now.
> >>>
> >>> Will fix in v2.
> >>>
> >>>>> +
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static int versal_fpga_ops_write(struct fpga_manager *mgr,
> >>>>> +				 const char *buf, size_t size) {
> >>>>> +	struct versal_fpga_priv *priv;
> >>>>> +	dma_addr_t dma_addr = 0;
> >>>>> +	char *kbuf;
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	priv = mgr->priv;
> >>>>> +
> >>>>> +	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr,
> >>>> GFP_KERNEL);
> >>>>> +	if (!kbuf)
> >>>>> +		return -ENOMEM;
> >>>>> +
> >>>>> +	memcpy(kbuf, buf, size);
> >>>>> +
> >>>>> +	wmb(); /* ensure all writes are done before initiate FW call */
> >>>>> +
> >>>>> +	ret = zynqmp_pm_load_pdi(PDI_SOURCE_TYPE, dma_addr);
> >>>>> +
> >>>>> +	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
> >>>>> +
> >>>>> +	return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
> >>>>> +					  struct fpga_image_info *info) {
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static enum fpga_mgr_states versal_fpga_ops_state(struct
> >>>>> +fpga_manager
> >>>>> +*mgr) {
> >>>>> +	return FPGA_MGR_STATE_OPERATING;
> >>>> Is that always the case? Shouldn't that be
> >> FPGA_MGR_STATE_UNKNOWN?
> >>>
> >>> For Versal SoC base PDI is always configured prior to Linux boot up. So I
> >> make the fpga state as OPERATING.
> >>> Please let know if it is not a proper implementation will think about the
> >> alternate solution.
> >>
> >> So you're saying I can't boot a Versal SoC without a PDI / Bitstream loaded?
> >> Interesting :)
> >>>
> > 
> > For Versal SoC Vivado generated base PDI is always needed to bring-up the board. 
> 
> Look at PDI as ps7_init/psu_init file but in different format. And
> bitstream is optional part of it (like a one partition).

So at that point I could still have no bitstream loaded (optional), and
my status would be 'unknown' not 'operating' if I cannot tell the two
cases apart. What am I missing? :)

Thanks,
Moritz
