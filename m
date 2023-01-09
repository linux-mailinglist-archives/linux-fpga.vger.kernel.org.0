Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDCD662D14
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Jan 2023 18:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjAIRns (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 12:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbjAIRnj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 12:43:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E663D1ADA8;
        Mon,  9 Jan 2023 09:43:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A332EB80EBB;
        Mon,  9 Jan 2023 17:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B43BC433EF;
        Mon,  9 Jan 2023 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673286215;
        bh=OusFUpHUgWztm0MPCMtNFsLIBDzi7S02luxqwtlv1DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1jT4Ppjc4S7ABOJSmqD/07hlwETehUj7z3PHaDFC8nK+au5Nz2vVgIbRQIuTOuCe
         Mgr6IBPGbGEAENlmZvVzn1IEYwjUcDSySmgaghootojXndzO7meMzf74t9b7FuAm7N
         BsMwR3PlFR9CGCVEWIAzmQE3UxwsEKW+aTH50uJKjuALl4ObPMpWUWchfU04dt5Bg+
         1QUgnCwMmVpcfKu2HYB1heFjX1LxValNM6zmbYvgpfIjfhFZXaIH1Ue3apZh8ziIZY
         sfTULc149f8XwQYxhqgv0qEvRAPiI4K+rdeD+xXIemmiYxqx1Y6JjAm5K6qCwu3z2p
         GeSm1T76X0QBw==
Date:   Mon, 9 Jan 2023 17:43:29 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] mfd: intel-m10-bmc: Create m10bmc_platform_info
 for type specific info
Message-ID: <Y7xSQde3pzcOIu+X@google.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
 <20221226175849.13056-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226175849.13056-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 26 Dec 2022, Ilpo Järvinen wrote:

> BMC type specific info is currently set by a switch/case block. The
> size of this info is expected to grow as more dev types and features
> are added which would have made the switch block bloaty.
> 
> Store type specific info into struct and place them into .driver_data
> instead because it makes things a bit cleaner.
> 
> The m10bmc_type enum can be dropped as the differentiation is now
> fully handled by the platform info.
> 
> The info member of struct intel_m10bmc that is added here is not used
> yet in this change but its addition logically still belongs to this
> change. The CSR map change that comes after this change needs to have
> the info member.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c       | 53 ++++++++++++++-----------------
>  include/linux/mfd/intel-m10-bmc.h | 12 +++++++
>  2 files changed, 36 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index 7e3319e5b22f..12c522c16d83 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -13,12 +13,6 @@
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> -enum m10bmc_type {
> -	M10_N3000,
> -	M10_D5005,
> -	M10_N5010,
> -};
> -
>  static struct mfd_cell m10bmc_d5005_subdevs[] = {
>  	{ .name = "d5005bmc-hwmon" },
>  	{ .name = "d5005bmc-sec-update" }
> @@ -162,15 +156,17 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
>  static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> +	const struct intel_m10bmc_platform_info *info;
>  	struct device *dev = &spi->dev;
> -	struct mfd_cell *cells;
>  	struct intel_m10bmc *ddata;
> -	int ret, n_cell;
> +	int ret;
>  
>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return -ENOMEM;
>  
> +	info = (struct intel_m10bmc_platform_info *)id->driver_data;
> +	ddata->info = info;

Why are you keeping it?

>  	ddata->dev = dev;
>  
>  	ddata->regmap =
> @@ -189,24 +185,8 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	switch (id->driver_data) {
> -	case M10_N3000:
> -		cells = m10bmc_pacn3000_subdevs;
> -		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> -		break;
> -	case M10_D5005:
> -		cells = m10bmc_d5005_subdevs;
> -		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> -		break;
> -	case M10_N5010:
> -		cells = m10bmc_n5010_subdevs;
> -		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
> -		break;
> -	default:
> -		return -ENODEV;
> -	}
> -
> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> +				   info->cells, info->n_cells,
>  				   NULL, 0, NULL);
>  	if (ret)
>  		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
> @@ -214,10 +194,25 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  	return ret;
>  }
>  
> +static const struct intel_m10bmc_platform_info m10bmc_spi_n3000 = {
> +	.cells = m10bmc_pacn3000_subdevs,
> +	.n_cells = ARRAY_SIZE(m10bmc_pacn3000_subdevs),
> +};

Not seeing how adding a whole new structure and swapping out 4 lines to
describe a device for a different 4 lines per device is better?

I'm not necessarily against it.  Just seems like a bit of a pointless
exercise.

> +static const struct intel_m10bmc_platform_info m10bmc_spi_d5005 = {
> +	.cells = m10bmc_d5005_subdevs,
> +	.n_cells = ARRAY_SIZE(m10bmc_d5005_subdevs),
> +};
> +
> +static const struct intel_m10bmc_platform_info m10bmc_spi_n5010 = {
> +	.cells = m10bmc_n5010_subdevs,
> +	.n_cells = ARRAY_SIZE(m10bmc_n5010_subdevs),
> +};
> +
>  static const struct spi_device_id m10bmc_spi_id[] = {
> -	{ "m10-n3000", M10_N3000 },
> -	{ "m10-d5005", M10_D5005 },
> -	{ "m10-n5010", M10_N5010 },
> +	{ "m10-n3000", (kernel_ulong_t)&m10bmc_spi_n3000 },
> +	{ "m10-d5005", (kernel_ulong_t)&m10bmc_spi_d5005 },
> +	{ "m10-n5010", (kernel_ulong_t)&m10bmc_spi_n5010 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index f0044b14136e..725b51ea4aee 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -118,14 +118,26 @@
>  /* Address of 4KB inverted bit vector containing staging area FLASH count */
>  #define STAGING_FLASH_COUNT	0x17ffb000
>  
> +/**
> + * struct intel_m10bmc_platform_info - Intel MAX 10 BMC platform specific information
> + * @cells: MFD cells
> + * @n_cells: MFD cells ARRAY_SIZE()
> + */
> +struct intel_m10bmc_platform_info {
> +	struct mfd_cell *cells;
> +	int n_cells;
> +};
> +
>  /**
>   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
>   * @dev: this device
>   * @regmap: the regmap used to access registers by m10bmc itself
> + * @info: the platform information for MAX10 BMC
>   */
>  struct intel_m10bmc {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	const struct intel_m10bmc_platform_info *info;
>  };
>  
>  /*
> -- 
> 2.30.2
> 

-- 
Lee Jones [李琼斯]
