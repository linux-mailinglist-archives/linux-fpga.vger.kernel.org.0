Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A7E311FF3
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Feb 2021 21:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBFUeY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Feb 2021 15:34:24 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:38330 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFUeX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Feb 2021 15:34:23 -0500
Received: by mail-pg1-f172.google.com with SMTP id m2so336761pgq.5;
        Sat, 06 Feb 2021 12:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HRsFuiZCF6TPOJaTF9N1587EjrtcASlfF24gO/jl9Ak=;
        b=eyZVxeDh3HcCwDHTo9/s/v9Kat6++PyzdQOASzv3mi9TKBGwU4q44IAxnbnyE29PH8
         itTwNhezbodWsaF+u3IVoF109ttCXfxK1D4iPv03a/ViZYv1buuIyMD9gwidhngCoRrH
         Qdjdq8u1eu/lmPw4HgJ/VeRqHAaRNcqRVVHYyAsp5DxEPt/nidjdAFUsj96QHNcZUg65
         LDkhicuU4IS5fcPEyMztOXiTWi07hmWtdXyrQ+UWB9Jvc8pYMPe/xCHdRZxwk0XVoUid
         ZFNLjZ0hzaHCVBlqnl35X6E3KVuOvV9OwH69gjYLeoBvyAVfUKQ7eLg52GbC/828g5KG
         1a8g==
X-Gm-Message-State: AOAM533/EwU/Q0z+473RmbAsYCL+UqlW7xA/7zv9fLYI16Md7svTeHEi
        8TQdQ/vkJRCbANq3V/KHsdXsCczPmPOqxQ==
X-Google-Smtp-Source: ABdhPJwxGvaeVybkh9ALuXN4y/AtyKmGB2oKMWbQP7Q5w3lX+S9Xn/8U1mGM04VwkZdLvfy/2xKeIQ==
X-Received: by 2002:a63:ca45:: with SMTP id o5mr10697588pgi.48.1612643622735;
        Sat, 06 Feb 2021 12:33:42 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id m4sm13971578pgu.4.2021.02.06.12.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 12:33:42 -0800 (PST)
Date:   Sat, 6 Feb 2021 12:33:41 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Alan Tull <atull@kernel.org>,
        Anatolij Gustschin <agust@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: fpga-mgr: xilinx-spi: fix error messages on
 -EPROBE_DEFER
Message-ID: <YB79JVCEi+Xd6xpP@epycbox.lan>
References: <20210204121313.24655-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204121313.24655-1-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Feb 04, 2021 at 01:13:13PM +0100, Luca Ceresoli wrote:
> The current code produces an error message on devm_gpiod_get() errors even
> when the error is -EPROBE_DEFER, which should be silent.
> 
> This has been observed producing a significant amount of messages like:
> 
>     xlnx-slave-spi spi1.1: Failed to get PROGRAM_B gpio: -517
> 
> Fix and simplify code by using the dev_err_probe() helper function.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Fixes: dd2784c01d93 ("fpga manager: xilinx-spi: check INIT_B pin during write_init")
> Fixes: 061c97d13f1a ("fpga manager: Add Xilinx slave serial SPI driver")
> ---
>  drivers/fpga/xilinx-spi.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 27defa98092d..fee4d0abf6bf 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -233,25 +233,19 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  
>  	/* PROGRAM_B is active low */
>  	conf->prog_b = devm_gpiod_get(&spi->dev, "prog_b", GPIOD_OUT_LOW);
> -	if (IS_ERR(conf->prog_b)) {
> -		dev_err(&spi->dev, "Failed to get PROGRAM_B gpio: %ld\n",
> -			PTR_ERR(conf->prog_b));
> -		return PTR_ERR(conf->prog_b);
> -	}
> +	if (IS_ERR(conf->prog_b))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->prog_b),
> +				     "Failed to get PROGRAM_B gpio\n");
>  
>  	conf->init_b = devm_gpiod_get_optional(&spi->dev, "init-b", GPIOD_IN);
> -	if (IS_ERR(conf->init_b)) {
> -		dev_err(&spi->dev, "Failed to get INIT_B gpio: %ld\n",
> -			PTR_ERR(conf->init_b));
> -		return PTR_ERR(conf->init_b);
> -	}
> +	if (IS_ERR(conf->init_b))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->init_b),
> +				     "Failed to get INIT_B gpio\n");
>  
>  	conf->done = devm_gpiod_get(&spi->dev, "done", GPIOD_IN);
> -	if (IS_ERR(conf->done)) {
> -		dev_err(&spi->dev, "Failed to get DONE gpio: %ld\n",
> -			PTR_ERR(conf->done));
> -		return PTR_ERR(conf->done);
> -	}
> +	if (IS_ERR(conf->done))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
> +				     "Failed to get DONE gpio\n");
>  
>  	mgr = devm_fpga_mgr_create(&spi->dev,
>  				   "Xilinx Slave Serial FPGA Manager",
> -- 
> 2.30.0
> 
Looks good, will queue.

- Moritz
