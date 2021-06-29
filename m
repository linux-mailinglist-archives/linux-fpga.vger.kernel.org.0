Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5288A3B6C1C
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Jun 2021 03:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhF2Brr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 21:47:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:18888 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhF2Brq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 21:47:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="205059164"
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; 
   d="scan'208";a="205059164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 18:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; 
   d="scan'208";a="456583567"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2021 18:45:17 -0700
Date:   Tue, 29 Jun 2021 09:39:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mfd: intel-m10-bmc: add n5010 variant
Message-ID: <20210629013958.GA85916@yilunxu-OptiPlex-7050>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-5-martin@geanix.com>
 <YNYkXVgS4YBgahjw@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNYkXVgS4YBgahjw@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 25, 2021 at 11:45:49AM -0700, Moritz Fischer wrote:
> On Fri, Jun 25, 2021 at 09:42:12AM +0200, Martin Hundebøll wrote:
> > From: Martin Hundebøll <mhu@silicom.dk>
> > 
> >  The m10-bmc is used on the Silicom N5010 PAC too, so add it to list of
> >  m10bmc types.
> > 
> > Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Acked-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Thanks,
Yilun

> > ---
> > 
> > Changes since v1:
> >  * Patch split out to separate mfd changes
> > 
> >  drivers/mfd/intel-m10-bmc.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > index 1a9bfb7f48cd..8db3bcf5fccc 100644
> > --- a/drivers/mfd/intel-m10-bmc.c
> > +++ b/drivers/mfd/intel-m10-bmc.c
> > @@ -15,7 +15,8 @@
> >  
> >  enum m10bmc_type {
> >  	M10_N3000,
> > -	M10_D5005
> > +	M10_D5005,
> > +	M10_N5010,
> >  };
> >  
> >  static struct mfd_cell m10bmc_d5005_subdevs[] = {
> > @@ -28,6 +29,10 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
> >  	{ .name = "n3000bmc-secure" },
> >  };
> >  
> > +static struct mfd_cell m10bmc_n5010_subdevs[] = {
> > +	{ .name = "n5010bmc-hwmon" },
> > +};
> > +
> >  static const struct regmap_range m10bmc_regmap_range[] = {
> >  	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
> >  	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> > @@ -192,6 +197,10 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >  		cells = m10bmc_d5005_subdevs;
> >  		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> >  		break;
> > +	case M10_N5010:
> > +		cells = m10bmc_n5010_subdevs;
> > +		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
> > +		break;
> >  	default:
> >  		return -ENODEV;
> >  	}
> > @@ -207,6 +216,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >  static const struct spi_device_id m10bmc_spi_id[] = {
> >  	{ "m10-n3000", M10_N3000 },
> >  	{ "m10-d5005", M10_D5005 },
> > +	{ "m10-n5010", M10_N5010 },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> > -- 
> > 2.31.0
> > 
