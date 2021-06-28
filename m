Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623573B67CD
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhF1Rlz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 13:41:55 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:34711 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhF1Rlw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Jun 2021 13:41:52 -0400
Received: by mail-pf1-f170.google.com with SMTP id i6so14784762pfq.1;
        Mon, 28 Jun 2021 10:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GKO5ojBejaliDRAfRO3dAQuA7EBslyiTCMyxH3Bdubs=;
        b=syawl8jEHZqdvMxvR5fakwWtRDgKT8XukLpDW/eVN90/V20AjsAfShvbdNhrH1d7EN
         LmIrRd6vYOi/CHS72L+vMj1/eifVP6TwUVPYJNfziX5KThfccryIsKPmWx/dVPhEJ3ke
         Eart9k4SCUtzZSSCJ90j7hTM/ery/6Vg7QqrCnRo9OG+gi7OIs6TvPbk82BvIoSf04R2
         1mZTvHSvGn2z9Zm93MK+2jzRHfg8Z8hwLPe+ZBvQI8ITbUMMblgQA5e3/ZJgf4+hBMxA
         XcC5tK5uBaDAyZo2ODwk/hp7ETDOuIW90T059eF7Z4HxzzH8ZfQa5fV2ztstIGrJ4bTc
         M7Mw==
X-Gm-Message-State: AOAM533wIHj/j7+0i9VERRmyL1DsGc9goMGWeM/uyggIV1Xbop9r3uNt
        n9DkaUJeBheSShXjtbgY89g=
X-Google-Smtp-Source: ABdhPJxbGG6Dss+x24txJ9sAD+7Q7mbMGIrOLPniYtp7KvYScCcVODDtDbaXT+gf6TtFnz/Rc/F1Bg==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr24414320pgc.45.1624901965667;
        Mon, 28 Jun 2021 10:39:25 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id lb14sm141101pjb.5.2021.06.28.10.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 10:39:25 -0700 (PDT)
Date:   Mon, 28 Jun 2021 10:39:23 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 3/5] spi: spi-altera-dfl: support n5010 feature
 revision
Message-ID: <YNoJSxnm4g1vufbB@epycbox.lan>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-4-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625074213.654274-4-martin@geanix.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 25, 2021 at 09:42:11AM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
> 
> The Max10 BMC on the Silicom n5010 PAC is slightly different than the
> existing BMC's, so use a dedicated feature revision detect it.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> ---
> 
> Changes since v1:
>  * use feature revision from struct dfl_device instead of reading it
>    from io-mem
> 
>  drivers/spi/spi-altera-dfl.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
> index 3e32e4fe5895..f6cf7c8d9dac 100644
> --- a/drivers/spi/spi-altera-dfl.c
> +++ b/drivers/spi/spi-altera-dfl.c
> @@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
>  	.chip_select = 0,
>  };
>  
> +static struct spi_board_info m10_n5010_bmc_info = {
> +	.modalias = "m10-n5010",
> +	.max_speed_hz = 12500000,
> +	.bus_num = 0,
> +	.chip_select = 0,
> +};
Is there no way to query the mc for version info?
> +
>  static void config_spi_master(void __iomem *base, struct spi_master *master)
>  {
>  	u64 v;
> @@ -130,6 +137,7 @@ static void config_spi_master(void __iomem *base, struct spi_master *master)
>  
>  static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
>  {
> +	struct spi_board_info *board_info = &m10_bmc_info;
>  	struct device *dev = &dfl_dev->dev;
>  	struct spi_master *master;
>  	struct altera_spi *hw;
> @@ -172,9 +180,12 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
>  		goto exit;
>  	}
>  
> -	if (!spi_new_device(master,  &m10_bmc_info)) {
> +	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
> +		board_info = &m10_n5010_bmc_info;

Since this depends on the previous patch: Mark do you want to take both
patches once they're reviewed? From what I can tell the BMC and HWMON
don't directly depend on it, so taking them through SPI tree might be
easiest.

Alternatively I can provide a tag for the DFL change for you to pull.

> +
> +	if (!spi_new_device(master, board_info)) {
>  		dev_err(dev, "%s failed to create SPI device: %s\n",
> -			__func__, m10_bmc_info.modalias);
> +			__func__, board_info->modalias);
>  	}
>  
>  	return 0;
> -- 
> 2.31.0
> 

- Moritz
