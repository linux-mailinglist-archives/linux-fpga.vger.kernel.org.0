Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC9662E22
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Jan 2023 19:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjAISF6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Jan 2023 13:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbjAISF1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Jan 2023 13:05:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D4B7EA;
        Mon,  9 Jan 2023 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673287474; x=1704823474;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=tfZgR4XNGZMxtPhVY1tXUnRBRyh0EiF8aAzA04nEmzk=;
  b=VVatoS9MiWzrRH5Egs/A4A1v9EjMkRchDpMtsOXGwIPRyVTDXtIr0zed
   2J6JRkujpIDuiayVFwCi1cddMmup5T91z1MRb+5uM1RkwCajVLC15UU9m
   BEtSHNFtDvb1ynUITa9l0Xae+KDUS6YYj2oNR2SAETWMU5o6KETRaeAGt
   3xrCjrwG6MGMUj9OfvUvcVGNySZQ4+LAmEFmGVVGrMupMSWdpk6ScKNhH
   OP+IK0giHcWtF6LOPdxNABo1cqdwo2zJyphClk3EzvO+ysp6FHd/loXe6
   zpATQUs3COiHFnhf3RsCXHIiJgyAmf2P/wjX4iBPp6OXplu7/0rvKwa+V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324946503"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="324946503"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 10:04:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="689110569"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="689110569"
Received: from aabdilla-mobl.amr.corp.intel.com ([10.251.221.240])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 10:04:28 -0800
Date:   Mon, 9 Jan 2023 20:04:28 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 01/10] mfd: intel-m10-bmc: Create m10bmc_platform_info
 for type specific info
In-Reply-To: <Y7xSQde3pzcOIu+X@google.com>
Message-ID: <1ffa5844-f5ce-e56a-7ed9-9ba434904b6d@linux.intel.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com> <20221226175849.13056-2-ilpo.jarvinen@linux.intel.com> <Y7xSQde3pzcOIu+X@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1942689431-1673287225=:1694"
Content-ID: <f488e6fa-c85-f421-49e9-ef2e546e7ef@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1942689431-1673287225=:1694
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <123c7f5d-a9bb-3179-fbc8-fe64cd85741@linux.intel.com>

On Mon, 9 Jan 2023, Lee Jones wrote:

> On Mon, 26 Dec 2022, Ilpo Järvinen wrote:
> 
> > BMC type specific info is currently set by a switch/case block. The
> > size of this info is expected to grow as more dev types and features
> > are added which would have made the switch block bloaty.
> > 
> > Store type specific info into struct and place them into .driver_data
> > instead because it makes things a bit cleaner.
> > 
> > The m10bmc_type enum can be dropped as the differentiation is now
> > fully handled by the platform info.
> > 
> > The info member of struct intel_m10bmc that is added here is not used
> > yet in this change but its addition logically still belongs to this
> > change. The CSR map change that comes after this change needs to have
> > the info member.
> > 
> > Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/mfd/intel-m10-bmc.c       | 53 ++++++++++++++-----------------
> >  include/linux/mfd/intel-m10-bmc.h | 12 +++++++
> >  2 files changed, 36 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > index 7e3319e5b22f..12c522c16d83 100644
> > --- a/drivers/mfd/intel-m10-bmc.c
> > +++ b/drivers/mfd/intel-m10-bmc.c
> > @@ -13,12 +13,6 @@
> >  #include <linux/regmap.h>
> >  #include <linux/spi/spi.h>
> >  
> > -enum m10bmc_type {
> > -	M10_N3000,
> > -	M10_D5005,
> > -	M10_N5010,
> > -};
> > -
> >  static struct mfd_cell m10bmc_d5005_subdevs[] = {
> >  	{ .name = "d5005bmc-hwmon" },
> >  	{ .name = "d5005bmc-sec-update" }
> > @@ -162,15 +156,17 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
> >  static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >  {
> >  	const struct spi_device_id *id = spi_get_device_id(spi);
> > +	const struct intel_m10bmc_platform_info *info;
> >  	struct device *dev = &spi->dev;
> > -	struct mfd_cell *cells;
> >  	struct intel_m10bmc *ddata;
> > -	int ret, n_cell;
> > +	int ret;
> >  
> >  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> >  	if (!ddata)
> >  		return -ENOMEM;
> >  
> > +	info = (struct intel_m10bmc_platform_info *)id->driver_data;
> > +	ddata->info = info;
> 
> Why are you keeping it?

There are plenty of users starting from patch 04. There will more users 
and members in the changes not included into this series. Thus, storing 
csr_map instead of info would not be forward-looking enough.

> >  	ddata->dev = dev;
> >  
> >  	ddata->regmap =
> > @@ -189,24 +185,8 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >  		return ret;
> >  	}
> >  
> > -	switch (id->driver_data) {
> > -	case M10_N3000:
> > -		cells = m10bmc_pacn3000_subdevs;
> > -		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> > -		break;
> > -	case M10_D5005:
> > -		cells = m10bmc_d5005_subdevs;
> > -		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> > -		break;
> > -	case M10_N5010:
> > -		cells = m10bmc_n5010_subdevs;
> > -		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
> > -		break;
> > -	default:
> > -		return -ENODEV;
> > -	}
> > -
> > -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
> > +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > +				   info->cells, info->n_cells,
> >  				   NULL, 0, NULL);
> >  	if (ret)
> >  		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
> > @@ -214,10 +194,25 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >  	return ret;
> >  }
> >  
> > +static const struct intel_m10bmc_platform_info m10bmc_spi_n3000 = {
> > +	.cells = m10bmc_pacn3000_subdevs,
> > +	.n_cells = ARRAY_SIZE(m10bmc_pacn3000_subdevs),
> > +};
> 
> Not seeing how adding a whole new structure and swapping out 4 lines to
> describe a device for a different 4 lines per device is better?
> 
> I'm not necessarily against it.  Just seems like a bit of a pointless
> exercise.

After the BMC core/SPI split in a later patch in this series, there will 
be an init func in m10bmc core that will be called from spi side and 
after PMCI is added, from there too. 

With a structure, only a pointer to that will have to be passed to the 
init func rather than n parameters (there will be more members added into 
the info structure too both by changes in this series and in the ones not 
included to this series).


Thanks for the review.

-- 
 i.
--8323329-1942689431-1673287225=:1694--
