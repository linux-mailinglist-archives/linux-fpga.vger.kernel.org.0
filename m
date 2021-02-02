Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522EC30B663
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Feb 2021 05:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhBBEWT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 23:22:19 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:44708 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhBBEWS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Feb 2021 23:22:18 -0500
Received: by mail-pl1-f172.google.com with SMTP id j11so9126470plt.11;
        Mon, 01 Feb 2021 20:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SIwjUPSErfATOEPFPNdwWAOmlNousZElCyKYrK3KGNk=;
        b=qFzZWN184E4OEg0gv/InX0dwzX7cdDBHe7XBVq2WkmXiTKR2Fl+lpK3XIjrS1C6cqH
         IzLHl7FH2ON0JCk6hfWHdK+B3FJiIKent8fF3Qz4DVbKtVheeJEcQRd78HNMZyw0LXY5
         uiWe1E5pYIS4XQvwe2mTE0PGNvIIrWxsR5g8q7l6mabv7RiUQ6uxppe82Ga859u41YJP
         Wk7EbHj3mfqgSUG0WsRiV2HyQMf/dE3+/ACkCoewVjnUVD8XUkNDNbWFIS0InBV9Kzu4
         FFE/EbDLUARk/zQZzJ22tBVWSaIzMcmAPTlbPHuT0IoSj4lf/XXZaSPyCJ9w8TeINswZ
         6BHQ==
X-Gm-Message-State: AOAM533o1zi1FToFhLPeB/WYjTkmus9o2kb0AypQNQ4a6573zNMBV9x5
        oOFn539GI4JZi11HQyiGeCM=
X-Google-Smtp-Source: ABdhPJw30pd+73XF9MrM9PnfYr5STVqRuH8wgVy84YQ4KZE1lBmvdRSlOWvy4U+KgeAPvX6L4w23xg==
X-Received: by 2002:a17:90b:33ca:: with SMTP id lk10mr2227093pjb.186.1612239697173;
        Mon, 01 Feb 2021 20:21:37 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id bk18sm1036440pjb.41.2021.02.01.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 20:21:36 -0800 (PST)
Date:   Mon, 1 Feb 2021 20:21:35 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v3 1/4] clk: axi-clkgen: replace ARCH dependencies with
 driver deps
Message-ID: <YBjTT7pRUMxnuM9s@epycbox.lan>
References: <20210201151245.21845-1-alexandru.ardelean@analog.com>
 <20210201151245.21845-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201151245.21845-2-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 01, 2021 at 05:12:42PM +0200, Alexandru Ardelean wrote:
> The intent is to be able to run this driver to access the IP core in setups
> where FPGA board is also connected via a PCIe bus. In such cases the number
> of combinations explodes, where the host system can be an x86 with Xilinx
> Zynq/ZynqMP/Microblaze board connected via PCIe.
> Or even a ZynqMP board with a ZynqMP/Zynq/Microblaze connected via PCIe.
> 
> To accommodate for these cases, this change removes the limitation for this
> driver to be compilable only on Zynq/Microblaze architectures.
> And adds dependencies on the mechanisms required by the driver to work (OF
> and HAS_IOMEM).
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/clk/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 85856cff506c..cee1d4e657bc 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -247,7 +247,8 @@ config CLK_TWL6040
>  
>  config COMMON_CLK_AXI_CLKGEN
>  	tristate "AXI clkgen driver"
> -	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
> +	depends on HAS_IOMEM || COMPILE_TEST
> +	depends on OF
>  	help
>  	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
>  	  FPGAs. It is commonly used in Analog Devices' reference designs.
> -- 
> 2.17.1
> 

Thanks,
Moritz
