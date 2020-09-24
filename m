Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8302773CE
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 16:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgIXOVL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 10:21:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39219 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgIXOVL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Sep 2020 10:21:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id n14so1995716pff.6;
        Thu, 24 Sep 2020 07:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZnSe6Zu8y0XbejQE+ELBBUwH3XCUgLu4o8AsI4xo+No=;
        b=mbZtMjVG+BYfy3+ac0qMS74IWakjTqy0uY2jojelmCdzPLiX/KXzgh9ai5vc1F3+7a
         U7qmcWtdmpAAZ045sPNrOH6BOwmdf1yByjKE2Jv3m2o4ZtkXF6QluUs3FXfysVV1tv7V
         qLqwTa3urmlAQdDLu1iv6W4y6QDa0pCFjsZMi3pcEJ34cWu8W1LsJ4GT49Ct/0FInfYo
         ExkvVedqboWCZWjAWj49uaOpLP8ZHwmShF/qQnMmVqT9Q/LV594ciqqmgWMm1y7FI19Z
         yidA7QHKGzxsrTv+by69FnGtaEFuOyT3WOVrNlAej1Qk9fWiY2fgZuV263l9z0aca2EL
         rxHw==
X-Gm-Message-State: AOAM531pV/z28KX25fgvCZjSIBlz+IQR+m9o43p9MANbkqwrsuRPMRBn
        qefJKAOZac0n8nxia/Aj3sw=
X-Google-Smtp-Source: ABdhPJzywxxsn/aQygzC109Zy6QeKDBAjcKesYmvwLBVVbJA1hG6EgfOWAup9sFqkNtr3E3/DoZiFw==
X-Received: by 2002:aa7:9817:0:b029:13e:d13d:a139 with SMTP id e23-20020aa798170000b029013ed13da139mr4695421pfl.33.1600957269962;
        Thu, 24 Sep 2020 07:21:09 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id q190sm3169370pfc.176.2020.09.24.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:21:09 -0700 (PDT)
Date:   Thu, 24 Sep 2020 07:21:08 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        mircea.caprioru@analog.com
Subject: Re: [PATCH v3 6/6] clk: axi-clkgen: Add support for FPGA info
Message-ID: <20200924142108.GA60306@archbook>
References: <20200924065012.59605-1-alexandru.ardelean@analog.com>
 <20200924065012.59605-7-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924065012.59605-7-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Sep 24, 2020 at 09:50:12AM +0300, Alexandru Ardelean wrote:
> From: Mircea Caprioru <mircea.caprioru@analog.com>
> 
> This patch adds support for vco maximum and minimum ranges in accordance
> with fpga speed grade, voltage, device package, technology and family. This
> new information is extracted from two new registers implemented in the ip
> core: ADI_REG_FPGA_INFO and ADI_REG_FPGA_VOLTAGE, which are stored in the
> 'include/linux/fpga/adi-axi-common.h' file as they are common to all ADI
> FPGA cores.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c | 67 +++++++++++++++++++++++++++++++-----
>  1 file changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 6ffc19e9d850..b03ea28270cb 100644
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
> @@ -49,6 +50,7 @@
>  struct axi_clkgen {
>  	void __iomem *base;
>  	struct clk_hw clk_hw;
> +	unsigned int pcore_version;
>  };
>  
>  static uint32_t axi_clkgen_lookup_filter(unsigned int m)
> @@ -101,15 +103,15 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
>  }
>  
>  #ifdef ARCH_ZYNQMP
> -static const unsigned int fpfd_min = 10000;
> -static const unsigned int fpfd_max = 450000;
> -static const unsigned int fvco_min = 800000;
> -static const unsigned int fvco_max = 1600000;
> +static unsigned int fpfd_min = 10000;
> +static unsigned int fpfd_max = 450000;
> +static unsigned int fvco_min = 800000;
> +static unsigned int fvco_max = 1600000;
>  #else
> -static const unsigned int fpfd_min = 10000;
> -static const unsigned int fpfd_max = 300000;
> -static const unsigned int fvco_min = 600000;
> -static const unsigned int fvco_max = 1200000;
> +static unsigned int fpfd_min = 10000;
> +static unsigned int fpfd_max = 300000;
> +static unsigned int fvco_min = 600000;
> +static unsigned int fvco_max = 1200000;
>  #endif
Instead of modifying those wouldn't you want those to be part of your
struct axi_clkgen? I understand that they're technically properties of the
fabric you're implementing this IP block in, but are you sure you'll
never have a system with more than one of those in two different FPGAs,
are you never gonna use this beyond ARCH_ZYNQ/ZYNQMP/MICROBLAZE?

What about a PCIe plugin card for a ZynqMP system with a Zynq on it?
>  
>  static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
> @@ -229,6 +231,49 @@ static void axi_clkgen_read(struct axi_clkgen *axi_clkgen,
>  	*val = readl(axi_clkgen->base + reg);
>  }
>  
> +static void axi_clkgen_setup_ranges(struct axi_clkgen *axi_clkgen)
> +{
> +	unsigned int reg_value;
> +	unsigned int tech, family, speed_grade, voltage;
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
> +		fvco_max = 1200000;
> +		fpfd_max = 450000;
> +		break;
> +	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_2 ... ADI_AXI_FPGA_SPEED_GRADE_XILINX_2LV:
> +		fvco_max = 1440000;
> +		fpfd_max = 500000;
> +		if ((family == ADI_AXI_FPGA_FAMILY_XILINX_KINTEX) |
> +		    (family == ADI_AXI_FPGA_FAMILY_XILINX_ARTIX)) {
> +			if (voltage < 950) {
> +				fvco_max = 1200000;
> +				fpfd_max = 450000;
> +			}
> +		}
> +		break;
> +	case ADI_AXI_FPGA_SPEED_GRADE_XILINX_3:
> +		fvco_max = 1600000;
> +		fpfd_max = 550000;
> +		break;
> +	default:
> +		break;
> +	};
> +
> +	if (tech == ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE_PLUS) {
> +		fvco_max = 1600000;
> +		fvco_min = 800000;
> +	}
> +}
> +
>  static int axi_clkgen_wait_non_busy(struct axi_clkgen *axi_clkgen)
>  {
>  	unsigned int timeout = 10000;
> @@ -524,6 +569,12 @@ static int axi_clkgen_probe(struct platform_device *pdev)
>  	if (IS_ERR(axi_clkgen->base))
>  		return PTR_ERR(axi_clkgen->base);
>  
> +	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_VERSION,
> +			&axi_clkgen->pcore_version);
> +
> +	if (ADI_AXI_PCORE_VER_MAJOR(axi_clkgen->pcore_version) > 0x04)
> +		axi_clkgen_setup_ranges(axi_clkgen);
> +
>  	init.num_parents = of_clk_get_parent_count(pdev->dev.of_node);
>  	if (init.num_parents < 1 || init.num_parents > 2)
>  		return -EINVAL;
> -- 
> 2.25.1
> 
Thanks,
Moritz
