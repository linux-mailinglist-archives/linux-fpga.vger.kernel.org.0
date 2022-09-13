Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76E5B65EB
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Sep 2022 04:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIMC6O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Sep 2022 22:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiIMC6F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 12 Sep 2022 22:58:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1D352FF6;
        Mon, 12 Sep 2022 19:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663037883; x=1694573883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sp5gG4+b6ZZJ27Y2zvVjoqOFmRPQHUPIEcDl++tfFLY=;
  b=UfXYse/jCGmOGor0qaEKRlyZBlOgtWv/wPPO/vyFB/OEWw2a+f3qJTBS
   Skxr4l9zo4FO37ROH6fyp2TGXDaIjgelm9qz/hr3f9SGz5k+GxdjfJNWp
   L62bbIDB82ERbiLMheWu7shOOZoZ/Fur5s8dlOkH+j1XCAofplBq7YDER
   eDGdalp59CiarAsqFTV63dXjWEqisMm4UivrUMaNEDRz8S0dkKhwPair3
   pZBIWZqNUvFPG+m5uTxKd870D1r5ADYb+sX7MULayB4VHjPdiY2n6miM+
   A7UTqzQAlxVxdBwSd/tCPlQcnefOLTi77mRQ1iTk/8LuF4kZo1RxEowC0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="359747665"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="359747665"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 19:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="646736842"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2022 19:57:54 -0700
Date:   Tue, 13 Sep 2022 10:48:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 5/5] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <Yx/vdIVnd+ZVOffL@yilunxu-OptiPlex-7050>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-6-matthew.gerlach@linux.intel.com>
 <Yx2tSicH1M73cISi@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2209120817490.960392@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209120817490.960392@rhweight-WRK1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-12 at 08:29:47 -0700, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Sun, 11 Sep 2022, Xu Yilun wrote:
> 
> > On 2022-09-06 at 12:04:26 -0700, matthew.gerlach@linux.intel.com wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > 
> > > Add a Device Feature List (DFL) bus driver for the Altera
> > > 16550 implementation of UART.
> > > 
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_dfl.c | 188 +++++++++++++++++++++++++++++
> > >  drivers/tty/serial/8250/Kconfig    |   9 ++
> > >  drivers/tty/serial/8250/Makefile   |   1 +
> > >  include/linux/dfl.h                |   7 ++
> > >  4 files changed, 205 insertions(+)
> > >  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
> > > new file mode 100644
> > > index 000000000000..dcf6638a298c
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/8250/8250_dfl.c
> > > @@ -0,0 +1,188 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Driver for FPGA UART
> > > + *
> > > + * Copyright (C) 2022 Intel Corporation, Inc.
> > > + *
> > > + * Authors:
> > > + *   Ananda Ravuri <ananda.ravuri@intel.com>
> > > + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > + */
> > > +
> > > +#include <linux/dfl.h>
> > > +#include <linux/version.h>
> > > +#include <linux/serial.h>
> > > +#include <linux/serial_8250.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/bitfield.h>
> > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > +
> > > +struct dfl_uart {
> > > +	void __iomem   *csr_base;
> > > +	u64             csr_addr;
> > > +	unsigned int    csr_size;
> > > +	struct device  *dev;
> > > +	u64             uart_clk;
> > > +	u64             fifo_len;
> > > +	unsigned int    fifo_size;
> > > +	unsigned int    reg_shift;
> > > +	unsigned int    line;
> > > +};
> > > +
> > > +int feature_uart_walk(struct dfl_uart *dfluart, resource_size_t max)
> > > +{
> > > +	void __iomem *param_base;
> > > +	int off;
> > > +	u64 v;
> > > +
> > > +	v = readq(dfluart->csr_base + DFHv1_CSR_ADDR);
> > > +	dfluart->csr_addr = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
> > > +
> > > +	v = readq(dfluart->csr_base + DFHv1_CSR_SIZE_GRP);
> > > +	dfluart->csr_size = FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v);
> > 
> > These are generic for DFHv1, so maybe we parse them in DFL generic code.
> 
> I will look into moving this to the DFL generic code.
> 
> > 
> > > +
> > > +	if (dfluart->csr_addr == 0 || dfluart->csr_size == 0) {
> > > +		dev_err(dfluart->dev, "FIXME bad dfh address and size\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
> > > +		dev_err(dfluart->dev, "missing required parameters\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	param_base = dfluart->csr_base + DFHv1_PARAM_HDR;
> > 
> > The same concern.
> > 
> > > +
> > > +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_CLK_FRQ);
> > > +	if (off < 0) {
> > > +		dev_err(dfluart->dev, "missing CLK_FRQ param\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	dfluart->uart_clk = readq(param_base + off + DFHv1_PARAM_DATA);
> > > +	dev_dbg(dfluart->dev, "UART_CLK_ID %llu Hz\n", dfluart->uart_clk);
> > 
> > I see the DFHv1_PARAM_ID_CLK_FRQ defined in generic dfl.h, is this
> > param definition global to all features, or specific to uart?
> 
> Certainly uart drivers need to know the input clock frequency in order to
> properly calculate baud rate dividers, but drivers for other features/IP
> blocks may need to know the input clock frequency as well.  On the other
> hand not all drivers need to know the input clock frequency to the
> feature/IP block.
> 
> > 
> > Do we have clear definition of generic parameters vs feature specific
> > parameters?
> 
> I don't think there is a clear definition of generic versus feature
> specific, but a clock frequency and interrupt information it fairly generic.
> 
> > 
> > The concern here is to avoid duplicated parameter parsing for each driver.
> 
> I understand the concern about avoiding duplicated parameter parsing.

Yeah. Another concern is, reviewers from other domains have to look into
every detail of the DFH param layout to know what happened, which I
think is not that friendly.

Thanks,
Yilun
