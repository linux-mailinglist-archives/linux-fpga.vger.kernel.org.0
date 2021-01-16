Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4F42F8AD4
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Jan 2021 03:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbhAPC7M (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 15 Jan 2021 21:59:12 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:38934 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbhAPC7L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 15 Jan 2021 21:59:11 -0500
Received: by mail-pj1-f45.google.com with SMTP id u4so6303859pjn.4;
        Fri, 15 Jan 2021 18:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVsBck0Z5p+UKXwykplK7uSOgMz1NNsO42lw5Jci3JY=;
        b=BTrolAqnTwmwkshAsYJV9CjEESc9leSh1wIEQ5O/kBNr5uh/naGe5WlUYwAny0rpMY
         CKjgVaQrazZnCBw3iKSe+3B8NJeLY/FSIFAHAizT0KHjetYHs6fsAj2HqQUD2zDqe1fO
         SJTne2eSWvLt93rcDzIlL979dxrzIwMo2r5gNh6T38ORrstvi3iRsiBGqBPExK9olHz0
         ywRvNBVk8TwVAGiqkGxQqM9gtMJVS4hV9hNRD9EYJ+ZehXFVpYtiBvJIayRLL32iQ5+M
         ez9rf3nBB9a3Kfg4kAdQgIyA7nU0FhcCKQJh0qt3/lBFmdsYocbyR61dbapVMRaz76Gh
         LnRg==
X-Gm-Message-State: AOAM531H3OOSr2PMWUWg5PwEAkGT+67fMe80c3HwHdIHSvawfcXfwojj
        U47r6TXbiozZ3pJQLvMJaQ3RUb1pOKU=
X-Google-Smtp-Source: ABdhPJxp0lz8bnbGii40+rUGjA1bkL+IfGQ29DnHaOwLGQGHFSMOXwUx1KmpvP5XrSl4XiuaWg/T+w==
X-Received: by 2002:a17:90b:490c:: with SMTP id kr12mr13990625pjb.227.1610765905053;
        Fri, 15 Jan 2021 18:58:25 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id bx17sm9459544pjb.12.2021.01.15.18.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 18:58:24 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:58:23 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, robh+dt@kernel.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com
Subject: Re: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown manager
Message-ID: <YAJWT4IDPmHneam1@epycbox.lan>
References: <20210115013431.27667-1-nava.manne@xilinx.com>
 <20210115013431.27667-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115013431.27667-2-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

On Fri, Jan 15, 2021 at 07:04:31AM +0530, Nava kishore Manne wrote:
> This patch adds support for Xilinx Dynamic Function eXchange(DFX) AXI
> shutdown manager IP. It can be used to safely handling the AXI traffic
> on a Reconfigurable Partition when it is undergoing dynamic reconfiguration
> and there by preventing system deadlock that may occur if AXI transactions
> are interrupted during reconfiguration.
> 
> PR-Decoupler and AXI shutdown manager are completely different IPs.
> But both the IP registers are compatible and also both belong to the
> same sub-system (fpga-bridge).So using same driver for both IP's.

I'm a bit confused, the whole goal here is to give the thing a
different name?
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/xilinx-pr-decoupler.c | 35 ++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 7d69af230567..c95f3d065ccb 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -19,10 +19,15 @@
>  #define CTRL_OFFSET		0
>  
>  struct xlnx_pr_decoupler_data {
> +	const struct xlnx_config_data *ipconfig;
>  	void __iomem *io_base;
>  	struct clk *clk;
>  };
>  
> +struct xlnx_config_data {
> +	char *name;
> +};
> +
>  static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
>  					   u32 offset, u32 val)
>  {
> @@ -76,15 +81,28 @@ static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
>  	.enable_show = xlnx_pr_decoupler_enable_show,
>  };
>  
> +static const struct xlnx_config_data decoupler_config = {
> +	.name = "Xilinx PR Decoupler",
> +};
> +
> +static const struct xlnx_config_data shutdown_config = {
> +	.name = "Xilinx DFX AXI shutdown mgr",
> +};

If it's just the strings, why not store them as is?
> +
>  static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
> -	{ .compatible = "xlnx,pr-decoupler-1.00", },
> -	{ .compatible = "xlnx,pr-decoupler", },
> +	{ .compatible = "xlnx,pr-decoupler-1.00", .data = &decoupler_config },
> +	{ .compatible = "xlnx,pr-decoupler", .data = &decoupler_config },
> +	{ .compatible = "xlnx,dfx-axi-shutdown-manager-1.00",
> +					.data = &shutdown_config },
> +	{ .compatible = "xlnx,dfx-axi-shutdown-manager",
> +					.data = &shutdown_config },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
>  
>  static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct xlnx_pr_decoupler_data *priv;
>  	struct fpga_bridge *br;
>  	int err;
> @@ -94,6 +112,14 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	if (np) {
> +		const struct of_device_id *match;
> +
> +		match = of_match_node(xlnx_pr_decoupler_of_match, np);
> +		if (match && match->data)
> +			priv->ipconfig = match->data;
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->io_base))
> @@ -114,7 +140,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  
>  	clk_disable(priv->clk);
>  
> -	br = devm_fpga_bridge_create(&pdev->dev, "Xilinx PR Decoupler",
> +	br = devm_fpga_bridge_create(&pdev->dev, priv->ipconfig->name,
>  				     &xlnx_pr_decoupler_br_ops, priv);
>  	if (!br) {
>  		err = -ENOMEM;
> @@ -125,7 +151,8 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  
>  	err = fpga_bridge_register(br);
>  	if (err) {
> -		dev_err(&pdev->dev, "unable to register Xilinx PR Decoupler");
> +		dev_err(&pdev->dev, "unable to register %s",
> +			priv->ipconfig->name);
>  		goto err_clk;
>  	}
>  
> -- 
> 2.18.0
> 

Thanks,
Moritz
