Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6980431842C
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 05:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhBKEGk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Feb 2021 23:06:40 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:37681 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhBKEGi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 10 Feb 2021 23:06:38 -0500
Received: by mail-pg1-f171.google.com with SMTP id z21so2916393pgj.4;
        Wed, 10 Feb 2021 20:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YmprhBUucZtKdCmu+LAa/i7gnU89uApOkepqzbffePM=;
        b=iaNUsbrvkAnxEKNI/suPdo35uWbfrwyvj58EdmyeXtaz2k89NYamqkBJOJxcTCNLP1
         3m2CdrWRfpfX61DwYK0jkNexmCgNXcL7ZY/8z98Cz/t9hqtYsujKwAqnIPg74Wanld/F
         Mi5dkAPM7tdZXwlrBWlu8yVAKKw349GLr+dWStsYYwPzzQExNc5YCs16RSlE2e/brA4H
         nHR89AhH4ECSoGLFy+awlvrEBBpltUZGMM0PG8C0qIM0WNynAlkgdyBMH7qlQBztnz9l
         GjxeA5xLNG8DS7jorP0GtNPUhCQ5FTjst5cWEh4Q3H2AGweDcmbmjKWKUPdC+LR3uIIJ
         JJhQ==
X-Gm-Message-State: AOAM531tJLPJ/9KLYZdrxl90CU/su+ZXr36+kBmOuaoySznquGFN9UXB
        ZJzSTnZW4ZUbgKGkLcAYFGZdXOYt+aRrrg==
X-Google-Smtp-Source: ABdhPJwo/ejHlo1FzbyvQYlQmh5g0eMEySpfj3sTg0+aiNhiw864/oHn2Dlv72HCQOUE7clB/FbORA==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr6320181pgk.186.1613016358110;
        Wed, 10 Feb 2021 20:05:58 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z186sm3758954pgb.78.2021.02.10.20.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 20:05:57 -0800 (PST)
Date:   Wed, 10 Feb 2021 20:05:56 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH 2/2] clk: axi-clkgen: Add support for FPGA info
Message-ID: <YCStJFVsYIB2ogKU@epycbox.lan>
References: <20210210101535.47979-1-alexandru.ardelean@analog.com>
 <20210210101535.47979-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210101535.47979-2-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Feb 10, 2021 at 12:15:35PM +0200, Alexandru Ardelean wrote:
> From: Mircea Caprioru <mircea.caprioru@analog.com>
> 
> This patch adds support for vco maximum and minimum ranges in accordance
VCO
> with fpga speed grade, voltage, device package, technology and family. This
FPGA
> new information is extracted from two new registers implemented in the ip
> core: ADI_REG_FPGA_INFO and ADI_REG_FPGA_VOLTAGE, which are stored in the
> 'include/linux/fpga/adi-axi-common.h' file as they are common to all ADI
> FPGA cores.
Either all caps FPGA or all non-caps.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c | 52 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index ac6ff736ac8f..e4d6c87f8a07 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/platform_device.h>
>  #include <linux/clk-provider.h>
> +#include <linux/fpga/adi-axi-common.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> @@ -240,6 +241,50 @@ static void axi_clkgen_read(struct axi_clkgen *axi_clkgen,
>  	*val = readl(axi_clkgen->base + reg);
>  }
>  
> +static void axi_clkgen_setup_ranges(struct axi_clkgen *axi_clkgen)
> +{
> +	struct axi_clkgen_limits *limits = &axi_clkgen->limits;
> +	unsigned int reg_value;
> +	unsigned int tech, family, speed_grade, voltage;
Reverse xmas-tree please.

xxxxxx
xxx
x
> +
> +	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_INFO, &reg_value);
> +	tech = ADI_AXI_INFO_FPGA_TECH(reg_value);
> +	family = ADI_AXI_INFO_FPGA_FAMILY(reg_value);
> +	speed_grade = ADI_AXI_INFO_FPGA_SPEED_GRADE(reg_value);
> +
> +	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_VOLTAGE, &reg_value);
> +	voltage = ADI_AXI_INFO_FPGA_VOLTAGE(reg_value);
> +
> +	switch (speed_grade) {
> +	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_1 ... ADI_AXI_FPGA_SPEED_GRADE_XILINX_1LV:
> +		limits->fvco_max = 1200000;
> +		limits->fpfd_max = 450000;
> +		break;
> +	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_2 ... ADI_AXI_FPGA_SPEED_GRADE_XILINX_2LV:
> +		limits->fvco_max = 1440000;
> +		limits->fpfd_max = 500000;
> +		if ((family == ADI_AXI_FPGA_FAMILY_XILINX_KINTEX) |
> +		    (family == ADI_AXI_FPGA_FAMILY_XILINX_ARTIX)) {
> +			if (voltage < 950) {
> +				limits->fvco_max = 1200000;
> +				limits->fpfd_max = 450000;
> +			}
> +		}
> +		break;
> +	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_3:
> +		limits->fvco_max = 1600000;
> +		limits->fpfd_max = 550000;
> +		break;
> +	default:
No warning? Does PCORE_VER_MAJOR(ver) > 0x04 not imply this to be known
or valid?
> +		break;
> +	};
> +
Maybe:
"For Ultrascale+ the speedgrades don't matter" or something as a comment?
> +	if (tech == ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE_PLUS) {
> +		limits->fvco_max = 1600000;
> +		limits->fvco_min = 800000;
> +	}
> +}
> +
>  static int axi_clkgen_wait_non_busy(struct axi_clkgen *axi_clkgen)
>  {
>  	unsigned int timeout = 10000;
> @@ -510,7 +555,7 @@ static int axi_clkgen_probe(struct platform_device *pdev)
>  	struct clk_init_data init;
>  	const char *parent_names[2];
>  	const char *clk_name;
> -	unsigned int i;
> +	unsigned int i, ver;
>  	int ret;
>  
>  	dflt_limits = device_get_match_data(&pdev->dev);
> @@ -537,6 +582,11 @@ static int axi_clkgen_probe(struct platform_device *pdev)
>  
>  	memcpy(&axi_clkgen->limits, dflt_limits, sizeof(axi_clkgen->limits));
>  
> +	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_VERSION, &ver);
> +
> +	if (ADI_AXI_PCORE_VER_MAJOR(ver) > 0x04)
Nit: 0x4 is fine?
> +		axi_clkgen_setup_ranges(axi_clkgen);
> +
>  	clk_name = pdev->dev.of_node->name;
>  	of_property_read_string(pdev->dev.of_node, "clock-output-names",
>  		&clk_name);
> -- 
> 2.17.1
> 
Thanks,
Moritz
