Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5259430B66E
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Feb 2021 05:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBBEXL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 23:23:11 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:52970 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBBEXB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Feb 2021 23:23:01 -0500
Received: by mail-pj1-f43.google.com with SMTP id q72so58208pjq.2;
        Mon, 01 Feb 2021 20:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qLUs6dprwk/r88yCau/IIGgMC7gpUHG2dSzSEIv5pXs=;
        b=Ox2m3MzXu8u2namMxdMIgiKvv4hHvWTkEE8HXOLXj3Y8d4ahX51jnkCqpUEygo2ydu
         Gf0ch/KVJI4bDZoVGY3ezggGqTN4HMQna6ctZ0MUyc5vDG+hGMf7+DIoWkm/oKwgvuGi
         FNXH1ApjPJ1L7uKZxHzMTnWbQ1OZVOzPU8ncd1idcGKPi7au9rkD1kPKCMslhwV61TOh
         echoTW+7Jh/tJ+4rXCuYG28nhDVt6ARNG4il55r24LRd7HYlq4im/OhQL/UCQCrPJcFb
         II30WdzMBZ+S3BFl/I02vXaVQAV25MgcqGTuIidvaiZVbe7muNhxeAGdTv9wC4WuyM4V
         NPQw==
X-Gm-Message-State: AOAM531ezwlI5rIY+EkzQjHdJLDMHrxD6D8AYjkL/sJRsBfWQirw94SM
        CmSjwqVPy0l4xLirYrTHXcs=
X-Google-Smtp-Source: ABdhPJyoXB5vW1gOzmDFQ+nd9wk6Si/5vEg13RyfxPxS5OlEQc76b7P7cnLwSPEe1Sp1S8I57RTLsQ==
X-Received: by 2002:a17:90a:a083:: with SMTP id r3mr2195143pjp.55.1612239740667;
        Mon, 01 Feb 2021 20:22:20 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id c77sm10210424pfc.214.2021.02.01.20.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 20:22:19 -0800 (PST)
Date:   Mon, 1 Feb 2021 20:22:19 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Mathias Tausen <mta@gomspace.com>
Subject: Re: [PATCH v3 2/4] clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
Message-ID: <YBjTe8ioCb5DK+tt@epycbox.lan>
References: <20210201151245.21845-1-alexandru.ardelean@analog.com>
 <20210201151245.21845-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201151245.21845-3-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 01, 2021 at 05:12:43PM +0200, Alexandru Ardelean wrote:
> For ZynqMP (Ultrascale) the PFD and VCO limits are different. In order to
> support these, this change adds a compatible string (i.e.
> 'adi,zynqmp-axi-clkgen-2.00.a')  which will take into account for these
> limits and apply them.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Mathias Tausen <mta@gomspace.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/clk/clk-axi-clkgen.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index ad86e031ba3e..9d1b0fc56c73 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -108,6 +108,13 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
>  	return 0x1f1f00fa;
>  }
>  
> +static const struct axi_clkgen_limits axi_clkgen_zynqmp_default_limits = {
> +	.fpfd_min = 10000,
> +	.fpfd_max = 450000,
> +	.fvco_min = 800000,
> +	.fvco_max = 1600000,
> +};
> +
>  static const struct axi_clkgen_limits axi_clkgen_zynq_default_limits = {
>  	.fpfd_min = 10000,
>  	.fpfd_max = 300000,
> @@ -560,6 +567,10 @@ static int axi_clkgen_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id axi_clkgen_ids[] = {
> +	{
> +		.compatible = "adi,zynqmp-axi-clkgen-2.00.a",
> +		.data = &axi_clkgen_zynqmp_default_limits,
> +	},
>  	{
>  		.compatible = "adi,axi-clkgen-2.00.a",
>  		.data = &axi_clkgen_zynq_default_limits,
> -- 
> 2.17.1
> 
