Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C630F612437
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Oct 2022 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJ2PdZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 29 Oct 2022 11:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJ2PdY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 29 Oct 2022 11:33:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7113C5C9E6;
        Sat, 29 Oct 2022 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667057603; x=1698593603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mHuDuDNNRUovT7qPxWeRLywh7Ez+3FPl+XwoW9eBfPY=;
  b=Z0NWIqlEgU8Wl1x6r/v9bMNEZYNhPKTycCU5YgaW/B5eK5YVbcmgiA5d
   dYbPG+D8I4qy0B3qMgUcFQsf+6SCOppu2kyuH1q866s7I73EJgUGMXl2V
   5CrMbrBMPjxjhp9LvaCpo209ty/4b9RbBJIzV5OSNOVXxgVm1ulbH4JJx
   3fhDXqkMq9HFOHSQQrUL5HwyQN0DevYFPORwsBRW1UP8qfCwbIH2x8EQK
   2pj9zpRq4UCclIHjnIa4OMKWRfM46Iifpgh1Itflo099FieBUQ/ISjcYp
   RKkjgAiSTF/R8ZL4XI4QviJ27aIInUQs+hH++aBZuDSgPLEAdq9EoLH8O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="309761404"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="309761404"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 08:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="738464276"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="738464276"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2022 08:33:18 -0700
Date:   Sat, 29 Oct 2022 23:24:10 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v4 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <Y11FmiDeVhGir+7z@yilunxu-OptiPlex-7050>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020212610.697729-5-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-10-20 at 14:26:10 -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4: use dev_err_probe() everywhere that is appropriate
>     clean up noise
>     change error messages to use the word, unsupported
>     tried again to sort Makefile and KConfig better
>     reorder probe function for easier error handling
>     use new dfh_find_param API
> 
> v3: use passed in location of registers
>     use cleaned up functions for parsing parameters
> 
> v2: clean up error messages
>     alphabetize header files
>     fix 'missing prototype' error by making function static
>     tried to sort Makefile and Kconfig better
> ---
>  drivers/tty/serial/8250/8250_dfl.c | 149 +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig    |  12 +++
>  drivers/tty/serial/8250/Makefile   |   1 +
>  3 files changed, 162 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
> 
> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
> new file mode 100644
> index 000000000000..f02f0ba2a565
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_dfl.c
> @@ -0,0 +1,149 @@
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
> +	int line;
> +};
> +
> +static int dfl_uart_get_params(struct dfl_device *dfl_dev, struct uart_8250_port *uart)
> +{
> +	struct device *dev = &dfl_dev->dev;
> +	u64 v, fifo_len, reg_width;
> +	u64 *p;
> +
> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
> +	if (!p)
> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
> +
> +	uart->port.uartclk = *p;
> +	dev_dbg(dev, "UART_CLK_ID %u Hz\n", uart->port.uartclk);
> +
> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_FIFO_LEN);
> +	if (!p)
> +		return dev_err_probe(dev, -EINVAL, "missing FIFO_LEN param\n");
> +
> +	fifo_len = *p;
> +	dev_dbg(dev, "UART_FIFO_ID fifo_len %llu\n", fifo_len);
> +
> +	switch (fifo_len) {
> +	case 32:
> +		uart->port.type = PORT_ALTR_16550_F32;
> +		break;
> +
> +	case 64:
> +		uart->port.type = PORT_ALTR_16550_F64;
> +		break;
> +
> +	case 128:
> +		uart->port.type = PORT_ALTR_16550_F128;
> +		break;
> +
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "unsupported fifo_len %llu\n", fifo_len);
> +	}
> +
> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_REG_LAYOUT);
> +	if (!p)
> +		return dev_err_probe(dev, -EINVAL, "missing REG_LAYOUT param\n");
> +
> +	v = *p;
> +	uart->port.regshift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
> +	reg_width = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);

I have concern that the raw layout inside the parameter block is
still exposed to drivers and need to be parsed by each driver.

How about we define HW agnostic IDs for parameter specific fields like:

PARAM_ID		FIELD_ID
================================
MSIX			STARTV
			NUMV
--------------------------------
CLK			FREQ
--------------------------------
FIFO			LEN
--------------------------------
REG_LAYOUT		WIDTH
			SHIFT

And define like u64 dfl_find_param(struct dfl_device *, int param_id, int field_id)

Think further, if we have to define HW agnostic property - value pairs,
why don't we just use "Software nodes for the firmware node", see
drivers/base/swnode.c. I think this may be a better choice.

Thanks,
Yilun
