Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834BE3B87D3
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Jun 2021 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhF3RnT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Jun 2021 13:43:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:54695 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhF3RnS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 30 Jun 2021 13:43:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="206575955"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="206575955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 10:40:48 -0700
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="457343141"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 10:40:47 -0700
Date:   Wed, 30 Jun 2021 10:42:18 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mfd: intel-m10-bmc: add n5010 variant
In-Reply-To: <20210629121214.988036-4-martin@geanix.com>
Message-ID: <alpine.DEB.2.22.394.2106301042030.1372882@rhweight-WRK1>
References: <20210629121214.988036-1-martin@geanix.com> <20210629121214.988036-4-martin@geanix.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2141539894-1625074945=:1372882"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2141539894-1625074945=:1372882
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Tue, 29 Jun 2021, Martin Hundebøll wrote:

> From: Martin Hundebøll <mhu@silicom.dk>
>
> The m10-bmc is used on the Silicom N5010 PAC too, so add it to list of
> m10bmc types.
>
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>
> Changes since v2:
> * Added Yilun's Reviewed-by
> * Added Moritz' Acked-by
>
> Changes since v1:
> * Patch split out to separate mfd changes
>
> drivers/mfd/intel-m10-bmc.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index 1a9bfb7f48cd..8db3bcf5fccc 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -15,7 +15,8 @@
>
> enum m10bmc_type {
> 	M10_N3000,
> -	M10_D5005
> +	M10_D5005,
> +	M10_N5010,
> };
>
> static struct mfd_cell m10bmc_d5005_subdevs[] = {
> @@ -28,6 +29,10 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
> 	{ .name = "n3000bmc-secure" },
> };
>
> +static struct mfd_cell m10bmc_n5010_subdevs[] = {
> +	{ .name = "n5010bmc-hwmon" },
> +};
> +
> static const struct regmap_range m10bmc_regmap_range[] = {
> 	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
> 	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> @@ -192,6 +197,10 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> 		cells = m10bmc_d5005_subdevs;
> 		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> 		break;
> +	case M10_N5010:
> +		cells = m10bmc_n5010_subdevs;
> +		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
> +		break;
> 	default:
> 		return -ENODEV;
> 	}
> @@ -207,6 +216,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> static const struct spi_device_id m10bmc_spi_id[] = {
> 	{ "m10-n3000", M10_N3000 },
> 	{ "m10-d5005", M10_D5005 },
> +	{ "m10-n5010", M10_N5010 },
> 	{ }
> };
> MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> -- 
> 2.31.0
>
>
--8323328-2141539894-1625074945=:1372882--
