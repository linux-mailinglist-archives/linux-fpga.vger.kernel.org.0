Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B61D27D2C1
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Sep 2020 17:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgI2Pan (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Sep 2020 11:30:43 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53170 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2Pan (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 29 Sep 2020 11:30:43 -0400
Received: by mail-pj1-f68.google.com with SMTP id ml18so21882pjb.2;
        Tue, 29 Sep 2020 08:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aWsRNGEYWNS1FOlIs3a6BRy9lNpu3+jVuprEQmGm558=;
        b=OeuwqgpYCfRfagPKO+b2cc1EsVsuzNHKWZMS8mhuydA6PyvtsFPk8QiZuAEi6h5oku
         c7d465VG/xGC6hNdyuZf6ZHAQ8NBUUdDCRrIn2Klu1Sw9Ib19GbmV2uF9YkzE7Eud/aF
         1L+LBMqiQ/ddomXYhwd3vDTsvezau5Tl0khJmwfp9bv3OhAH4ELnnCoHdjrT6kOoHzrf
         yHWCd+pTqJbCrq8k4FfvjgE26y5dBITY1J66SeXVdHUYiNoTCgfKcI1EmcaK/g4jGUCx
         CuOfn2from1OEez5wNnTlgcrgiWecz6FCai4NiLpYcs/Dj2xITc9578yis4HrCbs82tX
         Ldgg==
X-Gm-Message-State: AOAM532cWHnytd1YblAvFxViScNGEFYVPLdtcnLaRcPK9Kr9dbq+Tom7
        Zrk022QsSR2qNgXgGHGT4x8=
X-Google-Smtp-Source: ABdhPJw5BlNaN3pSF96qwEnIL8dGCXUqwG8oGgJpCFD6AsIPGoIrPO+DcbMR2zsgvf5a1G5dujk4ZQ==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr4327116pjv.108.1601393442163;
        Tue, 29 Sep 2020 08:30:42 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id b15sm5731377pft.84.2020.09.29.08.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 08:30:41 -0700 (PDT)
Date:   Tue, 29 Sep 2020 08:30:40 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Mathias Tausen <mta@gomspace.com>
Subject: Re: [PATCH v4 5/7] clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency
 limits
Message-ID: <20200929153040.GA114067@archbook>
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
 <20200929144417.89816-14-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929144417.89816-14-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Alexandru,

On Tue, Sep 29, 2020 at 05:44:15PM +0300, Alexandru Ardelean wrote:
> From: Mathias Tausen <mta@gomspace.com>
> 
> Since axi-clkgen is now supported on ZYNQMP, make sure the max/min
> frequencies of the PFD and VCO are respected.
> 
> Signed-off-by: Mathias Tausen <mta@gomspace.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

This patch still does not cover the PCIe Zynq plugged into ZynqMP linux
machine case.

> ---
>  drivers/clk/clk-axi-clkgen.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 4342b7735590..2319bb1c5c08 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -108,12 +108,21 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
>  	return 0x1f1f00fa;
>  }
>  
> +#ifdef ARCH_ZYNQMP
> +static const struct axi_clkgen_limits axi_clkgen_default_limits = {
> +	.fpfd_min = 10000,
> +	.fpfd_max = 450000,
> +	.fvco_min = 800000,
> +	.fvco_max = 1600000,
> +};
> +#else
>  static const struct axi_clkgen_limits axi_clkgen_default_limits = {
>  	.fpfd_min = 10000,
>  	.fpfd_max = 300000,
>  	.fvco_min = 600000,
>  	.fvco_max = 1200000,
>  };
> +#endif

I still don't understand this. You have a way to determine which fabric
you are looking at with the FPGA info. Why not:

[..] axi_clkgen_zynqmp_default_limits = {
};

[..] axi_clkgen_default_limits = {
};

Set them based on what you read back, i.e. determine which fabric you
are looking at *per clock gen* and use that info, rather than making a
compile time decision to support only one of them.

Generally speaking #ifdef $ARCH should be a last resort solution.
>  
>  static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
>  	unsigned long fin, unsigned long fout,
> -- 
> 2.17.1
> 

Cheers,
Moritz
