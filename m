Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF341A106
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Sep 2021 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhI0VEs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Sep 2021 17:04:48 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:36376 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhI0VEn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Sep 2021 17:04:43 -0400
Received: by mail-pg1-f177.google.com with SMTP id 75so2577236pga.3
        for <linux-fpga@vger.kernel.org>; Mon, 27 Sep 2021 14:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gK+hhMOKMJZAfLuT/6b2n90csyF4Xs21IH6S/9SqVHM=;
        b=XFsSDXjhSZNucsPYQ2GmZOdM85DmwKnTuFmrrXByxnA40KhVXj5CycqiXqn6JwlrY8
         ZB+F3i9h/yOTI86A3mrNdq2ZBWZYY63a2btQov7rtWcwdcPr5DTJ8WWn5VSkSYqoAYLX
         h76DKqCY51jKh9qU13VxR+iZRY8Y88sLK4o2oSZOVfEl/dyx2lC0n+2R2YfX/8Vi/RKA
         Aus3DEHP9M33XURwRc4GXP2r/wZxwEo6NMelbfALWxhk3e7NTp9yYLMgt+9nbfJfWOQZ
         S5768KSVWIm/YgF57eS2Z6Ghn7UcfLPJ40+xTIlKnlsZz7rGnTGweBYtgcbh2yvgzcrx
         kcNQ==
X-Gm-Message-State: AOAM533joCOE7FVLX9QE3kAg7p8uuQFkiXqCD5rxR7c0KPNgryUSPvT5
        pfkNiOOMhLxafBIgtOR1gKHRLel+dOw=
X-Google-Smtp-Source: ABdhPJxrPidHbVWRJblqdN3M4b7tB99VNHEuUNkALcMIXKsZEYd8NQTEEI9PqegrVUKWkaWW4Lmq4g==
X-Received: by 2002:a62:1c96:0:b0:443:2428:c013 with SMTP id c144-20020a621c96000000b004432428c013mr1959906pfc.50.1632776584647;
        Mon, 27 Sep 2021 14:03:04 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id t8sm296353pjt.39.2021.09.27.14.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 14:03:03 -0700 (PDT)
Date:   Mon, 27 Sep 2021 14:03:02 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: ice40-spi: Add SPI device ID table
Message-ID: <YVIxhi+nK5yYih5J@epycbox.lan>
References: <20210927134403.32328-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927134403.32328-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Sep 27, 2021 at 02:44:03PM +0100, Mark Brown wrote:
> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding a SPI ID table.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/fpga/ice40-spi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index 69dec5af23c3..029d3cdb918d 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -192,12 +192,19 @@ static const struct of_device_id ice40_fpga_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ice40_fpga_of_match);
>  
> +static const struct spi_device_id ice40_fpga_spi_ids[] = {
> +	{ .name = "ice40-fpga-mgr", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, ice40_fpga_spi_ids);
> +
>  static struct spi_driver ice40_fpga_driver = {
>  	.probe = ice40_fpga_probe,
>  	.driver = {
>  		.name = "ice40spi",
>  		.of_match_table = of_match_ptr(ice40_fpga_of_match),
>  	},
> +	.id_table = ice40_fpga_spi_ids,
>  };
>  
>  module_spi_driver(ice40_fpga_driver);
> -- 
> 2.20.1
> 

Applied to fixes,

Thanks
