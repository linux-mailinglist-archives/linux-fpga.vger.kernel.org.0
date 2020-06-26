Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555C220BAE1
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Jun 2020 23:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgFZVCg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Jun 2020 17:02:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44038 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFZVCg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Jun 2020 17:02:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id r18so5446699pgk.11;
        Fri, 26 Jun 2020 14:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPqpR3Q9MP7aTmsoIH+Dq2vjzFrcdsAUpPCgSp+MH9A=;
        b=gqqlT2rumbSHxaO9ekHmOluqCZYFhxaTl0wMUpoucL32CNh3Q+9pWNNTY82lANUV5M
         Y2nADrgkYmu6eNcuUJizVV+79r4yy3PiECiUyEajVdwAFJ4/UCujbze8f0cONOwjdbbp
         wdnGC5WFpzUmnTi2ec027FIzJC6vk5A48qzEekx0dEmKqoyVnF0zykvfU8NkR8LfCOCh
         caregKBa5EGk8TkkGNDsGvsiBoRKed+EB550ZArGT7PRja/SoKcNXuklTOCjk2JsGqzb
         2JfLpoeTVAyvAigdKutLggLaoTokKfF059DZ3Ntu5etHe21ujSpG/Vv3Uu+/U0DX1O5d
         xKNQ==
X-Gm-Message-State: AOAM532Fit9/Eo8KG44vMZUPgGJmZtq0TMfLXhhnzvh7IF59jhEtWxOu
        m+x4OpacU6RRlPgATCKnbVA=
X-Google-Smtp-Source: ABdhPJzh5+RYjdzUEqWl80n7fPSBxcIVBClfzU74lEzoscgoLKgVGqc8PLvRupo60RCLYxaSwe31AA==
X-Received: by 2002:a63:5a54:: with SMTP id k20mr568669pgm.226.1593205355679;
        Fri, 26 Jun 2020 14:02:35 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id m20sm28646641pfk.52.2020.06.26.14.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:02:35 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:02:34 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 2/2] fpga manager: xilinx-spi: check INIT_B pin during
 write_init
Message-ID: <20200626210234.GB2259@epycbox.lan>
References: <20200622133723.23326-1-luca@lucaceresoli.net>
 <20200622133723.23326-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622133723.23326-2-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 22, 2020 at 03:37:23PM +0200, Luca Ceresoli wrote:
> The INIT_B pin reports the status during startup and after the end of the
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
> 
> ---
> 
> Changes in v2:
>  - rename DT property init_b-gpios to init-b-gpios (Rob Herring suggested to
>    not use '_' in property names)
>  - improve wait_for_init_b() documentation and variable naming
> ---
>  drivers/fpga/xilinx-spi.c | 55 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 799ae04301be..2967aa2a74e2 100644
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
> @@ -36,11 +37,45 @@ static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> +/**
> + * wait_for_init_b - wait for the INIT_B pin to have a given state, or wait
> + * a given delay if the pin is unavailable
> + *
> + * @mgr:        The FPGA manager object
> + * @value:      Value INIT_B to wait for (1 = asserted = low)
> + * @alt_udelay: Delay to wait if the INIT_B GPIO is not available
> + *
> + * Returns 0 when the INIT_B GPIO reached the given state or -ETIMEDOUT if
> + * too much time passed waiting for that. If no INIT_B GPIO is available
> + * then always return 0.
> + */
> +static int wait_for_init_b(struct fpga_manager *mgr, int value,
> +			   unsigned long alt_udelay)
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
> +	udelay(alt_udelay);
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
> @@ -49,10 +84,21 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
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
> @@ -154,6 +200,13 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  		return PTR_ERR(conf->prog_b);
>  	}
>  
> +	conf->init_b = devm_gpiod_get_optional(&spi->dev, "init-b", GPIOD_IN);
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

Will apply to for-next,

Thanks!
