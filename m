Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7675927
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2019 22:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfGYUwg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Jul 2019 16:52:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38302 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfGYUwf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Jul 2019 16:52:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so23340131pfn.5
        for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2019 13:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HSbDEN3ibEWL74woCB5/ubI7ob6l75EKZcH9+euwQ9o=;
        b=nFg/HGiWFTq/EMgCar/1xlB2z+sQESGO1xqggomrwydRok6MAIsG0EX+0jv4IdIOxJ
         mywgy3uEbRLx2BcqOai7HMQBVdeO0z3py0YzxA3dvC32vEWETVzCdpvsJNHhssf0w0W0
         zEFTmJ6rGWkSchvFSKjNN3TYcMjxae9BSzow9IUmpSk1/PMwwNVQYXh0/MaiOA2E0yFk
         trSw/n0QyrbLBbjkuM1bj0MEGbWsM88gkvJWM0TBbrMPlDdbsv+EVvUZuFkCYMjfnPvX
         hsjc9p5qibM4pGkLxlofzrITOB7yBuPkvOzB3iK5F12aFgLZV/irtluZKATf5wBcadii
         bSRw==
X-Gm-Message-State: APjAAAWgPOFuplB2gVy2A/Wd3x44+jS1uOXDSHLmCw/di+4SJLuNw8XD
        Zh9B+Dhe5ZaKt8QP4mYrNXbOLA==
X-Google-Smtp-Source: APXvYqxILZSGHGZoP7mI6D7dMOXnTZhRw/7zvuy3fGvY6D+CPw7qGzoF6q//1b6aWgTjuwiWTSVkAg==
X-Received: by 2002:a17:90a:2023:: with SMTP id n32mr90672164pjc.3.1564087955072;
        Thu, 25 Jul 2019 13:52:35 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id s11sm23226536pgc.78.2019.07.25.13.52.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 13:52:34 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:52:33 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     atull@kernel.org, mdf@kernel.org, colin.king@canonical.com,
        agust@denx.de, linux-fpga@vger.kernel.org
Subject: Re: [PATCH 1/1] fpga: altera-ps-spi: Fix getting of optional confd
 gpio
Message-ID: <20190725205233.GA13647@archbox>
References: <1564022925-40402-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564022925-40402-1-git-send-email-preid@electromag.com.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 25, 2019 at 10:48:45AM +0800, Phil Reid wrote:
> Currently the driver does not handle EPROBE_DEFER for the confd gpio.
> Use devm_gpiod_get_optional() instead of devm_gpiod_get() and return
> error codes from altera_ps_probe().
> 
> Fixes: 5692fae0742d ("fpga manager: Add altera-ps-spi driver for Altera FPGAs")
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
> 
> Notes:
>     Compile tested only. I currently don't have hardware to test.
>     I was reviewing the driver prior to a board design and noticed
>     the problem.
> 
>  drivers/fpga/altera-ps-spi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 678d0115f840..a02b88d63f89 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -213,7 +213,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
>  		return -EIO;
>  	}
>  
> -	if (!IS_ERR(conf->confd)) {
> +	if (conf->confd) {
>  		if (!gpiod_get_raw_value_cansleep(conf->confd)) {
>  			dev_err(&mgr->dev, "CONF_DONE is inactive!\n");
>  			return -EIO;
> @@ -292,10 +292,13 @@ static int altera_ps_probe(struct spi_device *spi)
>  		return PTR_ERR(conf->status);
>  	}
>  
> -	conf->confd = devm_gpiod_get(&spi->dev, "confd", GPIOD_IN);
> +	conf->confd = devm_gpiod_get_optional(&spi->dev, "confd", GPIOD_IN);
>  	if (IS_ERR(conf->confd)) {
> -		dev_warn(&spi->dev, "Not using confd gpio: %ld\n",
> -			 PTR_ERR(conf->confd));
> +		dev_err(&spi->dev, "Failed to get confd gpio: %ld\n",
> +			PTR_ERR(conf->confd));
> +		return PTR_ERR(conf->confd);
> +	} else if (!conf->confd) {
> +		dev_warn(&spi->dev, "Not using confd gpio");
>  	}
>  
>  	/* Register manager with unique name */
> -- 
> 1.8.3.1
> 
Applied, thanks.

Moritz
