Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6322D5E7E84
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiIWPes (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiIWPeq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 11:34:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17828357DF;
        Fri, 23 Sep 2022 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663947284; x=1695483284;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7SQbpKKz8VanXGTPlKzllewliUqrbY7ICoQto0yQ8eA=;
  b=RYveBZjwTB5GqO0tDKXpGLjfgv1/+4pNJgxsVvMT+PM2z2ST0j2Its6J
   Op3t3n6b9/P6W1IqZKLym7npQta6UEF2J0173HLE0OKWaIslVIT/RdJgm
   sqwPU1TrkVgDbQeo+lre7raKwlW9Gc+cck/rJHfMGnRuBL8YD93jnrhtz
   aNI58O2ybiTrSQpr45GDejv5vb1DDUyWejRaJywx6dT2bKO54rRu4JU0T
   GNM9VBC6gjm0cvQMcGDZdP/aK0JvSJg7VpPFgMxMqgpOYafU3Vt8Kk5Xj
   8C+GUswHD2VHSYCZUE4ol/eYi6sZBa2eXUP9laFn234HxoFwZ+A8+dEWu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="298215486"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="298215486"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:34:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="762651177"
Received: from alutz-mobl.ger.corp.intel.com ([10.252.35.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:34:38 -0700
Date:   Fri, 23 Sep 2022 18:34:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 6/6] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <20220923121745.129167-7-matthew.gerlach@linux.intel.com>
Message-ID: <6eb563c0-2811-f152-544d-392da0cbb65b@linux.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-7-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 23 Sep 2022, matthew.gerlach@linux.intel.com wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> v2: clean up error messages
>     alphabetize header files
>     fix 'missing prototype' error by making function static
>     tried to sort Makefile and Kconfig better
> ---
>  drivers/tty/serial/8250/8250_dfl.c | 177 +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig    |   9 ++
>  drivers/tty/serial/8250/Makefile   |   1 +
>  include/linux/dfl.h                |   7 ++
>  4 files changed, 194 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
> 
> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
> new file mode 100644
> index 000000000000..539ca6138eda
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_dfl.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA UART
> + *
> + * Copyright (C) 2022 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/dfl.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/serial.h>
> +#include <linux/serial_8250.h>
> +
> +struct dfl_uart {
> +	void __iomem   *csr_base;
> +	struct device  *dev;
> +	u64             uart_clk;
> +	u64             fifo_len;
> +	unsigned int    fifo_size;
> +	unsigned int    reg_shift;

Why to make this intermediate storage for these values, wouldn't it be 
simpler to just fill them into the uart_port directly?

> +	unsigned int    line;
> +};
> +
> +static int feature_uart_walk(struct dfl_uart *dfluart, resource_size_t max)
> +{
> +	void __iomem *param_base;
> +	int off;
> +	u64 v;
> +
> +	v = readq(dfluart->csr_base + DFHv1_CSR_SIZE_GRP);
> +
> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
> +		dev_err(dfluart->dev, "missing required DFH parameters\n");
> +		return -EINVAL;
> +	}
> +
> +	param_base = dfluart->csr_base + DFHv1_PARAM_HDR;

Are all callers of dfl_find_param() expected to run these same checks and
calculations? Perhaps some helper to find param base would be useful and
it could also run those checks.

> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_CLK_FRQ);
> +	if (off < 0) {
> +		dev_err(dfluart->dev, "missing CLK_FRQ param\n");
> +		return -EINVAL;
> +	}
> +
> +	dfluart->uart_clk = readq(param_base + off + DFHv1_PARAM_DATA);
> +	dev_dbg(dfluart->dev, "UART_CLK_ID %llu Hz\n", dfluart->uart_clk);
> +
> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_FIFO_LEN);
> +	if (off < 0) {
> +		dev_err(dfluart->dev, "missing FIFO_LEN param\n");
> +		return -EINVAL;
> +	}
> +
> +	dfluart->fifo_len = readq(param_base + off + DFHv1_PARAM_DATA);
> +	dev_dbg(dfluart->dev, "UART_FIFO_ID fifo_len %llu\n", dfluart->fifo_len);
> +
> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_REG_LAYOUT);
> +	if (off < 0) {
> +		dev_err(dfluart->dev, "missing REG_LAYOUT param\n");
> +		return -EINVAL;
> +	}
> +
> +	v = readq(param_base + off + DFHv1_PARAM_DATA);
> +	dfluart->fifo_size = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);

???

> +	dfluart->reg_shift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
> +	dev_dbg(dfluart->dev, "UART_LAYOUT_ID width %d shift %d\n",
> +		dfluart->fifo_size, dfluart->reg_shift);
> +
> +	return 0;
> +}
> +
> +static int dfl_uart_probe(struct dfl_device *dfl_dev)
> +{
> +	struct device *dev = &dfl_dev->dev;
> +	struct uart_8250_port uart;
> +	struct dfl_uart *dfluart;
> +	int ret;
> +
> +	memset(&uart, 0, sizeof(uart));
> +
> +	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
> +	if (!dfluart)
> +		return -ENOMEM;
> +
> +	dfluart->dev = dev;
> +
> +	dfluart->csr_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
> +	if (IS_ERR(dfluart->csr_base)) {
> +		return PTR_ERR(dfluart->csr_base);
> +	}

No need for braces.

> +static void dfl_uart_remove(struct dfl_device *dfl_dev)
> +{
> +	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
> +
> +	if (dfluart->line > 0)

Line 0 is valid uart port. Perhaps you'd never see it here due to how the 
8250 driver allocs ports but it would be better to not make this kind of 
assumption.

> +		serial8250_unregister_port(dfluart->line);
> +}

> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 7d74ef8d1d20..a17aeccc501e 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -67,6 +67,13 @@
>  #define DFHv1_PARAM_MSIX_STARTV	0x8
>  #define DFHv1_PARAM_MSIX_NUMV	0xc
>  
> +#define DFHv1_PARAM_ID_CLK_FRQ    0x2
> +#define DFHv1_PARAM_ID_FIFO_LEN   0x3
> +
> +#define DFHv1_PARAM_ID_REG_LAYOUT 0x4
> +#define DFHv1_PARAM_ID_REG_WIDTH  GENMASK_ULL(63, 32)
> +#define DFHv1_PARAM_ID_REG_SHIFT  GENMASK_ULL(31, 0)

Should UART be included into these names or are they intended to be more 
generic parameters (for non-UART uses)?


-- 
 i.

