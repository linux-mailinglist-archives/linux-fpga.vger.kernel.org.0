Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCD30514B
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 05:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbhA0Epp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 23:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhA0C4H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 26 Jan 2021 21:56:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74161C061356;
        Tue, 26 Jan 2021 18:38:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u4so410363pjn.4;
        Tue, 26 Jan 2021 18:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vklqd1CpSD6MzJLSP3R3zsuOOkfooEPp/iNgXN0T0fo=;
        b=c5RO3dEx0VxceY8JbhIgRQ/xXMdDVCmThzK2kX8xMsQV2hQzkAuCDGStm3l3mKKZqp
         NQRfgfBI0Ny71HDkFwn7AMLYPJASdfB7lAkcTq2pRgyaEMBHFIDFvaSJF22mNaX8hasY
         4pXonnSJRudWfOALOB1C1QLx9ZU6+aJhqBw6olQFZpFWrz8kN6jVwD2tssa16C9jNLps
         pBRcfFFfOowBMW4pt4hwokzFUiNNoA6sJxokCCxTqQ7EJkDei61PFXKiC/2nF2MJsaD8
         XRLr4pkITvoejI4Duhg8YFOaFR9lt+vhIKgLti6IuBHgDP4kD0lawhjaAEubTiZSb4ch
         XAPw==
X-Gm-Message-State: AOAM5321DbBE6z7BAMYa9k8fh3YdbS2jMr5RMzqu3yWvGhf52f4NfXS4
        bwOBdIgDsJWUBvotdK/DY5o=
X-Google-Smtp-Source: ABdhPJzDMFPavXxrd/pehJ8vKuy9+lAOm2D9rjspN+qou+kgmoZiHv+UcypGCMJcjC2bMLbacmaIHA==
X-Received: by 2002:a17:90a:17c6:: with SMTP id q64mr2992388pja.65.1611715135226;
        Tue, 26 Jan 2021 18:38:55 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id n15sm218388pjk.57.2021.01.26.18.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:38:54 -0800 (PST)
Date:   Tue, 26 Jan 2021 18:38:53 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v2 1/3] clk: axi-clkgen: remove ARCH dependency in Kconfig
Message-ID: <YBDSPVgmqD2JvPbk@epycbox.lan>
References: <20210126110826.24221-1-alexandru.ardelean@analog.com>
 <20210126110826.24221-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126110826.24221-2-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Alexandru,

On Tue, Jan 26, 2021 at 01:08:24PM +0200, Alexandru Ardelean wrote:
> The intent is to be able to run this driver to access the IP core in setups
> where FPGA board is also connected via a PCIe bus. In such cases the number
> of combinations explodes, where the host system can be an x86 with Xilinx
> Zynq/ZynqMP/Microblaze board connected via PCIe.
> Or even a ZynqMP board with a ZynqMP/Zynq/Microblaze connected via PCIe.
> 
> To accommodate for these cases, this change removes the limitation for this
> driver to be compilable only on Zynq/Microblaze architectures.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/clk/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 85856cff506c..d8c2d4593926 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -247,7 +247,6 @@ config CLK_TWL6040
>  
>  config COMMON_CLK_AXI_CLKGEN
>  	tristate "AXI clkgen driver"
> -	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
Umhhh ... no dependencies? How are you accessing your registers? You
seem to be using device tree, probably:

	depends on HAS_IOMEM || COMPILE_TEST
	depends on OF

at least? Please double check your dependencies.
>  	help
>  	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
>  	  FPGAs. It is commonly used in Analog Devices' reference designs.
> -- 
> 2.17.1
> 

- Moritz
