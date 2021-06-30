Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BBD3B88B5
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Jun 2021 20:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhF3SvB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Jun 2021 14:51:01 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:39711 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbhF3SvA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Jun 2021 14:51:00 -0400
Received: by mail-pj1-f52.google.com with SMTP id in17-20020a17090b4391b0290170ba0ec7fcso4651167pjb.4;
        Wed, 30 Jun 2021 11:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T5FvTKnWrIZyrzZ/uljUOZIdvOGQzvp6CeuTnf1Jtn0=;
        b=dGi6gOIqM/yjRxOfLvvdtXzni+bkPsDVhISNHIImj2AV60YlxYbvMbCff0LaSxlQYc
         Z5DXLYNCgThqUzNWEfPuLBJfiJOlA26TyHBLsCoPOa75uCH9UwCVnsE71QCq/kjJhaEF
         qVt9g0/boso3Tu9aRcaQeAZPhOyv447CI/+dT7PLMUH9BYdfyckLgo+rmBM7u2RJQcAs
         myKx+JVvAXgoa1GItMh4wIt5WYq9LRE3OfoppsQ/3OKZrQb2/HqNhMm6eIg8pCobHVUR
         doSyxXG8ZR1sDvzLuMkCinIbVyzMSJhHmxKinF4Y7O7cWzATycoZ0vtpe+SBdSwUTXNG
         rOoA==
X-Gm-Message-State: AOAM5324JVLj58BWvZ/Ya7dSBWjputw3Lw9L+WpTL8a/UBY8JrdAVgBm
        zPccsZY8r4EzRZaKaNTDSTM=
X-Google-Smtp-Source: ABdhPJzsVxMWPeRCTW7bLT3tT6tlo7q7w2i/wL52syQFL3P0aNQayL8hZz4/OWDGX0dv8dj7qdUqXg==
X-Received: by 2002:a17:902:8308:b029:129:220a:c455 with SMTP id bd8-20020a1709028308b0290129220ac455mr2102791plb.74.1625078910184;
        Wed, 30 Jun 2021 11:48:30 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id t17sm7270035pji.34.2021.06.30.11.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 11:48:29 -0700 (PDT)
Date:   Wed, 30 Jun 2021 11:48:28 -0700
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
Subject: Re: [PATCH v3 2/4] spi: spi-altera-dfl: support n5010 feature
 revision
Message-ID: <YNy8fG5ojNHo2DGY@epycbox.lan>
References: <20210629121214.988036-1-martin@geanix.com>
 <20210629121214.988036-3-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210629121214.988036-3-martin@geanix.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 29, 2021 at 02:12:12PM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
> 
> The Max10 BMC on the Silicom n5010 PAC is slightly different than the
> existing BMC's, so use a dedicated feature revision detect it.
Nit: BMCs not BMC's
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Changes since v2:
>  * None
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

Mark, if you're ok with this can you pick up patches 1/4 ("fpga: dfl:
expose feature revision from struct dfl_device") and this one?

The MFD and HWMON ones can go through the respective trees.

Thanks,
Moritz
