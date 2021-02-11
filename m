Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E2318426
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 05:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBKEAy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Feb 2021 23:00:54 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:33872 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhBKEAx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 10 Feb 2021 23:00:53 -0500
Received: by mail-pf1-f175.google.com with SMTP id m6so2882575pfk.1;
        Wed, 10 Feb 2021 20:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZaxGDPHRm4EL6EG2S0VxxdedUr3yRC4gGuEFBAHXe0s=;
        b=WMPFtwtKnSKGYFE8BvfRWKxEjvfDAD+kdRzTr2sqNTrlCxFkGnn/wygvk3j2Xbbe0P
         GtZy/MgiGR6xyUYFz+FFs6kqhY6hjJrLhLRGO+Fk23+zw11P25tiXuJvzWyU7Ai1Rkal
         P6jYvwMaVQ7xGkb4co9Ur2SgEZ8Og0QKZxJ0FC9q5l+FNzBaauUc/4Qwv9xtT9gdQIWZ
         6iaZo8hzp5IYbJPqH5nwodaj1wK7EcYvqZdWJ7bNULsz3e2/PJvvMH8GGNoqk/IhvklL
         +3e8+Lp63V9FTuarOpRkj5hA58eia936EuSv7hxMm1EzVAE3AjcHKDHdgLozd+P4tQGw
         Q1AA==
X-Gm-Message-State: AOAM533cnOeoDzLSz4RP066vhVDyKxFd+vy66/s14+9awITdqfHfzs/j
        b1/UQLIWUZUVNof5DpxDJSb3z98uiqTC7g==
X-Google-Smtp-Source: ABdhPJwnCZYdnND+e9X9uhPG3Qba1SSuaS7ehetzZAcYFu0N5s1xP0tm4qZynev1KPAuGmoflVoRQw==
X-Received: by 2002:a63:4a1a:: with SMTP id x26mr6398683pga.260.1613016012320;
        Wed, 10 Feb 2021 20:00:12 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id ob6sm3226750pjb.30.2021.02.10.20.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 20:00:11 -0800 (PST)
Date:   Wed, 10 Feb 2021 20:00:10 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH 1/2] include: fpga: adi-axi-common.h: add definitions for
 supported FPGAs
Message-ID: <YCSryh6kOhA+0xHc@epycbox.lan>
References: <20210210101535.47979-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210101535.47979-1-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Alexandru,

On Wed, Feb 10, 2021 at 12:15:34PM +0200, Alexandru Ardelean wrote:
> From: Mircea Caprioru <mircea.caprioru@analog.com>
> 
> All (newer) FPGA IP cores supported by Analog Devices, store information in

Nit: extra ',' ?
> the synthesized designs. This information describes various parameters,
> including the family of boards on which this is deployed, speed-grade, and
> so on.
> 
> Currently, some of these definitions are deployed mostly on Xilinx boards,
> but they have been considered also for FPGA boards from other vendors.
Let's add them together with the code that uses them.
> 
> The register definitions are described at this link:
>   https://wiki.analog.com/resources/fpga/docs/hdl/regmap
> (the 'Base (common to all cores)' section).
> 
> Acked-by: Moritz Fischer <mdf@kernel.org>
This patchset is very different from the reviewed one earlier. Please
don't just copy Acked-by's.

> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> This is a continuation of this old set:
> https://lore.kernel.org/linux-clk/20200929144417.89816-1-alexandru.ardelean@analog.com/
> 
> Particularly patches:
>   https://lore.kernel.org/linux-clk/20200929144417.89816-15-alexandru.ardelean@analog.com/
>   https://lore.kernel.org/linux-clk/20200929144417.89816-16-alexandru.ardelean@analog.com/
> 
> That was v4, but this patchset was split away from it, to resolve
> discussion on some other patches in that set.
> 
> The other patches were accepted here:
>   https://lore.kernel.org/linux-clk/20210201151245.21845-1-alexandru.ardelean@analog.com/
> 
>  include/linux/fpga/adi-axi-common.h | 103 ++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> index 141ac3f251e6..1a7f18e3a384 100644
> --- a/include/linux/fpga/adi-axi-common.h
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -13,6 +13,9 @@
>  
>  #define ADI_AXI_REG_VERSION			0x0000
>  
> +#define ADI_AXI_REG_FPGA_INFO			0x001C
> +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
> +
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
>  
> @@ -20,4 +23,104 @@
>  #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
>  #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
>  
> +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)		((val) & 0xffff)
> +
> +#define ADI_AXI_INFO_FPGA_TECH(info)		(((info) >> 24) & 0xff)
> +#define ADI_AXI_INFO_FPGA_FAMILY(info)		(((info) >> 16) & 0xff)
> +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)	(((info) >> 8) & 0xff)
> +#define ADI_AXI_INFO_FPGA_DEV_PACKAGE(info)	((info) & 0xff)

Do we really need all the macros?
> +
> +/**
> + * FPGA Technology definitions
> + */
> +#define ADI_AXI_FPGA_TECH_XILINX_UNKNOWN		0
> +#define ADI_AXI_FPGA_TECH_XILINS_SERIES7		1
> +#define ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE		2
> +#define ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE_PLUS	3
> +
> +#define ADI_AXI_FPGA_TECH_INTEL_UNKNOWN			100
> +#define ADI_AXI_FPGA_TECH_INTEL_CYCLONE_5		101
> +#define ADI_AXI_FPGA_TECH_INTEL_CYCLONE_10		102
> +#define ADI_AXI_FPGA_TECH_INTEL_ARRIA_10		103
> +#define ADI_AXI_FPGA_TECH_INTEL_STRATIX_10		104
> +
> +/**
> + * FPGA Family definitions
> + */
> +#define ADI_AXI_FPGA_FAMILY_UNKNOWN			0
> +
> +#define ADI_AXI_FPGA_FAMILY_XILINX_ARTIX		1
> +#define ADI_AXI_FPGA_FAMILY_XILINX_KINTEX		2
> +#define ADI_AXI_FPGA_FAMILY_XILINX_VIRTEX		3
> +#define ADI_AXI_FPGA_FAMILY_XILINX_ZYNQ			4
> +
> +#define ADI_AXI_FPGA_FAMILY_INTEL_SX			1
> +#define ADI_AXI_FPGA_FAMILY_INTEL_GX			2
> +#define ADI_AXI_FPGA_FAMILY_INTEL_GT			3
> +#define ADI_AXI_FPGA_FAMILY_INTEL_GZ			4
> +
> +/**
> + * FPGA Speed-grade definitions
> + */
> +#define ADI_AXI_FPGA_SPEED_GRADE_UNKNOWN		0
> +
> +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1		10
> +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1L		11
> +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1H		12
> +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1HV		13
> +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1LV		14
> +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2		20
> +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2L		21
> +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2LV		22
> +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_3		30
> +
> +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_1		1
> +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_2		2
> +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_3		3
> +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_4		4
> +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_5		5
> +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_6		6
> +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_7		7
> +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_8		8
> +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_9		9
> +
> +/**
> + * FPGA Device Package definitions
> + */
> +#define ADI_AXI_FPGA_DEV_PACKAGE_UNKNOWN		0
> +
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RF		1
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FL		2
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FF		3
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FB		4
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_HC		5
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FH		6
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CS		7
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CP		8
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FT		9
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FG		10
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_SB		11
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RB		12
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RS		13
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CL		14
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_SF		15
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_BA		16
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FA		17
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FS		18
> +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FI		19
> +
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_BGA		1
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PGA		2
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_FBGA		3
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_HBGA		4
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PDIP		5
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_EQFP		6
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PLCC		7
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PQFP		8
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_RQFP		9
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_TQFP		10
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_UBGA		11
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_UFBGA		12
> +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_MBGA		13

What is using those? Do these package impact anything behavioral?
> +
>  #endif /* ADI_AXI_COMMON_H_ */
> -- 
> 2.17.1
> 

- Moritz

PS: The subject line could use a bit of work, too :)
