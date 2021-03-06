Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800D532FB6E
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Mar 2021 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCFPkv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Mar 2021 10:40:51 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34676 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhCFPkr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Mar 2021 10:40:47 -0500
Received: by mail-pl1-f173.google.com with SMTP id ba1so2898833plb.1;
        Sat, 06 Mar 2021 07:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvMBjB2eThPG5ApAfydPYsmVW1zRQKVcPc7w19OhDdM=;
        b=jQtaCPqsqHlZ/0+QfqstjaR3Bos7uv3PIIqv52Un19AyXmkAUoGToTLAPaBTgUC5xR
         qkGBNN/amU6NlehhjP4gUJ+WfzLWqYrYVcI5RNvF8AcC110adOzmKUc09XqjLM7QPUTt
         tplvJutYgXnLJfqHYD/xAsc6xpGVUUQf6xFhHIy34UomRqR1mXQBMdy2lk7HmSihj4qf
         +ZIcuTmI/psf/PucT/R9tjj6MORiilAOhJYVGTB4hwEF1Z0uPryS6EFYhRbZseKyI29X
         eXwDJNEkbiPoJmFb9cmKihKqh7Qz2MMYoVazT/3zHv6JtLb4MYORiCdln3ESycvg9NGZ
         N9yA==
X-Gm-Message-State: AOAM531ibl9jSoLpfV9ICG6TOav23j6kvdedU0cAkxJN6XKDdY+GeAR3
        zkTWiWnLeu2EOrAVI6fBnoyo15BkuLk=
X-Google-Smtp-Source: ABdhPJz6FFGwIulq1psPxPPiAEeGOd4Ik9ZkNs0Q7MUPjI1TWSpxqL4E6zX6OmGk8ZlMGtHy93reRw==
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr15975073pjv.13.1615045246670;
        Sat, 06 Mar 2021 07:40:46 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a19sm5529555pff.186.2021.03.06.07.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 07:40:45 -0800 (PST)
Date:   Sat, 6 Mar 2021 07:40:44 -0800
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
Message-ID: <YEOifBrTrETFahYN@epycbox.lan>
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

Applied to for-5.13,

- Moritz
