Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE7041B297
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Sep 2021 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbhI1PGz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Sep 2021 11:06:55 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:38893 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241400AbhI1PGu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 28 Sep 2021 11:06:50 -0400
Received: by mail-pj1-f54.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1926498pjc.3
        for <linux-fpga@vger.kernel.org>; Tue, 28 Sep 2021 08:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWeOgo5DskT83K+HP+NaH9T2lGp/nhDohpmuB24in7I=;
        b=7NrhbE5gWA09UqSsS6GyCWczpq8Hhq8J8uvEfJ12BUBaUjt46zmeSgRujfK4pmQ/ti
         uel38pI2ZAulNorccKVwZgVRxwuhvhzVGNnvK9XRclhA5pNER4PqAngxIphQpxHTwWax
         oUyQpZJe02vos7pXRbmooAxfjxez0du9D5KeLmh6bGdPRJZQCsFpYXpmIZPFmOh1fJMI
         IDVVSjxaMbZ3cHxD/frjSca98Sx+U//xwrtdp/D8CQTiFiaW7hYviM7BIeOxvkNMbro7
         1tPtp2S/s5d2yO1ahPSbDXsOxp0rfJ8xT0whmY1zojbMfE4u9ujk4ipzG35gz1FbRMpV
         mqdg==
X-Gm-Message-State: AOAM532RT69rW/4IArc/Ch67HB75nAppsirpkQIeBDH2R3aYZ7CpAUeg
        /7MC3GLJMctI4FbFlEy+u3U=
X-Google-Smtp-Source: ABdhPJzHmkAb72DCsdmfB7iWtWWu3lDN+Pt5xCx0S1uQSiZZLAD6MRycmyh6ruT6A+5odkjpoT+26g==
X-Received: by 2002:a17:902:e88d:b0:13b:67d5:2c34 with SMTP id w13-20020a170902e88d00b0013b67d52c34mr5211358plg.66.1632841510487;
        Tue, 28 Sep 2021 08:05:10 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id i24sm2854056pjl.8.2021.09.28.08.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:05:09 -0700 (PDT)
Date:   Tue, 28 Sep 2021 08:05:08 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: ice40-spi: Add SPI device ID table
Message-ID: <YVMvJIDQd5oVzk/Q@epycbox.lan>
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

Ehr .. please ignore that ... I fatfingered sending that patch again.

Sorry for the noise ...

- Moritz

