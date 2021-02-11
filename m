Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7947F318DB8
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBKOxk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 09:53:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231177AbhBKOqK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Feb 2021 09:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613054679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcinVWu3bcunxMizVr6YdOQZJoRP+W/VNBiBV+7EN7Y=;
        b=URKZt45+av0h1oYGRGdrjdzOwUNMzRfYH8OmLdT+7MYa8eLY6xPHR4iCvaT/SUozt8v+K3
        /D4czgeHibkQG0uYxpGTOaV3mod39HSrCf4RdOGZA5Fb9I/Vj1I7+fkLMjzfYSK3058FEA
        dGkbz8ddVtmsgYvTv/s1oFJw6Wca1HA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-8LAuK2xBM4KFHme9A59_Qw-1; Thu, 11 Feb 2021 09:44:38 -0500
X-MC-Unique: 8LAuK2xBM4KFHme9A59_Qw-1
Received: by mail-qk1-f200.google.com with SMTP id i11so4351421qkn.21
        for <linux-fpga@vger.kernel.org>; Thu, 11 Feb 2021 06:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RcinVWu3bcunxMizVr6YdOQZJoRP+W/VNBiBV+7EN7Y=;
        b=g44BK1qa9xCZzVFhGKMRb4lStUiTwfbQVM/HvA20CldD7vB8tK+xdNqHFBf4WBGbz4
         sBK0J2LwnZgY1w+N3tZtHGC89L/H1xp09sk0PseXVc5n0zRArlVEe554J1BnFL/r5P5Z
         qKrvzlOXptMjCwiuOTqBWWw2k6gZKQ6urfBQlTjtcPUeVPLkss1Sw5bN255wgM+qpALN
         1Pc2tiTTRJ2pC4mCSqVZIWK0ZIIJCtLm9e+I26iAYT0I3eSkxNGhd/f2dvTgiz9mu2Zm
         NBTqsdt3zV5c3qEdUmM1ZARYVD+vjEztumFyy3NYvnp5GjsY+lApBk5SXA3ZefNeT3MW
         RCEw==
X-Gm-Message-State: AOAM532SoN4OD2qllWlvMFip1IIczgDLKyrLIdXOiJe+LLA2bjw+IBTW
        TMPP73qu3lcvAI27aY5lCIlBEtUTow5cyw8cXjL6hxVO8flcUmkmV17S+fyexrlMOYKCjzyUz6J
        eK30vHf+GLGoSgN0nmfNonQ==
X-Received: by 2002:ac8:ecd:: with SMTP id w13mr7771272qti.91.1613054677867;
        Thu, 11 Feb 2021 06:44:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwy2sdyEM6H+86CchK4C9MQe83PTDkHtsADOMUokbWbPMagfuKn9UL1YevyhiDGgrW3FS/YeQ==
X-Received: by 2002:ac8:ecd:: with SMTP id w13mr7771251qti.91.1613054677626;
        Thu, 11 Feb 2021 06:44:37 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b16sm3521564qtx.85.2021.02.11.06.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 06:44:37 -0800 (PST)
Subject: Re: [PATCH 2/2] clk: axi-clkgen: Add support for FPGA info
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Mircea Caprioru <mircea.caprioru@analog.com>
References: <20210210101535.47979-1-alexandru.ardelean@analog.com>
 <20210210101535.47979-2-alexandru.ardelean@analog.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <26eae7d2-768d-4df4-5646-c44d53b8659e@redhat.com>
Date:   Thu, 11 Feb 2021 06:44:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210101535.47979-2-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/10/21 2:15 AM, Alexandru Ardelean wrote:
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
NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
3a419c9317b157ef06ca347b7e6bbab846a3d605 clk: axi-clkgen: Add support for FPGA info
CHECK: Unnecessary parentheses around 'family == ADI_AXI_FPGA_FAMILY_XILINX_KINTEX'
#57: FILE: drivers/clk/clk-axi-clkgen.c:266:
+        if ((family == ADI_AXI_FPGA_FAMILY_XILINX_KINTEX) |
+            (family == ADI_AXI_FPGA_FAMILY_XILINX_ARTIX)) {

Please use checkpatch -strict to find this problem.

Likely the '|', should be '||'

Tom

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
> +		break;
> +	};
> +
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
> +		axi_clkgen_setup_ranges(axi_clkgen);
> +
>  	clk_name = pdev->dev.of_node->name;
>  	of_property_read_string(pdev->dev.of_node, "clock-output-names",
>  		&clk_name);

