Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7D5F04BB
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Sep 2022 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiI3GQv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Sep 2022 02:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiI3GQT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Sep 2022 02:16:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B4F17F54B;
        Thu, 29 Sep 2022 23:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664518572; x=1696054572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=meLDc32biOGivdMOYPdJCWrVN8wpR3WdWFWRtUB782I=;
  b=n/3DRAaXVkmYZnGj/gUkwD+oRdCI/vrhbYVLjzEQoKhfZ3sCQCLGYqSj
   xc2IRaWynUuo/knpYxuQAYKtiFtV6BYGLOJKFFDgJQNwMD6fZHQcT2Qjt
   t9IrsWdAZAlVAoJfo+ViDCd8egvMxeumh5wgTq6LOaV/skbD+26xXmFOj
   B9hrRJXJD1Rpgz8Upw+9XeYszyYzH2AdApbZJKhKzhdNIOwuxjo2atjTE
   8SJ0X5lISbIBoZ/KeC2MIQ9l69+ytT1kL5Dj05HOfvLcof+v1n5K7x/Sw
   0iSNz2zNy7wj+aUJHhHSFPKZRh40GXljaIsB7Csgc/Y3aB5TvHiBrfMjA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="328495816"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="328495816"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 23:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="600302777"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="600302777"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 29 Sep 2022 23:16:05 -0700
Date:   Fri, 30 Sep 2022 14:07:15 +0800
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
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 6/6] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <YzaHk0McD2bAm6PE@yilunxu-OptiPlex-7050>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
 <20220923121745.129167-7-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923121745.129167-7-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-23 at 05:17:45 -0700, matthew.gerlach@linux.intel.com wrote:
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
> +
> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_CLK_FRQ);

I think the parameters of dfl_find_param are too complicated to be used
outside dfl framework (It is OK for dfl internal use).

How about:

  dfl_find_param(struct dfl_device *ddev, int param_id)

Thanks,
Yilun
