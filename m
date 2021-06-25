Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5D3B48F0
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 20:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFYSsN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 14:48:13 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:34498 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhFYSsM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 25 Jun 2021 14:48:12 -0400
Received: by mail-pg1-f180.google.com with SMTP id p9so8615951pgb.1;
        Fri, 25 Jun 2021 11:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s8UZjhb/9CTUZ4W5sRC8vDKWtYjlkIwbCG+US3rg5/o=;
        b=O/UYK96rweYFtX4B82TzuNmHqx73NnqGN0x7XxZBtZIWUgvfPAQsOG6GG7wLFRtUpP
         5vFH8oU0r03DzQEx2RyQzu9SaVk4nITTEIb1FreyCPeKAZwpBkFUga2g1n/MyplGRyAT
         erH6hDLD/PDFIG6jEzCa7R9Fz51uvINC/hzHmmkwWILq0DxmM2x7jMyIc9Wn4SHwT3Hk
         5q1oN6ywdnuWjE+/hNuRkyiLoygq8wOND1Qegz8NcSpZ2hNQGtPAgiGDU2CWnSyieHCC
         7h//tbQr94C7dwIr/NS/Yn2kIjmwWAy/9EYXwzIr0VV1NVd1jhf38m9Yg7dVHqa/eOKb
         4ZSA==
X-Gm-Message-State: AOAM531BhnGysnmZqa88N+3Jfx9ufN/W9Ywf+8cvyt9vmaB2jaXNitiB
        F5w37cDmZ1xbfn5aD4LpDFw=
X-Google-Smtp-Source: ABdhPJxzAChRS2n8hKWTgSwH4cke8OUtk7PAqyskbcDRB28irTzBPwzJLYgLuqxS5EzAFxFFuOofBg==
X-Received: by 2002:a63:a53:: with SMTP id z19mr10612129pgk.125.1624646750764;
        Fri, 25 Jun 2021 11:45:50 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z6sm6147347pgs.24.2021.06.25.11.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 11:45:50 -0700 (PDT)
Date:   Fri, 25 Jun 2021 11:45:49 -0700
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
Subject: Re: [PATCH v2 4/5] mfd: intel-m10-bmc: add n5010 variant
Message-ID: <YNYkXVgS4YBgahjw@epycbox.lan>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-5-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625074213.654274-5-martin@geanix.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 25, 2021 at 09:42:12AM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
> 
>  The m10-bmc is used on the Silicom N5010 PAC too, so add it to list of
>  m10bmc types.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Changes since v1:
>  * Patch split out to separate mfd changes
> 
>  drivers/mfd/intel-m10-bmc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index 1a9bfb7f48cd..8db3bcf5fccc 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -15,7 +15,8 @@
>  
>  enum m10bmc_type {
>  	M10_N3000,
> -	M10_D5005
> +	M10_D5005,
> +	M10_N5010,
>  };
>  
>  static struct mfd_cell m10bmc_d5005_subdevs[] = {
> @@ -28,6 +29,10 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
>  	{ .name = "n3000bmc-secure" },
>  };
>  
> +static struct mfd_cell m10bmc_n5010_subdevs[] = {
> +	{ .name = "n5010bmc-hwmon" },
> +};
> +
>  static const struct regmap_range m10bmc_regmap_range[] = {
>  	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
>  	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> @@ -192,6 +197,10 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  		cells = m10bmc_d5005_subdevs;
>  		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
>  		break;
> +	case M10_N5010:
> +		cells = m10bmc_n5010_subdevs;
> +		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
> +		break;
>  	default:
>  		return -ENODEV;
>  	}
> @@ -207,6 +216,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  static const struct spi_device_id m10bmc_spi_id[] = {
>  	{ "m10-n3000", M10_N3000 },
>  	{ "m10-d5005", M10_D5005 },
> +	{ "m10-n5010", M10_N5010 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> -- 
> 2.31.0
> 
