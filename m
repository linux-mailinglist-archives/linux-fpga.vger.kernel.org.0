Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB1E1FA7E3
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Jun 2020 06:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgFPEnu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Jun 2020 00:43:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35656 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFPEnu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 Jun 2020 00:43:50 -0400
Received: by mail-io1-f67.google.com with SMTP id s18so232476ioe.2;
        Mon, 15 Jun 2020 21:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LmzMHIvmvF58EZXJmekpQXD5nDdYxi6HKu1Pmlrtz+M=;
        b=TXTHuxx/oqrxWKTqdzUByAoR+HU6GCBTzgrUQrRnqfnDEryP0pPNyTw6C18JbfWx3i
         SbHWG2TyliSR11c/7b6W++YTGaS8KEkyCohbPl7bdkLxjm6j/SW77fODh5NnR4yVBfvL
         rWBcHImSZNPDnXuUE4D0qPlWiH/qgJCgxHlri00DNltoCN9Rp0Rq/i7I8iMckH0urO6P
         1c97aiy95KXbYvUHDKaytID/9tpJklKJHcNvL8yLODfaWtniffC1z2fbSzAElJpbl57D
         iy+XlfvhjUVLcYUCpvysJKvg6piTYfNxhPKe3kmHw0tYGdhS6E9OGI0It/f1JMydw5lI
         KCYA==
X-Gm-Message-State: AOAM532k6GDni5IP25GA10i6wC9rSPTYltFdYIP4JpZv+poXTRMMHpm9
        WJp2+mWl2Sp/XINzpUeG8wQ=
X-Google-Smtp-Source: ABdhPJztXkJFcZT+mRv8x6WbAlQ2+knDwMSuXZBCslzSxlJCr1fZCeslAJy3cbCICzu0QKi5U0suaQ==
X-Received: by 2002:a6b:8dd5:: with SMTP id p204mr864149iod.33.1592282628930;
        Mon, 15 Jun 2020 21:43:48 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id r17sm9235940ilc.33.2020.06.15.21.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 21:43:48 -0700 (PDT)
Date:   Mon, 15 Jun 2020 21:43:47 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 5/5] fpga manager: xilinx-spi: check INIT_B pin during
 write_init
Message-ID: <20200616044347.GB46300@epycbox.lan>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
 <20200611211144.9421-5-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-5-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Luca,

On Thu, Jun 11, 2020 at 11:11:44PM +0200, Luca Ceresoli wrote:
> The INIT_B reports the status during startup and after the end of the
> programming process. However the current driver completely ignores it.
> 
> Check the pin status during startup to make sure programming is never
> started too early and also to detect any hardware issues in the FPGA
> connection.
> 
> This is optional for backward compatibility. If INIT_B is not passed by
> device tree, just fallback to the old udelays.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/fpga/xilinx-spi.c | 54 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 799ae04301be..2710a15ed16b 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -23,6 +23,7 @@
>  struct xilinx_spi_conf {
>  	struct spi_device *spi;
>  	struct gpio_desc *prog_b;
> +	struct gpio_desc *init_b;
>  	struct gpio_desc *done;
>  };
>  
> @@ -36,11 +37,44 @@ static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> +/**
> + * wait_for_init_b - wait for the INIT_B pin to have a given state, or wait
> + * a given delay if the pin is unavailable
> + *
> + * @mgr        The FPGA manager object
> + * @value      Value INIT_B to wait for (1 = asserted = low)
> + * @act_udelay Delay to wait if the INIT_B pin is not available
> + *
> + * Returns 0 when the pin reached the given state or -ETIMEDOUT if too much
> + * time passed waiting for that. If there is no INIT_B, always return 0.
> + */
> +static int wait_for_init_b(struct fpga_manager *mgr, int value,
> +			   unsigned long backup_udelay)
> +{
> +	struct xilinx_spi_conf *conf = mgr->priv;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> +
> +	if (conf->init_b) {
> +		while (time_before(jiffies, timeout)) {
> +			/* dump_state(conf, "wait for init_d .."); */
> +			if (gpiod_get_value(conf->init_b) == value)
> +				return 0;
> +			usleep_range(100, 400);
> +		}
> +		return -ETIMEDOUT;
> +	}
> +
> +	udelay(backup_udelay);
> +
> +	return 0;
> +}
> +
>  static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  				 struct fpga_image_info *info,
>  				 const char *buf, size_t count)
>  {
>  	struct xilinx_spi_conf *conf = mgr->priv;
> +	int err;
>  
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
> @@ -49,10 +83,21 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  
>  	gpiod_set_value(conf->prog_b, 1);
>  
> -	udelay(1); /* min is 500 ns */
> +	err = wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
> +	if (err) {
> +		dev_err(&mgr->dev, "INIT_B pin did not go low\n");
> +		gpiod_set_value(conf->prog_b, 0);
> +		return err;
> +	}
>  
>  	gpiod_set_value(conf->prog_b, 0);
>  
> +	err = wait_for_init_b(mgr, 0, 0);
> +	if (err) {
> +		dev_err(&mgr->dev, "INIT_B pin did not go high\n");
> +		return err;
> +	}
> +
>  	if (gpiod_get_value(conf->done)) {
>  		dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
>  		return -EIO;
> @@ -154,6 +199,13 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  		return PTR_ERR(conf->prog_b);
>  	}
>  
> +	conf->init_b = devm_gpiod_get_optional(&spi->dev, "init_b", GPIOD_IN);
> +	if (IS_ERR(conf->init_b)) {
> +		dev_err(&spi->dev, "Failed to get INIT_B gpio: %ld\n",
> +			PTR_ERR(conf->init_b));
> +		return PTR_ERR(conf->init_b);
> +	}
> +
>  	conf->done = devm_gpiod_get(&spi->dev, "done", GPIOD_IN);
>  	if (IS_ERR(conf->done)) {
>  		dev_err(&spi->dev, "Failed to get DONE gpio: %ld\n",
> -- 
> 2.27.0
> 

Series looks good, will apply to for-next.

Thanks,
Moritz
