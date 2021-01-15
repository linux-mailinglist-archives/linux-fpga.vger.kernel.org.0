Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EBB2F8458
	for <lists+linux-fpga@lfdr.de>; Fri, 15 Jan 2021 19:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbhAOS1x (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 15 Jan 2021 13:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727711AbhAOS1v (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 15 Jan 2021 13:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610735184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edpQ9XBa4NxUM42jV640jE0QnzJCtHUWVPa7s08fP6M=;
        b=Wshpl5KRRd9niSnQ2ICUQmQ2dzz9Qq0xsgXWfBlFS+LY72nKd1bNeaHRCVgqmichD+3jsI
        oXENPzTD79b/1Ij3rQmBKez/PIzEOE4U0Lqzq/2AM5tJnxpAI5+0820cTYoaySVZjjEdDo
        mOxmw1oMpSsIVlIYdMSSV9EuiJ3NzjQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-qMZ784bkMZmd8DeLyKHnLg-1; Fri, 15 Jan 2021 13:26:22 -0500
X-MC-Unique: qMZ784bkMZmd8DeLyKHnLg-1
Received: by mail-qv1-f72.google.com with SMTP id i13so8457501qvx.11
        for <linux-fpga@vger.kernel.org>; Fri, 15 Jan 2021 10:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=edpQ9XBa4NxUM42jV640jE0QnzJCtHUWVPa7s08fP6M=;
        b=Cn9kTfbivpsbfWXIG3aF67FX+PFlWYkkI5mtGjiGMiQcTMsIOrL0P5DVOYSfTNcl+R
         9+lGC8JiQHB9LN0gZP3trarqOujFN9rlfEdXtTT5A0yBLQSNisYkOOt5VCr8MtE4yJw1
         RtziHs5YesVB9iOeHhO4CFqLOQAIfsKF78ywaKB0KerP909A3gWZwhoEC07+jeIoVcZz
         mJS2WSVdQ5qmj0JzS/zhuvWF8ECGL6zF0kyYhUespNpVpXETKPBZwZCgzCnJYlE7z5Q/
         vCzgbzxdlFUNuwaXHYZRtXC8OSYqUiZ8dBKRRW3fvOUEk/r7r7cDNqu5muqITV24Un79
         psrw==
X-Gm-Message-State: AOAM531WDbxV2IZmGANEX0Nl/IVTiGhcVTjSXWvFmY0Qwqp78b+tFnWW
        5aqPsFks+zIsDg2HCkrbStFqDO8hcD7OsEKhT0mWJUG0JciafmKD/5DGH45KMTXwMU6OEwEYASW
        /RHXrYQ4hDc3dGqELcOIXCg==
X-Received: by 2002:a37:8703:: with SMTP id j3mr13736111qkd.455.1610735182347;
        Fri, 15 Jan 2021 10:26:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhh3gcJfS7/iyNYYOy0a2+NqIKUaY7FuPSZFU4sMQT601HHELrIoh6E714w3tQyBxQ+Nw6Lw==
X-Received: by 2002:a37:8703:: with SMTP id j3mr13736081qkd.455.1610735182105;
        Fri, 15 Jan 2021 10:26:22 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q185sm5545762qka.96.2021.01.15.10.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 10:26:21 -0800 (PST)
Subject: Re: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown manager
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     git@xilinx.com, chinnikishore369@gmail.com
References: <20210115013431.27667-1-nava.manne@xilinx.com>
 <20210115013431.27667-2-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2dc469ae-cdf4-0774-c786-7dd01c4914c9@redhat.com>
Date:   Fri, 15 Jan 2021 10:26:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115013431.27667-2-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/14/21 5:34 PM, Nava kishore Manne wrote:
> This patch adds support for Xilinx Dynamic Function eXchange(DFX) AXI
> shutdown manager IP. It can be used to safely handling the AXI traffic
> on a Reconfigurable Partition when it is undergoing dynamic reconfiguration
> and there by preventing system deadlock that may occur if AXI transactions
> are interrupted during reconfiguration.
>
> PR-Decoupler and AXI shutdown manager are completely different IPs.
> But both the IP registers are compatible and also both belong to the
> same sub-system (fpga-bridge).So using same driver for both IP's.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/xilinx-pr-decoupler.c | 35 ++++++++++++++++++++++++++----

It looks like the copyright is wrong, please review spelling of Xilix

 * Copyright (c) 2017, Xilix Inc


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

Move xlnx_config_data above xlnx_pr_decouple_data.

could you 'const' char *name ?

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

To be consistent with decoupler name,

shutdown mgr -> Shutdown Manager

> +};
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

Look at XILINX_PR_DECOUPLER entry in Kconfig, maybe add something like

help

  Say Y to enable drivers for the  ... Decoupler or DFX AIX Shutdown Manager

Tom

>  

